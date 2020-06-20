SELECT tc.table_name, tc.column_name
FROM dba_tab_columns tc
  INNER JOIN dba_tab_columns msa ON (tc.column_name = msa.column_name)
WHERE tc.owner = 'SFDC'
  AND msa.table_name = 'SF_QA_INX_CONTACT'
  AND tc.table_name NOT LIKE '%$%'
ORDER BY 1, 2;

SELECT tc.table_name, tc.column_name
FROM dba_tab_columns tc
WHERE tc.owner = 'SFDC'
  AND tc.table_name = 'SF_QA_INX_CONTACT'
ORDER BY 1, 2;
