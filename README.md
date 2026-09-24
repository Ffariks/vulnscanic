# vulnscanic

A dependency vulnerability scanner.

Takes a dependency manifest (`pom.xml`, `package-lock.json`), matches the
libraries and their versions against the [OSV.dev](https://osv.dev/) database
of known vulnerabilities, and reports what is affected, how severe it is, and
which version fixes it.

## Status

In development. Completed: domain model, ScanService with Stream API queries.
Next: PostgreSQL persistence.

## Stack

- Java 21
- Maven
- JUnit 5

Planned: Spring Boot, PostgreSQL, Docker, React, AWS.

## Running

```bash
mvn clean test
```

## Structure

```
src/main/java/com/farik/vulnscanic/
├── model/      — domain models
├── service/    — business logic
└── exception/  — custom exceptions
```
