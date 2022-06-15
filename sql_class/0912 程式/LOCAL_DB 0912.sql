-- STORE_ID => 商店編號
-- STORE_NAME => 商店名稱
-- SALES => 營業額
-- STORE_DATE => 開始營業日
-- FK_GEOGRAPHY_ID => 地區編號

--------------------------------------------------------------------------------
-- 選擇STORE_NAME , SALES 總和 ， 計算 STORE_NAME 有幾個
SELECT STORE_NAME, SUM(SALES),COUNT(STORE_NAME),
-- LISTAGG(查看想解除合併的值，分隔符號) => 可以知道 SALES 裡有哪些值加起來
-- WITHIN GROUP (ORDER_BY_CLAUSE) => 前面是語法 (解除合併的排序) ASC => 小到大
LISTAGG(SALES, ' + ') WITHIN GROUP (ORDER BY SALES ASC),
-- 查看 STORE_DATE 開始營業日 ， 用 逗點 區隔 ， 小到大 排序
LISTAGG(STORE_DATE, ' , ') WITHIN GROUP (ORDER BY SALES ASC)
FROM STORE_INFORMATION -- 在 STORE_INFORMATION 表格裡
GROUP BY STORE_NAME; 

--------------------------------------------------------------------------------

-- 選擇STORE_NAME 和 STORE_DATE , 計算 STORE_NAME 有幾個 , 加總(SALES)的全部 => (營業額 總額)
SELECT STORE_NAME, STORE_DATE, COUNT(STORE_NAME) , SUM(SALES)
FROM STORE_INFORMATION
-- GROUP BY 選取不只一個的欄位 ，且其中一個欄位有包含函數的運用時，就必須用 GROUP BY
GROUP BY STORE_NAME, STORE_DATE 
ORDER BY STORE_NAME, STORE_DATE; -- 按照結果 小到大(預設) 排序

--------------------------------------------------------------------------------

-- 選擇STORE_NAME，加總(SALES)
SELECT STORE_NAME, SUM(SALES)
FROM STORE_INFORMATION
-- HAVING => 有函數值的欄位查詢 (直接使用 欄位 )
-- SELECT "欄位1" , SUM("欄位2") FROM "表格名" GROUP BY "欄位1" HAVING(函數條件) 
-- 如果被 SELECT 的是 函數欄 ， 那就不用 GROUP BY
GROUP BY STORE_NAME  -- 沒有這行 就無法計算多個函數
HAVING SUM(SALES) >= 3000; -- 營業額 >= 3000

--------------------------------------------------------------------------------

-- ALIAS 別名(雙引號 "") ， ALIAS 可省略不寫(空格隔開)
-- 欄位 別名 總額 改名 改成 SUM SALES  盡量加"" 比較好(閱讀性較高)
SELECT STORE_NAME, SUM(SALES) "SUM SALES", 
COUNT(STORE_NAME) COUNT_NAME, -- 可直接底線 就可以不用字串 (不建議)
-- 也可把名字改成中文 如下
LISTAGG(SALES, '/') WITHIN GROUP (ORDER BY SALES ASC) 營業額清單 
FROM STORE_INFORMATION
GROUP BY STORE_NAME;

--------------------------------------------------------------------------------

-- SELECT "表格別名" . "欄位1" "欄位別名" FROM "表格名" "表格別名"
-- 表格 別名 可以把表格改名  STORE_INFORMATION 就變成 S
SELECT S.STORE_NAME, S.STORE_DATE 
FROM STORE_INFORMATION S;

--------------------------------------------------------------------------------

-- SUM(SALES) SUM_SALES 空格 後 是 重新命名 欄位
-- 選擇 個別商店 「總合營業額」、「商店資料個數」、「平均營業額」
SELECT S.STORE_NAME, SUM(S.SALES) "SUM_SALES" , COUNT(S.STORE_NAME) "COUNT_STORE" , AVG(S.SALES) "AVG_SALES"
FROM STORE_INFORMATION S
GROUP BY S.STORE_NAME  -- 
HAVING AVG(S.SALES) > 1000 -- 排除「平均營業額」1000(含)以下的商店資料
AND COUNT(S.STORE_NAME) > 1 -- 排除「商店資料個數」1(含)個以下的商店資料
ORDER BY AVG(S.SALES) DESC; -- 依照「平均營業額」由 大至小(DESC) 排序

