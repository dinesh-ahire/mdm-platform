/*****************************************************************************************
Project      : Enterprise Master Data Platform
Platform     : Snowflake
Script       : 01_database.sql
Purpose      : Create foundational infrastructure for the MDM Platform.

Objects Created
---------------
1. Warehouse
2. Database
3. Roles
4. Grants
5. Default Context

Author       : Dinesh Ahire
*****************************************************************************************/


/*=======================================================================================
 STEP 1 : Create Warehouse
=======================================================================================*/

CREATE OR REPLACE WAREHOUSE MDM_WH
WITH
WAREHOUSE_SIZE = 'SMALL'
WAREHOUSE_TYPE = 'STANDARD'
AUTO_SUSPEND = 60
AUTO_RESUME = TRUE
INITIALLY_SUSPENDED = TRUE
COMMENT = 'Warehouse for Enterprise Master Data Platform';


/*=======================================================================================
 STEP 2 : Create Database
=======================================================================================*/

CREATE OR REPLACE DATABASE MDM_PLATFORM
COMMENT = 'Enterprise Master Data Platform Database';


/*=======================================================================================
 STEP 3 : Create Roles
=======================================================================================*/

CREATE ROLE IF NOT EXISTS MDM_ADMIN_ROLE
COMMENT='Platform Administrator';

CREATE ROLE IF NOT EXISTS MDM_ENGINEER_ROLE
COMMENT='Data Engineering Role';

CREATE ROLE IF NOT EXISTS MDM_ANALYST_ROLE
COMMENT='Business Consumption Role';

CREATE ROLE IF NOT EXISTS MDM_READONLY_ROLE
COMMENT='Read Only Access';


/*=======================================================================================
 STEP 4 : Role Hierarchy
=======================================================================================*/

GRANT ROLE MDM_READONLY_ROLE TO ROLE MDM_ANALYST_ROLE;

GRANT ROLE MDM_ANALYST_ROLE TO ROLE MDM_ENGINEER_ROLE;

GRANT ROLE MDM_ENGINEER_ROLE TO ROLE MDM_ADMIN_ROLE;


/*=======================================================================================
 STEP 5 : Warehouse Grants
=======================================================================================*/

GRANT USAGE
ON WAREHOUSE MDM_WH
TO ROLE MDM_READONLY_ROLE;

GRANT OPERATE
ON WAREHOUSE MDM_WH
TO ROLE MDM_ENGINEER_ROLE;


/*=======================================================================================
 STEP 6 : Database Grants
=======================================================================================*/

GRANT USAGE
ON DATABASE MDM_PLATFORM
TO ROLE MDM_READONLY_ROLE;

GRANT CREATE SCHEMA
ON DATABASE MDM_PLATFORM
TO ROLE MDM_ENGINEER_ROLE;


/*=======================================================================================
 STEP 7 : Future Object Ownership
=======================================================================================*/

GRANT ALL PRIVILEGES
ON DATABASE MDM_PLATFORM
TO ROLE MDM_ADMIN_ROLE;


/*=======================================================================================
 STEP 8 : Session Context
=======================================================================================*/

USE ROLE MDM_ADMIN_ROLE;

USE WAREHOUSE MDM_WH;

USE DATABASE MDM_PLATFORM;


/*=======================================================================================
 End of Script
=======================================================================================*/