COPY INTO {target_table}
FROM @{stage}
FILE_FORMAT = (FORMAT_NAME = '{file_format}')
PATTERN = '{pattern}'
ON_ERROR = 'CONTINUE';