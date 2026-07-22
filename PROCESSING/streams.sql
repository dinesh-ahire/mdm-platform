/*****************************************************************************************
Project      : Enterprise Master Data Platform
Platform     : Snowflake
Script       : 14_streams.sql

Purpose
-------
Create Streams for incremental processing across platform layers.

Author       : Dinesh Ahire
*****************************************************************************************/

USE ROLE MDM_ADMIN_ROLE;
USE DATABASE MDM_PLATFORM;
USE WAREHOUSE MDM_WH;

------------------------------------------------------------------------------------------
-- RAW CUSTOMER STREAM
------------------------------------------------------------------------------------------

CREATE OR REPLACE STREAM RAW.RAW_CUSTOMER_STREAM
ON TABLE RAW.RAW_CUSTOMER
APPEND_ONLY = FALSE
COMMENT = 'Captures incremental changes from RAW_CUSTOMER';

------------------------------------------------------------------------------------------
-- CONFORMED CUSTOMER STREAM
------------------------------------------------------------------------------------------

CREATE OR REPLACE STREAM CONFORMED.CONFORMED_CUSTOMER_STREAM
ON TABLE CONFORMED.CONFORMED_CUSTOMER
APPEND_ONLY = FALSE
COMMENT = 'Captures incremental changes from CONFORMED_CUSTOMER';

------------------------------------------------------------------------------------------
-- MATCH GROUP STREAM
------------------------------------------------------------------------------------------

CREATE OR REPLACE STREAM CONFORMED.MATCH_GROUP_STREAM
ON TABLE CONFORMED.MATCH_GROUP
APPEND_ONLY = FALSE
COMMENT = 'Captures new and updated match groups';

------------------------------------------------------------------------------------------
-- GOLDEN CUSTOMER STREAM
------------------------------------------------------------------------------------------

CREATE OR REPLACE STREAM GOLDEN.GOLDEN_CUSTOMER_STREAM
ON TABLE GOLDEN.GOLDEN_CUSTOMER
APPEND_ONLY = FALSE
COMMENT = 'Captures changes to Golden Customer records';

------------------------------------------------------------------------------------------
-- Grants
------------------------------------------------------------------------------------------

GRANT SELECT
ON ALL STREAMS IN DATABASE MDM_PLATFORM
TO ROLE MDM_ENGINEER_ROLE;

GRANT SELECT
ON FUTURE STREAMS IN DATABASE MDM_PLATFORM
TO ROLE MDM_ENGINEER_ROLE;

------------------------------------------------------------------------------------------
-- End of Script
------------------------------------------------------------------------------------------