select * from bank_loan_data

-- Total_Loan_Application

select COUNT(id) as total_loan_application
from bank_loan_data

 -- Month-To-Date Total Loan Applications

 select COUNT(id) as MTD_loan_applications
 from bank_loan_data
 where month(issue_date) = 12 and YEAR(issue_date) = 2021 

 --Privious_Month_on_date loan aplications

 select count(id) as PMTD_Loan_Application
 from bank_loan_data
 where MONTH(issue_date) = 11 and YEAR(issue_date)= 2021

 -- Total Funded Amount For every purpose

 select Purpose, SUM(loan_amount) as Total_fund_Amount
 from bank_loan_data
 group by purpose

 -- MTD Total Funded Amount For every purpose

 select Purpose, SUM(loan_amount) as Total_fund_Amount
 from bank_loan_data
 where MONTH(issue_date) = 12 and YEAR(issue_date) = 2021
 group by purpose

 --  PMTD Total Funded Amount For every purpose

 select Purpose, SUM(loan_amount) as Total_fund_Amount
 from bank_loan_data
 where MONTH(issue_date) = 11 and YEAR(issue_date) = 2021
 group by purpose

 --Total Amount Received

 select Purpose, sum(total_payment) as Total_amt_reive
 from bank_loan_data
 group by purpose

 -- MTD Total Amount Received

 select  sum(total_payment) as Total_amt_reive
 from bank_loan_data
 where month(issue_date) = 12 and YEAR(issue_date) = 2021
 

 select Purpose, sum(total_payment) as Total_amt_reive
 from bank_loan_data
 where month(issue_date) = 12 and YEAR(issue_date) = 2021
 group by purpose

  -- PMTD Total Amount Received

 select  sum(total_payment) as Total_amt_reive
 from bank_loan_data
 where month(issue_date) = 11 and YEAR(issue_date) = 2021


 select Purpose, sum(total_payment) as Total_amt_reive
 from bank_loan_data
 where month(issue_date) = 11 and YEAR(issue_date) = 2021
 group by purpose

 -- Average Interest Rate for each home ownership

 select Home_ownership, ROUND(AVG(int_rate)* 100, 2) as Avg_rate_int
 from bank_loan_data
 group by home_ownership

 --MTD Average Interest Rate for each home ownership

 select Home_ownership, ROUND(AVG(int_rate)* 100, 2) as MTD_Avg_rate_int
 from bank_loan_data
 where MONTH(issue_date) = 12 and YEAR(issue_date) = 2021
 group by home_ownership

 --PMTD Average Interest Rate for each home ownership

 select Home_ownership, ROUND(AVG(int_rate)* 100, 2) as PMTD_Avg_rate_int
 from bank_loan_data
 where MONTH(issue_date) = 11 and YEAR(issue_date) = 2021
 group by home_ownership


 -- AVG DTI

 select ROUND(AVG(dti)*100, 2) as avg_dti 
 from bank_loan_data


 -- Good Loan VS Bad Loan-------------------------

 select loan_status
 from bank_loan_data
 group by loan_status


 -- Good Loan Issued

 select 
		(COUNT(case when loan_status = 'Fully Paid' or loan_status = 'Current' then id end) * 100)
		/ 
		count(id) as Good_loan_percentage
  from bank_loan_data

  -- Good Loan Application: Show total loan_application, emp name and home_ownership in descending order
  
  select  Emp_title, Home_ownership, COUNT(id) as Loan_appliction
  from bank_loan_data
  where loan_status = 'Fully Paid' or loan_status = 'Current'
  group by emp_title, home_ownership
  order by home_ownership desc

  -- Good loan funded amount for each type of ownership

 select  home_ownership, SUM(loan_amount) as Good_funded_amount
 from bank_loan_data
 where loan_status = 'Fully Paid' or loan_status = 'Current'
 group by home_ownership

 -- Good Loan Amount Received for each type of ownership

 select  home_ownership, SUM(total_payment) as Good_funded_amount_recived
 from bank_loan_data
 where loan_status = 'Fully Paid' or loan_status = 'Current'
 group by home_ownership



 -- Bad Loan

 select 
	(COUNT(case when loan_status = 'Charged Off' then id end)* 100.0)
	/
	COUNT(id) as bad_loan
from bank_loan_data

-- Bad Loan Amount for each ownership

select home_ownership, COUNT(id) as total_bad_loan  
from bank_loan_data
where loan_status = 'Charged Off'
group by home_ownership

-- Bad Loan Funded Amount for each ownership

select  home_ownership, sum(loan_amount) as total_bad_loan_funded_amount
from bank_loan_data
where loan_status = 'Charged Off'
group by  home_ownership

-- Bad loan Received amount each ownership

select  home_ownership, sum(total_payment) as total_bad_loan_recived_amount
from bank_loan_data
where loan_status = 'Charged Off'
group by  home_ownership

-- loan status 

select 
	loan_status,
	COUNT(id) as Total_application,
	SUM(loan_amount) as Total_fund_Amount,
	SUM(total_payment) as Total_recived_amount,
	AVG(int_rate * 100) as Interest_Rate,
	AVG(dti * 100) as DTI
from bank_loan_data
group by loan_status


select 
 	loan_status,
	SUM(loan_amount) as MTD_Total_fund_Amount,
	SUM(total_payment) as MTD_Total_recived_amount
from bank_loan_data
where MONTH(issue_date) = 12
group by loan_status

-- Find How much apllication for every month and find total amount funded and received by every month

select 
	COUNT(id) as Total_Applications,
	MONTH(issue_date) as Month_no, 
	DATENAME(month, issue_date) As Month_Name,
	SUM(loan_amount) as Total_funded_amount,
	SUM(total_payment) as Received_payment
from bank_loan_data
group by MONTH(issue_date), DATENAME(month, issue_date) 
order by Month_no

-- Regional Analysis by State 


select 
	address_state as State,
	COUNT(id) as Total_Applications,
	SUM(loan_amount) as Total_funded_amount,
	SUM(total_payment) as Received_payment
from bank_loan_data
group by address_state 
order by SUM(loan_amount) desc


-- TERM

select 
	term as Term,
	COUNT(id) as Total_Applications,
	SUM(loan_amount) as Total_funded_amount,
	SUM(total_payment) as Received_payment
from bank_loan_data
group by term
order by term


select 
	emp_length as Emp_lenth,
	COUNT(id) as Total_Applications,
	SUM(loan_amount) as Total_funded_amount,
	SUM(total_payment) as Received_payment
from bank_loan_data
group by emp_length
order by Total_Applications desc


-- Purpose 

select 
	purpose,
	COUNT(id) as Total_Applications,
	SUM(loan_amount) as Total_funded_amount,
	SUM(total_payment) as Received_payment
from bank_loan_data
group by purpose
order by Total_Applications desc

-- Home Ownership

select 
	home_ownership,
	COUNT(id) as Total_Applications,
	SUM(loan_amount) as Total_funded_amount,
	SUM(total_payment) as Received_payment
from bank_loan_data
group by home_ownership
order by Total_Applications desc



