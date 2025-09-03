{{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model: submission_seed
derived_columns: 
    SOURCE: "!SEND_WB_SFG"
    LOAD_DATETIME: CURRENT_TIMESTAMP()::TIMESTAMP_NTZ
    EFFECTIVE_FROM: SOURCE_EVENT_TIMESTAMP
hashed_columns:
    SUBMISSION_HK: 
        -ID
        -VERSION_NUMBER
    SUBMISSION_HASHDIFF: 
        is_hashdiff: true
        columns:
            - RISK_TYPE
            - EFFECTIVE_FROM
{%- endset -%}



{% set metadata_dict = fromyaml(yaml_metadata) %}

{% set source_model = metadata_dict['source_model'] %}
{% set derived_columns = metadata_dict['derived_columns'] %}
{% set hashed_columns = metadata_dict['hashed_columns'] %}

{{ automate_dv.stage(include_source_columns=true,
                     source_model=source_model,
                     derived_columns=derived_columns,
                     hashed_columns=hashed_columns) }}
