SELECT DISTINCT
    'INXPO-172' jira_number, '' jira_bug, '' jira_bug_comment, 
    'Case' object_name, 'Type Field Mismatch' jira_desc, 
    TO_CHAR(SYSDATE, 'DD-MON-YYYY') test_date, TO_CHAR(trg.id) west_id, 
    TO_CHAR(src.id) inxpo_id, NVL(TO_CHAR(trg.Type), 'NULL') west_value, 
    NVL(TO_CHAR(src.Type), 'NULL') inxpo_value
FROM 
    sfdc.v_sf_inx_src_case src
    JOIN sfdc.v_sf_inx_trg_case trg ON (src.casenumber = trg.casenumber)
WHERE
    NVL(TO_CHAR(trg.Type), 'NULL') <> NVL(TO_CHAR(src.Type), 'NULL')

UNION ALL

SELECT DISTINCT
    'INXPO-172' jira_number, '' jira_bug, '' jira_bug_comment, 
    'Case' object_name, 'Won_Lost__c Field Mismatch' jira_desc, 
    TO_CHAR(SYSDATE, 'DD-MON-YYYY') test_date, TO_CHAR(trg.id) west_id, 
    TO_CHAR(src.id) inxpo_id, NVL(TO_CHAR(trg.Won_Lost__c), 'NULL') west_value, 
    NVL(TO_CHAR(src.Won_Lost__c), 'NULL') inxpo_value
FROM 
    sfdc.v_sf_inx_src_case src
    JOIN sfdc.v_sf_inx_trg_case trg ON (src.casenumber = trg.casenumber)
WHERE
    NVL(TO_CHAR(trg.Won_Lost__c), 'NULL') <> NVL(TO_CHAR(src.Won_Lost__c), 'NULL')

UNION ALL

SELECT DISTINCT
    'INXPO-172' jira_number, '' jira_bug, '' jira_bug_comment, 
    'Case' object_name, 'At_Risk_Date__c Field Mismatch' jira_desc, 
    TO_CHAR(SYSDATE, 'DD-MON-YYYY') test_date, TO_CHAR(trg.id) west_id, 
    TO_CHAR(src.id) inxpo_id, NVL(TO_CHAR(trg.At_Risk_Date__c), 'NULL') west_value, 
    NVL(TO_CHAR(src.At_Risk_Date__c), 'NULL') inxpo_value
FROM 
    sfdc.v_sf_inx_src_case src
    JOIN sfdc.v_sf_inx_trg_case trg ON (src.casenumber = trg.casenumber)
WHERE
    NVL(TO_CHAR(trg.At_Risk_Date__c), 'NULL') <> NVL(TO_CHAR(src.At_Risk_Date__c), 'NULL')

UNION ALL

SELECT DISTINCT
    'INXPO-172' jira_number, '' jira_bug, '' jira_bug_comment, 
    'Case' object_name, 'Client_Temp__c Field Mismatch' jira_desc, 
    TO_CHAR(SYSDATE, 'DD-MON-YYYY') test_date, TO_CHAR(trg.id) west_id, 
    TO_CHAR(src.id) inxpo_id, NVL(TO_CHAR(trg.Client_Temp__c), 'NULL') west_value, 
    NVL(TO_CHAR(src.Client_Temp__c), 'NULL') inxpo_value
FROM 
    sfdc.v_sf_inx_src_case src
    JOIN sfdc.v_sf_inx_trg_case trg ON (src.casenumber = trg.casenumber)
WHERE
    NVL(TO_CHAR(trg.Client_Temp__c), 'NULL') <> NVL(TO_CHAR(src.Client_Temp__c), 'NULL')

UNION ALL

SELECT DISTINCT
    'INXPO-172' jira_number, '' jira_bug, '' jira_bug_comment, 
    'Case' object_name, 'Impairment_Severity__c Field Mismatch' jira_desc, 
    TO_CHAR(SYSDATE, 'DD-MON-YYYY') test_date, TO_CHAR(trg.id) west_id, 
    TO_CHAR(src.id) inxpo_id, NVL(TO_CHAR(trg.Impairment_Severity__c), 'NULL') west_value, 
    NVL(TO_CHAR(src.Impairment_Severity__c), 'NULL') inxpo_value
