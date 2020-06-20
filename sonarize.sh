#! /usr/bin/bash

# Commit to SVN
svn commit -m "$1"

# Run sonar job in Jenkins
curl -X POST https://qaautomation.west.com/jenkins/job/iCRM.sonar/build --data-urlencode json='{"parameter": [{"name":"AQW_PROJECT", "value":"iCRM"}, {"name":"AQW_CAMPAIGNS", "value":"sonar"}, {"name":"AQW_THREAD_NUMBER", "value":"1"}, {"name":"AQW_PROFILE", "value":"production"}, {"name":"JIRA_ID", "value":"aqa-377"}]}'
