/*
=============================================================
Create Bank Loan Data Table
=============================================================
Script Purpose:
    This script creates a table to store loan data in the 'bank' schema.
    The table stores details about customer loans including application 
    type, employment details, loan amounts, and payment schedules. 
    This table will serve as the foundation for further data processing 
    and analytics on bank loan information.

Table Summary:
    1. bank_loan_data    – Stores customer loan information 
    including loan status, payment details, and customer demographics.

WARNING:
    This script will drop and recreate the table in the bank schema.
    Any existing data in this table will be permanently deleted. Ensure 
    data is backed up or persisted elsewhere before execution.

Instructions:
    1. Connect to the target database before executing.
    2. Run this script as-is to reset the table structure for the bank loan data.
*/

-- =============================================================
-- Step 1: Drop existing bank_loan_data table (if it exists)
-- -------------------------------------------------------------
-- This step ensures that the table is recreated with a fresh structure.
-- It deletes the existing table, so ensure backup if needed.
-- =============================================================
DROP TABLE IF EXISTS bank.bank_loan_data;

-- =============================================================
-- Step 2: Create bank_loan_data table
-- -------------------------------------------------------------
-- Purpose: Stores customer loan details for further analysis
-- Use Case: Loan application analysis, payment tracking, customer segmentation
-- =============================================================
CREATE TABLE IF NOT EXISTS bank.bank_loan_data (
    id INT PRIMARY KEY,                          -- Unique identifier for each loan record
    address_state VARCHAR(50),                   -- State of the customer’s address
    application_type VARCHAR(50),                -- Type of application (e.g., individual, joint)
    emp_length VARCHAR(50),                      -- Length of employment (e.g., 1 year, 3 years)
    emp_title VARCHAR(255),                      -- Job title of the customer (increased length for longer titles)
    grade VARCHAR(50),                           -- Loan grade (e.g., A, B, C)
    home_ownership VARCHAR(50),                  -- Home ownership status (e.g., own, rent)
    issue_date DATE,                             -- Date the loan was issued
    last_credit_pull_date DATE,                  -- Last credit pull date for the customer
    last_payment_date DATE,                      -- Date of the most recent payment made
    loan_status VARCHAR(50),                     -- Status of the loan (e.g., current, late)
    next_payment_date DATE,                      -- Date of the next scheduled payment
    member_id INT,                               -- Member ID associated with the loan
    purpose VARCHAR(50),                         -- Purpose of the loan (e.g., debt consolidation, medical)
    sub_grade VARCHAR(50),                       -- Sub-grade for more granular loan classification
    term VARCHAR(50),                            -- Loan term (e.g., 36 months, 60 months)
    verification_status VARCHAR(50),             -- Verification status of the application (e.g., verified, not verified)
    annual_income FLOAT,                         -- Customer’s reported annual income
    dti FLOAT,                                   -- Debt-to-income ratio
    installment FLOAT,                           -- Monthly installment amount
    int_rate FLOAT,                              -- Interest rate of the loan
    loan_amount INT,                             -- Total loan amount
    total_acc INT,                               -- Total number of accounts the customer has
    total_payment INT                            -- Total payments made by the customer
);

-- =============================================================
-- Step 3: Additional Notes
-- -------------------------------------------------------------
-- - The table schema uses appropriate data types for each column 
-- based on the expected values (e.g., VARCHAR for text, DATE for dates, 
-- FLOAT for numerical values).
-- - Adjustments to column lengths or data types may be necessary 
-- if the business requirements evolve or the data volume grows.
-- =============================================================
