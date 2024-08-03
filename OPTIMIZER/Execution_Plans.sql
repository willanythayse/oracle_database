--=================================================
---  			EXECUTION PLANS					---
--=================================================
select * from v$SQL_PLAN;


--=================================================
---  			REAL-TIME MONITORING			---
--=================================================
select * from v$ACTIVE_SESSION_HISTORY;
select * from v$SESSION;
select * from v$SESSION_LOGOPS;
select * from v$SQL;
select * from v$SQL_PLAN;


--=================================================
---  					HINTS					---
--=================================================
SELECT /*+ INDEX (employess emp_department_ix) */
	employess_id
	, departament_id
FROM employess
WHERE departament_id < 50
;