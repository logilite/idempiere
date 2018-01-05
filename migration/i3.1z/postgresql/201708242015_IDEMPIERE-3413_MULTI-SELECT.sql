-- IDEMPIERE-3413
-- Aug 24, 2017 8:15:00 PM IST
ALTER TABLE t_alter_column ADD COLUMN usingclause character varying(200)
;

DROP RULE alter_column_rule ON t_alter_column
;

DROP FUNCTION altercolumn(name, name, name, character varying, character varying)
;

CREATE OR REPLACE FUNCTION altercolumn(tablename name, columnname name, datatype name, nullclause character varying, defaultclause character varying, usingclause character varying)
  RETURNS void AS
$$
declare
   command text;
   viewtext text[];
   viewname name[];
   dropviews name[];
   i int;
   j int;
   v record;
   sqltype       text;
   sqltype_short text;
   typename name;
begin
   if datatype is not null then
	select pg_type.typname, format_type(pg_type.oid, pg_attribute.atttypmod)
            into typename, sqltype
            from pg_class, pg_attribute, pg_type
            where relname = lower(tablename)
                and relkind = 'r'
                and pg_class.oid = pg_attribute.attrelid
                and attname = lower(columnname)
                and atttypid = pg_type.oid;
        sqltype_short := sqltype;
        if typename = 'numeric' then
	   sqltype_short := replace(sqltype, ',0', '');
        elsif strpos(sqltype,'character varying') = 1 then
	   sqltype_short := replace(sqltype, 'character varying', 'varchar');
        elsif sqltype = 'timestamp without time zone' then
           sqltype_short := 'timestamp';
        end if;
        if lower(datatype) <> sqltype and lower(datatype) <> sqltype_short then
		i := 0;
		for v in
	        with recursive depv(relname, viewoid, depth) as (
		    select distinct a.relname, a.oid, 1
		        from pg_class a, pg_depend b, pg_depend c, pg_class d, pg_attribute e
		        where a.oid = b.refobjid
			    and b.objid = c.objid
			    and b.refobjid <> c.refobjid
			    and b.deptype = 'n'
			    and c.refobjid = d.oid
			    and d.relname = lower(tablename)
			    and d.relkind = 'r'
			    and d.oid = e.attrelid
			    and e.attname = lower(columnname)
			    and c.refobjsubid = e.attnum
			    and a.relkind = 'v'
	          union all
		    select distinct dependee.relname, dependee.oid, depv.depth+1
		        from pg_depend 
			    join pg_rewrite on pg_depend.objid = pg_rewrite.oid 
			    join pg_class as dependee on pg_rewrite.ev_class = dependee.oid 
			    join pg_class as dependent on pg_depend.refobjid = dependent.oid 
			    join pg_attribute ON pg_depend.refobjid = pg_attribute.attrelid and pg_depend.refobjsubid = pg_attribute.attnum and pg_attribute.attnum > 0
			    join depv on dependent.relname = depv.relname
	        )
	        select relname, viewoid, max(depth) from depv group by relname, viewoid order by 3 desc
		loop
		    i := i + 1;
		    viewtext[i] := pg_get_viewdef(v.viewoid);
		    viewname[i] := v.relname;
		end loop;
		if i > 0 then
		   begin
		     for j in 1 .. i loop
		        command := 'drop view ' || viewname[j];
			raise notice 'executing -> %', command;
		        execute command;
		        dropviews[j] := viewname[j];
		     end loop;
                     exception
                        when others then
                          i := array_upper(dropviews, 1);
                          if i > 0 then
                             for j in reverse i .. 1 loop
                                command := 'create or replace view ' || dropviews[j] || ' as ' || viewtext[j];
			        raise notice 'executing -> %', 'create view ' || dropviews[j];
		                execute command;
                             end loop;
                          end if;
                          raise exception 'Failed to recreate dependent view. SQLERRM=%', SQLERRM;
                   end;
		end if;
		command := 'alter table ' || lower(tablename) || ' alter column ' || lower(columnname) || ' type ' || lower(datatype);
		if usingclause is not null then
		   command := command || ' ' || usingclause;
		end if;
		raise notice 'executing -> %', command;
		execute command;
                i := array_upper(dropviews, 1);
		if i > 0 then
		   for j in reverse i .. 1 loop
		     command := 'create or replace view ' || dropviews[j] || ' as ' || viewtext[j];
		     raise notice 'executing -> %', 'create view ' || dropviews[j];
		     execute command;
		   end loop;
		end if;
        end if;
   end if;
   
   if defaultclause is not null then
       if lower(defaultclause) = 'null' then
          command := 'alter table ' || lower(tablename) || ' alter column ' || lower(columnname) || ' drop default ';
       else
          if defaultclause  ~ '.*[(].*[)].*' or lower(defaultclause) = 'current_timestamp' then
          	command := 'alter table ' || lower(tablename) || ' alter column ' || lower(columnname) || ' set default ' || defaultclause;
          else
	  	  	command := 'alter table ' || lower(tablename) || ' alter column ' || lower(columnname) || ' set default ''' || defaultclause || '''';
	  	  end if;
       end if;
       raise notice 'executing -> %', command;
       execute command;
   end if;
   
   if nullclause is not null then
      if lower(nullclause) = 'not null' then
          command := 'alter table ' || lower(tablename) || ' alter column ' || lower(columnname) || ' set not null';
          raise notice 'executing -> %', command;
          execute command;
      elsif lower(nullclause) = 'null' then
          command := 'alter table ' || lower(tablename) || ' alter column ' || lower(columnname) || ' drop not null';
          raise notice 'executing -> %', command;
          execute command;
      end if;
   end if;
end;
$$ language plpgsql VOLATILE
;

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

CREATE OR REPLACE RULE alter_column_rule AS
    ON INSERT TO t_alter_column DO INSTEAD  SELECT altercolumn(new.tablename, new.columnname, new.datatype, new.nullclause, new.defaultclause, new.usingclause) AS altercolumn
;

SELECT register_migration_script('201708242015_IDEMPIERE-3413_MULTI-SELECT.sql') FROM dual
;
