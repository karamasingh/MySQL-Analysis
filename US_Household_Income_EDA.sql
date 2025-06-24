# US Household Income Project

# Part 2: Exploratory Data Analysis

SELECT *
FROM USHouseholdIncome;

SELECT *
FROM ushouseholdincome_statistics;

# Let's first take a look at Water and Land area for each state
SELECT State_Name, 
SUM(ALand) as Total_Land, 
SUM(AWater) as Total_Water
FROM USHouseholdIncome
GROUP BY State_Name
ORDER BY Total_Land DESC
LIMIT 10;

SELECT State_Name, 
SUM(ALand) as Total_Land, 
SUM(AWater) as Total_Water
FROM USHouseholdIncome
GROUP BY State_Name
ORDER BY Total_Water DESC
LIMIT 10;

# Now let's join our two tables together so we can look at income data
SELECT *
FROM USHouseholdIncome as T1
JOIN ushouseholdincome_statistics as T2
ON T1.id = T2.id
WHERE Mean != 0;

SELECT T1.State_Name, County, Type, `Primary`, Mean, Median
FROM USHouseholdIncome as T1
JOIN ushouseholdincome_statistics as T2
ON T1.id = T2.id
WHERE Mean != 0;

# Let's look at the average income for states ordered by highest mean
SELECT T1.State_Name, 
ROUND(AVG(Mean), 2) as Avg_Mean, 
ROUND(AVG(Median), 2) as Avg_Median
FROM USHouseholdIncome as T1
JOIN ushouseholdincome_statistics as T2
ON T1.id = T2.id
WHERE Mean != 0
GROUP BY State_Name
ORDER BY 2 DESC;

# Let's look at the average income for states ordered by highest median
SELECT T1.State_Name, 
ROUND(AVG(Mean), 2) as Avg_Mean, 
ROUND(AVG(Median), 2) as Avg_Median
FROM USHouseholdIncome as T1
JOIN ushouseholdincome_statistics as T2
ON T1.id = T2.id
WHERE Mean != 0
GROUP BY State_Name
ORDER BY 2;

# We can see from the above outputs that almost all states have a medain greater than the mean income
# This tells us that the distributions of income for most states are skewed to the left, or left-tailed

# Now lets do the same calculations for type, ordered by mean 
SELECT Type, 
COUNT(Type),
ROUND(AVG(Mean), 2) as Avg_Mean, 
ROUND(AVG(Median), 2) as Avg_Median
FROM USHouseholdIncome as T1
JOIN ushouseholdincome_statistics as T2
ON T1.id = T2.id
WHERE Mean != 0
GROUP BY Type
ORDER BY 3 DESC;

# Ordered by Median
SELECT Type, 
COUNT(Type),
ROUND(AVG(Mean), 2) as Avg_Mean, 
ROUND(AVG(Median), 2) as Avg_Median
FROM USHouseholdIncome as T1
JOIN ushouseholdincome_statistics as T2
ON T1.id = T2.id
WHERE Mean != 0
GROUP BY Type
ORDER BY 4 DESC;

# Let's look at what states have Community and Urban as their Type since they are very poor
SELECT State_Name, County, City, Place, Type
FROM USHouseholdIncome
WHERE Type = 'Community'
OR Type = 'Urban';

# Let's also look at where Municipality and County are located sinc e there are so few 
SELECT State_Name, County, City, Place, Type
FROM USHouseholdIncome
WHERE Type = 'Municipality'
OR Type = 'County';

# Now let's focus on average income for cities ordered by mean
SELECT T1.State_Name,
City,
ROUND(AVG(Mean), 2) as Avg_Mean,
ROUND(AVG(Median), 2) as Avg_Median
FROM USHouseholdIncome as T1
JOIN ushouseholdincome_statistics as T2
ON T1.id = T2.id
WHERE Mean != 0
GROUP BY T1.State_Name, City
ORDER BY Avg_Mean DESC;
