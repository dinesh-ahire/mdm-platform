CREATE TABLE CONFIG.CONFIG_MATCH_RULES
(
    RULE_ID                 NUMBER AUTOINCREMENT,

    ATTRIBUTE_NAME          VARCHAR,

    MATCH_METHOD            VARCHAR,

    WEIGHT                  NUMBER,

    THRESHOLD               NUMBER,

    BLOCKING_ATTRIBUTE      BOOLEAN,

    ACTIVE_FLAG             BOOLEAN,

    CREATED_TS              TIMESTAMP
)

COMMENT='Identity Resolution scoring configuration.';