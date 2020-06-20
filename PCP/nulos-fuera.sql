-- Nulos en COMPONENTE
UPDATE componente SET descripcion = id_nombre WHERE descripcion IS NULL OR descripcion = '';
UPDATE componente SET usuario_modificador = 'CONSULT20' WHERE usuario_modificador IS NULL OR usuario_modificador = '';
UPDATE componente SET usuario_creador = usuario_modificador WHERE usuario_creador IS NULL OR usuario_creador = '';
UPDATE componente SET duenno = usuario_modificador WHERE duenno IS NULL OR duenno = '';
UPDATE componente SET etiqueta = 'Etiqueta' WHERE etiqueta IS NULL OR etiqueta = '';
UPDATE componente SET justificacion = 'Justificación' WHERE justificacion IS NULL OR justificacion = '';
UPDATE componente SET nombre_java = 'NombreJava' WHERE nombre_java IS NULL OR nombre_java = '';
UPDATE componente SET nombre_tabla = 'NOMBRE_TABLA' WHERE nombre_tabla IS NULL OR nombre_tabla = '';
UPDATE componente SET peticion = 'Petición' WHERE peticion IS NULL OR peticion = '';
UPDATE componente SET tipo_dato = 'Texto' WHERE tipo_dato IS NULL OR tipo_dato = '';

-- Nulos en DOCUMENTO
UPDATE documento SET nombre = 'Nombre' WHERE nombre IS NULL OR nombre = '';
UPDATE documento SET id_tipo_componente = 1 WHERE id_tipo_componente IS NULL OR id_tipo_componente = '';
UPDATE documento SET id_componente = 1 WHERE id_componente IS NULL OR id_componente = '';
UPDATE documento SET id_instancia_componente = 1 WHERE id_instancia_componente IS NULL OR id_instancia_componente = '';
UPDATE documento SET fecha_registro = now() WHERE fecha_registro IS NULL OR fecha_registro = '';
UPDATE documento SET usuario_registro = 'consult20' WHERE usuario_registro IS NULL OR usuario_registro = '';

-- Nulos en INSTANCIA_PROPIEDAD
UPDATE instancia_propiedad SET cad_valor = 'valor' WHERE cad_valor IS NULL OR cad_valor = '';
UPDATE instancia_propiedad SET id_nombre_componente = 'Componente' WHERE id_nombre_componente IS NULL OR id_nombre_componente = '';
UPDATE instancia_propiedad SET id_nombre_propiedad = 'Propiedad' WHERE id_nombre_propiedad IS NULL OR id_nombre_propiedad = '';
UPDATE instancia_propiedad SET id_nombre_tipo_componente = 'Tipo Componente' WHERE id_nombre_tipo_componente IS NULL OR id_nombre_tipo_componente = '';

-- Nulos en REGISTRO_CATALOGO
UPDATE registro_catalogo SET valor = 'valor' WHERE valor IS NULL OR valor = '';
UPDATE registro_catalogo SET descripcion = 'descripción' WHERE descripcion IS NULL OR descripcion = '';

-- Nulos en TIPO_OPERACION
UPDATE tipo_operacion SET descripcion = id_nombre WHERE descripcion IS NULL OR descripcion = '';

-- Nulos en COMENTARIO
UPDATE comentario SET comentario = 'comentario' WHERE comentario IS NULL OR comentario = '';

-- Nulos en TIPO_PROPIEDAD
UPDATE tipo_propiedad SET id_nombre = 'id_nombre' WHERE id_nombre IS NULL OR id_nombre = '';

-- Nulos en VALOR_OBJETO_NEGOCIO_X_ACT
UPDATE valor_objeto_negocio_x_act SET valor = 'valor' WHERE valor IS NULL OR valor = '';
