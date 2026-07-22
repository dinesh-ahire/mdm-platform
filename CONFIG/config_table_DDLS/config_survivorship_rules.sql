CREATE TABLE CONFIG.CONFIG_SURVIVORSHIP_RULES
(
    RULE_ID                 NUMBER AUTOINCREMENT,

    ATTRIBUTE_NAME          VARCHAR,

    RULE_TYPE               VARCHAR,

    SOURCE_PRIORITY         VARCHAR,

    ACTIVE_FLAG             BOOLEAN,

    CREATED_TS              TIMESTAMP
)

COMMENT='Golden Record survivorship configuration.';