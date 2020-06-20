CREATE OR REPLACE VIEW v_dm_qatest_public_account AS 
    SELECT a.account_previous_id__c w_account, a.* 
    FROM sf_qatest_account a
    WHERE company_organization_type__c = 'Public'
       OR company_organization_type__c IS NULL;

CREATE OR REPLACE VIEW v_dm_n3a_public_account AS 
    SELECT a.* 
    FROM stg_nasdaq_qatest.sfdc_account a
    WHERE a.market__c <> 'None'
       OR a.additional_markets__c IS NOT NULL
       OR a.tickersymbol IS NOT NULL;


SELECT 'QATEST' AS environment, Count(*)
FROM v_dm_qatest_public_account

UNION ALL

SELECT 'NASDAQ' AS environment, Count(*)
FROM v_dm_n3a_public_account;