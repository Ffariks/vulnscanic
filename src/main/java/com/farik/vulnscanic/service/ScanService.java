package com.farik.vulnscanic.service;

import java.util.List;
import java.util.Optional;

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

    public Optional<Dependency> findbyId(long id) {
        return dependencies.stream().filter(d -> d.id() == id).findFirst();
    }

    public Dependency getById(long id) {
        return findbyId(id).orElseThrow(() -> new DependencyNotFoundException(id));
    }

}
