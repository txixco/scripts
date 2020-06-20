SELECT (SELECT COUNT(*) FROM &tabla16) &tabla16, 
       (SELECT COUNT(*) FROM &tabla20 WHERE usuario_modificador <> 'CARGAINICIAL') &tabla20
FROM dual
