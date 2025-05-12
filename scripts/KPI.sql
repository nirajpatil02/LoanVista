-- ============================================
-- Script Name: Loan KPI Verification Queries
-- Purpose: This script contains all SQL queries used to calculate key performance indicators (KPIs)
-- for the bank loan dataset. These KPIs are intended for visualization in the final Power BI dashboard.
-- The script enables business users, clients, or QA teams to independently verify the underlying data
-- and ensure the accuracy of each metric reported in the dashboard.
-- ============================================

-- Preview the data
SELECT * FROM bank.bank_loan_data;

-- ============================================
-- SECTION 1: TOTAL LOAN APPLICATIONS
-- ============================================

-- Total number of loan applications
SELECT COUNT(id) AS Total_Loan_Applications
FROM bank.bank_loan_data;

-- MTD (Month-To-Date) Loan Applications for Dec 2021
SELECT COUNT(id) AS MTD_Total_Loan_Applications
FROM bank.bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12 AND EXTRACT(YEAR FROM issue_date) = 2021;

-- PMTD (Previous Month-To-Date) Loan Applications for Nov 2021
SELECT COUNT(id) AS PMTD_Total_Loan_Applications
FROM bank.bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 11 AND EXTRACT(YEAR FROM issue_date) = 2021;

-- ============================================
-- SECTION 2: TOTAL FUNDED AMOUNT
-- ============================================

-- Total funded loan amount
SELECT SUM(loan_amount) AS Total_Funded_Amount
FROM bank.bank_loan_data;

-- MTD funded loan amount
SELECT SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM bank.bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12 AND EXTRACT(YEAR FROM issue_date) = 2021;

-- PMTD funded loan amount
SELECT SUM(loan_amount) AS PMTD_Total_Funded_Amount
FROM bank.bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 11 AND EXTRACT(YEAR FROM issue_date) = 2021;

-- ============================================
-- SECTION 3: TOTAL RECEIVED AMOUNT
-- ============================================

-- Total amount received (total payments made)
SELECT SUM(total_payment) AS Total_Amount_Received
FROM bank.bank_loan_data;

-- MTD amount received
SELECT SUM(total_payment) AS MTD_Total_Amount_Received
FROM bank.bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12 AND EXTRACT(YEAR FROM issue_date) = 2021;

-- PMTD amount received
SELECT SUM(total_payment) AS PMTD_Total_Amount_Received
FROM bank.bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 11 AND EXTRACT(YEAR FROM issue_date) = 2021;

-- ============================================
-- SECTION 4: INTEREST RATE ANALYSIS
-- ============================================

-- Average interest rate (across all loans)
SELECT ROUND(AVG(int_rate::NUMERIC), 4) * 100 AS Avg_Interest_Rate
FROM bank.bank_loan_data;

-- MTD average interest rate
SELECT ROUND(AVG(int_rate::NUMERIC), 4) * 100 AS MTD_Avg_Interest_Rate
FROM bank.bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12 AND EXTRACT(YEAR FROM issue_date) = 2021;

-- PMTD average interest rate
SELECT ROUND(AVG(int_rate::NUMERIC), 4) * 100 AS PMTD_Avg_Interest_Rate
FROM bank.bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 11 AND EXTRACT(YEAR FROM issue_date) = 2021;

-- ============================================
-- SECTION 5: DEBT-TO-INCOME (DTI) ANALYSIS
-- ============================================

-- Average DTI
SELECT ROUND(AVG(dti)::NUMERIC, 4) * 100 AS Avg_DTI
FROM bank.bank_loan_data;

-- MTD average DTI
SELECT ROUND(AVG(dti)::NUMERIC, 4) * 100 AS MTD_Avg_DTI
FROM bank.bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12 AND EXTRACT(YEAR FROM issue_date) = 2021;

-- PMTD average DTI
SELECT ROUND(AVG(dti)::NUMERIC, 4) * 100 AS PMTD_Avg_DTI
FROM bank.bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 11 AND EXTRACT(YEAR FROM issue_date) = 2021;

-- ============================================
-- SECTION 6: GOOD LOAN ANALYSIS
-- Good loans = Fully Paid OR Current status
-- ============================================

-- Percentage of good loans
SELECT
	ROUND(
		(COUNT(CASE WHEN loan_status IN ('Fully Paid', 'Current') THEN id END) * 100.0)
		/ COUNT(id), 2
	) AS Good_Loan_Percentage
FROM bank.bank_loan_data;

-- Total number of good loan applications
SELECT COUNT(id) AS Good_Loan_Applications
FROM bank.bank_loan_data
WHERE loan_status IN ('Fully Paid', 'Current');

-- Total funded amount for good loans
SELECT SUM(loan_amount) AS Good_Loan_Funded_Amount
FROM bank.bank_loan_data
WHERE loan_status IN ('Fully Paid', 'Current');

-- Total received amount for good loans
SELECT SUM(total_payment) AS Good_Loan_Received_Amount
FROM bank.bank_loan_data
WHERE loan_status IN ('Fully Paid', 'Current');

-- ============================================
-- SECTION 7: BAD LOAN ANALYSIS
-- Bad loans = Charged Off status
-- ============================================

-- Percentage of bad loans
SELECT
	ROUND(
		(COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0)
		/ COUNT(id), 2
	) AS Bad_Loan_Percentage
FROM bank.bank_loan_data;

-- Total number of bad loan applications
SELECT COUNT(id) AS Bad_Loan_Applications
FROM bank.bank_loan_data
WHERE loan_status = 'Charged Off';

-- Total funded amount for bad loans
SELECT SUM(loan_amount) AS Bad_Loan_Funded_Amount
FROM bank.bank_loan_data
WHERE loan_status = 'Charged Off';

-- Total received amount for bad loans
SELECT SUM(total_payment) AS Bad_Loan_Received_Amount
FROM bank.bank_loan_data
WHERE loan_status = 'Charged Off';

-- ============================================
-- SECTION 8: LOAN STATUS COMPARISON (OVERALL)
-- ============================================

-- Comparison by loan_status across all data
SELECT
	loan_status,
	COUNT(id) AS Total_Loan_Applications,
	SUM(total_payment) AS Total_Amount_Received,
	SUM(loan_amount) AS Total_Funded_Amount,
	AVG(int_rate * 100) AS Interest_Rate,
	AVG(dti * 100) AS DTI
FROM bank.bank_loan_data
GROUP BY loan_status;

-- ============================================
-- SECTION 9: LOAN STATUS COMPARISON (MTD)
-- ============================================

-- Comparison by loan_status for MTD (Dec)
SELECT
	loan_status,
	SUM(total_payment) AS MTD_Total_Amount_Received,
	SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM bank.bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12
GROUP BY loan_status;
