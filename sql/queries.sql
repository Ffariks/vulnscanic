-- 1. All dependencies from the MAVEN ecosystem
SELECT * 
FROM dependencies 
WHERE ecosystem = 'MAVEN';

-- 2. Single dependency looked up by its primary key
SELECT * 
FROM dependencies 
WHERE id = 4;

-- 3. All CRITICAL vulnerabilities, ordered by their OSV identifier
SELECT * 
FROM vulnerabilities 
WHERE severity = 'CRITICAL' 
ORDER BY osv_id;

-- 4. How many vulnerabilities there are at each severity level
SELECT severity, COUNT(*) AS vulnerability_count
FROM vulnerabilities 
GROUP BY severity;

-- 5. Every dependency paired with each vulnerability affecting it
SELECT name, version, osv_id, severity 
FROM dependencies
JOIN dependency_vulnerabilities ON dependencies.id = dependency_vulnerabilities.dependency_id
JOIN vulnerabilities ON vulnerabilities.id = dependency_vulnerabilities.vulnerability_id;

-- 6. Dependencies that have at least one vulnerability, no duplicates
SELECT DISTINCT id, project_id, name, version, ecosystem
FROM dependencies
JOIN dependency_vulnerabilities ON dependencies.id = dependency_vulnerabilities.dependency_id;

-- 7. Dependencies with no known vulnerabilities at all
SELECT *
FROM dependencies
LEFT JOIN dependency_vulnerabilities ON dependencies.id = dependency_vulnerabilities.dependency_id
WHERE vulnerability_id IS NULL;

-- 8. Vulnerability count per dependency, including those with none
SELECT dependencies.name, COUNT(vulnerability_id) AS vulnerability_count
FROM dependencies
LEFT JOIN dependency_vulnerabilities ON dependencies.id = dependency_vulnerabilities.dependency_id
GROUP BY dependencies.id;
