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
