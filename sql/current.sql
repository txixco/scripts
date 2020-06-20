
---------------------------------------------------------------------------------------------------------
-------------------------------------------- CAMPAIGNMEMBER ---------------------------------------------
---------------------------------------------------------------------------------------------------------

SELECT DISTINCT
    '_Total Count' jira_number, '' jira_bug, '' jira_bug_comment,
    'Campaignmember' object_name, 'Number of Campaignmember in West' jira_desc,
    to_char(sysdate, 'DD-MON-YYYY') TEST_DATE, '-' IS_CRITICAL,
    --count(*) NB_RECORDS
    to_char(trg.id) west_id, 'Not Application' inxpo_id,  'Not Application' west_value, 'Not Application' inxpo_value
FROM
    sfdc.v_sf_inx_trg_campaignmember trg

UNION ALL

SELECT DISTINCT
    '_Total Count' jira_number, '' jira_bug, '' jira_bug_comment,
    'Campaignmember' object_name, 'Number of Campaignmember in INXPO' jira_desc,
    to_char(sysdate, 'DD-MON-YYYY') TEST_DATE, '-' IS_CRITICAL,
    --count(*) NB_RECORDS
    'Not Application' west_id,  TO_CHAR(src.id) inxpo_id, 'Not Application' west_value,  'Not Application' inxpo_value
FROM
    sfdc.v_sf_inx_src_campaignmember src

UNION ALL

SELECT DISTINCT
    'INXPO-232' jira_number, '' jira_bug, '' jira_bug_comment,
    'Campaignmember' object_name, 'Missing Campaignmember In Target' jira_desc,
    to_char(sysdate, 'DD-MON-YYYY') TEST_DATE, 'Yes' IS_CRITICAL,
    --count(*) NB_RECORDS
    'NULL' west_id, TO_CHAR(src.id) inxpo_id,  'Not Application' west_value, 'Not Application' inxpo_value
FROM
    sfdc.v_sf_inx_src_campaignmember src
WHERE
    NOT EXISTS ( SELECT trg.campaignmember_previous_id__c
                 FROM sfdc.v_sf_inx_trg_campaignmember trg
                 WHERE trg.campaignmember_previous_id__c  = src.id )

UNION ALL

SELECT DISTINCT
    'INXPO-232' jira_number, '' jira_bug, '' jira_bug_comment,
    'Campaignmember' object_name, 'Missing Campaignmember In Source' jira_desc,
    to_char(sysdate, 'DD-MON-YYYY') TEST_DATE, 'Yes' IS_CRITICAL,
    --count(*) NB_RECORDS
    to_char(trg.id) west_id, 'NULL' inxpo_id,  'Not Application' west_value, 'Not Application' inxpo_value
FROM
    sfdc.v_sf_inx_trg_campaignmember trg
WHERE
    NOT EXISTS ( SELECT src.id
                 FROM sfdc.v_sf_inx_src_campaignmember src
                 WHERE src.id = trg.campaignmember_previous_id__c )
