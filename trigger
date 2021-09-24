--创建trigger-删除‘行’
CREATE DEFINER=`root`@`localhost` TRIGGER `payments_AFTER_DELETE` AFTER DELETE ON `payments` FOR EACH ROW 

BEGIN
	update invoices
    set payment_total=payment_total-old.amount
    and invoice_id=old.invoice_id;
END

--执行trigger
delete from payments
where client_id=5 and invoice_id=3

--创建事件
delimiter //
create event yearly_delete_state_audit_rows
on schedule
 every 1 year starts '2021-10-01' ends '2027-10-01'
 do begin
	delete from payments_audit
    where action_date< now()-interval 1 year;
end //
delimiter ;

--Json Object
update products
set properties='{ "dimensions":[1,2,3], "weight":10, "manufacturer": {"name":"Sony"}
				}'
where product_id=1;

select properties->>'$.manufacturer.name'
from products
where product_id=1;

---Update/Remove
update products
set properties=json_set(properties, '$.weight',12, '$.age', 33)
where product_id=1;

--创建数据库/表/建立主键+外键/建立外键的关系
drop table if exists order1;
drop table if exists cutomer1;
drop database if exists sql_store1;
create database sql_store1;

use sql_store1;

create table customer1 ( customer_id int primary key auto_increment,
			first_name varchar(50) not null,
                        birthdate date not null,
                        email varchar(50) unique);

create table order1 (order_id int primary key auto_increment,
					customer_id int not null,
                    status tinyint not null,
                    foreign key ft_order1_cutomer1 (customer_id)
                    references customer1 (customer_id)
                    on update cascade
                    on delete no action);
