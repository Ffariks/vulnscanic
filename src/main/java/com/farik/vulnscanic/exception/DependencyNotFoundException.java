package com.farik.vulnscanic.exception;

public class DependencyNotFoundException extends RuntimeException{
    public DependencyNotFoundException(long id) {
        super("Dependency with id " + id + " not found");
    }
}
