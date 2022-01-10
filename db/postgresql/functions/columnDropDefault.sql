/*
 * Copyright (C) 2017 Adaxa Pty Ltd. All Rights Reserved. This program is free
 * software; you can redistribute it and/or modify it under the terms version 2
 * of the GNU General Public License as published by the Free Software
 * Foundation. This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 */
 
CREATE OR REPLACE FUNCTION columndropdefault(tablename name, columnname name)
  RETURNS void AS
$BODY$
DECLARE
   command text;
BEGIN
	IF tablename IS NOT NULL AND columnname IS NOT NULL THEN
		command := 'alter table ' || lower(tablename) || ' alter column ' || lower(columnname) || ' drop default ';
		RAISE notice 'executing -> %', command;
		EXECUTE command;
	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
;