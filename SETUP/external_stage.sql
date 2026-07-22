/*****************************************************************************************
Project      : Enterprise Master Data Platform
Platform     : Snowflake
Script       : 05_external_stage.sql

Purpose
-------
Create AWS Storage Integration and External Stages
for production ingestion.

Author       : Dinesh Ahire
*****************************************************************************************/

USE ROLE MDM_ADMIN_ROLE;
USE DATABASE MDM_PLATFORM;
USE SCHEMA RAW;
USE WAREHOUSE MDM_WH;

------------------------------------------------------------------------------------------
-- Storage Integration
------------------------------------------------------------------------------------------

CREATE OR REPLACE STORAGE INTEGRATION MDM_S3_INT
TYPE = EXTERNAL_STAGE
STORAGE_PROVIDER = S3
ENABLED = TRUE
STORAGE_AWS_ROLE_ARN = '<AWS_IAM_ROLE_ARN>'
STORAGE_ALLOWED_LOCATIONS =
(
    's3://enterprise-mdm/'
)
COMMENT='AWS Storage Integration for Enterprise MDM Platform';

------------------------------------------------------------------------------------------
-- CRM External Stage
------------------------------------------------------------------------------------------

CREATE OR REPLACE STAGE EXT_CRM_STAGE
URL='s3://enterprise-mdm/crm/customer/'
STORAGE_INTEGRATION = MDM_S3_INT
FILE_FORMAT = CONFIG.FF_CSV_STANDARD
DIRECTORY=(ENABLE=TRUE)
COMMENT='CRM Production Feed';

------------------------------------------------------------------------------------------
-- E-Commerce External Stage
------------------------------------------------------------------------------------------

CREATE OR REPLACE STAGE EXT_ECOM_STAGE
URL='s3://enterprise-mdm/ecommerce/customer/'
STORAGE_INTEGRATION = MDM_S3_INT
FILE_FORMAT = CONFIG.FF_JSON_STANDARD
DIRECTORY=(ENABLE=TRUE)
COMMENT='E-Commerce Production Feed';

------------------------------------------------------------------------------------------
-- Support External Stage
------------------------------------------------------------------------------------------

CREATE OR REPLACE STAGE EXT_SUPPORT_STAGE
URL='s3://enterprise-mdm/support/caller/'
STORAGE_INTEGRATION = MDM_S3_INT
FILE_FORMAT = CONFIG.FF_JSON_STANDARD
DIRECTORY=(ENABLE=TRUE)
COMMENT='Support Production Feed';

------------------------------------------------------------------------------------------
-- Loyalty External Stage
------------------------------------------------------------------------------------------

CREATE OR REPLACE STAGE EXT_LOYALTY_STAGE
URL='s3://enterprise-mdm/loyalty/member/'
STORAGE_INTEGRATION = MDM_S3_INT
FILE_FORMAT = CONFIG.FF_CSV_STANDARD
DIRECTORY=(ENABLE=TRUE)
COMMENT='Loyalty Production Feed';

------------------------------------------------------------------------------------------
-- Archive Stage
------------------------------------------------------------------------------------------

CREATE OR REPLACE STAGE EXT_ARCHIVE_STAGE
URL='s3://enterprise-mdm/archive/'
STORAGE_INTEGRATION = MDM_S3_INT
DIRECTORY=(ENABLE=TRUE)
COMMENT='Processed files archive';

------------------------------------------------------------------------------------------
-- Quarantine Stage
------------------------------------------------------------------------------------------

CREATE OR REPLACE STAGE EXT_QUARANTINE_STAGE
URL='s3://enterprise-mdm/quarantine/'
STORAGE_INTEGRATION = MDM_S3_INT
DIRECTORY=(ENABLE=TRUE)
COMMENT='Rejected and malformed files';

------------------------------------------------------------------------------------------
-- Grants
------------------------------------------------------------------------------------------

GRANT USAGE
ON INTEGRATION MDM_S3_INT
TO ROLE MDM_ENGINEER_ROLE;

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
-- End
------------------------------------------------------------------------------------------