---=====================================================================================
--										DDL											 ---
---=====================================================================================
CREATE TABLE partitioned_table (
    id NUMBER,
    date DATE,
    country VARCHAR2(50),
    district VARCHAR2(50),
    city VARCHAR2(50)
)
PARTITION BY RANGE (date)
SUBPARTITION BY LIST (country, district)
(
    PARTITION p_20240630 VALUES LESS THAN (TO_DATE('20240701', 'YYYYMMDD'))
    (
        SUBPARTITION sp_porto VALUES ('PORTUGAL', 'PORTO')
    ),
    PARTITION p_others VALUES LESS THAN (MAXVALUE)
);

---=====================================================================================
--										DML											 ---
---=====================================================================================

INSERT INTO partitioned_table (id, date, country, district, city) VALUES (1, TO_DATE('20240630', 'YYYYMMDD'), 'PORTUGAL', 'PORTO', 'PORTO');
INSERT INTO partitioned_table (id, date, country, district, city) VALUES (2, TO_DATE('20240630', 'YYYYMMDD'), 'PORTUGAL', 'PORTO', 'GAIA');
INSERT INTO partitioned_table (id, date, country, district, city) VALUES (3, TO_DATE('20240630', 'YYYYMMDD'), 'PORTUGAL', 'PORTO', 'GAIA');
INSERT INTO partitioned_table (id, date, country, district, city) VALUES (4, TO_DATE('20240630', 'YYYYMMDD'), 'PORTUGAL', 'PORTO', 'POVOA');
INSERT INTO partitioned_table (id, date, country, district, city) VALUES (5, TO_DATE('20240630', 'YYYYMMDD'), 'PORTUGAL', 'PORTO', 'POVOA');
INSERT INTO partitioned_table (id, date, country, district, city) VALUES (6, TO_DATE('20240630', 'YYYYMMDD'), 'PORTUGAL', 'PORTO', 'PORTO');
INSERT INTO partitioned_table (id, date, country, district, city) VALUES (7, TO_DATE('20240630', 'YYYYMMDD'), 'PORTUGAL', 'PORTO', 'MINDELO');


---=====================================================================================
SELECT id, date, country, district, city
FROM (
    SELECT 
        id, 
        date, 
        country, 
        district, 
        city,
        ROW_NUMBER() OVER (PARTITION BY date, country, district, city ORDER BY id DESC) as rn
    FROM partitioned_table
)
WHERE rn = 1;
