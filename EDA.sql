-- States with their land area and water area --
SELECT State_Name,sum(ALand),sum(AWater)
FROM us_income.us_household_income
group by State_Name
order by 2 desc;

SELECT State_Name,sum(ALand),sum(AWater)
FROM us_income.us_household_income
group by State_Name
order by 3 desc;

-- Top 10 states by land area --
SELECT State_Name,sum(ALand)
FROM us_income.us_household_income
group by State_Name
order by 2 desc
limit 10;

-- Top 10 states by water area --
SELECT State_Name,sum(AWater)
FROM us_income.us_household_income
group by State_Name
order by 2 desc
limit 10;

-- Join tables --
SELECT * 
FROM us_household_income i
join us_household_income_statistics s
on i.id=s.id;

-- As for 'mean' column there are many values as '0' --
-- final data for EDA--
SELECT * 
FROM us_household_income i
join us_household_income_statistics s
on i.id=s.id
where mean <> 0;

-- categorical data -- differnt states-> differnet counties->cities->mean,median
SELECT i.State_Name,County,Type,`Primary`,mean,median
FROM us_household_income i
join us_household_income_statistics s
on i.id=s.id
where mean <> 0;

SELECT i.State_Name,county,city,avg(mean),avg(median)
FROM us_household_income i
join us_household_income_statistics s
on i.id=s.id
where mean <> 0
group by i.State_Name,i.County,i.city
order by 4;

-- lowest Avg income states --
SELECT i.State_Name,round(avg(mean),1),round(avg(median),1)
FROM us_household_income i
join us_household_income_statistics s
on i.id=s.id
where mean <> 0
group by i.state_name
order by 2
limit 5;

-- Highest avg mean income states -- (can do avg median as well)
SELECT i.State_Name,round(avg(mean),1),round(avg(median),1)
FROM us_household_income i
join us_household_income_statistics s
on i.id=s.id
where mean <> 0
group by i.state_name
order by 2 desc
limit 10;

-- Top avg income by TYPE -- removed types with less than 100 count
SELECT type,count(Type) as count,round(avg(mean),1),round(avg(median),1)
FROM us_household_income i
join us_household_income_statistics s
on i.id=s.id
where mean <> 0
group by type
having count > 100
order by 3 desc;
-- just checking why community has low avg -- 
select * from us_household_income
where type='Community';


-- top cities with highest avg mean income--
SELECT i.City,round(avg(Mean),1)
FROM us_household_income i
join us_household_income_statistics s
on i.id=s.id
group by i.city
order by 2 desc
limit 10;

-- Top cities with their states ---
SELECT i.State_Name,i.City,round(avg(Mean),1)
FROM us_household_income i
join us_household_income_statistics s
on i.id=s.id
group by i.State_Name,i.city
order by 3 desc
limit 10;