--------------------------------------------------------------------------------

-- 表格 連接(JOIN) 利用 WHERE 的概念 做連接
-- 其實也是等值連接
-- 選擇 STORE_INFORMATION 的 STORE_ID 及 STORE_NAME 及 FK_GEOGRAPHY_ID
-- 選擇 GEOGRAPHY 的 REGION_NAME
SELECT  S.STORE_ID, S.STORE_NAME, S.FK_GEOGRAPHY_ID, G.REGION_NAME 
-- STORE_INFORMATION 命名為 S ， GEOGRAPHY 命名為 G
FROM STORE_INFORMATION S, GEOGRAPHY G
-- STORE_INFORMATION 的 FK_GEOGRAPHY_ID = GEOGRAPHY 的 GEOGRAPHY_ID
-- 如果 FK_GEOGRAPHY_ID 為1 那就等於 GEOGRAPHY_ID 代表1的值 為 EAST ， 2 就代表 WEST ， 3 就代表 NORTH (不懂可以叫出表格來查看)
WHERE S.FK_GEOGRAPHY_ID = G.GEOGRAPHY_ID;

--------------------------------------------------------------------------------

-- (內部)等值連接 (跟上面是一樣的意思)
SELECT  S.STORE_ID, S.STORE_NAME, S.FK_GEOGRAPHY_ID, G.REGION_NAME 
FROM STORE_INFORMATION S INNER JOIN GEOGRAPHY G
ON S.FK_GEOGRAPHY_ID = G.GEOGRAPHY_ID;

--------------------------------------------------------------------------------

-- 左側連接
-- 選擇 STORE_INFORMATION 的 STORE_ID 及 STORE_NAME 及 FK_GEOGRAPHY_ID
-- 選擇 GEOGRAPHY 的 REGION_NAME
-- STORE_INFORMATION S 跟 GEOGRAPHY G 做 左側(LEFT JOIN) 連接
-- 列出全部的商店，不論商店是否有區域(空值)，也不管右側有沒有值
-- 因為 Buffalo, Walden Galleria 是空值 所以 FK_GEOGRAPHY_ID 和 REGION_NAME 顯示空值
SELECT  S.STORE_ID, S.STORE_NAME, S.FK_GEOGRAPHY_ID, G.REGION_NAME 
FROM STORE_INFORMATION S LEFT JOIN GEOGRAPHY G
ON S.FK_GEOGRAPHY_ID = G.GEOGRAPHY_ID;

--------------------------------------------------------------------------------

-- 右側連接
-- 列出全部 地區名稱(區域) ，不論區域是否有從屬商店(空值)，也不管左側有沒有值
-- 因為 Buffalo, Walden Galleria 是空值 所以 FK_GEOGRAPHY_ID 和 REGION_NAME 顯示空值
-- 而因為 REGION_NAME 的 North 是 3 ， 但因為 FK_GEOGRAPHY_ID 裡沒有 3 的值，所以左側都是空值
SELECT  S.STORE_ID, S.STORE_NAME, S.FK_GEOGRAPHY_ID, G.GEOGRAPHY_ID , G.REGION_NAME 
FROM STORE_INFORMATION S RIGHT JOIN GEOGRAPHY G
ON S.FK_GEOGRAPHY_ID = G.GEOGRAPHY_ID;

--------------------------------------------------------------------------------

-- (+)哪邊缺資料就補哪邊:Oracle適用
-- STORE_INFORMATION 的 FK_GEOGRAPHY_ID 補值
SELECT  S.STORE_ID, S.STORE_NAME, S.FK_GEOGRAPHY_ID, G.REGION_NAME 
FROM STORE_INFORMATION S , GEOGRAPHY G
WHERE S.FK_GEOGRAPHY_ID = G.GEOGRAPHY_ID(+); 

