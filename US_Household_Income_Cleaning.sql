# US Household Income Project

# Part 1: Data Cleaning

SELECT COUNT(*)
FROM USHouseholdIncome;

SELECT COUNT(*)
FROM USHouseholdIncome_Statistics;

# Checking for duplicate rows in USHouseholdIncome
SELECT id, 
COUNT(id)
FROM USHouseholdIncome
GROUP BY id
HAVING COUNT(id) > 1;

SELECT * FROM 
	(SELECT row_id, 
	id,
	ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) as row_num
	FROM USHouseholdIncome) as duplicates
WHERE row_num > 1;

# Now we can delete these rows from our original table
DELETE FROM USHouseholdIncome
WHERE row_id IN (SELECT row_id FROM 
		(SELECT row_id, 
		id,
		ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) as row_num
		FROM USHouseholdIncome) as duplicates
	WHERE row_num > 1)
;

# Checking for duplicate rows in USHouseholdIncome_Statistics
SELECT id, 
COUNT(id)
FROM USHouseholdIncome_Statistics
GROUP BY id
HAVING COUNT(id) > 1;

# We have no duplicates in second table

# Now going back to first table and fixing state name errors
SELECT State_Name,
COUNT(State_Name)
FROM USHouseholdIncome
GROUP BY State_Name;

# Updating incorrect state names
UPDATE USHouseholdIncome 
SET State_Name = 'Georgia'
WHERE State_Name = 'georia';

UPDATE USHouseholdIncome 
SET State_Name = 'Alabama'
WHERE State_Name = 'alabama';

# Looking at Place
SELECT *
FROM USHouseholdIncome
WHERE Place IS NULL;

SELECT *
FROM USHouseholdIncome
WHERE County = 'Autauga County';

# Given all but one od the places corresponding to Autagua County are Ataugaville, we can populate the missing place as such
UPDATE USHouseholdIncome
SET Place = 'Autaugaville'
WHERE County = 'Autauga County'
AND City = 'Vinemont';

# Looking at Type column to find errors
SELECT Type, COUNT(Type)
FROM USHouseholdIncome
GROUP BY Type;

# We can update Boroughs 
UPDATE USHouseholdIncome
SET Type = 'Borough'
WHERE Type = 'Boroughs';

# Looking at ALand and AWater columns
SELECT ALand, AWater
FROM USHouseholdIncome
WHERE ALand IN (0, '', NULL)
AND AWater IN (0, '', NULL);

# We don't have any columns where both ALand and AWater are 0 so we don't need to remove anything

