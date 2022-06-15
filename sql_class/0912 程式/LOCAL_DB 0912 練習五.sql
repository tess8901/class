-- DEPARTMENTS ����

-- HR DB ��Ƭd��
--	�d�ߩҦ�������T�p�U�G
--	1.�Ҧb�a(��a�B�w�١B����)
--	2.����(�����s���B�����W��)
--	3.�����޲z��(���u�s���B���u�m�W�B���u¾��)

-- Step1:��X�u�����v���ݪ��u��ƪ�v
-- LOCATIONS(COUNTRY_ID�BSTATE_PROVINCE�BCITY)
-- DEPARTMENTS(DEPARTMENT_ID�BDEPARTMENT_NAME)
-- EMPLOYEES(EMPLOYEE_ID�BFIRST_NAME)
-- JOBS(JOB_TITLE)

-- Step2:��X�u��ƪ�v�P�u��ƪ�v�����s�����
-- LOCATIONS(LOCATION_ID)�BDEPARTMENTS(LOCATION_ID)
-- DEPARTMENTS(MANAGER_ID)�BEMPLOYEES(MANAGER_ID)
-- EMPLOYEES(JOB_ID)�BJOBS(JOB_ID)

-- Step3:�gSQL
-- LOCATION   �Ҧb�a L
-- DEPARTMENT ���� D
-- EMPLOYEES  �����޲z�� E
--  �d�ߩҦ�������T�p�U�G
--	1.�Ҧb�a(��a�B�w�١B����)
--	2.����(�����s���B�����W��)
--	3.�����޲z��(���u�s���B���u�m�W�B���u¾��)

SELECT L.COUNTRY_ID, L.STATE_PROVINCE, L.CITY, -- 1.�Ҧb�a(��a�B�w�١B����)
D.DEPARTMENT_ID, D.DEPARTMENT_NAME,            -- 2.����(�����s���B�����W��)
E.EMPLOYEE_ID, E.FIRST_NAME,                   -- 3.�����޲z��(���u�s���B���u�m�W)
J.JOB_TITLE -- ���u¾��
FROM DEPARTMENTS D 
INNER JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
LEFT JOIN EMPLOYEES E ON D.MANAGER_ID = E.EMPLOYEE_ID
LEFT JOIN JOBS J ON E.JOB_ID = J.JOB_ID;

