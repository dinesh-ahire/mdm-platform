/*****************************************************************************************
Project      : Enterprise Master Data Platform
Platform     : Snowflake
Script       : 04_internal_stage.sql

Purpose
-------
Create Internal Stages for development, testing,
manual uploads and source-specific ingestion.

Stages
------
INT_COMMON_STAGE
INT_CRM_STAGE
INT_ECOM_STAGE
INT_SUPPORT_STAGE
INT_LOYALTY_STAGE
INT_QUARANTINE_STAGE
INT_ARCHIVE_STAGE

Author       : Dinesh Ahire
*****************************************************************************************/

USE ROLE MDM_ADMIN_ROLE;
USE DATABASE MDM_PLATFORM;
USE SCHEMA RAW;
USE WAREHOUSE MDM_WH;

------------------------------------------------------------------------------------------
-- Shared Stage
------------------------------------------------------------------------------------------

CREATE OR REPLACE STAGE INT_COMMON_STAGE
DIRECTORY = (ENABLE = TRUE)
COMMENT='Shared internal stage for manual uploads, testing and ad-hoc ingestion';

------------------------------------------------------------------------------------------
-- CRM Stage
------------------------------------------------------------------------------------------

CREATE OR REPLACE STAGE INT_CRM_STAGE
DIRECTORY = (ENABLE = TRUE)
FILE_FORMAT = CONFIG.FF_CSV_STANDARD
COMMENT='Internal stage for CRM source files';

------------------------------------------------------------------------------------------
-- E-Commerce Stage
------------------------------------------------------------------------------------------

CREATE OR REPLACE STAGE INT_ECOM_STAGE
DIRECTORY = (ENABLE = TRUE)
FILE_FORMAT = CONFIG.FF_JSON_STANDARD
COMMENT='Internal stage for E-Commerce source files';

------------------------------------------------------------------------------------------
-- Support Stage
------------------------------------------------------------------------------------------

CREATE OR REPLACE STAGE INT_SUPPORT_STAGE
DIRECTORY = (ENABLE = TRUE)
FILE_FORMAT = CONFIG.FF_JSON_STANDARD
COMMENT='Internal stage for Support source files';

------------------------------------------------------------------------------------------
-- Loyalty Stage
------------------------------------------------------------------------------------------

CREATE OR REPLACE STAGE INT_LOYALTY_STAGE
DIRECTORY = (ENABLE = TRUE)
FILE_FORMAT = CONFIG.FF_CSV_STANDARD
COMMENT='Internal stage for Loyalty source files';

------------------------------------------------------------------------------------------
-- Quarantine Stage
------------------------------------------------------------------------------------------

CREATE OR REPLACE STAGE INT_QUARANTINE_STAGE
DIRECTORY = (ENABLE = TRUE)
COMMENT='Stores rejected files that require investigation';

------------------------------------------------------------------------------------------
-- Archive Stage
------------------------------------------------------------------------------------------

CREATE OR REPLACE STAGE INT_ARCHIVE_STAGE
DIRECTORY = (ENABLE = TRUE)
COMMENT='Stores successfully processed files for audit and replay';

------------------------------------------------------------------------------------------
-- Grants
------------------------------------------------------------------------------------------

GRANT USAGE
ON ALL STAGES IN SCHEMA RAW
TO ROLE MDM_ENGINEER_ROLE;

GRANT READ
ON ALL STAGES IN SCHEMA RAW
TO ROLE MDM_ENGINEER_ROLE;

------------------------------------------------------------------------------------------
-- Future Grants
------------------------------------------------------------------------------------------

GRANT USAGE
ON FUTURE STAGES IN SCHEMA RAW
TO ROLE MDM_ENGINEER_ROLE;

GRANT READ
ON FUTURE STAGES IN SCHEMA RAW
TO ROLE MDM_ENGINEER_ROLE;

------------------------------------------------------------------------------------------
-- End of Script
------------------------------------------------------------------------------------------