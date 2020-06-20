#!/usr/bin/env python3

'''
Build a SQL with some fields of an object
'''

import sys

# Variable declarations

objectName = 'case'
fieldNames = [
    'Type', 
    'Won_Lost__c', 
    'At_Risk_Date__c', 
    'Client_Temp__c', 
    'Impairment_Severity__c', 
    'Impairment_Date__c', 
    'Reason', 
    'Region__c', 
    'Opportunity__c', 
    'Event_Name__c', 
    'ClosedDate', 
    'ContactId', 
    'AccountId', 
    'SuppliedName', 
    'SuppliedEmail', 
    'Description', 
    'Priority', 
    'Origin', 
    'Subject', 
    'CaseNumber', 
    'CreatedById', 
    'CreatedDate', 
    'CurrencyIsoCode', 
    'HasCommentsUnreadByOwner', 
    'HasSelfServiceComments', 
    'Id', 
    'Notice_Received__c', 
    'OwnerId', 
    'RecordTypeId', 
    'Revenue_At_Risk__c', 
    'Status', 
    'SystemModstamp', 
    'Comments', 
    'ContactEmail', 
    'ContactFax', 
    'ContactMobile', 
    'ContactPhone' ] 

template = """SELECT DISTINCT
    'INXPO-172' jira_number, '' jira_bug, '' jira_bug_comment, 
    'Case' object_name, '{0} Field Mismatch' jira_desc, 
    TO_CHAR(SYSDATE, 'DD-MON-YYYY') test_date, TO_CHAR(trg.id) west_id, 
    TO_CHAR(src.id) inxpo_id, NVL(TO_CHAR(trg.{0}), 'NULL') west_value, 
    NVL(TO_CHAR(src.{0}), 'NULL') inxpo_value
FROM 
    sfdc.v_sf_inx_src_case src
    JOIN sfdc.v_sf_inx_trg_case trg ON (src.casenumber = trg.casenumber)
WHERE
    NVL(TO_CHAR(trg.{0}), 'NULL') <> NVL(TO_CHAR(src.{0}), 'NULL')"""

union = '\n\nUNION ALL\n\n';

queries = [];

for fieldName in fieldNames :
    query = template.format(fieldName)
    queries.append(query)

print(union.join(queries))
