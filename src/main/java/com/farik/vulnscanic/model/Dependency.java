package com.farik.vulnscanic.model;

public record Dependency(long id, String name, String version, Ecosystem ecosystem) {
}