--Задание 1
CREATE TABLE DEPARTMENT (
  Id NUMDER PRIMARY KEY,
  NAME  VARCHAR2(100)
);

INSERT INTO DEPARTMENT VALUES (1, 'Department 1');
INSERT INTO DEPARTMENT VALUES (2, 'Department 2');
INSERT INTO DEPARTMENT VALUES (3, 'Department 3');
INSERT INTO DEPARTMENT VALUES (4, 'Department 4');

CREATE TABLE EMPLOYEE (
  Id NUMDER PRIMARY KEY,
  DEPARTMENT_Id NUMBER,
  CHIEF_ID NUMBER,
  NAME  VARCHAR2(100),
  SALARY NUMBER,
  CONSTRAINT CHIEF_ID 
    FOREIGN KEY (CHIEF_ID) REFERENCES DEPARTMENT (Id),
 FOREIGN KEY (DEPARTMENT_Id) REFERENCES DEPARTMENT (Id)
);
INSERT INTO EMPLOYEE VALUES (1, 1, 1, 'Владимир', 2111);
INSERT INTO EMPLOYEE VALUES (2, 1, 1, 'Алексей', 2110);
INSERT INTO EMPLOYEE VALUES (3, 1, 1, 'Иля', 1023);
INSERT INTO EMPLOYEE VALUES (4, 1, 2, 'Рамзан', 15);
INSERT INTO EMPLOYEE VALUES (5, 2, 2, 'Виктор', 1200);
INSERT INTO EMPLOYEE VALUES (6, 2, 1, 'Андрей', 2112);
INSERT INTO EMPLOYEE VALUES (7, 2, 6, 'Эвелина', 110);
INSERT INTO EMPLOYEE VALUES (8, 2, 6, 'Лариса', 115);
INSERT INTO EMPLOYEE VALUES (9, 3, 6, 'Раиса', 115);
INSERT INTO EMPLOYEE VALUES (10, 3, 1, 'Денис', 115);

--Сотрудника с максимальной заработной платой.
SELECT NAME
FROM EMPLOYEE
WHERE (NAME, SALARY) 
IN 
 (SELECT NAME, MAX(SALARY) FROM EMPLOYEE);
 
--Вывести одно число: максимальную длину цепочки руководителей по таблице сотрудников (вычислить глубину дерева).
WITH RECURSIVE cte AS (
  SELECT Id, CHIEF_ID, 1 AS depth
  FROM EMPLOYEE
  WHERE CHIEF_ID = Id
  UNION ALL
  SELECT e.Id, e.CHIEF_ID, cte.depth + 1
  FROM EMPLOYEE e
  JOIN cte ON e.CHIEF_ID = cte.Id
  WHERE NOT e.Id = cte.CHIEF_ID
)
SELECT MAX(depth) AS max_depth FROM cte;

--Отдел, с максимальной суммарной зарплатой сотрудников. 

WITH dep_salary AS
	(SELECT DEPARTMENT_Id, sum(SALARY) AS SALARY
    FROM EMPLOYEE 
	GROUP BY DEPARTMENT_Id)
SELECT DEPARTMENT_Id
FROM dep_salary
WHERE dep_salary.salary = (SELECT max(salary) FROM dep_salary);

--Сотрудника, чье имя начинается на «Р» и заканчивается на «н».
SELECT NAME
FROM EMPLOYEE
WHERE NAME LIKE 'Р%н';

