/*****************************************************************************************
Project      : Enterprise Master Data Platform
Platform     : Snowflake
Script       : 02_schemas.sql
Purpose      : Create logical schemas for the MDM Platform.

Schemas
-------
CONFIG
REFERENCE
METADATA
RAW
CONFORMED
GOLDEN
AUDIT
SERVING

Author       : Dinesh Ahire
*****************************************************************************************/

USE ROLE MDM_ADMIN_ROLE;
USE DATABASE MDM_PLATFORM;
USE WAREHOUSE MDM_WH;

------------------------------------------------------------------------------------------
-- CONFIG
------------------------------------------------------------------------------------------

CREATE SCHEMA IF NOT EXISTS CONFIG
COMMENT='Configuration-driven framework metadata';

------------------------------------------------------------------------------------------
-- REFERENCE
------------------------------------------------------------------------------------------

CREATE SCHEMA IF NOT EXISTS REFERENCE
COMMENT='Reference and lookup data used for standardization and validation';

------------------------------------------------------------------------------------------
-- METADATA
------------------------------------------------------------------------------------------

CREATE SCHEMA IF NOT EXISTS METADATA
COMMENT='Pipeline execution metadata, lineage and reconciliation';

------------------------------------------------------------------------------------------
-- RAW (Bronze Layer)
------------------------------------------------------------------------------------------

CREATE SCHEMA IF NOT EXISTS RAW
COMMENT='Raw source data exactly as received from upstream systems';

------------------------------------------------------------------------------------------
-- CONFORMED (Silver Layer)
------------------------------------------------------------------------------------------

CREATE SCHEMA IF NOT EXISTS CONFORMED
COMMENT='Standardized, validated and conformed customer records';

------------------------------------------------------------------------------------------
-- GOLDEN (Gold Layer)
------------------------------------------------------------------------------------------

CREATE SCHEMA IF NOT EXISTS GOLDEN
COMMENT='Golden Records and Master Data entities';

------------------------------------------------------------------------------------------
-- AUDIT
------------------------------------------------------------------------------------------

CREATE SCHEMA IF NOT EXISTS AUDIT
COMMENT='Audit logs, operational metrics and error tracking';

------------------------------------------------------------------------------------------
-- SERVING
------------------------------------------------------------------------------------------

CREATE SCHEMA IF NOT EXISTS SERVING
COMMENT='Business consumption layer including views and APIs';

------------------------------------------------------------------------------------------
-- Grant Schema Usage
------------------------------------------------------------------------------------------

GRANT USAGE ON SCHEMA CONFIG TO ROLE MDM_READONLY_ROLE;
GRANT USAGE ON SCHEMA REFERENCE TO ROLE MDM_READONLY_ROLE;
GRANT USAGE ON SCHEMA METADATA TO ROLE MDM_READONLY_ROLE;
GRANT USAGE ON SCHEMA RAW TO ROLE MDM_READONLY_ROLE;
GRANT USAGE ON SCHEMA CONFORMED TO ROLE MDM_READONLY_ROLE;
GRANT USAGE ON SCHEMA GOLDEN TO ROLE MDM_READONLY_ROLE;
GRANT USAGE ON SCHEMA AUDIT TO ROLE MDM_READONLY_ROLE;
GRANT USAGE ON SCHEMA SERVING TO ROLE MDM_READONLY_ROLE;

------------------------------------------------------------------------------------------
-- Engineering Privileges
------------------------------------------------------------------------------------------

GRANT CREATE TABLE
ON ALL SCHEMAS IN DATABASE MDM_PLATFORM
TO ROLE MDM_ENGINEER_ROLE;

GRANT CREATE VIEW
ON ALL SCHEMAS IN DATABASE MDM_PLATFORM
TO ROLE MDM_ENGINEER_ROLE;

GRANT CREATE STAGE
ON ALL SCHEMAS IN DATABASE MDM_PLATFORM
TO ROLE MDM_ENGINEER_ROLE;

GRANT CREATE FILE FORMAT
ON ALL SCHEMAS IN DATABASE MDM_PLATFORM
TO ROLE MDM_ENGINEER_ROLE;

GRANT CREATE STREAM
ON ALL SCHEMAS IN DATABASE MDM_PLATFORM
TO ROLE MDM_ENGINEER_ROLE;

GRANT CREATE TASK
ON ALL SCHEMAS IN DATABASE MDM_PLATFORM
TO ROLE MDM_ENGINEER_ROLE;

GRANT CREATE PROCEDURE
ON ALL SCHEMAS IN DATABASE MDM_PLATFORM
TO ROLE MDM_ENGINEER_ROLE;

GRANT CREATE FUNCTION
ON ALL SCHEMAS IN DATABASE MDM_PLATFORM
TO ROLE MDM_ENGINEER_ROLE;

------------------------------------------------------------------------------------------
-- Future Grants
------------------------------------------------------------------------------------------

GRANT SELECT
ON FUTURE TABLES
IN SCHEMA GOLDEN
TO ROLE MDM_ANALYST_ROLE;

GRANT SELECT
ON FUTURE VIEWS
IN SCHEMA SERVING
TO ROLE MDM_ANALYST_ROLE;

GRANT SELECT
ON FUTURE TABLES
IN SCHEMA CONFORMED
TO ROLE MDM_ANALYST_ROLE;

------------------------------------------------------------------------------------------
-- End of Script
------------------------------------------------------------------------------------------