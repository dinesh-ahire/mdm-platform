# Enterprise MDM Platform - Operations Runbook

> Version: 1.0  
> Author: Dinesh Ahire  
> Platform: Snowflake Native  
> Last Updated: July 2026

---

# Table of Contents

1. Purpose
2. Environment Overview
3. Prerequisites
4. Deployment Guide
5. Initial Configuration
6. Pipeline Execution
7. Monitoring
8. Operational Procedures
9. Troubleshooting
10. Recovery Procedures
11. Maintenance
12. Source System Onboarding
13. Backup & Disaster Recovery
14. Operational Best Practices

---

# 1. Purpose

This runbook provides operational guidance for deploying, executing, monitoring, and maintaining the Enterprise Master Data Management (MDM) Platform.

It is intended for:

- Data Engineers
- Platform Engineers
- DevOps Teams
- Support Engineers
- Snowflake Administrators

---

# 2. Environment Overview

## Platform Components

- Snowflake Database
- Snowflake Warehouse
- Internal Stages
- External Stages
- Snowpipe
- Streams
- Tasks
- Snowpark Python Procedures
- Streamlit Application

---

## Processing Workflow

```text
Source Systems

↓

Snowpipe

↓

RAW

↓

CONFORMED

↓

MATCHING

↓

GOLDEN

↓

Serving Layer
```

---

# 3. Prerequisites

Before deployment ensure the following are available.

## Snowflake

- Enterprise Edition or higher
- ACCOUNTADMIN privileges (deployment)
- SYSADMIN privileges (runtime)

## Python

- Python 3.11+
- Snowpark Python
- Streamlit

## Cloud Storage

If External Stage is used:

- AWS S3
- Azure Blob
- Google Cloud Storage

---

# 4. Deployment Guide

Deployment should follow the order below.

## Step 1

Create Warehouse

```sql
CREATE WAREHOUSE MDM_WH;
```

---

## Step 2

Create Database

```sql
CREATE DATABASE MDM;
```

---

## Step 3

Execute SQL Scripts

Run folders in sequence.

```text
00_setup/

↓

01_configuration/

↓

02_core/

↓

03_processing/

↓

04_seed_data/

↓

05_validation/
```

---

## Step 4

Deploy Snowpark Stored Procedures

Deploy procedures from

```text
snowpark/procedures/
```

---

## Step 5

Create Streams

Execute

```sql
CREATE STREAM ...
```

---

## Step 6

Create Tasks

Resume tasks only after validation.

```sql
ALTER TASK ... RESUME;
```

---

## Step 7

Deploy Streamlit Application

Execute

```text
streamlit run app.py
```

Deployment is now complete.

---

# 5. Initial Configuration

Populate configuration tables.

Required tables include:

- CONFIG_SOURCE_SYSTEMS
- CONFIG_PIPELINE
- CONFIG_STANDARDIZATION_RULES
- CONFIG_DQ_RULES
- CONFIG_MATCH_RULES
- CONFIG_SURVIVORSHIP_RULES

Validate configuration before enabling Tasks.

---

# 6. Pipeline Execution

## Automatic

Production execution is event-driven.

```text
Snowpipe

↓

RAW_STREAM

↓

Standardization

↓

CONFORMED_STREAM

↓

DQ

↓

MATCH_STREAM

↓

Survivorship
```

---

## Manual Execution

Each stage can be executed independently.

Example:

```sql
CALL SP_STANDARDIZE_CUSTOMER();
```

or

```sql
CALL SP_MATCH_CUSTOMERS();
```

---

# 7. Monitoring

Monitor the following operational metrics.

| Metric | Description |
|---------|-------------|
| Pipeline Status | Success / Failure |
| Records Processed | Row count |
| Processing Time | Execution duration |
| DQ Failures | Validation failures |
| Manual Review Queue | Pending reviews |
| Warehouse Utilization | Compute usage |

Useful metadata tables:

- PIPELINE_RUN
- FILE_LOAD_HISTORY
- ERROR_LOG
- OBJECT_LINEAGE
- RECONCILIATION_METRICS

---

# 8. Operational Procedures

## Daily

- Verify pipeline completion
- Check failed records
- Review manual review queue
- Confirm reconciliation counts
- Validate warehouse usage

---

## Weekly

- Review DQ trends
- Archive completed files
- Review audit logs
- Validate task schedules

---

## Monthly

- Review source priorities
- Optimize warehouses
- Analyze pipeline performance
- Review metadata growth

---

# 9. Troubleshooting

## File Failed to Load

Possible causes:

- Incorrect format
- Missing columns
- Corrupted file
- Invalid stage location

Resolution:

- Check FILE_LOAD_HISTORY
- Review ERROR_LOG
- Correct file
- Reload

---

## Pipeline Failure

Check:

- TASK_HISTORY
- PIPELINE_RUN
- Stored Procedure logs

Restart failed stage.

---

## Duplicate Golden Records

Review:

- MATCH_RULES
- MATCH_GROUP
- MANUAL_REVIEW_QUEUE

Adjust thresholds if necessary.

---

## High Warehouse Cost

Verify:

- Task schedule
- Warehouse size
- Incremental processing
- Stream backlog

---

# 10. Recovery Procedures

## Recover Failed File

Correct source file.

Reload into stage.

Re-execute ingestion procedure.

---

## Replay Pipeline

Because Streams are incremental:

- Resume failed stage
- Downstream Tasks continue automatically

---

## Recover Golden Record

Golden history enables rollback.

Restore previous version.

Update XREF if required.

---

# 11. Maintenance

Routine maintenance includes:

- Purging archived files
- Reviewing metadata tables
- Optimizing warehouses
- Updating reference data
- Updating business rules

No application deployment is required when metadata changes.

---

# 12. Source System Onboarding

Adding a new source requires:

1. Create Stage
2. Register source
3. Configure mapping
4. Configure DQ rules
5. Configure match rules
6. Test ingestion
7. Enable production

No core application changes are required.

---

# 13. Backup & Disaster Recovery

Snowflake features provide:

- Time Travel
- Fail-safe
- Database Cloning
- Zero-copy Cloning

Recommended strategy:

Daily

- Metadata validation

Weekly

- Clone production database

Monthly

- Disaster recovery testing

---

# 14. Operational Best Practices

Recommended practices include:

- Process incrementally
- Avoid full refreshes
- Monitor Streams
- Archive processed files
- Keep business rules metadata-driven
- Minimize warehouse size
- Enable observability
- Review reconciliation daily
- Use manual review for uncertain matches
- Maintain audit history

---

# Appendix

## Useful SQL

View Task History

```sql
SELECT *
FROM TABLE(INFORMATION_SCHEMA.TASK_HISTORY());
```

---

View Stream Status

```sql
SELECT SYSTEM$STREAM_HAS_DATA('RAW_CUSTOMER_STREAM');
```

---

Pipeline Runs

```sql
SELECT *
FROM METADATA.PIPELINE_RUN
ORDER BY START_TIME DESC;
```

---

Recent Errors

```sql
SELECT *
FROM METADATA.ERROR_LOG
ORDER BY ERROR_TIME DESC;
```

---

File Load History

```sql
SELECT *
FROM METADATA.FILE_LOAD_HISTORY
ORDER BY LOAD_TIME DESC;
```

---

# Conclusion

This runbook provides the operational procedures required to deploy, execute, monitor, troubleshoot, and maintain the Enterprise MDM Platform. Following these practices helps ensure reliable, scalable, and auditable operations while minimizing downtime and simplifying ongoing support.