USE sandman;

SET AUTOCOMMIT = 0;

START TRANSACTION;

INSERT INTO config (id, config_type, key_name, value)
VALUES
  (1, 0, 'Patient_1', 'Patient'),
  (2, 0, 'Patient_2', 'Patient?name=s'),
  (3, 0, 'Default_Patient_3', 'Patient?birthdate=>2010-01-01&birthdate=<2011-12-31'),
  (4, 0, 'Observation_1', 'Observation'),
  (5, 0, 'Observation_2', 'Observation?code=8480-6'),
  (6, 0, 'Default_Observation_3', 'Observation?category=vital-signs'),
  (7, 0, 'Observation_4', 'Observation?date=>2010-01-01&date=<2011-12-31'),
  (8, 0, 'Condition_1', 'Condition'),
  (9, 0, 'Condition_2', 'Condition?onset=>2010-01-01&onset=<2011-12-31'),
  (10, 0, 'Procedure_1', 'Procedure'),
  (11, 0, 'Default_Procedure_2', 'Procedure?date=>2010-01-01&date=<2011-12-31'),
  (12, 0, 'AllergyIntolerance_1', 'AllergyIntolerance'),
  (13, 0, 'Default_AllergyIntolerance_2', 'AllergyIntolerance?date=>1999-01-01&date=<2011-12-31'),
  (14, 0, 'Default_Condition_3', 'Condition?code:text=diabetes');

INSERT INTO user (id, created_timestamp, sbm_user_id, name, email)
VALUES (1, '2017-03-15 16:40:08', 'admin', 'Admin User', 'admin@example.com');

INSERT INTO system_role (user_id, role)
VALUES (1, 0), (1, 2);

INSERT INTO sandbox (id, allow_open_access, created_timestamp, description, name, sandbox_id, schema_version, created_by_id, fhir_server_end_point, visibility)
VALUES
  (1, '', '2017-03-15 16:46:06', 'HSPC Development Sandbox v1', 'HSPC Sandbox v1', 'hspc1', '1', 1, null, 1),
  (2, '', '2017-03-15 16:46:50', 'HSPC Development Sandbox v4', 'HSPC Sandbox v4', 'hspc4', '4', 1, null, 1);

INSERT INTO user_sandbox (user_id, sandbox_id)
VALUES (1, 1), (1, 2);

INSERT INTO user_role (id, role, user_id)
VALUES (1, 0, 1), (2, 3, 1), (3, 4, 1), (4, 0, 1), (5, 3, 1), (6, 4, 1);

INSERT INTO sandbox_user_roles (sandbox, user_roles)
VALUES (1, 1), (1, 2), (1, 3), (2, 4), (2, 5), (2, 6);

INSERT INTO auth_client (id, auth_database_id, client_id, client_name, logo_uri)
VALUES
  (1, 8, 'bp_centiles', 'BP Centiles', 'http://localhost:8080/hspc-reference-apps/static/images/apps/bpc.png'),
  (2, 9, 'cardiac_risk', 'Cardiac Risk', 'http://localhost:8080/hspc-reference-apps/static/images/apps/cardio.png'),
  (3, 18, 'growth_chart', 'Growth Chart', 'http://localhost:8080/hspc-reference-apps/static/images/apps/pgc.png');

INSERT INTO app (id, created_timestamp, launch_uri, logo_uri, visibility, auth_client_id, created_by_id, logo_id, sandbox_id)
VALUES
  (1, now(), 'http://localhost:8080/hspc-reference-apps/static/apps/bp-centiles/launch.html',
   'http://localhost:8080/hspc-reference-apps/static/images/apps/bpc.png', 0, 1, 1, NULL, 1),
  (2, now(), 'http://localhost:8080/hspc-reference-apps/static/apps/cardiac-risk/launch.html',
   'http://localhost:8080/hspc-reference-apps/static/images/apps/cardio.png', 0, 2, 1, NULL, 1),
  (3, now(), 'http://localhost:8080/hspc-reference-apps/static/apps/growth-chart/launch.html',
   'http://localhost:8080/hspc-reference-apps/static/images/apps/pgc.png', 0, 3, 1, NULL, 1),
  (4, now(), 'http://localhost:8080/hspc-reference-apps/static/apps/bp-centiles/launch.html',
   'http://localhost:8080/hspc-reference-apps/static/images/apps/bpc.png', 0, 1, 1, NULL, 2),
  (5, now(), 'http://localhost:8080/hspc-reference-apps/static/apps/cardiac-risk/launch.html',
   'http://localhost:8080/hspc-reference-apps/static/images/apps/cardio.png', 0, 2, 1, NULL, 2),
  (6, now(), 'http://localhost:8080/hspc-reference-apps/static/apps/growth-chart/launch.html',
   'http://localhost:8080/hspc-reference-apps/static/images/apps/pgc.png', 0, 3, 1, NULL, 2);

COMMIT;

SET AUTOCOMMIT = 1;
