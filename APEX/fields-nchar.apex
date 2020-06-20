List<String> fields =
        new List<String> { 
                'First Name',
                'Last Name',
                'City',
                'Country',
                'Street',
                'Zip/Postal Code',
                'State/Province',
                'Mailing Geocode Accuracy',
                'Latitude',
                'Longitude',
                'Mobile Phone',
                'Owner Description',
                'Business Fax',
                'Department',
                'Reports To ID',
                'Other Address',
                'Other Street',
                'Salutation',
                'Email Bounced Date',
                'Email Bounced Reason',
                'Other City',
                'Other Country',
                'Other Zip/Postal Code',
                'Assistant\'s Name',
                'Other Phone',
                'Other State/Province',
                'Home Phone', 'Asst. Phone' };

List<Schema.DisplayType> textTypes =
        new List<Schema.DisplayType> {
                Schema.DisplayType.STRING,
                Schema.DisplayType.TEXTAREA
        };

String template = 'SELECT DISTINCT\n' +
        '    "INXPO-139" jira_number, "" jira_bug, "" jira_bug_comment, \n' +
        '    "Contact" object_name, "{0} Field Mismatch" jira_desc, \n' +
        '    TO_CHAR(SYSDATE, "DD-MON-YYYY") test_date, TO_CHAR(trg.id) west_id, \n' +
        '    TO_CHAR(src.id) inxpo_id, NVL(trg.{1}, "NULL") west_value, \n' +
        '    NVL(src.{1}, "NULL") inxpo_value\n' +
        'FROM \n' +
        '    sfdc.v_sf_inx_src_contact src\n' +
        '    JOIN sfdc.v_sf_inx_trg_contact trg ON (src.id = trg.contact_previous_id__c)\n' +
        'WHERE\n' +
        '    NVL(trg.{1}, "NULL") <> NVL(src.{1}, "NULL")';

String union = '\n\nUNION ALL\n\n';

List<String> queries = new List<String>();

//System.debug(template);

Map <String, Schema.SObjectType> schemaMap = 
        Schema.getGlobalDescribe();
Map <String, Schema.SObjectField> fieldMap = 
        schemaMap.get('Contact').getDescribe().fields.getMap();

for (Schema.SObjectField sfield : fieldMap.Values()) {
    schema.describefieldresult dfield = sfield.getDescribe();
    if (fields.contains(dfield.getLabel())) {
        String query;
        
        if (!textTypes.contains(dfield.getType())) {
            query = template.replaceAll('(src|trg)\\.\\{1\\}', 
                                        'TO_NCHAR($1.{1})');
        } else {
            query = template;
        }
        
        query = String.format(query, 
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
