
explain analyse
select *
from
	sales.order_items
where order_item_id < 100

explain analyse
select *
from
	sales.order_items
where prod_id < 100

CREATE INDEX idx_prod_id
ON sales.order_items(prod_id);


Non Clustered INDEX

Cust_id

Table(heap)
    tid(pointer)    =>  cust_id

order in which table is storing the value   =>  primary


clustered       =>  PK
non Clustered   =>  