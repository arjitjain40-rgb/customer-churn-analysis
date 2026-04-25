CREATE DATABASE churn_analysis;
USE churn_analysis;

-- total no. of customers
select count(*) as total_customers
from customer_churn;

-- churn distribution
select Churn, Count(*) as count
from customer_churn
group by Churn;

-- churn rate
select
round(
(Sum(case when Churn = "Yes" then 1 else 0 end))*100/count(*), 2) as churn_rate
from customer_churn;

-- churn rate by contract
select
Contract,
count(*) as total,
sum(case when Churn = 'Yes' then 1 else 0 end) as churned,
round(
sum(case when Churn = 'Yes' then 1 else 0 end)* 100/count(*), 2) as churn_rate
from customer_churn
group by Contract
order by churn_rate desc;

-- churn by tenure
select
case 
when tenure < 12 then '0-1 year'
when tenure between 12 and 24 then '1-2 year'
else '2+year'
end as tenure_group,
count(*) as total,
sum(case when Churn = 'Yes' then 1 else 0 end) as churned,
round(
sum(case when Churn = 'Yes' then 1 else 0 end)* 100/count(*), 2) as churn_rate
from customer_churn
group by tenure_group
order by churn_rate desc;

-- churn by monthly charges
SELECT 
    CASE 
        WHEN MonthlyCharges < 50 THEN 'Low'
        WHEN MonthlyCharges BETWEEN 50 AND 80 THEN 'Medium'
        ELSE 'High'
    END AS charge_group,
    COUNT(*) AS total,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
    2) AS churn_rate
FROM customer_churn
GROUP BY charge_group
ORDER BY churn_rate DESC;




 