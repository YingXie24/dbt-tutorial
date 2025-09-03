# Design decisions:
- Create new views in the src folder where columns are renamed to what is seen in LDM
- Recreate submission view (in which folder?) to have PARENT_RISK_ID. (Need to check with Alex as some things do not make sense)
- In DV stage:
    - LOAD_DATETIME = CURRENT_TIMESTAMP() function 
        - Every time dbtrun/dbtbuild the column gets refreshed because it is a view (Do we want to materialise it as a table?)
    - EFFECTIVE_FROM = SOURCE_EVENT_TIMESTAMP column
    -  HASHDIFF columns contain attributes as well as EFFECTIVE_FROM. No Business Key.
