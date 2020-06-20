List<String> fields =
        new List<String> { 
            'Case Type', 
            'Won/Lost', 
            'At Risk Date', 
            'Client Temp', 
            'Impairment Severity', 
            'Impairment Date', 
            'Case Reason', 
            'Region', 
            'Opportunity', 
            'Event Name', 
            'Closed Date', 
            'Contact ID', 
            'Account ID', 
            'Name', 
            'Email Address', 
            'Description', 
            'Priority', 
            'Case Origin', 
            'Subject', 
            'Case Number', 
            'Created By ID', 
            'Created Date', 
            'Case Currency', 
            'New Self-Service Comment', 
            'Self-Service Commented', 
            'Case ID', 
            'Notice Received', 
            'Owner ID', 
            'Record Type ID', 
            'Revenue At Risk', 
            'Status', 
            'System Modstamp', 
            'Internal Comments', 
            'Contact Email', 
            'Contact Fax', 
            'Contact Mobile', 
            'Contact Phone' 
          };

String template = 'SELECT DISTINCT\n' +
        '    "INXPO-172" jira_number, "" jira_bug, "" jira_bug_comment, \n' +
        '    "Case" object_name, "{0} Field Mismatch" jira_desc, \n' +
        '    TO_CHAR(SYSDATE, "DD-MON-YYYY") test_date, TO_CHAR(trg.id) west_id, \n' +
        '    TO_CHAR(src.id) inxpo_id, NVL(TO_CHAR(trg.{1}), "NULL") west_value, \n' +
        '    NVL(TO_CHAR(src.{1}), "NULL") inxpo_value\n' +
        'FROM \n' +
        '    sfdc.v_sf_inx_src_case src\n' +
        '    JOIN sfdc.v_sf_inx_trg_case trg ON (src.casenumber = trg.casenumber)\n' +
        'WHERE\n' +
        '    NVL(TO_CHAR(trg.{1}), "NULL") <> NVL(TO_CHAR(src.{1}), "NULL")';

String union = '\n\nUNION ALL\n\n';

List<String> queries = new List<String>();

//System.debug(template);

Map <String, Schema.SObjectType> schemaMap = 
        Schema.getGlobalDescribe();
Map <String, Schema.SObjectField> fieldMap = 
        schemaMap.get('Case').getDescribe().fields.getMap();

for (Schema.SObjectField sfield : fieldMap.Values()) {
    schema.describefieldresult dfield = sfield.getDescribe();
    if (fields.contains(dfield.getLabel())) {
        String query = String.format(template, 
                                     new List<Object> {
                                             dfield.getLabel(),
                                             dfield.getName()
                              });
        query = query.replace('\'', '\'\'');
        query = query.replace('"', '\'');
//        system.debug(query);
        queries.add(query);
    }
}

System.debug(String.join(queries, union) + ';');
