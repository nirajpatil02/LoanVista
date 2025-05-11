/*
=============================================================
Create Dynamic Loader Stored Procedure for Bank Loan Data
=============================================================
Script Purpose:
    This stored procedure dynamically loads bank loan data from a specified
    CSV file into the 'bank_loan_data' table in the 'bank' schema.
    The procedure first truncates the table for a fresh load, then uses the 
    COPY command to ingest data. It is designed to be reusable, allowing 
    for dynamic file paths to be passed as parameters.

Procedure Summary:
    1. sp_load_bank_loan_data – Procedure to load data from a CSV file
    into the bank_loan_data table.

Instructions:
    1. Ensure that the 'bank_loan_data' table exists and the file path is correct.
    2. Pass the file name as an argument to this stored procedure when calling it.
    3. Run this stored procedure to reload the table with data from the CSV file.
    4. File should be in CSV format with a header row.

WARNING:
    The table will be truncated before data is loaded. Ensure that you have
    backed up any important data before running this procedure.

Steps:
    1. Truncate the 'bank_loan_data' table to clear any previous data.
    2. Dynamically construct the full file path by combining the base path and 
       the file name provided as an argument.
    3. Load the CSV data into the 'bank_loan_data' table using the COPY command.
    4. Raise a notice indicating successful data loading.
*/

-- =============================================================
-- Step 1: Drop existing stored procedure if it exists
-- -------------------------------------------------------------
-- This step ensures there are no conflicts with previously created procedures.
-- If the procedure already exists, it will be replaced.
-- =============================================================
DROP PROCEDURE IF EXISTS bank.sp_load_bank_loan_data;

-- =============================================================
-- Step 2: Create the stored procedure to load data dynamically
-- -------------------------------------------------------------
-- Purpose: Dynamically loads CSV data into the bank_loan_data table.
-- Use Case: Load fresh data from a CSV file to replace old data in the table.
-- =============================================================
CREATE OR REPLACE PROCEDURE bank.sp_load_bank_loan_data(file_name TEXT)
LANGUAGE plpgsql
AS $$ 
DECLARE
    -- Declare a base path where the files are stored.
    base_path TEXT := 'C:\Users\Niraj Patil\OneDrive\Desktop\Bank Loan PowerBI\Project Doc & Dataset';
    full_path TEXT; -- Variable to store the complete file path
BEGIN
    -- Step 3: Set date style to DMY (day-month-year)
    -- Ensures proper date format parsing during data load.
    SET datestyle TO DMY;
    
    -- Step 4: Construct the full file path using the base path and file name
    -- Combines the static base path with the dynamic file name argument.
    full_path := base_path || file_name;

    -- Step 5: Truncate the table before loading new data
    -- This ensures that the table is cleared of old data before reloading.
    TRUNCATE TABLE bank.bank_loan_data;

    -- Step 6: Load data using COPY command with dynamic path
    -- The COPY command is used to efficiently load data from the CSV file.
    -- It reads the file at the constructed full path and loads the data into 
    -- the bank_loan_data table. The CSV file is assumed to have a header row.
    EXECUTE format(
        'COPY bank.bank_loan_data FROM %L DELIMITER '','' CSV HEADER;',
        full_path
    );

    -- Step 7: Raise a notice indicating successful data loading
    -- This helps with debugging and provides confirmation that the data load 
    -- was completed successfully.
    RAISE NOTICE '>> Data successfully loaded from %', full_path;
END;
$$;

-- =============================================================
-- Step 8: Example call to the procedure
-- -------------------------------------------------------------
-- To execute the stored procedure, use the following syntax:
-- CALL bank.sp_load_bank_loan_data('financial_loan.csv');
-- =============================================================
