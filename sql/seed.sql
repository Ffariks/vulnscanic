INSERT INTO users (email)
VALUES ('farik@example.com');

INSERT INTO projects (user_id, name)
VALUES (1, 'my-backend');

INSERT INTO dependencies (project_id, name, version, ecosystem)
VALUES (1, 'jackson-databind', '2.9.0',    'MAVEN'),
       (1, 'lodash',           '4.17.11',  'NPM'),
       (1, 'guava',            '30.0-jre', 'MAVEN'),
       (1, 'log4j-core',       '2.14.0',   'MAVEN'),
       (1, 'requests',         '2.19.1',   'PYPI'),
       (1, 'express',          '4.16.0',   'NPM'),
       (1, 'pyyaml',           '5.1',      'PYPI');

INSERT INTO vulnerabilities (osv_id, description, severity, fixed_version)
VALUES ('CVE-2019-12384', 'Deserialization of untrusted data',     'CRITICAL', '2.9.9'),
       ('CVE-2018-7489',  'Incomplete blacklist bypass',           'HIGH',     '2.9.5'),
       ('CVE-2019-10744', 'Prototype pollution in defaultsDeep',   'HIGH',     '4.17.12'),
       ('CVE-2021-44228', 'Remote code execution via JNDI lookup', 'CRITICAL', '2.15.0'),
       ('CVE-2018-18074', 'Credentials leaked on redirect',        'MEDIUM',   '2.20.0'),
       ('CVE-2020-14343', 'Arbitrary code execution in full_load', 'LOW',      '5.4'),
       ('CVE-2020-1747',  'Unsafe YAML deserialization',           'MEDIUM',   '5.3.1');

INSERT INTO dependency_vulnerabilities (dependency_id, vulnerability_id)
VALUES (1, 1),
       (1, 2),
       (2, 3),
       (4, 4),
       (5, 5),
       (5, 6),
       (7, 7);