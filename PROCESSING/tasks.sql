/*****************************************************************************************
Project      : Enterprise Master Data Platform
Platform     : Snowflake
Script       : 15_tasks.sql

Purpose
-------
Create orchestration tasks for incremental processing.

Author       : Dinesh Ahire
*****************************************************************************************/

USE ROLE MDM_ADMIN_ROLE;
USE DATABASE MDM_PLATFORM;
USE WAREHOUSE MDM_WH;

------------------------------------------------------------------------------------------
-- Root Task
------------------------------------------------------------------------------------------

CREATE OR REPLACE TASK TASK_INGESTION
WAREHOUSE = MDM_WH
SCHEDULE = '1 MINUTE'
COMMENT='Starts ingestion pipeline'
AS
CALL SP_INGEST_DATA();

------------------------------------------------------------------------------------------
-- Standardization
------------------------------------------------------------------------------------------

CREATE OR REPLACE TASK TASK_STANDARDIZATION
WAREHOUSE = MDM_WH
AFTER TASK_INGESTION
WHEN SYSTEM$STREAM_HAS_DATA('RAW.RAW_CUSTOMER_STREAM')
AS
CALL SP_STANDARDIZE_CUSTOMER();

------------------------------------------------------------------------------------------
-- Data Quality
------------------------------------------------------------------------------------------

CREATE OR REPLACE TASK TASK_DQ
WAREHOUSE = MDM_WH
AFTER TASK_STANDARDIZATION
WHEN SYSTEM$STREAM_HAS_DATA('CONFORMED.CONFORMED_CUSTOMER_STREAM')
AS
CALL SP_EXECUTE_DQ();

------------------------------------------------------------------------------------------
-- Matching
------------------------------------------------------------------------------------------

CREATE OR REPLACE TASK TASK_MATCHING
WAREHOUSE = MDM_WH
AFTER TASK_DQ
WHEN SYSTEM$STREAM_HAS_DATA('CONFORMED.CONFORMED_CUSTOMER_STREAM')
AS
CALL SP_MATCH_CUSTOMERS();

------------------------------------------------------------------------------------------
-- Golden Record
------------------------------------------------------------------------------------------

CREATE OR REPLACE TASK TASK_GOLDEN
WAREHOUSE = MDM_WH
AFTER TASK_MATCHING
WHEN SYSTEM$STREAM_HAS_DATA('CONFORMED.MATCH_GROUP_STREAM')
AS
CALL SP_BUILD_GOLDEN_RECORD();

------------------------------------------------------------------------------------------
-- Reconciliation
------------------------------------------------------------------------------------------

CREATE OR REPLACE TASK TASK_RECON
WAREHOUSE = MDM_WH
AFTER TASK_GOLDEN
AS
CALL SP_RECONCILIATION();

------------------------------------------------------------------------------------------
-- Lineage
------------------------------------------------------------------------------------------

CREATE OR REPLACE TASK TASK_LINEAGE
WAREHOUSE = MDM_WH
AFTER TASK_RECON
AS
CALL SP_CAPTURE_LINEAGE();

------------------------------------------------------------------------------------------
-- Observability
------------------------------------------------------------------------------------------

CREATE OR REPLACE TASK TASK_OBSERVABILITY
WAREHOUSE = MDM_WH
AFTER TASK_LINEAGE
AS
CALL SP_UPDATE_METRICS();