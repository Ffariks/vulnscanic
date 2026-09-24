package com.farik.vulnscanic;

import java.util.List;

import com.farik.vulnscanic.exception.DependencyNotFoundException;
import com.farik.vulnscanic.model.Dependency;
import com.farik.vulnscanic.model.Ecosystem;
import com.farik.vulnscanic.model.Vulnerability;
import com.farik.vulnscanic.service.ScanService;
import com.farik.vulnscanic.model.Severity;

public class Main {
    public static void main(String[] аrgs) {
        List<Dependency> deps = List.of(
                new Dependency(1, "jackson-databind", "2.9.0", Ecosystem.MAVEN),
                new Dependency(2, "lodash", "4.17.11", Ecosystem.NPM),
                new Dependency(3, "guava", "30.0-jre", Ecosystem.MAVEN),
                new Dependency(4, "log4j-core", "2.14.0", Ecosystem.MAVEN),
                new Dependency(5, "requests", "2.19.1", Ecosystem.PYPI),
                new Dependency(6, "express", "4.16.0", Ecosystem.NPM),
                new Dependency(7, "pyyaml", "5.1", Ecosystem.PYPI));

        List<Vulnerability> vulns = List.of(
                new Vulnerability("CVE-2019-12384", "Deserialization of untrusted data",
                        Severity.CRITICAL, "2.9.9", 1),
                new Vulnerability("CVE-2018-7489", "Incomplete blacklist bypass",
                        Severity.HIGH, "2.9.5", 1),
                new Vulnerability("CVE-2019-10744", "Prototype pollution in defaultsDeep",
                        Severity.HIGH, "4.17.12", 2),
                new Vulnerability("CVE-2021-44228", "Remote code execution via JNDI lookup",
                        Severity.CRITICAL, "2.15.0", 4),
                new Vulnerability("CVE-2018-18074", "Credentials leaked on redirect",
                        Severity.MEDIUM, "2.20.0", 5),
                new Vulnerability("CVE-2020-14343", "Arbitrary code execution in full_load",
                        Severity.LOW, "5.4", 5),
                new Vulnerability("CVE-2020-1747", "Unsafe YAML deserialization",
                        Severity.MEDIUM, "5.3.1", 7));

        ScanService service = new ScanService(deps, vulns);
        System.out.println("=== Maven deps ===");
        System.out.println(service.findByEcosystem(Ecosystem.MAVEN));
        System.out.println();
        System.out.println("=== NPM deps ===");
        System.out.println(service.findByEcosystem(Ecosystem.NPM));
        System.out.println();
        System.out.println("=== PYPI deps ===");
        System.out.println(service.findByEcosystem(Ecosystem.PYPI));
        System.out.println();
        System.out.println("=== Get By Id ===");
        System.out.println(service.getById(7));
        System.out.println();
        System.out.println("=== Get By Id ===");
        try {
            System.out.println(service.getById(99));
        } catch (DependencyNotFoundException e) {
            System.out.println("Cought: " + e.getMessage());
        }
        System.out.println();
        System.out.println("=== Find By Id ===");
        System.out.println(service.findById(2));
        System.out.println();
        System.out.println("=== Find By Id ===");
        System.out.println(service.findById(99));
        System.out.println();
        System.out.println("=== Find By Severity at least HIGH ===");
        System.out.println(service.findBySeverityAtLeast(Severity.HIGH));
        System.out.println();
        System.out.println("=== Find By Severity at least CRITICAL ===");
        System.out.println(service.findBySeverityAtLeast(Severity.CRITICAL));
        System.out.println();
        System.out.println("=== Group By Severity ===");
        System.out.println(service.groupBySeverity());
        System.out.println();
        System.out.println("=== Count By Severity ===");
        System.out.println(service.countBySeverity());
        System.out.println();
        System.out.println("=== Vulnerable Dependencies ===");
        System.out.println(service.vulnerableDependencies());
        System.out.println();
        System.out.println("=== Top Risky ===");
        System.out.println(service.topRisky(3));
        System.out.println();
        System.out.println("=== Report ===");
        System.out.println(service.reportLine());

    }

}
