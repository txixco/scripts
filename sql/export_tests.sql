SELECT ts_name, Substr(ts_name, 1, 22) GroupName, Substr(ts_name, 26, Length(ts_name)) TestName
FROM TEST t
WHERE ts_name LIKE 'OA Feature Inheritance%'
ORDER BY ts_name;

SELECT '**** HACER ' || Substr(ts_name, 26, Length(ts_name)) TestName
FROM TEST
WHERE ts_name LIKE 'OA Feature Inheritance%'
  AND Length(ts_name) > 25
ORDER BY ts_name;