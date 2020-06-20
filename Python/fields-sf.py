#!/usr/bin/env python3

'''
Build a SQL with some fields of an object
'''

from simple_salesforce import Salesforce
from getpass import getpass
import sys

# Variable declarations

objectName = 'campaign'
fieldNames = [
        'ActualCost', 
        'AmountAllOpportunities', 
        'AmountWonOpportunities', 
        'BudgetedCost', 
        'CreatedById', 
        'CreatedDate', 
        'CurrencyIsoCode', 
        'Description', 
        'EndDate', 
        'ExpectedResponse', 
        'ExpectedRevenue', 
        'HierarchyActualCost', 
        'HierarchyAmountAllOpportunities', 
        'HierarchyAmountWonOpportunities', 
        'HierarchyBudgetedCost', 
        'HierarchyExpectedRevenue', 
        'HierarchyNumberOfContacts', 
        'HierarchyNumberOfConvertedLeads', 
        'HierarchyNumberOfLeads', 
        'HierarchyNumberOfOpportunities', 
        'HierarchyNumberOfResponses', 
        'HierarchyNumberOfWonOpportunities', 
        'HierarchyNumberSent', 
        'Id', 
        'Name', 
        'NumberOfContacts', 
        'NumberOfConvertedLeads', 
        'NumberOfLeads', 
        'NumberOfOpportunities', 
        'NumberOfResponses', 
        'NumberOfWonOpportunities', 
        'NumberSent', 
        'OwnerId', 
        'ParentId', 
        'StartDate', 
        'Status', 
        'SystemModstamp', 
        'Type' ]

template = '''SELECT DISTINCT\n
                  "INXPO-177" jira_number, "" jira_bug, "" jira_bug_comment, \n
                  "Campaign" object_name, "{0} Field Mismatch" jira_desc, \n
                  TO_CHAR(SYSDATE, "DD-MON-YYYY") test_date, TO_CHAR(trg.id) west_id, \n
                  TO_CHAR(src.id) inxpo_id, NVL(TO_CHAR(trg.{1}), "NULL") west_value, \n
                  NVL(TO_CHAR(src.{1}), "NULL") inxpo_value\n
              FROM \n
                  sfdc.v_sf_inx_src_campaign src\n
                  JOIN sfdc.v_sf_inx_trg_campaign trg ON (src.id = trg.campaign_previous_id__c)\n
              WHERE\n
                  NVL(TO_CHAR(trg.{1}), "NULL") <> NVL(TO_CHAR(src.{1}), "NULL") '''

union = '\n\nUNION ALL\n\n';

queries = [];

#Map <String, Schema.SObjectType> schemaMap = 
#        Schema.getGlobalDescribe();
#Map <String, Schema.SObjectField> fieldMap = 
#        schemaMap.get('Campaign').getDescribe().fields.getMap();

# Do login

user = 'fjrueda@west.com.qatest'
#user = input('User: ')
password = 'SLSFRC2019sptmbr'
#password = getpass()
token = 'IWsUC5iuU2EX54yg8Yhgdm8AE'
#token = getpass('Token: ')

sf = Salesforce(username=user, password=password, security_token=token, domain='test')

for o in sf.describe()['sobjects']:
    if (o['label'].lower() == objectName):
        object = o

print(object['metadata'])
