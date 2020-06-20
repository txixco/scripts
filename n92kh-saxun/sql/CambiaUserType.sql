---------------------------------------
--MODIFICA EL ID DE UN TIPO DE USUARIO
--26/08/2004
---------------------------------------

UPDATE dfc_usertype SET usertype_id=34111 where usertype_id=101 ;
UPDATE dfc_usertype SET father_id=34111 where father_id=101 ;
UPDATE dfc_attrib SET usertype_id=34111 where usertype_id=101 ;
UPDATE dfc_btnlook SET usertype_id=34111 where usertype_id=101 ;
UPDATE dfc_controls SET usertype_id=34111 where usertype_id=101 ;
UPDATE dfc_ctrlfield SET usertype_id=34111 where usertype_id=101 ;
UPDATE dfc_gridcols SET usertype_id=34111 where usertype_id=101 ;
UPDATE dfc_gridctrl SET usertype_id=34111 where usertype_id=101 ;
UPDATE dfc_looks SET usertype_id=34111 where usertype_id=101 ;
UPDATE dfc_menu SET usertype_id=34111 where usertype_id=101 ;
UPDATE dfc_taborders SET usertype_id=34111 where usertype_id=101 ;
UPDATE dfc_tabs SET usertype_id=34111 where usertype_id=101 ;
UPDATE dfc_userlang SET usertype_id=34111 where usertype_id=101 ;
