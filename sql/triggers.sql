
drop trigger s_and_p_600_audit_update;
delimiter $$
CREATE DEFINER=`admin`@`localhost` TRIGGER `s_and_p_600_audit_update` AFTER UPDATE ON `s_and_p_600` FOR EACH ROW 
BEGIN
	if(old.name != new.name) THEN
    	INSERT INTO s_and_p_600_audit (old_ticker, old_name, new_ticker, new_name, action)
		values(old.ticker, old.name, new.ticker, new.name, 'UPDATED');
    end if;
END;
$$
delimiter ;

drop trigger s_and_p_600_audit_add;
CREATE TRIGGER s_and_p_600_audit_add AFTER INSERT on s_and_p_600 FOR EACH ROW
	INSERT INTO s_and_p_600_audit (old_ticker, old_name, new_ticker, new_name, action)
	VALUES (new.ticker, new.name, new.ticker, new.name, 'ADDED');

drop trigger s_and_p_600_audit_remove;
CREATE TRIGGER s_and_p_600_audit_remove AFTER DELETE on s_and_p_600 FOR EACH ROW
	INSERT INTO s_and_p_600_audit (old_ticker, old_name, new_ticker, new_name, action)
	VALUES (old.ticker, old.name, old.ticker, old.name, 'REMOVED');
