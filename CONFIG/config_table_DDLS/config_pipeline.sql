CREATE TABLE CONFIG.CONFIG_PIPELINE
(
    PIPELINE_ID             NUMBER AUTOINCREMENT,

    PIPELINE_NAME           VARCHAR,

    SOURCE_CODE             VARCHAR,

    TASK_NAME               VARCHAR,

    STREAM_NAME             VARCHAR,

    WAREHOUSE_NAME          VARCHAR,

    SCHEDULE_CRON           VARCHAR,

    MAX_RETRIES             NUMBER,

    RETRY_INTERVAL_SECONDS  NUMBER,

    ENABLED                 BOOLEAN,

    CREATED_TS              TIMESTAMP,

    UPDATED_TS              TIMESTAMP
)

COMMENT='Pipeline orchestration configuration.';