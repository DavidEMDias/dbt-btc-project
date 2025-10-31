{{config(
    materialized = 'incremental',
    incremental_strategy = 'append'
)}}


WITH flattened_outputs as (

select 
tx.hash_key,
tx.block_number,
tx.block_timestamp,
tx.is_coinbase,
f.value:address::STRING as output_address,
f.value:value::FLOAT as output_value

from {{ref("stg_btc")}} tx,

LATERAL FLATTEN(input => outputs) f -- Explode 

WHERE f.value:address is not null

{% if is_incremental() %}

and tx.BLOCK_TIMESTAMP >= (select max(tx.BLOCK_TIMESTAMP) from {{ this }} )

{% endif %}

)

select 
hash_key,
block_number,
block_timestamp,
is_coinbase,
output_address,
output_value
from flattened_outputs