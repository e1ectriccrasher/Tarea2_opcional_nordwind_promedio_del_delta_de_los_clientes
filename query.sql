-- este es el query utilizado

with t as (	
	select c.customer_id, od.order_id , od.unit_price 
	, lag(od.unit_price, 1) over (partition by c.customer_id order by od.order_id)
	, od.unit_price - lag(od.unit_price, 1) over (partition by c.customer_id order by od.order_id) as diferencia
	from order_details od 
	join orders o on od.order_id = o.order_id 
	join customers c on o.customer_id  = c.customer_id
	)
select t.customer_id, avg(t.diferencia) as "diferencias de deltas"
from t
group by t.customer_id
order by avg(t.diferencia ) desc
 
