/*****************************************************************************************
Project      : Enterprise Master Data Platform
Platform     : Snowflake
Script       : 12_matching_tables.sql

Purpose
-------
Create Identity Resolution tables.

Author       : Dinesh Ahire
*****************************************************************************************/

USE ROLE MDM_ADMIN_ROLE;
USE DATABASE MDM_PLATFORM;
USE SCHEMA CONFORMED;
USE WAREHOUSE MDM_WH;

------------------------------------------------------------------------------------------
-- Match Candidates
------------------------------------------------------------------------------------------

CREATE OR REPLACE TABLE MATCH_CANDIDATES
(
    CANDIDATE_ID              NUMBER AUTOINCREMENT,

    LEFT_CUSTOMER_ID          NUMBER NOT NULL,
    RIGHT_CUSTOMER_ID         NUMBER NOT NULL,

    BLOCKING_KEY              VARCHAR(200),

    EMAIL_SCORE               NUMBER(5,2),
    PHONE_SCORE               NUMBER(5,2),
    NAME_SCORE                NUMBER(5,2),
    ADDRESS_SCORE             NUMBER(5,2),

    TOTAL_MATCH_SCORE         NUMBER(5,2),

    MATCH_STATUS              VARCHAR(20),

    PIPELINE_RUN_ID           NUMBER,

    CREATED_TS                TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),

    CONSTRAINT PK_MATCH_CANDIDATE
        PRIMARY KEY (CANDIDATE_ID)

)

COMMENT='Potential duplicate customer pairs.';

------------------------------------------------------------------------------------------
-- Match Groups
------------------------------------------------------------------------------------------

CREATE OR REPLACE TABLE MATCH_GROUP
(
    MATCH_GROUP_ID            NUMBER AUTOINCREMENT,

    GROUP_STATUS              VARCHAR(20),

    MATCH_CONFIDENCE          NUMBER(5,2),

    GOLDEN_RECORD_CREATED     BOOLEAN DEFAULT FALSE,

    PIPELINE_RUN_ID           NUMBER,

    CREATED_TS                TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),

    UPDATED_TS                TIMESTAMP,

    CONSTRAINT PK_MATCH_GROUP
        PRIMARY KEY (MATCH_GROUP_ID)

)

COMMENT='Logical customer clusters.';

------------------------------------------------------------------------------------------
-- Match Group Members
------------------------------------------------------------------------------------------

CREATE OR REPLACE TABLE MATCH_GROUP_MEMBER
(
    MEMBER_ID                 NUMBER AUTOINCREMENT,

    MATCH_GROUP_ID            NUMBER,

    CONFORMED_CUSTOMER_ID     NUMBER,

    SOURCE_CODE               VARCHAR(30),

    SOURCE_RECORD_ID          VARCHAR(100),

    CREATED_TS                TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),

    CONSTRAINT PK_MATCH_MEMBER
        PRIMARY KEY (MEMBER_ID)

)

COMMENT='Members belonging to a match group.';

------------------------------------------------------------------------------------------
-- Match Decision
------------------------------------------------------------------------------------------

CREATE OR REPLACE TABLE MATCH_DECISION
(
    DECISION_ID               NUMBER AUTOINCREMENT,

    MATCH_GROUP_ID            NUMBER,

    DECISION_TYPE             VARCHAR(20),

    DECISION_BY               VARCHAR(100),

    DECISION_REASON           VARCHAR,

    DECISION_TS               TIMESTAMP,

    PIPELINE_RUN_ID           NUMBER,

    CONSTRAINT PK_MATCH_DECISION
        PRIMARY KEY (DECISION_ID)

)

COMMENT='Auto or manual merge decisions.';

------------------------------------------------------------------------------------------
-- Manual Review Queue
------------------------------------------------------------------------------------------

CREATE OR REPLACE TABLE MANUAL_REVIEW_QUEUE
(
    REVIEW_ID                 NUMBER AUTOINCREMENT,

    MATCH_GROUP_ID            NUMBER,

    LEFT_CUSTOMER_ID          NUMBER,

    RIGHT_CUSTOMER_ID         NUMBER,

    MATCH_SCORE               NUMBER(5,2),

    REVIEW_STATUS             VARCHAR(20),

    ASSIGNED_TO               VARCHAR(100),

    REVIEW_COMMENTS           VARCHAR,

    CREATED_TS                TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),

    RESOLVED_TS               TIMESTAMP,

    CONSTRAINT PK_REVIEW
        PRIMARY KEY (REVIEW_ID)

)

COMMENT='Low confidence matches requiring steward review.';

