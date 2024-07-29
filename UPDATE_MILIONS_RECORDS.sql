DECLARE 
	CURSOR c_cursor IS
		SELECT /* FIRST_ROWS */ 
				case 
					when col1 = 1 THEN 'a'
					when col2 = 2 THEN 'b'
					when col3 = 3 THEN 'c'
					else 'xyz'
				end 	as flag
				, att1
				, att2
				, att3
				, id
		FROM dual
		WHERE att1 is NULL
		;
	
	TYPE t_type IS TABLE OF c_cursor%ROWTYPE INDEX BY BINARY_INTEGER;
	l_type 	t_type;
	
BEGIN
	OPEN c_cursor%isopen THEN
		LOOP 
			FETCH c_cursor BULK COLLECT INTO l_type limit 100000;
			EXIT WHEN l_type.COUNT = 0;
			
			FORALL r IN l_type.first .. l_type.last 
				UPDATE dual 
				SET att1 = NULL
				where 1=1
					and id = l_type(r).id
				;
			COMMIT;
		END LOOP;
	END IF;
	
	CLOSE c_cursor;
	
END;
/