select distinct store_name
from STORE_INFORMATION;

select * from STORE_INFORMATION
where STORE_ID = 2;

select *from STORE_INFORMATION
where STORE_ID in (2,3,5);

select * from STORE_INFORMATION
where store_name in ('Los Angeles', 'San Diego');

select * from STORE_INFORMATION
where STORE_NAME like '%a%';

select * from STORE_INFORMATION
where store_name like 'L%s';

--�Y�H����ӻ��Adesc �O�Z�����ѳ̪��u��
select * from STORE_INFORMATION
order by STORE_DATE desc;

select sum(sales), count(sales), avg(sales), max(sales), min(sales)
from STORE_INFORMATION;

select STORE_NAME, store_date, sum(sales), count(store_name), sum(sales) 
from STORE_INFORMATION
group by STORE_NAME, store_date;

-------------------------------------------------------------------------

--�s�� + �X��
select store_name, sum(sales), count(STORE_NAME)
from STORE_INFORMATION
group by STORE_NAME;

--�Y�Q�n�ݦX�֫e�O���Ǹ�ƦX�֪����G(�u�})

select store_name, sum(sales), count(STORE_NAME),
LISTAGG(sales, ' + ') within group(order by sales desc) each_sales
from STORE_INFORMATION
group by STORE_NAME;

select store_name, sum(sales), count(STORE_NAME),
LISTAGG(sales, ' + ') within group(order by sales desc) each_sales,
LISTAGG(STORE_DATE, ' , ') within group(order by STORE_DATE desc) each_DATE
from STORE_INFORMATION
group by STORE_NAME;

--having �ϥΦb��������(sum�Bcount)���P�_�A�q�`�|�f�tgroup by�ϥ�
select store_name, sum(sales)
from STORE_INFORMATION
group by STORE_NAME
having sum(sales)>3000;

--where �Ȱw���@��쪺�ȶi��P�_
select store_name, sum(sales),
LISTAGG(sales, ' + ') within group(order by sales desc) each_sales
from STORE_INFORMATION
where SALES>1000
group by STORE_NAME;

--���O�W�A""�i�H�ٲ����g�A���O�٬O��ĳ�n�g
--�p�G�������ӪťաA�@�w�n�g ""
select store_name, sum(sales) "sum sales",
count(store_name),
LISTAGG(sales,'/') within group (order by sales asc) as "��~�B�M��"
from STORE_INFORMATION
group by STORE_NAME;

--���O�W�A�ɶq�R�W�����N�q
--��java ������ܹ�
select store.STORE_NAME, store.STORE_DATE
from STORE_INFORMATION store;

--��ĳ���n�o�˥h�g
select STORE_INFORMATION.STORE_NAME, STORE_INFORMATION.STORE_DATE
from STORE_INFORMATION;


SELECT s.store_name,
  SUM(s.sales) "SUM_SALES",
  COUNT(s.store_name) "COUNT_NAME",
  AVG(s.sales) "AVG_SALES"
FROM STORE_INFORMATION s
GROUP BY store_name
HAVING AVG(SALES)    >1000 --=���i�H�ϥΧO�W�A�]��having�����Y��
AND COUNT(STORE_NAME)>1
ORDER BY AVG(sales) DESC;  --���\�ϥΧO�W�N��


--join���Ϊk
select s.STORE_NAME, s.STORE_ID, s.FK_GEOGRAPHY_ID, g.REGION_NAME 
from STORE_INFORMATION s, GEOGRAPHY g
where s.FK_GEOGRAPHY_ID = g.GEOGRAPHY_ID;

--inner join �|�L�o����L��
select s.STORE_ID, s.STORE_NAME, s.FK_GEOGRAPHY_ID, g.REGION_NAME 
from STORE_INFORMATION s inner join GEOGRAPHY g
on s.FK_GEOGRAPHY_ID = g.GEOGRAPHY_ID;

--left join �H"����"�����D�A���䪺���������|��ܥX��
select s.STORE_ID, s.STORE_NAME, s.FK_GEOGRAPHY_ID, g.REGION_NAME 
from STORE_INFORMATION s left join GEOGRAPHY g
on s.FK_GEOGRAPHY_ID = g.GEOGRAPHY_ID;

------------------------------------------------------------------
--right join �H"�k��"�����D�A�k�䪺���������|��ܥX��
select s.STORE_ID, s.STORE_NAME, s.FK_GEOGRAPHY_ID, g.REGION_NAME 
from STORE_INFORMATION s right join GEOGRAPHY g
on s.FK_GEOGRAPHY_ID = g.GEOGRAPHY_ID;

select s.STORE_ID, s.STORE_NAME, s.FK_GEOGRAPHY_ID, g.REGION_NAME 
from GEOGRAPHY g left join STORE_INFORMATION s
on  g.GEOGRAPHY_ID = s.FK_GEOGRAPHY_ID;
-----------------------------------------------------
--full join ���k�䪺���ҷ|�����C�X��
select s.STORE_ID, s.STORE_NAME, s.FK_GEOGRAPHY_ID, g.GEOGRAPHY_ID, g.REGION_NAME 
from STORE_INFORMATION s full join GEOGRAPHY g
on s.FK_GEOGRAPHY_ID = g.GEOGRAPHY_ID;

----------------------------------------------------------------------
--oracle �M�ΡA(+)��ܭ��@��ʸ�ơA�ʪ���Ʒ|�Hnull��ܡA�u��ϥΦb�@��W��
select s.STORE_NAME, s.STORE_ID, s.FK_GEOGRAPHY_ID, g.REGION_NAME 
from STORE_INFORMATION s, GEOGRAPHY g
where s.FK_GEOGRAPHY_ID =g.GEOGRAPHY_ID(+);

select s.STORE_ID, s.STORE_NAME, s.FK_GEOGRAPHY_ID, g.REGION_NAME 
from STORE_INFORMATION s left join GEOGRAPHY g
on s.FK_GEOGRAPHY_ID = g.GEOGRAPHY_ID;
-----------------------------------------------------------------
--�m���D(�T)-1
--NVL (���,��) �p�G��쬰NULL�A���N�^��"��"
select g.REGION_NAME, NVL(sum(s.SALES),0) "SUM_SALES" 
from GEOGRAPHY g left join STORE_INFORMATION s
on g.GEOGRAPHY_ID = s.FK_GEOGRAPHY_ID
group by g.REGION_NAME
order by SUM_SALES DESC;

--�m���D(�T)-2
--DISTINCT �����e���A�|�����ƭp�⪺���D
select DISTINCT g.REGION_NAME, count(s.STORE_NAME) "STORE_COUNT" 
from GEOGRAPHY g left join STORE_INFORMATION s
on g.GEOGRAPHY_ID = s.FK_GEOGRAPHY_ID
group by g.REGION_NAME
order by STORE_COUNT desc;

--DISTINCT �ݭn��bcount���̭��A�h��store_name�̭�������
select g.REGION_NAME, count(DISTINCT s.STORE_NAME) "STORE_COUNT" 
from GEOGRAPHY g left join STORE_INFORMATION s
on g.GEOGRAPHY_ID = s.FK_GEOGRAPHY_ID
group by g.REGION_NAME
order by STORE_COUNT desc;