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
