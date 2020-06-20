SELECT OBJECT_NAME(c.id) as table_name, c.name, 
	(case t.type when 39 then 'varchar(' + Cast(c.length as varchar) + ')'
			else t.name end) AS data_type,
    com.text AS default_text
FROM syscolumns c
	LEFT JOIN systypes t ON c.type = t.type 
			AND c.xtype = t.xtype
	LEFT JOIN syscomments com ON com.id = c.cdefault
WHERE OBJECT_NAME(c.id) in ('OtrosCedula','EntradasCedula','BitacoraCedula','EdosCedula','Cedula','RecibosCedula')
ORDER BY table_name, c.colorder;
