CREATE TABLE CONFIG.CONFIG_DATA_CONTRACTS
(
    CONTRACT_ID                 NUMBER AUTOINCREMENT,

    SOURCE_CODE                 VARCHAR,

    SCHEMA_VERSION              VARCHAR,

    EXPECTED_COLUMNS            ARRAY,

    MANDATORY_COLUMNS           ARRAY,

    PRIMARY_KEY                 VARCHAR,

    DELIVERY_SLA                VARCHAR,

    EXPECTED_FILE_PATTERN       VARCHAR,

    DATA_OWNER                  VARCHAR,

    ACTIVE_FLAG                 BOOLEAN,

    CREATED_TS                  TIMESTAMP
)

COMMENT='Source data contracts.';