FROM 
    sfdc.v_sf_inx_src_case src
    JOIN sfdc.v_sf_inx_trg_case trg ON (src.casenumber = trg.casenumber)
WHERE
    NVL(TO_CHAR(trg.Impairment_Severity__c), 'NULL') <> NVL(TO_CHAR(src.Impairment_Severity__c), 'NULL')

UNION ALL

SELECT DISTINCT
    'INXPO-172' jira_number, '' jira_bug, '' jira_bug_comment, 
    'Case' object_name, 'Impairment_Date__c Field Mismatch' jira_desc, 
    TO_CHAR(SYSDATE, 'DD-MON-YYYY') test_date, TO_CHAR(trg.id) west_id, 
    TO_CHAR(src.id) inxpo_id, NVL(TO_CHAR(trg.Impairment_Date__c), 'NULL') west_value, 
    NVL(TO_CHAR(src.Impairment_Date__c), 'NULL') inxpo_value
FROM 
    sfdc.v_sf_inx_src_case src
    JOIN sfdc.v_sf_inx_trg_case trg ON (src.casenumber = trg.casenumber)
WHERE
    NVL(TO_CHAR(trg.Impairment_Date__c), 'NULL') <> NVL(TO_CHAR(src.Impairment_Date__c), 'NULL')

UNION ALL

SELECT DISTINCT
    'INXPO-172' jira_number, '' jira_bug, '' jira_bug_comment, 
    'Case' object_name, 'Reason Field Mismatch' jira_desc, 
    TO_CHAR(SYSDATE, 'DD-MON-YYYY') test_date, TO_CHAR(trg.id) west_id, 
    TO_CHAR(src.id) inxpo_id, NVL(TO_CHAR(trg.Reason), 'NULL') west_value, 
    NVL(TO_CHAR(src.Reason), 'NULL') inxpo_value
FROM 
    sfdc.v_sf_inx_src_case src
    JOIN sfdc.v_sf_inx_trg_case trg ON (src.casenumber = trg.casenumber)
WHERE
    NVL(TO_CHAR(trg.Reason), 'NULL') <> NVL(TO_CHAR(src.Reason), 'NULL')

UNION ALL

SELECT DISTINCT
    'INXPO-172' jira_number, '' jira_bug, '' jira_bug_comment, 
    'Case' object_name, 'Region__c Field Mismatch' jira_desc, 
    TO_CHAR(SYSDATE, 'DD-MON-YYYY') test_date, TO_CHAR(trg.id) west_id, 
    TO_CHAR(src.id) inxpo_id, NVL(TO_CHAR(trg.Region__c), 'NULL') west_value, 
    NVL(TO_CHAR(src.Region__c), 'NULL') inxpo_value
FROM 
    sfdc.v_sf_inx_src_case src
    JOIN sfdc.v_sf_inx_trg_case trg ON (src.casenumber = trg.casenumber)
WHERE
    NVL(TO_CHAR(trg.Region__c), 'NULL') <> NVL(TO_CHAR(src.Region__c), 'NULL')

UNION ALL

SELECT DISTINCT
    'INXPO-172' jira_number, '' jira_bug, '' jira_bug_comment, 
    'Case' object_name, 'Opportunity__c Field Mismatch' jira_desc, 
    TO_CHAR(SYSDATE, 'DD-MON-YYYY') test_date, TO_CHAR(trg.id) west_id, 
    TO_CHAR(src.id) inxpo_id, NVL(TO_CHAR(trg.Opportunity__c), 'NULL') west_value, 
    NVL(TO_CHAR(src.Opportunity__c), 'NULL') inxpo_value
FROM 
    sfdc.v_sf_inx_src_case src
    JOIN sfdc.v_sf_inx_trg_case trg ON (src.casenumber = trg.casenumber)
WHERE
    NVL(TO_CHAR(trg.Opportunity__c), 'NULL') <> NVL(TO_CHAR(src.Opportunity__c), 'NULL')

UNION ALL

