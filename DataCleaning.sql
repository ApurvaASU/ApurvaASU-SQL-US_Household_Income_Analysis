SELECT * FROM us_income.us_household_income_statistics;
alter table us_income.us_household_income_statistics rename column `ï»¿id` to `id`;

select *
from us_household_income_statistics;
select *
from us_household_income;

select id,count(id)
from us_household_income
group by id
having count(id)>1;

select *
from(
select row_id,
id,
row_number() over(partition by id order by id) row_num
from us_household_income
)duplicates
where row_num>1;
-- deleted duplicat rows
delete from us_household_income
where row_id in
( 
select row_id
from(
select row_id,
id,
row_number() over(partition by id order by id) row_num
from us_household_income
)duplicates
where row_num>1
);

-- Spelling mistakes --
select distinct State_Name
from us_household_income;

update us_household_income 
set State_Name = 'Georgia'
where State_Name = 'georia';

update us_household_income 
set State_Name = 'Alabama'
where State_Name = 'alabama';

-- missing vales--
select *
from us_household_income
where place='';

select *
from us_household_income
where County = 'Autauga County';
-- populated it
update us_household_income 
set place='Autaugaville'
where county='Autauga County' and city = 'Vinemont';
-- spelling mistakes
select type,count(type)
from us_household_income
group by type;

update us_household_income 
set type ='Borough'
where type ='Boroughs';

-- 0 or null check but only zeros here--
select ALand, AWater
from us_household_income
where (AWater ='' or AWater= 0 or AWater is null)
and (Aland ='' or Aland= 0 or Aland is null);

select ALand, AWater
from us_household_income
where AWater ='' or AWater= 0 or AWater is null;

select ALand, AWater
from us_household_income
where Aland ='' or Aland = 0 or Aland is null;










