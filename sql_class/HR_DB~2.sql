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

--若以日期來說，desc 是距離今天最近為優先
select * from STORE_INFORMATION
order by STORE_DATE desc;

select sum(sales), count(sales), avg(sales), max(sales), min(sales)
from STORE_INFORMATION;

select STORE_NAME, store_date, sum(sales), count(store_name), sum(sales) 
from STORE_INFORMATION
group by STORE_NAME, store_date;

-------------------------------------------------------------------------

--群組 + 合併
select store_name, sum(sales), count(STORE_NAME)
from STORE_INFORMATION
group by STORE_NAME;

--若想要看合併前是那些資料合併的結果(攤開)

select store_name, sum(sales), count(STORE_NAME),
LISTAGG(sales, ' + ') within group(order by sales desc) each_sales
from STORE_INFORMATION
group by STORE_NAME;

select store_name, sum(sales), count(STORE_NAME),
LISTAGG(sales, ' + ') within group(order by sales desc) each_sales,
LISTAGG(STORE_DATE, ' , ') within group(order by STORE_DATE desc) each_DATE
from STORE_INFORMATION
group by STORE_NAME;

--having 使用在有函數欄位(sum、count)的判斷，通常會搭配group by使用
select store_name, sum(sales)
from STORE_INFORMATION
group by STORE_NAME
having sum(sales)>3000;

--where 僅針對單一欄位的值進行判斷
select store_name, sum(sales),
LISTAGG(sales, ' + ') within group(order by sales desc) each_sales
from STORE_INFORMATION
where SALES>1000
group by STORE_NAME;

--欄位別名，""可以省略不寫，但是還是建議要寫
--如果中間有個空白，一定要寫 ""
select store_name, sum(sales) "sum sales",
count(store_name),
LISTAGG(sales,'/') within group (order by sales asc) as "營業額清單"
from STORE_INFORMATION
group by STORE_NAME;

--表格別名，盡量命名的有意義
--跟java 的物件很像
select store.STORE_NAME, store.STORE_DATE
from STORE_INFORMATION store;

--建議不要這樣去寫
select STORE_INFORMATION.STORE_NAME, STORE_INFORMATION.STORE_DATE
from STORE_INFORMATION;


SELECT s.store_name,
  SUM(s.sales) "SUM_SALES",
  COUNT(s.store_name) "COUNT_NAME",
  AVG(s.sales) "AVG_SALES"
FROM STORE_INFORMATION s
GROUP BY store_name
HAVING AVG(SALES)    >1000 --=不可以使用別名，因為having較為嚴謹
AND COUNT(STORE_NAME)>1
ORDER BY AVG(sales) DESC;  --允許使用別名代替


--join的用法
select s.STORE_NAME, s.STORE_ID, s.FK_GEOGRAPHY_ID, g.REGION_NAME 
from STORE_INFORMATION s, GEOGRAPHY g
where s.FK_GEOGRAPHY_ID = g.GEOGRAPHY_ID;

--inner join 會過濾掉其他的
select s.STORE_ID, s.STORE_NAME, s.FK_GEOGRAPHY_ID, g.REGION_NAME 
from STORE_INFORMATION s inner join GEOGRAPHY g
on s.FK_GEOGRAPHY_ID = g.GEOGRAPHY_ID;

--left join 以"左邊"的為主，左邊的表格全部都會顯示出來
select s.STORE_ID, s.STORE_NAME, s.FK_GEOGRAPHY_ID, g.REGION_NAME 
from STORE_INFORMATION s left join GEOGRAPHY g
on s.FK_GEOGRAPHY_ID = g.GEOGRAPHY_ID;

------------------------------------------------------------------
--right join 以"右邊"的為主，右邊的表格全部都會顯示出來
select s.STORE_ID, s.STORE_NAME, s.FK_GEOGRAPHY_ID, g.REGION_NAME 
from STORE_INFORMATION s right join GEOGRAPHY g
on s.FK_GEOGRAPHY_ID = g.GEOGRAPHY_ID;

select s.STORE_ID, s.STORE_NAME, s.FK_GEOGRAPHY_ID, g.REGION_NAME 
from GEOGRAPHY g left join STORE_INFORMATION s
on  g.GEOGRAPHY_ID = s.FK_GEOGRAPHY_ID;
-----------------------------------------------------
--full join 左右邊的表格皆會全部列出來
select s.STORE_ID, s.STORE_NAME, s.FK_GEOGRAPHY_ID, g.GEOGRAPHY_ID, g.REGION_NAME 
from STORE_INFORMATION s full join GEOGRAPHY g
on s.FK_GEOGRAPHY_ID = g.GEOGRAPHY_ID;

----------------------------------------------------------------------
--oracle 專用，(+)表示哪一邊缺資料，缺的資料會以null表示，只能使用在一邊上面
select s.STORE_NAME, s.STORE_ID, s.FK_GEOGRAPHY_ID, g.REGION_NAME 
from STORE_INFORMATION s, GEOGRAPHY g
where s.FK_GEOGRAPHY_ID =g.GEOGRAPHY_ID(+);

select s.STORE_ID, s.STORE_NAME, s.FK_GEOGRAPHY_ID, g.REGION_NAME 
from STORE_INFORMATION s left join GEOGRAPHY g
on s.FK_GEOGRAPHY_ID = g.GEOGRAPHY_ID;
-----------------------------------------------------------------
--練習題(三)-1
--NVL (欄位,值) 如果欄位為NULL，那就回傳"值"
select g.REGION_NAME, NVL(sum(s.SALES),0) "SUM_SALES" 
from GEOGRAPHY g left join STORE_INFORMATION s
on g.GEOGRAPHY_ID = s.FK_GEOGRAPHY_ID
group by g.REGION_NAME
order by SUM_SALES DESC;

--練習題(三)-2
--DISTINCT 不行放前面，會有重複計算的問題
select DISTINCT g.REGION_NAME, count(s.STORE_NAME) "STORE_COUNT" 
from GEOGRAPHY g left join STORE_INFORMATION s
on g.GEOGRAPHY_ID = s.FK_GEOGRAPHY_ID
group by g.REGION_NAME
order by STORE_COUNT desc;

--DISTINCT 需要放在count的裡面，去掉store_name裡面的重複
select g.REGION_NAME, count(DISTINCT s.STORE_NAME) "STORE_COUNT" 
from GEOGRAPHY g left join STORE_INFORMATION s
on g.GEOGRAPHY_ID = s.FK_GEOGRAPHY_ID
group by g.REGION_NAME
order by STORE_COUNT desc;