
ALTER SESSION SET CURRENT_SCHEMA = icrm_icrmr_db;

AUTOMATION_AUTOMATION_ORACLE
 
 select * from LOCKS WHERE LK_USER = 'ririgoye';

select * from v$version

DELETE FROM LOCKS WHERE LK_USER = 'ririgoye' ;
DELETE FROM LOCKS WHERE LK_USER = 'frueda' ;
AND LK_OBJECT_TYPE = 'TEST' ;

select SYS_CONTEXT('userenv','current_schema') from dual;