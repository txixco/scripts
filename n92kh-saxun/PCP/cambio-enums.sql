UPDATE Componente SET Estado = 'Activo' WHERE Estado = 'ACTIVO';
UPDATE Componente SET Estado = 'Inactivo' WHERE Estado = 'INACTIVO';
UPDATE Componente SET Estado = 'Pendiente_Revision' WHERE Estado = 'PENDIENTE_REVISION';

UPDATE Tipo_Componente SET Estado = 'Activo' WHERE Estado = 'ACTIVO';
UPDATE Tipo_Componente SET Estado = 'Inactivo' WHERE Estado = 'INACTIVO';
UPDATE Tipo_Componente SET Estado = 'Pendiente_Revision' WHERE Estado = 'PENDIENTE_REVISION';

UPDATE Componente SET Tipo_Dato = 'Texto' WHERE Tipo_Dato = 'TEXTO';
UPDATE Componente SET Tipo_Dato = 'Decimal' WHERE Tipo_Dato = 'DECIMAL';
UPDATE Componente SET Tipo_Dato = 'Entero' WHERE Tipo_Dato = 'ENTERO';
UPDATE Componente SET Tipo_Dato = 'Booleano' WHERE Tipo_Dato = 'BOOLEANO';
UPDATE Componente SET Tipo_Dato = 'Doble' WHERE Tipo_Dato = 'DOBLE';
UPDATE Componente SET Tipo_Dato = 'Flotante' WHERE Tipo_Dato = 'FLOTANTE';
UPDATE Componente SET Tipo_Dato = 'Lista_Valores' WHERE Tipo_Dato = 'LISTA_VALORES';
UPDATE Componente SET Tipo_Dato = 'Fecha' WHERE Tipo_Dato = 'FECHA';
UPDATE Componente SET Tipo_Dato = 'Lista' WHERE Tipo_Dato = 'LISTA';

UPDATE Propiedad SET Estado = 'Activo' WHERE Estado = 'ACTIVO';
UPDATE Propiedad SET Estado = 'Inactivo' WHERE Estado = 'INACTIVO';
UPDATE Propiedad SET Estado = 'Pendiente_Revision' WHERE Estado = 'PENDIENTE_REVISION';

UPDATE Tipo_Propiedad SET Estado = 'Activo' WHERE Estado = 'ACTIVO';
UPDATE Tipo_Propiedad SET Estado = 'Inactivo' WHERE Estado = 'INACTIVO';
UPDATE Tipo_Propiedad SET Estado = 'Pendiente_Revision' WHERE Estado = 'PENDIENTE_REVISION';

SELECT DISTINCT estado FROM componente;
SELECT DISTINCT estado FROM tipo_componente;
SELECT DISTINCT tipo_dato FROM componente;
SELECT DISTINCT estado FROM propiedad;
SELECT DISTINCT estado FROM tipo_propiedad;
