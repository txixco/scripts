--Crea xp_md5 en el master


USE master;
EXEC sp_addextendedproc 'xp_md5', 'xp_md5.dll'