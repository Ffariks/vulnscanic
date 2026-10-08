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

SELECT dependencies.name, dependencies.version,
MAX(CASE severity
WHEN 'CRITICAL' THEN 4
WHEN 'HIGH' THEN 3
WHEN 'MEDIUM' THEN 2
WHEN 'LOW' THEN 1
END) AS worst_severity, 
COUNT(vulnerability_id) AS vulnerability_count
FROM dependencies
JOIN dependency_vulnerabilities ON dependencies.id = dependency_vulnerabilities.dependency_id
JOIN vulnerabilities ON vulnerabilities.id = dependency_vulnerabilities.vulnerability_id
GROUP BY dependencies.id
ORDER BY worst_severity DESC, vulnerability_count DESC
LIMIT 3;

SELECT dependencies.name, dependencies.version, vulnerabilities.osv_id, vulnerabilities.severity, vulnerabilities.fixed_version,
CASE severity
WHEN 'CRITICAL' THEN 4
WHEN 'HIGH' THEN 3
WHEN 'MEDIUM' THEN 2
WHEN 'LOW' THEN 1
END AS worst_severity
FROM dependencies
JOIN dependency_vulnerabilities ON dependencies.id = dependency_vulnerabilities.dependency_id
JOIN vulnerabilities ON vulnerabilities.id = dependency_vulnerabilities.vulnerability_id
ORDER BY worst_severity DESC;