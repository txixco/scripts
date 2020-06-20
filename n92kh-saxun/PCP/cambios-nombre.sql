-- Tablas a renombrar
RENAME TABLE configuracion_gestor_doc TO config_gestor_doc;
RENAME TABLE componentes_base_comp_det TO detalles_componente;
RENAME TABLE reg_cat_padres_reg_cat_hijos TO reg_catalogo_hijos;
RENAME TABLE tipo_componente_x_tipo_doc TO tipo_comp_x_tipo_doc;
RENAME TABLE valor_objeto_negocio_x_act TO val_obj_neg_x_act;

-- Campos a renombrar
ALTER TABLE inventario_catalogo CHANGE COLUMN precission prexision DECIMAL(8,2) NULL DEFAULT NULL;
ALTER TABLE componente CHANGE COLUMN listavalores_id id_lista_valores DECIMAL(8,2) NULL DEFAULT NULL;
ALTER TABLE rel_act_solicitud CHANGE COLUMN id_rel_act_solicitud_actual rel_act_sol_act DECIMAL(8,2) NULL DEFAULT NULL;
ALTER TABLE val_obj_neg_x_act CHANGE COLUMN ID_OBJETO_NEGOCIO_X_ACTIVIDAD obj_neg_x_act DECIMAL(8,2) NULL DEFAULT NULL;

-- Campos a eliminar
ALTER TABLE solicitud_actual DROP id_solicitud;
ALTER TABLE componente DROP permisos_id;
