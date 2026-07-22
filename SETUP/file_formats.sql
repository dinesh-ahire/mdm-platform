/*****************************************************************************************
Project      : Enterprise Master Data Platform
Platform     : Snowflake
Script       : 03_file_formats.sql
Purpose      : Create reusable file formats for enterprise data ingestion.

File Formats
------------
FF_CSV_STANDARD
FF_JSON_STANDARD
FF_PARQUET_STANDARD

Author       : Dinesh Ahire
*****************************************************************************************/

USE ROLE MDM_ADMIN_ROLE;
USE DATABASE MDM_PLATFORM;
USE SCHEMA CONFIG;
USE WAREHOUSE MDM_WH;

------------------------------------------------------------------------------------------
-- CSV Standard File Format
------------------------------------------------------------------------------------------

CREATE OR REPLACE FILE FORMAT FF_CSV_STANDARD
TYPE = CSV
FIELD_DELIMITER = ','
SKIP_HEADER = 1
FIELD_OPTIONALLY_ENCLOSED_BY = '"'
TRIM_SPACE = TRUE
EMPTY_FIELD_AS_NULL = TRUE
NULL_IF = ('NULL', 'null', '')
ERROR_ON_COLUMN_COUNT_MISMATCH = FALSE
ESCAPE_UNENCLOSED_FIELD = NONE
COMMENT = 'Standard CSV format for enterprise source systems';

------------------------------------------------------------------------------------------
-- JSON Standard File Format
------------------------------------------------------------------------------------------

CREATE OR REPLACE FILE FORMAT FF_JSON_STANDARD
TYPE = JSON
STRIP_OUTER_ARRAY = TRUE
ALLOW_DUPLICATE = FALSE
IGNORE_UTF8_ERRORS = TRUE
COMMENT = 'Standard JSON format for REST APIs and event-based ingestion';

------------------------------------------------------------------------------------------
-- Parquet Standard File Format
------------------------------------------------------------------------------------------

CREATE OR REPLACE FILE FORMAT FF_PARQUET_STANDARD
TYPE = PARQUET
BINARY_AS_TEXT = FALSE
USE_LOGICAL_TYPE = TRUE
COMMENT = 'Standard Parquet format for analytical and bulk data ingestion';

------------------------------------------------------------------------------------------
-- XML File Format (Future Support)
------------------------------------------------------------------------------------------

CREATE OR REPLACE FILE FORMAT FF_XML_STANDARD
TYPE = XML
IGNORE_UTF8_ERRORS = TRUE
COMMENT = 'XML format for legacy enterprise applications';

------------------------------------------------------------------------------------------
-- Avro File Format (Future Support)
------------------------------------------------------------------------------------------

CREATE OR REPLACE FILE FORMAT FF_AVRO_STANDARD
TYPE = AVRO
COMMENT = 'Avro format for streaming and Kafka integrations';

------------------------------------------------------------------------------------------
-- ORC File Format (Future Support)
------------------------------------------------------------------------------------------

CREATE OR REPLACE FILE FORMAT FF_ORC_STANDARD
TYPE = ORC
COMMENT = 'ORC format for Hadoop ecosystem integrations';

------------------------------------------------------------------------------------------
-- Grant Usage
------------------------------------------------------------------------------------------

GRANT USAGE
ON FILE FORMAT FF_CSV_STANDARD
TO ROLE MDM_ENGINEER_ROLE;

GRANT USAGE
ON FILE FORMAT FF_JSON_STANDARD
TO ROLE MDM_ENGINEER_ROLE;

GRANT USAGE
ON FILE FORMAT FF_PARQUET_STANDARD
TO ROLE MDM_ENGINEER_ROLE;

GRANT USAGE
ON FILE FORMAT FF_XML_STANDARD
TO ROLE MDM_ENGINEER_ROLE;

GRANT USAGE
ON FILE FORMAT FF_AVRO_STANDARD
TO ROLE MDM_ENGINEER_ROLE;

GRANT USAGE
ON FILE FORMAT FF_ORC_STANDARD
TO ROLE MDM_ENGINEER_ROLE;

------------------------------------------------------------------------------------------
-- End of Script
------------------------------------------------------------------------------------------