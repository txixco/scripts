----------------------------------
--INSERTA UN NUEVO TIPO DE USUARIO
--05/11/2004
----------------------------------
INSERT INTO dfc_usertype (usertype_id,father_id,usertype_name,deleted) VALUES (34110,34100,'New User Type',NULL) ;
UPDATE dfc_usertype SET usertype_name = 'Rep' WHERE usertype_id = 34110 ;

INSERT INTO dfc_usertype (usertype_id,father_id,usertype_name,deleted) VALUES (34120,34100,'New User Type',NULL) ;
UPDATE dfc_usertype SET usertype_name = 'Ga' WHERE usertype_id = 34120 ;

INSERT INTO dfc_usertype (usertype_id,father_id,usertype_name,deleted) VALUES (34130,34100,'New User Type',NULL) ;
UPDATE dfc_usertype SET usertype_name = 'HO Oracle' WHERE usertype_id = 34130 ;


INSERT INTO dfc_usertype (usertype_id,father_id,usertype_name,deleted) VALUES (34131,34130,'New User Type',NULL) ;
UPDATE dfc_usertype SET usertype_name = 'JV' WHERE usertype_id = 34131 ;

INSERT INTO dfc_usertype (usertype_id,father_id,usertype_name,deleted) VALUES (34132,34130,'New User Type',NULL) ;
UPDATE dfc_usertype SET usertype_name = 'OP Acciones' WHERE usertype_id = 34132 ;

-------------------------------------
INSERT INTO dfc_usertype (usertype_id,father_id,usertype_name,deleted) VALUES (34133,34130,'New User Type',NULL) ;
UPDATE dfc_usertype SET usertype_name = 'OP Expenses' WHERE usertype_id = 34133 ;

INSERT INTO dfc_usertype (usertype_id,father_id,usertype_name,deleted) VALUES (34134,34130,'New User Type',NULL) ;
UPDATE dfc_usertype SET usertype_name = 'JV Libra' WHERE usertype_id = 34134 ;
