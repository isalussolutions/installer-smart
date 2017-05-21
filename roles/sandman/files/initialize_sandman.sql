-- initialize the sandman schema

LOCK TABLES config WRITE;
INSERT INTO config (id,config_type,key_name,value)
VALUES
(1,0,'Patient_1','Patient'),(2,0,'Patient_2','Patient?name=s'),
(3,0,'Default_Patient_3','Patient?birthdate=>2010-01-01&birthdate=<2011-12-31'),
(4,0,'Observation_1','Observation'),(5,0,'Observation_2','Observation?code=8480-6'),
(6,0,'Default_Observation_3','Observation?category=vital-signs'),
(7,0,'Observation_4','Observation?date=>2010-01-01&date=<2011-12-31'),
(8,0,'Condition_1','Condition'),
(9,0,'Default_Condition_2','Condition?onset=>2010-01-01&onset=<2011-12-31'),
(10,0,'Procedure_1','Procedure'),
(11,0,'Default_Procedure_2','Procedure?date=>2010-01-01&date=<2011-12-31'),
(12,0,'AllergyIntolerance_1','AllergyIntolerance'),
(13,0,'Default_AllergyIntolerance_2','AllergyIntolerance?date=>1999-01-01&date=<2011-12-31');
UNLOCK TABLES;

LOCK TABLES `user` WRITE;
INSERT INTO `user` (`id`,`created_timestamp`,`ldap_id`,`name`)
VALUES (1,now(),'admin','Admin');
UNLOCK TABLES;

LOCK TABLES `system_role` WRITE;
INSERT INTO `system_role` (`user_id`,`role`)
VALUES (1,0),(1,2);
UNLOCK TABLES;
