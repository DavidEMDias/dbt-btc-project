--whale "big fish" doing massive transactions

select 
output_address,
sum(output_value) as total_sent -- total_sent to address,
count(*) as tx_count --how many transactions

from {{ref("stg_btc_transactions")}}

where output_value > 10 -- 10 btc

group by output_address
order by total_sent desc