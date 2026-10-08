DROP TABLE IF EXISTS dependency_vulnerabilities;
DROP TABLE IF EXISTS vulnerabilities;
DROP TABLE IF EXISTS dependencies;
DROP TABLE IF EXISTS projects;
DROP TABLE IF EXISTS users;


CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    created_at TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE projects (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL REFERENCES users(id),
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE dependencies (
    id BIGSERIAL PRIMARY KEY,
    project_id BIGINT NOT NULL REFERENCES projects(id),
    name VARCHAR(255) NOT NULL,
    version VARCHAR(50) NOT NULL,
    ecosystem VARCHAR(20) NOT NULL CHECK (ecosystem IN ('MAVEN', 'NPM','PYPI'))
);

CREATE TABLE vulnerabilities (
    id BIGSERIAL PRIMARY KEY,
    osv_id VARCHAR(50) NOT NULL UNIQUE,
    description TEXT NOT NULL,
    severity VARCHAR(10) NOT NULL CHECK (severity IN ('LOW', 'MEDIUM', 'HIGH', 'CRITICAL')),
    fixed_version VARCHAR(50)
);

CREATE TABLE dependency_vulnerabilities (
    dependency_id BIGINT NOT NULL REFERENCES dependencies(id),
    vulnerability_id BIGINT NOT NULL REFERENCES vulnerabilities(id),
    PRIMARY KEY (dependency_id, vulnerability_id)
);