/*****************************************************************************************
Project      : Enterprise Master Data Platform
Platform     : Snowflake
Script       : 09_metadata_tables.sql

Purpose
-------
Create metadata tables for monitoring, lineage, auditing,
reconciliation and observability.

Author       : Dinesh Ahire
*****************************************************************************************/

USE ROLE MDM_ADMIN_ROLE;
USE DATABASE MDM_PLATFORM;
USE SCHEMA METADATA;
USE WAREHOUSE MDM_WH;

------------------------------------------------------------------------------------------
-- Pipeline Run
------------------------------------------------------------------------------------------

CREATE OR REPLACE TABLE PIPELINE_RUN
(
    RUN_ID                   NUMBER AUTOINCREMENT,
    PIPELINE_NAME            VARCHAR(100)      NOT NULL,
    SOURCE_CODE              VARCHAR(30),
    START_TIME               TIMESTAMP_NTZ,
    END_TIME                 TIMESTAMP_NTZ,
    STATUS                   VARCHAR(20),
    RECORDS_READ             NUMBER,
    RECORDS_WRITTEN          NUMBER,
    RECORDS_REJECTED         NUMBER,
    EXECUTION_TIME_SECONDS   NUMBER,
    ERROR_MESSAGE            STRING,
    CREATED_TS               TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),

    CONSTRAINT PK_PIPELINE_RUN PRIMARY KEY (RUN_ID)
)
COMMENT='Tracks every pipeline execution.';

------------------------------------------------------------------------------------------
-- File Load History
------------------------------------------------------------------------------------------

CREATE OR REPLACE TABLE FILE_LOAD_HISTORY
(
    LOAD_ID                  NUMBER AUTOINCREMENT,
    SOURCE_CODE              VARCHAR(30),
    FILE_NAME                STRING,
    FILE_PATH                STRING,
    FILE_SIZE_BYTES          NUMBER,
    CHECKSUM                 STRING,
    LOAD_TIME                TIMESTAMP_NTZ,
    LOAD_STATUS              VARCHAR(20),
    ROW_COUNT                NUMBER,
    ERROR_COUNT              NUMBER,
    PIPELINE_RUN_ID          NUMBER,
    CREATED_TS               TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),

    CONSTRAINT PK_FILE_LOAD PRIMARY KEY (LOAD_ID)
)
COMMENT='Tracks every processed file.';

------------------------------------------------------------------------------------------
-- Object Lineage
------------------------------------------------------------------------------------------

CREATE OR REPLACE TABLE OBJECT_LINEAGE
(
    LINEAGE_ID               NUMBER AUTOINCREMENT,
    PIPELINE_RUN_ID          NUMBER,
    SOURCE_OBJECT            STRING,
    TARGET_OBJECT            STRING,
    TRANSFORMATION_NAME      STRING,
    EXECUTION_TS             TIMESTAMP_NTZ,
    CREATED_TS               TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),

    CONSTRAINT PK_OBJECT_LINEAGE PRIMARY KEY (LINEAGE_ID)
)
COMMENT='Captures end-to-end data lineage.';

------------------------------------------------------------------------------------------
-- Task Execution History
------------------------------------------------------------------------------------------

CREATE OR REPLACE TABLE TASK_EXECUTION_HISTORY
(
    TASK_RUN_ID              NUMBER AUTOINCREMENT,
    TASK_NAME                STRING,
    START_TIME               TIMESTAMP_NTZ,
    END_TIME                 TIMESTAMP_NTZ,
    STATUS                   VARCHAR(20),
    ERROR_MESSAGE            STRING,
    PIPELINE_RUN_ID          NUMBER,
    CREATED_TS               TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),

    CONSTRAINT PK_TASK_HISTORY PRIMARY KEY (TASK_RUN_ID)
)
COMMENT='Stores execution details for Snowflake Tasks.';

------------------------------------------------------------------------------------------
-- Reconciliation Metrics
------------------------------------------------------------------------------------------

CREATE OR REPLACE TABLE RECONCILIATION_METRICS
(
    RECON_ID                 NUMBER AUTOINCREMENT,
    PIPELINE_RUN_ID          NUMBER,
    SOURCE_TABLE             STRING,
    TARGET_TABLE             STRING,
    SOURCE_RECORD_COUNT      NUMBER,
    TARGET_RECORD_COUNT      NUMBER,
    DIFFERENCE_COUNT         NUMBER,
    RECON_STATUS             VARCHAR(20),
    CREATED_TS               TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),

    CONSTRAINT PK_RECON PRIMARY KEY (RECON_ID)
)
COMMENT='Stores reconciliation metrics between processing layers.';

------------------------------------------------------------------------------------------
-- Error Log
------------------------------------------------------------------------------------------

CREATE OR REPLACE TABLE ERROR_LOG
(
    ERROR_ID                 NUMBER AUTOINCREMENT,
    PIPELINE_RUN_ID          NUMBER,
    OBJECT_NAME              STRING,
    ERROR_STAGE              VARCHAR(50),
    ERROR_MESSAGE            STRING,
    ERROR_DETAILS            STRING,
    CREATED_TS               TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),

    CONSTRAINT PK_ERROR_LOG PRIMARY KEY (ERROR_ID)
)
COMMENT='Centralized application error log.';

------------------------------------------------------------------------------------------
-- Schema Version History
------------------------------------------------------------------------------------------

CREATE OR REPLACE TABLE SCHEMA_VERSION_HISTORY
(
    VERSION_ID               NUMBER AUTOINCREMENT,
    SCRIPT_NAME              STRING,
    VERSION                  VARCHAR(20),
    DEPLOYED_BY              STRING,
    DEPLOYED_TS              TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    REMARKS                  STRING,

    CONSTRAINT PK_SCHEMA_VERSION PRIMARY KEY (VERSION_ID)
)
COMMENT='Tracks deployment history of SQL scripts.';

------------------------------------------------------------------------------------------
-- Grants
------------------------------------------------------------------------------------------

GRANT SELECT ON ALL TABLES IN SCHEMA METADATA
TO ROLE MDM_ANALYST_ROLE;

GRANT SELECT ON FUTURE TABLES IN SCHEMA METADATA
TO ROLE MDM_ANALYST_ROLE;

GRANT SELECT, INSERT, UPDATE, DELETE
ON ALL TABLES IN SCHEMA METADATA
TO ROLE MDM_ENGINEER_ROLE;

GRANT SELECT, INSERT, UPDATE, DELETE
ON FUTURE TABLES IN SCHEMA METADATA
TO ROLE MDM_ENGINEER_ROLE;

------------------------------------------------------------------------------------------
-- End of Script
------------------------------------------------------------------------------------------