SELECT DISTINCT
    'INXPO-172' jira_number, '' jira_bug, '' jira_bug_comment, 
    'Case' object_name, 'Event_Name__c Field Mismatch' jira_desc, 
    TO_CHAR(SYSDATE, 'DD-MON-YYYY') test_date, TO_CHAR(trg.id) west_id, 
    TO_CHAR(src.id) inxpo_id, NVL(TO_CHAR(trg.Event_Name__c), 'NULL') west_value, 
    NVL(TO_CHAR(src.Event_Name__c), 'NULL') inxpo_value
FROM 
    sfdc.v_sf_inx_src_case src
    JOIN sfdc.v_sf_inx_trg_case trg ON (src.casenumber = trg.casenumber)
WHERE
    NVL(TO_CHAR(trg.Event_Name__c), 'NULL') <> NVL(TO_CHAR(src.Event_Name__c), 'NULL')

UNION ALL

SELECT DISTINCT
    'INXPO-172' jira_number, '' jira_bug, '' jira_bug_comment, 
    'Case' object_name, 'ClosedDate Field Mismatch' jira_desc, 
    TO_CHAR(SYSDATE, 'DD-MON-YYYY') test_date, TO_CHAR(trg.id) west_id, 
    TO_CHAR(src.id) inxpo_id, NVL(TO_CHAR(trg.ClosedDate), 'NULL') west_value, 
    NVL(TO_CHAR(src.ClosedDate), 'NULL') inxpo_value
FROM 
    sfdc.v_sf_inx_src_case src
    JOIN sfdc.v_sf_inx_trg_case trg ON (src.casenumber = trg.casenumber)
WHERE
    NVL(TO_CHAR(trg.ClosedDate), 'NULL') <> NVL(TO_CHAR(src.ClosedDate), 'NULL')

UNION ALL

SELECT DISTINCT
    'INXPO-172' jira_number, '' jira_bug, '' jira_bug_comment, 
    'Case' object_name, 'ContactId Field Mismatch' jira_desc, 
    TO_CHAR(SYSDATE, 'DD-MON-YYYY') test_date, TO_CHAR(trg.id) west_id, 
    TO_CHAR(src.id) inxpo_id, NVL(TO_CHAR(trg.ContactId), 'NULL') west_value, 
    NVL(TO_CHAR(src.ContactId), 'NULL') inxpo_value
FROM 
    sfdc.v_sf_inx_src_case src
    JOIN sfdc.v_sf_inx_trg_case trg ON (src.casenumber = trg.casenumber)
WHERE
    NVL(TO_CHAR(trg.ContactId), 'NULL') <> NVL(TO_CHAR(src.ContactId), 'NULL')

UNION ALL

SELECT DISTINCT
    'INXPO-172' jira_number, '' jira_bug, '' jira_bug_comment, 
    'Case' object_name, 'AccountId Field Mismatch' jira_desc, 
    TO_CHAR(SYSDATE, 'DD-MON-YYYY') test_date, TO_CHAR(trg.id) west_id, 
    TO_CHAR(src.id) inxpo_id, NVL(TO_CHAR(trg.AccountId), 'NULL') west_value, 
    NVL(TO_CHAR(src.AccountId), 'NULL') inxpo_value
FROM 
    sfdc.v_sf_inx_src_case src
    JOIN sfdc.v_sf_inx_trg_case trg ON (src.casenumber = trg.casenumber)
WHERE
    NVL(TO_CHAR(trg.AccountId), 'NULL') <> NVL(TO_CHAR(src.AccountId), 'NULL')

UNION ALL

SELECT DISTINCT
    'INXPO-172' jira_number, '' jira_bug, '' jira_bug_comment, 
    'Case' object_name, 'SuppliedName Field Mismatch' jira_desc, 
    TO_CHAR(SYSDATE, 'DD-MON-YYYY') test_date, TO_CHAR(trg.id) west_id, 
    TO_CHAR(src.id) inxpo_id, NVL(TO_CHAR(trg.SuppliedName), 'NULL') west_value, 
    NVL(TO_CHAR(src.SuppliedName), 'NULL') inxpo_value
FROM 
    sfdc.v_sf_inx_src_case src
    JOIN sfdc.v_sf_inx_trg_case trg ON (src.casenumber = trg.casenumber)
