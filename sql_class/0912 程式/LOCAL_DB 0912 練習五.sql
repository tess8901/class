-- DEPARTMENTS 部門

-- HR DB 資料查詢
--	查詢所有部門資訊如下：
--	1.所在地(國家、洲省、城市)
--	2.部門(部門編號、部門名稱)
--	3.部門管理者(員工編號、員工姓名、員工職稱)

-- Step1:找出「資料欄」所屬的「資料表」
-- LOCATIONS(COUNTRY_ID、STATE_PROVINCE、CITY)
-- DEPARTMENTS(DEPARTMENT_ID、DEPARTMENT_NAME)
-- EMPLOYEES(EMPLOYEE_ID、FIRST_NAME)
-- JOBS(JOB_TITLE)

-- Step2:找出「資料表」與「資料表」之間連接欄位
-- LOCATIONS(LOCATION_ID)、DEPARTMENTS(LOCATION_ID)
-- DEPARTMENTS(MANAGER_ID)、EMPLOYEES(MANAGER_ID)
-- EMPLOYEES(JOB_ID)、JOBS(JOB_ID)

-- Step3:寫SQL
-- LOCATION   所在地 L
-- DEPARTMENT 部門 D
-- EMPLOYEES  部門管理者 E
--  查詢所有部門資訊如下：
--	1.所在地(國家、洲省、城市)
--	2.部門(部門編號、部門名稱)
--	3.部門管理者(員工編號、員工姓名、員工職稱)

SELECT L.COUNTRY_ID, L.STATE_PROVINCE, L.CITY, -- 1.所在地(國家、洲省、城市)
D.DEPARTMENT_ID, D.DEPARTMENT_NAME,            -- 2.部門(部門編號、部門名稱)
E.EMPLOYEE_ID, E.FIRST_NAME,                   -- 3.部門管理者(員工編號、員工姓名)
J.JOB_TITLE -- 員工職稱
FROM DEPARTMENTS D 
INNER JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
LEFT JOIN EMPLOYEES E ON D.MANAGER_ID = E.EMPLOYEE_ID
LEFT JOIN JOBS J ON E.JOB_ID = J.JOB_ID;

