-- The Following serves to diagnose Tsunami errors

-- 1. Determine if there needs to be a change to the published_tables setup
SELECT * FROM all_objects WHERE UPPER(object_name) IN ('PUBLISHED_TABLES', 'SERVER_PUBLISHED_TABLES')

-- 2. Determine if any tables have been granted by more than one schema - Expected No rows
Select Object_Name, Count(Object_Name) As Num_Grantors
  From All_Objects
 Where Object_Type = 'TABLE'
 Group By Object_Name
Having Count(Object_Name) > 1
 Order By Object_Name

Select * From all_objects Where object_name = 'ALIGNMENT'

-- 3. Determine if any of the tables listed in the published_tables table do not have primary keys - Expected No rows
Select Table_Name
  From Published_Tables p
 Where (Published Like '%1HU%' Or Published = '1%' Or Published Like '%1H%')
   And Not Exists (Select 1
          From All_Constraints o
         Where o.Constraint_Type = 'P'
           And o.Table_Name = Upper(p.Table_Name))
 Order By Table_Name


Select * 
  From event e 
       Left Outer Join event_signature es On es.event_id = e.event_id
       Left Outer Join Sample_Transaction st On st.event_id = e.event_id
Where e.event_id In (809020003222752, 809020003222763)

Select * From ROTATION_CUST_ALIGN