--------------------------------------------------------------------------------

-- (+)哪邊缺資料就補哪邊:Oracle適用
-- GEOGRAPHY 的 GEOGRAPHY_ID 補值
SELECT  S.STORE_ID, S.STORE_NAME, S.FK_GEOGRAPHY_ID, G.REGION_NAME 
FROM STORE_INFORMATION S , GEOGRAPHY G
WHERE S.FK_GEOGRAPHY_ID(+) = G.GEOGRAPHY_ID; 

--------------------------------------------------------------------------------

-- FULL JOIN => 左側 連接 + 右測 連接 (把兩側的結果都顯示)
SELECT  S.STORE_ID, S.STORE_NAME, S.FK_GEOGRAPHY_ID, G.REGION_NAME 
FROM STORE_INFORMATION S FULL JOIN GEOGRAPHY G
ON S.FK_GEOGRAPHY_ID = G.GEOGRAPHY_ID;

--------------------------------------------------------------------------------

--查詢各區域的營業額總計 (所以不管有沒有值都要顯示，以 GEOGRAPHY 為主 所以使用 LEFT JOIN )
-- --NVL (欄位,值) 如果欄位為NULL，那就回傳(0)"值"
SELECT G.REGION_NAME ,NVL(SUM(S.SALES),0) "SUM_SALES" 
--(不論該區域底下是否有所屬商店)
FROM GEOGRAPHY G  LEFT JOIN STORE_INFORMATION S
-- 如果 GEOGRAPHY 的 GEOGRAPHY_ID = STORE_INFORMATION 的 FK_GEOGRAPHY_ID 就做 相加
ON G.GEOGRAPHY_ID  = S.FK_GEOGRAPHY_ID  
GROUP BY G.REGION_NAME
--資料結果依營業額總計由大到小排序
ORDER BY SUM_SALES DESC;

--------------------------------------------------------------------------------

--查詢各區域的商店個數
--(依據商店名稱,不包含重覆的商店)
--(不論該區域底下是否有所屬商店)
SELECT G.REGION_NAME ,COUNT(DISTINCT S.STORE_NAME) "COUNT_STORE"
FROM GEOGRAPHY G  LEFT JOIN STORE_INFORMATION S
ON G.GEOGRAPHY_ID  = S.FK_GEOGRAPHY_ID  
GROUP BY G.REGION_NAME
--資料結果依區域的商店個數由大至小排序
ORDER BY AVG(S.SALES) ASC;

-- 外查詢
SELECT SUM(S.SALES) 
FROM STORE_INFORMATION S WHERE S.STORE_NAME IN (
  -- 內查詢
  SELECT S.STORE_NAME FROM STORE_INFORMATION S WHERE S.FK_GEOGRAPHY_ID = 2
);

-- 相關子查詢
-- 外查詢
SELECT SUM(S.SALES) FROM STORE_INFORMATION S WHERE S.FK_GEOGRAPHY_ID IN (
    -- 內查詢
    SELECT G.GEOGRAPHY_ID FROM GEOGRAPHY G WHERE G.GEOGRAPHY_ID  = S.FK_GEOGRAPHY_ID
);


SELECT  *  FROM 
(
   SELECT GEOGRAPHY_ID, REGION_NAME FROM GEOGRAPHY
) G
, 
(
   SELECT FK_GEOGRAPHY_ID, STORE_NAME 
   FROM STORE_INFORMATION
) S
WHERE G.GEOGRAPHY_ID = S.FK_GEOGRAPHY_ID;


SELECT  *  FROM (
   SELECT GEOGRAPHY_ID, REGION_NAME FROM GEOGRAPHY
) G , STORE_INFORMATION S
WHERE G.GEOGRAPHY_ID = S.FK_GEOGRAPHY_ID;