WHERE
    NVL(TO_CHAR(trg.SuppliedName), 'NULL') <> NVL(TO_CHAR(src.SuppliedName), 'NULL')

UNION ALL

SELECT DISTINCT
    'INXPO-172' jira_number, '' jira_bug, '' jira_bug_comment, 
    'Case' object_name, 'SuppliedEmail Field Mismatch' jira_desc, 
    TO_CHAR(SYSDATE, 'DD-MON-YYYY') test_date, TO_CHAR(trg.id) west_id, 
    TO_CHAR(src.id) inxpo_id, NVL(TO_CHAR(trg.SuppliedEmail), 'NULL') west_value, 
    NVL(TO_CHAR(src.SuppliedEmail), 'NULL') inxpo_value
FROM 
    sfdc.v_sf_inx_src_case src
    JOIN sfdc.v_sf_inx_trg_case trg ON (src.casenumber = trg.casenumber)
WHERE
    NVL(TO_CHAR(trg.SuppliedEmail), 'NULL') <> NVL(TO_CHAR(src.SuppliedEmail), 'NULL')

UNION ALL

SELECT DISTINCT
    'INXPO-172' jira_number, '' jira_bug, '' jira_bug_comment, 
    'Case' object_name, 'Description Field Mismatch' jira_desc, 
    TO_CHAR(SYSDATE, 'DD-MON-YYYY') test_date, TO_CHAR(trg.id) west_id, 
    TO_CHAR(src.id) inxpo_id, NVL(TO_CHAR(trg.Description), 'NULL') west_value, 
    NVL(TO_CHAR(src.Description), 'NULL') inxpo_value
FROM 
    sfdc.v_sf_inx_src_case src
    JOIN sfdc.v_sf_inx_trg_case trg ON (src.casenumber = trg.casenumber)
WHERE
    NVL(TO_CHAR(trg.Description), 'NULL') <> NVL(TO_CHAR(src.Description), 'NULL')

UNION ALL

SELECT DISTINCT
    'INXPO-172' jira_number, '' jira_bug, '' jira_bug_comment, 
    'Case' object_name, 'Priority Field Mismatch' jira_desc, 
    TO_CHAR(SYSDATE, 'DD-MON-YYYY') test_date, TO_CHAR(trg.id) west_id, 
    TO_CHAR(src.id) inxpo_id, NVL(TO_CHAR(trg.Priority), 'NULL') west_value, 
    NVL(TO_CHAR(src.Priority), 'NULL') inxpo_value
FROM 
    sfdc.v_sf_inx_src_case src
    JOIN sfdc.v_sf_inx_trg_case trg ON (src.casenumber = trg.casenumber)
WHERE
    NVL(TO_CHAR(trg.Priority), 'NULL') <> NVL(TO_CHAR(src.Priority), 'NULL')

UNION ALL

SELECT DISTINCT
    'INXPO-172' jira_number, '' jira_bug, '' jira_bug_comment, 
    'Case' object_name, 'Origin Field Mismatch' jira_desc, 
    TO_CHAR(SYSDATE, 'DD-MON-YYYY') test_date, TO_CHAR(trg.id) west_id, 
    TO_CHAR(src.id) inxpo_id, NVL(TO_CHAR(trg.Origin), 'NULL') west_value, 
    NVL(TO_CHAR(src.Origin), 'NULL') inxpo_value
FROM 
    sfdc.v_sf_inx_src_case src
    JOIN sfdc.v_sf_inx_trg_case trg ON (src.casenumber = trg.casenumber)
WHERE
    NVL(TO_CHAR(trg.Origin), 'NULL') <> NVL(TO_CHAR(src.Origin), 'NULL')

UNION ALL

SELECT DISTINCT
    'INXPO-172' jira_number, '' jira_bug, '' jira_bug_comment, 
    'Case' object_name, 'Subject Field Mismatch' jira_desc, 
    TO_CHAR(SYSDATE, 'DD-MON-YYYY') test_date, TO_CHAR(trg.id) west_id, 
    TO_CHAR(src.id) inxpo_id, NVL(TO_CHAR(trg.Subject), 'NULL') west_value, 
    NVL(TO_CHAR(src.Subject), 'NULL') inxpo_value
