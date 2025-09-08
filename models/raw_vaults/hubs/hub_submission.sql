{{ config(materialized='incremental') }}

{%- set yaml_metadata -%}
source_model: 
    - v_stg_submissions
src_pk: SUBMISSION_HK
src_nk:
    - PARENT_RISK_ID
    - VERSION_NUMBER
src_ldts: LOAD_DATETIME
src_source: SOURCE
{%- endset -%}



{% set metadata_dict = fromyaml(yaml_metadata) %}

{%- set source_model = metadata_dict['source_model'] -%}
{%- set src_pk = metadata_dict['src_pk'] -%}
{%- set src_nk = metadata_dict['src_nk'] -%}
{%- set src_ldts = metadata_dict['src_ldts'] -%}
{%- set src_source = metadata_dict['src_source'] -%}

{{ automate_dv.hub( source_model=source_model,
                    src_pk=src_pk,
                    src_nk=src_nk,
                    src_ldts=src_ldts,
                    src_source=src_source) }}
