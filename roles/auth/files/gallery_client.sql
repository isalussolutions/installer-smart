-- noinspection SqlNoDataSourceInspectionForFile
-- noinspection SqlDialectInspectionForFile
SET AUTOCOMMIT = 0;

START TRANSACTION;

-- Sandbox Manager

INSERT INTO client_details (client_id, client_name, access_token_validity_seconds, token_endpoint_auth_method) VALUES
  ('hspc_gallery', 'HSPC Gallery', 86400, 'NONE');

/*
INSERT INTO client_redirect_uri (owner_id, redirect_uri) VALUES
  ((SELECT id from client_details where client_id = 'hspc_gallery'), 'http://localhost:8080/hspc-gallery'),
  ((SELECT id from client_details where client_id = 'hspc_gallery'), 'http://54.213.219.198:9080/uat/hspc-gallery'),
  ((SELECT id from client_details where client_id = 'hspc_gallery'), 'http://ec2-54-191-52-193.us-west-2.compute.amazonaws.com/proxy'),
  ((SELECT id from client_details where client_id = 'hspc_gallery'), 'https://sandbox.hspconsortium.org/hspc-gallery');
*/

INSERT INTO client_scope (owner_id, scope) VALUES
  ((SELECT id from client_details where client_id = 'hspc_gallery'), 'user/*.*'),
  ((SELECT id from client_details where client_id = 'hspc_gallery'), 'smart/orchestrate_launch'),
  ((SELECT id from client_details where client_id = 'hspc_gallery'), 'openid'),
  ((SELECT id from client_details where client_id = 'hspc_gallery'), 'profile');

INSERT INTO client_grant_type (owner_id, grant_type) VALUES
  ((SELECT id from client_details where client_id = 'hspc_gallery'), 'authorization_code');

INSERT INTO whitelisted_site (creator_user_id, client_id) VALUES
  ('admin', 'hspc_gallery');

INSERT INTO whitelisted_site_scope (owner_id, scope) VALUES
  ((SELECT id from whitelisted_site where client_id = 'hspc_gallery'), 'user/*.*');

INSERT INTO whitelisted_site_scope (owner_id, scope) VALUES
  ((SELECT id from whitelisted_site where client_id = 'hspc_gallery'), 'smart/orchestrate_launch');

INSERT INTO whitelisted_site_scope (owner_id, scope) VALUES
  ((SELECT id from whitelisted_site where client_id = 'hspc_gallery'), 'openid');

INSERT INTO whitelisted_site_scope (owner_id, scope) VALUES
  ((SELECT id from whitelisted_site where client_id = 'hspc_gallery'), 'profile');

COMMIT;

SET AUTOCOMMIT = 1;
