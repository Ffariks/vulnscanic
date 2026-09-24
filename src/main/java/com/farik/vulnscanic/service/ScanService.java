package com.farik.vulnscanic.service;

import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.Comparator;

import com.farik.vulnscanic.model.Severity;
import com.farik.vulnscanic.exception.DependencyNotFoundException;
import com.farik.vulnscanic.model.Dependency;
import com.farik.vulnscanic.model.Ecosystem;
import com.farik.vulnscanic.model.Vulnerability;

public class ScanService {
    private final List<Dependency> dependencies;
    private final List<Vulnerability> vulnerabilities;

    public ScanService(List<Dependency> dependencies, List<Vulnerability> vulnerabilities) {
        this.dependencies = dependencies;
        this.vulnerabilities = vulnerabilities;
    }

    public List<Dependency> findByEcosystem(Ecosystem eco) {
        return dependencies.stream().filter(d -> d.ecosystem() == eco).toList();
    }

    public Optional<Dependency> findById(long id) {
        return dependencies.stream().filter(d -> d.id() == id).findFirst();
    }

    public Dependency getById(long id) {
        return findById(id).orElseThrow(() -> new DependencyNotFoundException(id));
    }

    public List<Vulnerability> findBySeverityAtLeast(Severity min) {
        return vulnerabilities.stream().filter(v -> v.severity().compareTo(min) >= 0).toList();
    }

    public Map<Severity, List<Vulnerability>> groupBySeverity() {
        return vulnerabilities.stream().collect(Collectors.groupingBy(v -> v.severity()));
    }

    public Map<Severity, Long> countBySeverity() {
        return vulnerabilities.stream().collect(Collectors.groupingBy(v -> v.severity(), Collectors.counting()));
    }

    public List<Dependency> vulnerableDependencies() {
        Set<Long> vulnerableIds = vulnerabilities.stream().map(v -> v.dependencyId()).collect(Collectors.toSet());
        return dependencies.stream().filter(d -> vulnerableIds.contains(d.id())).toList();
    }

    private Optional<Severity> worstSeverity(Dependency d) {
        return vulnerabilities.stream().filter(v -> v.dependencyId() == d.id()).map(v -> v.severity())
                .max(Comparator.naturalOrder());
    }

    private long vulnCount(Dependency d) {
        return vulnerabilities.stream().filter(v -> v.dependencyId() == d.id()).count();
    }

    public List<Dependency> topRisky(int limit) {
        return dependencies.stream()
                .sorted(Comparator.comparing((Dependency d) -> worstSeverity(d).orElse(Severity.LOW))
                        .thenComparing(d -> vulnCount(d)).reversed())
                .limit(limit).toList();
    }

    public String reportLine() {
        return countBySeverity().entrySet().stream()
                .sorted(Map.Entry.<Severity, Long>comparingByKey().reversed())
                .map(e -> e.getKey() + ": " + e.getValue())
                .collect(Collectors.joining(", ", "[ ", "] "));
    }
}
