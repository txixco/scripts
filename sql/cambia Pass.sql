DECLARE @BCP_Numero INT
DECLARE @Usu_Usuario VARCHAR(50)
DECLARE @NUEVOPASS VARCHAR(50)

--select * from usuarios where  --usu_usuario = 'AMARCEB'
--usu_appat = 'de anda'

SET @Usu_Usuario = 'OPFRONT'  --178264
SET @NUEVOPASS = 'Pruebas09'
SET @BCP_Numero = 0

--DBO.fn_md5(@NUEVOPASS) 
UPDATE USUARIOS SET Usu_Password = DBO.fn_md5(@NUEVOPASS)--@NUEVOPASS
WHERE Usu_Usuario = @Usu_Usuario

SET @BCP_Numero = (SELECT TOP 1 ISNULL(BCP_Numero,0)
					 FROM BitacoraCambioPassword 
					WHERE USU_USUARIO = @Usu_Usuario 
					ORDER BY BCP_Fecha DESC )
IF @BCP_Numero <> 0 
	BEGIN
		--DBO.fn_md5(@NUEVOPASS) 
		UPDATE  BitacoraCambioPassword SET BCP_PasNue = DBO.fn_md5(@NUEVOPASS)--@NUEVOPASS
		,BCP_Fecha=getdate()
		WHERE Usu_Usuario = @Usu_Usuario AND BCP_Numero = @BCP_Numero 
		
	END
ELSE
	BEGIN 
		PRINT 'NO SE AUCTUALIZO BIEN EL CAMBIO DE PASSWORD'
	END 


--select * from BitacoraCambioPassword


select CVEPROVEEDOR ,ctl_fecenvageinv ,ctl_fecrecageinv ,* from control
where sol_numero = 179237


update control set ctl_fecrecageinv='2009-05-12 00:00:00.000'
where sol_numero = 179237
