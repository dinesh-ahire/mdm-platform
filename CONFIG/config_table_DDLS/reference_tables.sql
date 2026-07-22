/*****************************************************************************************
Project      : Enterprise Master Data Platform
Platform     : Snowflake
Script       : 08_reference_tables.sql

Purpose
-------
Create enterprise reference tables used for data standardization,
validation, and identity resolution.

Author       : Dinesh Ahire
*****************************************************************************************/

USE ROLE MDM_ADMIN_ROLE;
USE DATABASE MDM_PLATFORM;
USE SCHEMA REFERENCE;
USE WAREHOUSE MDM_WH;

------------------------------------------------------------------------------------------
-- Country Reference
------------------------------------------------------------------------------------------

CREATE OR REPLACE TABLE REF_COUNTRY
(
    COUNTRY_CODE        VARCHAR(3)      NOT NULL,
    COUNTRY_NAME        VARCHAR(100)    NOT NULL,
    ISO2_CODE           VARCHAR(2),
    ISO3_CODE           VARCHAR(3),
    ACTIVE_FLAG         BOOLEAN DEFAULT TRUE,
    CREATED_TS          TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),

    CONSTRAINT PK_REF_COUNTRY PRIMARY KEY (COUNTRY_CODE)
)
COMMENT='Master list of countries';

------------------------------------------------------------------------------------------
-- State / Province Reference
------------------------------------------------------------------------------------------

CREATE OR REPLACE TABLE REF_STATE
(
    STATE_CODE          VARCHAR(10)     NOT NULL,
    STATE_NAME          VARCHAR(100)    NOT NULL,
    COUNTRY_CODE        VARCHAR(3)      NOT NULL,
    ACTIVE_FLAG         BOOLEAN DEFAULT TRUE,
    CREATED_TS          TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),

    CONSTRAINT PK_REF_STATE PRIMARY KEY (STATE_CODE)
)
COMMENT='Master list of states and provinces';

------------------------------------------------------------------------------------------
-- Gender Reference
------------------------------------------------------------------------------------------

CREATE OR REPLACE TABLE REF_GENDER
(
    GENDER_CODE         VARCHAR(10)     NOT NULL,
    GENDER_DESCRIPTION  VARCHAR(50),
    ACTIVE_FLAG         BOOLEAN DEFAULT TRUE,
    CREATED_TS          TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),

    CONSTRAINT PK_REF_GENDER PRIMARY KEY (GENDER_CODE)
)
COMMENT='Standard gender values';

------------------------------------------------------------------------------------------
-- Phone Country Code Reference
------------------------------------------------------------------------------------------

CREATE OR REPLACE TABLE REF_PHONE_COUNTRY_CODE
(
    COUNTRY_CODE        VARCHAR(3)      NOT NULL,
    DIAL_CODE           VARCHAR(10)     NOT NULL,
    COUNTRY_NAME        VARCHAR(100),
    ACTIVE_FLAG         BOOLEAN DEFAULT TRUE,
    CREATED_TS          TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),

    CONSTRAINT PK_REF_PHONE_COUNTRY PRIMARY KEY (COUNTRY_CODE)
)
COMMENT='International dialing codes';

------------------------------------------------------------------------------------------
-- Customer Status Reference
------------------------------------------------------------------------------------------

CREATE OR REPLACE TABLE REF_CUSTOMER_STATUS
(
    STATUS_CODE         VARCHAR(20)     NOT NULL,
    STATUS_DESCRIPTION  VARCHAR(100),
    ACTIVE_FLAG         BOOLEAN DEFAULT TRUE,
    CREATED_TS          TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),

    CONSTRAINT PK_REF_CUSTOMER_STATUS PRIMARY KEY (STATUS_CODE)
)
COMMENT='Standard customer lifecycle statuses';

------------------------------------------------------------------------------------------
-- Grants
------------------------------------------------------------------------------------------

GRANT SELECT
ON ALL TABLES IN SCHEMA REFERENCE
TO ROLE MDM_ANALYST_ROLE;

GRANT SELECT
ON FUTURE TABLES IN SCHEMA REFERENCE
TO ROLE MDM_ANALYST_ROLE;

GRANT SELECT, INSERT, UPDATE, DELETE
ON ALL TABLES IN SCHEMA REFERENCE
TO ROLE MDM_ENGINEER_ROLE;

GRANT SELECT, INSERT, UPDATE, DELETE
ON FUTURE TABLES IN SCHEMA REFERENCE
TO ROLE MDM_ENGINEER_ROLE;

------------------------------------------------------------------------------------------
-- End of Script
------------------------------------------------------------------------------------------