FROM 
    sfdc.v_sf_inx_src_case src
    JOIN sfdc.v_sf_inx_trg_case trg ON (src.casenumber = trg.casenumber)
WHERE
    NVL(TO_CHAR(trg.Subject), 'NULL') <> NVL(TO_CHAR(src.Subject), 'NULL')

UNION ALL

SELECT DISTINCT
    'INXPO-172' jira_number, '' jira_bug, '' jira_bug_comment, 
    'Case' object_name, 'CaseNumber Field Mismatch' jira_desc, 
    TO_CHAR(SYSDATE, 'DD-MON-YYYY') test_date, TO_CHAR(trg.id) west_id, 
    TO_CHAR(src.id) inxpo_id, NVL(TO_CHAR(trg.CaseNumber), 'NULL') west_value, 
    NVL(TO_CHAR(src.CaseNumber), 'NULL') inxpo_value
FROM 
    sfdc.v_sf_inx_src_case src
    JOIN sfdc.v_sf_inx_trg_case trg ON (src.casenumber = trg.casenumber)
WHERE
    NVL(TO_CHAR(trg.CaseNumber), 'NULL') <> NVL(TO_CHAR(src.CaseNumber), 'NULL')

UNION ALL

SELECT DISTINCT
    'INXPO-172' jira_number, '' jira_bug, '' jira_bug_comment, 
    'Case' object_name, 'CreatedById Field Mismatch' jira_desc, 
    TO_CHAR(SYSDATE, 'DD-MON-YYYY') test_date, TO_CHAR(trg.id) west_id, 
    TO_CHAR(src.id) inxpo_id, NVL(TO_CHAR(trg.CreatedById), 'NULL') west_value, 
    NVL(TO_CHAR(src.CreatedById), 'NULL') inxpo_value
FROM 
    sfdc.v_sf_inx_src_case src
    JOIN sfdc.v_sf_inx_trg_case trg ON (src.casenumber = trg.casenumber)
WHERE
    NVL(TO_CHAR(trg.CreatedById), 'NULL') <> NVL(TO_CHAR(src.CreatedById), 'NULL')

UNION ALL

SELECT DISTINCT
    'INXPO-172' jira_number, '' jira_bug, '' jira_bug_comment, 
    'Case' object_name, 'CreatedDate Field Mismatch' jira_desc, 
    TO_CHAR(SYSDATE, 'DD-MON-YYYY') test_date, TO_CHAR(trg.id) west_id, 
    TO_CHAR(src.id) inxpo_id, NVL(TO_CHAR(trg.CreatedDate), 'NULL') west_value, 
    NVL(TO_CHAR(src.CreatedDate), 'NULL') inxpo_value
FROM 
    sfdc.v_sf_inx_src_case src
    JOIN sfdc.v_sf_inx_trg_case trg ON (src.casenumber = trg.casenumber)
WHERE
    NVL(TO_CHAR(trg.CreatedDate), 'NULL') <> NVL(TO_CHAR(src.CreatedDate), 'NULL')

UNION ALL

SELECT DISTINCT
    'INXPO-172' jira_number, '' jira_bug, '' jira_bug_comment, 
    'Case' object_name, 'CurrencyIsoCode Field Mismatch' jira_desc, 
    TO_CHAR(SYSDATE, 'DD-MON-YYYY') test_date, TO_CHAR(trg.id) west_id, 
    TO_CHAR(src.id) inxpo_id, NVL(TO_CHAR(trg.CurrencyIsoCode), 'NULL') west_value, 
    NVL(TO_CHAR(src.CurrencyIsoCode), 'NULL') inxpo_value
FROM 
    sfdc.v_sf_inx_src_case src
    JOIN sfdc.v_sf_inx_trg_case trg ON (src.casenumber = trg.casenumber)
WHERE
    NVL(TO_CHAR(trg.CurrencyIsoCode), 'NULL') <> NVL(TO_CHAR(src.CurrencyIsoCode), 'NULL')

UNION ALL

