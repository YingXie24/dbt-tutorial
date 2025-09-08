{{ config(materialized='incremental') }}

{%- set yaml_metadata -%}
source_model: "v_stg_submissions"
src_pk: "SUBMISSION_HK"
src_hashdiff: 
  source_column: "SUBMISSION_HASHDIFF"
  alias: "HASHDIFF"
src_payload:
  - "SEQUENCE"
  - "RISK_ID"
  - "VERSION_NUMBER"
  - "TRANSACTION_TYPE"
  - "POLICY_STATUS"
src_eff: "EFFECTIVE_FROM"
src_ldts: "LOAD_DATETIME"
src_source: "SOURCE"
{%- endset -%}



{% set metadata_dict = fromyaml(yaml_metadata) %}

{%- set source_model = metadata_dict['source_model'] -%}
{%- set src_pk = metadata_dict['src_pk'] -%}
{%- set src_hashdiff = metadata_dict['src_hashdiff'] -%}
{%- set src_payload = metadata_dict['src_payload'] -%}
{%- set src_eff = metadata_dict['src_eff'] -%}
{%- set src_ldts = metadata_dict['src_ldts'] -%}
{%- set src_source = metadata_dict['src_source'] -%}

{{ automate_dv.sat(src_pk=src_pk, src_hashdiff=src_hashdiff, src_payload=src_payload,
                   src_eff=src_eff, src_ldts=src_ldts, src_source=src_source,
                   source_model=source_model)      }}         