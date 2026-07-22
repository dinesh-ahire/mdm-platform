CREATE TABLE CONFIG.CONFIG_DQ_RULES
(
    RULE_ID                 NUMBER AUTOINCREMENT,

    RULE_NAME               VARCHAR,

    TARGET_TABLE            VARCHAR,

    TARGET_COLUMN           VARCHAR,

    RULE_TYPE               VARCHAR,

    RULE_EXPRESSION         VARCHAR,

    SEVERITY                VARCHAR,

    ERROR_MESSAGE           VARCHAR,

    EXECUTION_ORDER         NUMBER,

    ACTIVE_FLAG             BOOLEAN,

    CREATED_TS              TIMESTAMP
)

COMMENT='Configurable Data Quality validation rules.';