SELECT DISTINCT
    'INXPO-172' jira_number, '' jira_bug, '' jira_bug_comment, 
    'Case' object_name, 'HasCommentsUnreadByOwner Field Mismatch' jira_desc, 
    TO_CHAR(SYSDATE, 'DD-MON-YYYY') test_date, TO_CHAR(trg.id) west_id, 
    TO_CHAR(src.id) inxpo_id, NVL(TO_CHAR(trg.HasCommentsUnreadByOwner), 'NULL') west_value, 
    NVL(TO_CHAR(src.HasCommentsUnreadByOwner), 'NULL') inxpo_value
FROM 
    sfdc.v_sf_inx_src_case src
    JOIN sfdc.v_sf_inx_trg_case trg ON (src.casenumber = trg.casenumber)
WHERE
    NVL(TO_CHAR(trg.HasCommentsUnreadByOwner), 'NULL') <> NVL(TO_CHAR(src.HasCommentsUnreadByOwner), 'NULL')

UNION ALL

SELECT DISTINCT
    'INXPO-172' jira_number, '' jira_bug, '' jira_bug_comment, 
    'Case' object_name, 'HasSelfServiceComments Field Mismatch' jira_desc, 
    TO_CHAR(SYSDATE, 'DD-MON-YYYY') test_date, TO_CHAR(trg.id) west_id, 
    TO_CHAR(src.id) inxpo_id, NVL(TO_CHAR(trg.HasSelfServiceComments), 'NULL') west_value, 
    NVL(TO_CHAR(src.HasSelfServiceComments), 'NULL') inxpo_value
FROM 
    sfdc.v_sf_inx_src_case src
    JOIN sfdc.v_sf_inx_trg_case trg ON (src.casenumber = trg.casenumber)
WHERE
    NVL(TO_CHAR(trg.HasSelfServiceComments), 'NULL') <> NVL(TO_CHAR(src.HasSelfServiceComments), 'NULL')

UNION ALL

SELECT DISTINCT
    'INXPO-172' jira_number, '' jira_bug, '' jira_bug_comment, 
    'Case' object_name, 'Id Field Mismatch' jira_desc, 
    TO_CHAR(SYSDATE, 'DD-MON-YYYY') test_date, TO_CHAR(trg.id) west_id, 
    TO_CHAR(src.id) inxpo_id, NVL(TO_CHAR(trg.Id), 'NULL') west_value, 
    NVL(TO_CHAR(src.Id), 'NULL') inxpo_value
FROM 
    sfdc.v_sf_inx_src_case src
    JOIN sfdc.v_sf_inx_trg_case trg ON (src.casenumber = trg.casenumber)
WHERE
    NVL(TO_CHAR(trg.Id), 'NULL') <> NVL(TO_CHAR(src.Id), 'NULL')

UNION ALL

SELECT DISTINCT
    'INXPO-172' jira_number, '' jira_bug, '' jira_bug_comment, 
    'Case' object_name, 'Notice_Received__c Field Mismatch' jira_desc, 
    TO_CHAR(SYSDATE, 'DD-MON-YYYY') test_date, TO_CHAR(trg.id) west_id, 
    TO_CHAR(src.id) inxpo_id, NVL(TO_CHAR(trg.Notice_Received__c), 'NULL') west_value, 
    NVL(TO_CHAR(src.Notice_Received__c), 'NULL') inxpo_value
FROM 
    sfdc.v_sf_inx_src_case src
    JOIN sfdc.v_sf_inx_trg_case trg ON (src.casenumber = trg.casenumber)
WHERE
    NVL(TO_CHAR(trg.Notice_Received__c), 'NULL') <> NVL(TO_CHAR(src.Notice_Received__c), 'NULL')

UNION ALL

SELECT DISTINCT
    'INXPO-172' jira_number, '' jira_bug, '' jira_bug_comment, 
    'Case' object_name, 'OwnerId Field Mismatch' jira_desc, 
    TO_CHAR(SYSDATE, 'DD-MON-YYYY') test_date, TO_CHAR(trg.id) west_id, 
    TO_CHAR(src.id) inxpo_id, NVL(TO_CHAR(trg.OwnerId), 'NULL') west_value, 
    NVL(TO_CHAR(src.OwnerId), 'NULL') inxpo_value
FROM 
    sfdc.v_sf_inx_src_case src
    JOIN sfdc.v_sf_inx_trg_case trg ON (src.casenumber = trg.casenumber)
