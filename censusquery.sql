select * from census.dbo.[data 1];
select * from census.dbo.[data 2];

-- to get number of rows in dataset
select count(*) from census..[data 1];
select count(*) from census..[data 2];

-- to get data of jharkhand only
select * from census..[data 1] where State='Jharkhand';
select * from census..[data 2] where state='jharkhand';

-- to get data for gujarat and rajasthan (multple condition with where)
select * from census..[data 1] where state in('gujarat','rajasthan');

-- to get the total population 
select sum(population) totalpopulation from census..[data 2];

-- to get the literacy >80 for maharashtra state
select * from census..[data 1] where State='maharashtra' and literacy>=80;

-- to get the average growth of India
select avg(Growth)*100 as avggrowth from census..[data 1];

-- to select avg growth statewise
select state ,avg(Growth)*100 as avg_gwth from census..[data 1] group by state;

--to get avg sex ratio
select round(avg(sex_ratio),0) as avg_sexratio from census..[data 1];

-- to get avg literacy rate statewise in descending order
select state, avg(literacy) as avg_lit from census..[data 1] group by state order by avg_lit desc;

-- to get avg lit greater than 90
select state, avg(literacy) as avg_lit from census..[data 1] 
group by state 
having avg(literacy)>90
order by avg_lit desc ;

-- to get top 3 sttaes based on literacy
select top 3 state,avg(literacy) as avg_lit from census..[data 1] group by state order by avg_lit desc;


-- to get bottom three states on basis of literacy
select top 3 state,avg(literacy) as avg_lit from census..[data 1] group by state order by avg_lit asc;

-- to get highest 3 and lowest 3 literate state in one output
create table #topstate  
( state nvarchar(255),
  topstate float
  )
insert into #topstate
select top 3 state,avg(literacy) as avg_lit from census..[data 1] group by state order by avg_lit desc;
select topstate from #topstate order by topstate desc;

create table #bottomstate  
( state nvarchar(255),
  bottomstate float
  )
insert into #bottomstate
select top 3 state,avg(literacy) as avg_lit from census..[data 1] group by state order by avg_lit asc;
select bottomstate from #bottomstate order by bottomstate asc;


select * from (
select top 3 topstate,state from #topstate order by topstate desc
union 
select top 3 bottomstate,state from #bottomstate order by bottomstate  asc) as a;

-- to get state sarts with a
select state from census..[data 1] where state like'a%' and state like'%h';