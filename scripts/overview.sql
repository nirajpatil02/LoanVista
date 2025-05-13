/*
-------------------------------------------------------------------------------------
Overview Script for Loan Data Validation (Used for Power BI Dashboard Verification)
-------------------------------------------------------------------------------------

Purpose:
This script provides a comprehensive overview of key metrics in the loan dataset.
It is designed to validate and cross-check the numbers and KPIs that appear in the 
Power BI dashboard, ensuring transparency and accuracy across the reporting pipeline.

Usage:
- Can be executed by BI developers, QA teams, stakeholders, or clients.
- Helps verify if the aggregated values in the dashboard (e.g., loan volumes, trends,
  funding amounts, regional breakdowns) are accurate and traceable back to raw data.
- Each section targets a specific dimension of analysis for better interpretability.

Dataset:
- Source Table: bank.bank_loan_data
- Assumes columns like issue_date, loan_amount, total_payment, emp_length, etc.

-------------------------------------------------------------------------------------
*/

-- Full Data Preview
SELECT * FROM bank.bank_loan_data;

-- Monthly Trends by Issue Date
SELECT
	EXTRACT(MONTH FROM issue_date) AS month_number,
	TO_CHAR(issue_date, 'Month') AS month_name,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank.bank_loan_data
GROUP BY TO_CHAR(issue_date, 'Month'), EXTRACT(MONTH FROM issue_date)
ORDER BY EXTRACT(MONTH FROM issue_date);

-- Regional Analysis by State
SELECT
	address_state,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank.bank_loan_data
GROUP BY address_state
ORDER BY SUM(loan_amount) DESC;

-- Loan Term Analysis
SELECT
	term,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank.bank_loan_data
GROUP BY term
ORDER BY term;

-- Employee Length Analysis
SELECT
	emp_length,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank.bank_loan_data
GROUP BY emp_length
ORDER BY COUNT(id) DESC;

-- Loan Purpose Analysis
SELECT
	purpose,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank.bank_loan_data
GROUP BY purpose
ORDER BY COUNT(id) DESC;

-- Home Ownership Breakdown
SELECT
	home_ownership,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank.bank_loan_data
GROUP BY home_ownership
ORDER BY COUNT(id) DESC;