WHERE
    NVL(TO_CHAR(trg.OwnerId), 'NULL') <> NVL(TO_CHAR(src.OwnerId), 'NULL')

UNION ALL

SELECT DISTINCT
    'INXPO-172' jira_number, '' jira_bug, '' jira_bug_comment, 
    'Case' object_name, 'RecordTypeId Field Mismatch' jira_desc, 
    TO_CHAR(SYSDATE, 'DD-MON-YYYY') test_date, TO_CHAR(trg.id) west_id, 
    TO_CHAR(src.id) inxpo_id, NVL(TO_CHAR(trg.RecordTypeId), 'NULL') west_value, 
    NVL(TO_CHAR(src.RecordTypeId), 'NULL') inxpo_value
FROM 
    sfdc.v_sf_inx_src_case src
    JOIN sfdc.v_sf_inx_trg_case trg ON (src.casenumber = trg.casenumber)
WHERE
    NVL(TO_CHAR(trg.RecordTypeId), 'NULL') <> NVL(TO_CHAR(src.RecordTypeId), 'NULL')

UNION ALL

SELECT DISTINCT
    'INXPO-172' jira_number, '' jira_bug, '' jira_bug_comment, 
    'Case' object_name, 'Revenue_At_Risk__c Field Mismatch' jira_desc, 
    TO_CHAR(SYSDATE, 'DD-MON-YYYY') test_date, TO_CHAR(trg.id) west_id, 
    TO_CHAR(src.id) inxpo_id, NVL(TO_CHAR(trg.Revenue_At_Risk__c), 'NULL') west_value, 
    NVL(TO_CHAR(src.Revenue_At_Risk__c), 'NULL') inxpo_value
FROM 
    sfdc.v_sf_inx_src_case src
    JOIN sfdc.v_sf_inx_trg_case trg ON (src.casenumber = trg.casenumber)
WHERE
    NVL(TO_CHAR(trg.Revenue_At_Risk__c), 'NULL') <> NVL(TO_CHAR(src.Revenue_At_Risk__c), 'NULL')

UNION ALL

SELECT DISTINCT
    'INXPO-172' jira_number, '' jira_bug, '' jira_bug_comment, 
    'Case' object_name, 'Status Field Mismatch' jira_desc, 
    TO_CHAR(SYSDATE, 'DD-MON-YYYY') test_date, TO_CHAR(trg.id) west_id, 
    TO_CHAR(src.id) inxpo_id, NVL(TO_CHAR(trg.Status), 'NULL') west_value, 
    NVL(TO_CHAR(src.Status), 'NULL') inxpo_value
FROM 
    sfdc.v_sf_inx_src_case src
    JOIN sfdc.v_sf_inx_trg_case trg ON (src.casenumber = trg.casenumber)
WHERE
    NVL(TO_CHAR(trg.Status), 'NULL') <> NVL(TO_CHAR(src.Status), 'NULL')

UNION ALL

SELECT DISTINCT
    'INXPO-172' jira_number, '' jira_bug, '' jira_bug_comment, 
    'Case' object_name, 'SystemModstamp Field Mismatch' jira_desc, 
    TO_CHAR(SYSDATE, 'DD-MON-YYYY') test_date, TO_CHAR(trg.id) west_id, 
    TO_CHAR(src.id) inxpo_id, NVL(TO_CHAR(trg.SystemModstamp), 'NULL') west_value, 
    NVL(TO_CHAR(src.SystemModstamp), 'NULL') inxpo_value
FROM 
    sfdc.v_sf_inx_src_case src
    JOIN sfdc.v_sf_inx_trg_case trg ON (src.casenumber = trg.casenumber)
WHERE
    NVL(TO_CHAR(trg.SystemModstamp), 'NULL') <> NVL(TO_CHAR(src.SystemModstamp), 'NULL')

UNION ALL

SELECT DISTINCT
    'INXPO-172' jira_number, '' jira_bug, '' jira_bug_comment, 
    'Case' object_name, 'Comments Field Mismatch' jira_desc, 
    TO_CHAR(SYSDATE, 'DD-MON-YYYY') test_date, TO_CHAR(trg.id) west_id, 
    TO_CHAR(src.id) inxpo_id, NVL(TO_CHAR(trg.Comments), 'NULL') west_value, 
    NVL(TO_CHAR(src.Comments), 'NULL') inxpo_value
FROM 
    sfdc.v_sf_inx_src_case src
    JOIN sfdc.v_sf_inx_trg_case trg ON (src.casenumber = trg.casenumber)
WHERE
    NVL(TO_CHAR(trg.Comments), 'NULL') <> NVL(TO_CHAR(src.Comments), 'NULL')

UNION ALL

SELECT DISTINCT
    'INXPO-172' jira_number, '' jira_bug, '' jira_bug_comment, 
    'Case' object_name, 'ContactEmail Field Mismatch' jira_desc, 
    TO_CHAR(SYSDATE, 'DD-MON-YYYY') test_date, TO_CHAR(trg.id) west_id, 
    TO_CHAR(src.id) inxpo_id, NVL(TO_CHAR(trg.ContactEmail), 'NULL') west_value, 
    NVL(TO_CHAR(src.ContactEmail), 'NULL') inxpo_value
FROM 
    sfdc.v_sf_inx_src_case src
    JOIN sfdc.v_sf_inx_trg_case trg ON (src.casenumber = trg.casenumber)
WHERE
    NVL(TO_CHAR(trg.ContactEmail), 'NULL') <> NVL(TO_CHAR(src.ContactEmail), 'NULL')

UNION ALL

SELECT DISTINCT
    'INXPO-172' jira_number, '' jira_bug, '' jira_bug_comment, 
    'Case' object_name, 'ContactFax Field Mismatch' jira_desc, 
    TO_CHAR(SYSDATE, 'DD-MON-YYYY') test_date, TO_CHAR(trg.id) west_id, 
    TO_CHAR(src.id) inxpo_id, NVL(TO_CHAR(trg.ContactFax), 'NULL') west_value, 
    NVL(TO_CHAR(src.ContactFax), 'NULL') inxpo_value
FROM 
    sfdc.v_sf_inx_src_case src
    JOIN sfdc.v_sf_inx_trg_case trg ON (src.casenumber = trg.casenumber)
WHERE
    NVL(TO_CHAR(trg.ContactFax), 'NULL') <> NVL(TO_CHAR(src.ContactFax), 'NULL')

UNION ALL

SELECT DISTINCT
    'INXPO-172' jira_number, '' jira_bug, '' jira_bug_comment, 
    'Case' object_name, 'ContactMobile Field Mismatch' jira_desc, 
    TO_CHAR(SYSDATE, 'DD-MON-YYYY') test_date, TO_CHAR(trg.id) west_id, 
    TO_CHAR(src.id) inxpo_id, NVL(TO_CHAR(trg.ContactMobile), 'NULL') west_value, 
    NVL(TO_CHAR(src.ContactMobile), 'NULL') inxpo_value
FROM 
    sfdc.v_sf_inx_src_case src
    JOIN sfdc.v_sf_inx_trg_case trg ON (src.casenumber = trg.casenumber)
WHERE
    NVL(TO_CHAR(trg.ContactMobile), 'NULL') <> NVL(TO_CHAR(src.ContactMobile), 'NULL')

UNION ALL

SELECT DISTINCT
    'INXPO-172' jira_number, '' jira_bug, '' jira_bug_comment, 
    'Case' object_name, 'ContactPhone Field Mismatch' jira_desc, 
    TO_CHAR(SYSDATE, 'DD-MON-YYYY') test_date, TO_CHAR(trg.id) west_id, 
    TO_CHAR(src.id) inxpo_id, NVL(TO_CHAR(trg.ContactPhone), 'NULL') west_value, 
    NVL(TO_CHAR(src.ContactPhone), 'NULL') inxpo_value
FROM 
    sfdc.v_sf_inx_src_case src
    JOIN sfdc.v_sf_inx_trg_case trg ON (src.casenumber = trg.casenumber)
WHERE
    NVL(TO_CHAR(trg.ContactPhone), 'NULL') <> NVL(TO_CHAR(src.ContactPhone), 'NULL')
