-- STORE_ID => �ө��s��
-- STORE_NAME => �ө��W��
-- SALES => ��~�B
-- STORE_DATE => �}�l��~��
-- FK_GEOGRAPHY_ID => �a�Ͻs��

--------------------------------------------------------------------------------
-- ���STORE_NAME , SALES �`�M �A �p�� STORE_NAME ���X��
SELECT STORE_NAME, SUM(SALES),COUNT(STORE_NAME),
-- LISTAGG(�d�ݷQ�Ѱ��X�֪��ȡA���j�Ÿ�) => �i�H���D SALES �̦����ǭȥ[�_��
-- WITHIN GROUP (ORDER_BY_CLAUSE) => �e���O�y�k (�Ѱ��X�֪��Ƨ�) ASC => �p��j
LISTAGG(SALES, ' + ') WITHIN GROUP (ORDER BY SALES ASC),
-- �d�� STORE_DATE �}�l��~�� �A �� �r�I �Ϲj �A �p��j �Ƨ�
LISTAGG(STORE_DATE, ' , ') WITHIN GROUP (ORDER BY SALES ASC)
FROM STORE_INFORMATION -- �b STORE_INFORMATION ����
GROUP BY STORE_NAME; 

--------------------------------------------------------------------------------

-- ���STORE_NAME �M STORE_DATE , �p�� STORE_NAME ���X�� , �[�`(SALES)������ => (��~�B �`�B)
SELECT STORE_NAME, STORE_DATE, COUNT(STORE_NAME) , SUM(SALES)
FROM STORE_INFORMATION
-- GROUP BY ������u�@�Ӫ���� �A�B�䤤�@����즳�]�t��ƪ��B�ήɡA�N������ GROUP BY
GROUP BY STORE_NAME, STORE_DATE 
ORDER BY STORE_NAME, STORE_DATE; -- ���ӵ��G �p��j(�w�]) �Ƨ�

--------------------------------------------------------------------------------

-- ���STORE_NAME�A�[�`(SALES)
SELECT STORE_NAME, SUM(SALES)
FROM STORE_INFORMATION
-- HAVING => ����ƭȪ����d�� (�����ϥ� ��� )
-- SELECT "���1" , SUM("���2") FROM "���W" GROUP BY "���1" HAVING(��Ʊ���) 
-- �p�G�Q SELECT ���O ����� �A ���N���� GROUP BY
GROUP BY STORE_NAME  -- �S���o�� �N�L�k�p��h�Ө��
HAVING SUM(SALES) >= 3000; -- ��~�B >= 3000

--------------------------------------------------------------------------------

-- ALIAS �O�W(���޸� "") �A ALIAS �i�ٲ����g(�Ů�j�})
-- ��� �O�W �`�B ��W �令 SUM SALES  �ɶq�["" ����n(�\Ū�ʸ���)
SELECT STORE_NAME, SUM(SALES) "SUM SALES", 
COUNT(STORE_NAME) COUNT_NAME, -- �i�������u �N�i�H���Φr�� (����ĳ)
-- �]�i��W�r�令���� �p�U
LISTAGG(SALES, '/') WITHIN GROUP (ORDER BY SALES ASC) ��~�B�M�� 
FROM STORE_INFORMATION
GROUP BY STORE_NAME;

--------------------------------------------------------------------------------

-- SELECT "���O�W" . "���1" "���O�W" FROM "���W" "���O�W"
-- ��� �O�W �i�H�����W  STORE_INFORMATION �N�ܦ� S
SELECT S.STORE_NAME, S.STORE_DATE 
FROM STORE_INFORMATION S;

--------------------------------------------------------------------------------

-- SUM(SALES) SUM_SALES �Ů� �� �O ���s�R�W ���
-- ��� �ӧO�ө� �u�`�X��~�B�v�B�u�ө���ƭӼơv�B�u������~�B�v
SELECT S.STORE_NAME, SUM(S.SALES) "SUM_SALES" , COUNT(S.STORE_NAME) "COUNT_STORE" , AVG(S.SALES) "AVG_SALES"
FROM STORE_INFORMATION S
GROUP BY S.STORE_NAME  -- 
HAVING AVG(S.SALES) > 1000 -- �ư��u������~�B�v1000(�t)�H�U���ө����
AND COUNT(S.STORE_NAME) > 1 -- �ư��u�ө���ƭӼơv1(�t)�ӥH�U���ө����
ORDER BY AVG(S.SALES) DESC; -- �̷ӡu������~�B�v�� �j�ܤp(DESC) �Ƨ�

--------------------------------------------------------------------------------

-- ��� �s��(JOIN) �Q�� WHERE ������ ���s��
-- ���]�O���ȳs��
-- ��� STORE_INFORMATION �� STORE_ID �� STORE_NAME �� FK_GEOGRAPHY_ID
-- ��� GEOGRAPHY �� REGION_NAME
SELECT  S.STORE_ID, S.STORE_NAME, S.FK_GEOGRAPHY_ID, G.REGION_NAME 
-- STORE_INFORMATION �R�W�� S �A GEOGRAPHY �R�W�� G
FROM STORE_INFORMATION S, GEOGRAPHY G
-- STORE_INFORMATION �� FK_GEOGRAPHY_ID = GEOGRAPHY �� GEOGRAPHY_ID
-- �p�G FK_GEOGRAPHY_ID ��1 ���N���� GEOGRAPHY_ID �N��1���� �� EAST �A 2 �N�N�� WEST �A 3 �N�N�� NORTH (�����i�H�s�X���Ӭd��)
WHERE S.FK_GEOGRAPHY_ID = G.GEOGRAPHY_ID;

--------------------------------------------------------------------------------

-- (����)���ȳs�� (��W���O�@�˪��N��)
SELECT  S.STORE_ID, S.STORE_NAME, S.FK_GEOGRAPHY_ID, G.REGION_NAME 
FROM STORE_INFORMATION S INNER JOIN GEOGRAPHY G
ON S.FK_GEOGRAPHY_ID = G.GEOGRAPHY_ID;

--------------------------------------------------------------------------------

-- �����s��
-- ��� STORE_INFORMATION �� STORE_ID �� STORE_NAME �� FK_GEOGRAPHY_ID
-- ��� GEOGRAPHY �� REGION_NAME
-- STORE_INFORMATION S �� GEOGRAPHY G �� ����(LEFT JOIN) �s��
-- �C�X�������ө��A���װө��O�_���ϰ�(�ŭ�)�A�]���ޥk�����S����
-- �]�� Buffalo, Walden Galleria �O�ŭ� �ҥH FK_GEOGRAPHY_ID �M REGION_NAME ��ܪŭ�
SELECT  S.STORE_ID, S.STORE_NAME, S.FK_GEOGRAPHY_ID, G.REGION_NAME 
FROM STORE_INFORMATION S LEFT JOIN GEOGRAPHY G
ON S.FK_GEOGRAPHY_ID = G.GEOGRAPHY_ID;

--------------------------------------------------------------------------------

-- �k���s��
-- �C�X���� �a�ϦW��(�ϰ�) �A���װϰ�O�_���q�ݰө�(�ŭ�)�A�]���ޥ������S����
-- �]�� Buffalo, Walden Galleria �O�ŭ� �ҥH FK_GEOGRAPHY_ID �M REGION_NAME ��ܪŭ�
-- �Ӧ]�� REGION_NAME �� North �O 3 �A ���]�� FK_GEOGRAPHY_ID �̨S�� 3 ���ȡA�ҥH�������O�ŭ�
SELECT  S.STORE_ID, S.STORE_NAME, S.FK_GEOGRAPHY_ID, G.GEOGRAPHY_ID , G.REGION_NAME 
FROM STORE_INFORMATION S RIGHT JOIN GEOGRAPHY G
ON S.FK_GEOGRAPHY_ID = G.GEOGRAPHY_ID;

--------------------------------------------------------------------------------

-- (+)����ʸ�ƴN�ɭ���:Oracle�A��
-- STORE_INFORMATION �� FK_GEOGRAPHY_ID �ɭ�
SELECT  S.STORE_ID, S.STORE_NAME, S.FK_GEOGRAPHY_ID, G.REGION_NAME 
FROM STORE_INFORMATION S , GEOGRAPHY G
WHERE S.FK_GEOGRAPHY_ID = G.GEOGRAPHY_ID(+); 

--------------------------------------------------------------------------------

-- (+)����ʸ�ƴN�ɭ���:Oracle�A��
-- GEOGRAPHY �� GEOGRAPHY_ID �ɭ�
SELECT  S.STORE_ID, S.STORE_NAME, S.FK_GEOGRAPHY_ID, G.REGION_NAME 
FROM STORE_INFORMATION S , GEOGRAPHY G
WHERE S.FK_GEOGRAPHY_ID(+) = G.GEOGRAPHY_ID; 

--------------------------------------------------------------------------------

-- FULL JOIN => ���� �s�� + �k�� �s�� (��ⰼ�����G�����)
SELECT  S.STORE_ID, S.STORE_NAME, S.FK_GEOGRAPHY_ID, G.REGION_NAME 
FROM STORE_INFORMATION S FULL JOIN GEOGRAPHY G
ON S.FK_GEOGRAPHY_ID = G.GEOGRAPHY_ID;

--------------------------------------------------------------------------------

--�d�ߦU�ϰ쪺��~�B�`�p (�ҥH���ަ��S���ȳ��n��ܡA�H GEOGRAPHY ���D �ҥH�ϥ� LEFT JOIN )
-- --NVL (���,��) �p�G��쬰NULL�A���N�^��(0)"��"
SELECT G.REGION_NAME ,NVL(SUM(S.SALES),0) "SUM_SALES" 
--(���׸Ӱϰ쩳�U�O�_�����ݰө�)
FROM GEOGRAPHY G  LEFT JOIN STORE_INFORMATION S
-- �p�G GEOGRAPHY �� GEOGRAPHY_ID = STORE_INFORMATION �� FK_GEOGRAPHY_ID �N�� �ۥ[
ON G.GEOGRAPHY_ID  = S.FK_GEOGRAPHY_ID  
GROUP BY G.REGION_NAME
--��Ƶ��G����~�B�`�p�Ѥj��p�Ƨ�
ORDER BY SUM_SALES DESC;

--------------------------------------------------------------------------------

--�d�ߦU�ϰ쪺�ө��Ӽ�
--(�̾ڰө��W��,���]�t���Ъ��ө�)
--(���׸Ӱϰ쩳�U�O�_�����ݰө�)
SELECT G.REGION_NAME ,COUNT(DISTINCT S.STORE_NAME) "COUNT_STORE"
FROM GEOGRAPHY G  LEFT JOIN STORE_INFORMATION S
ON G.GEOGRAPHY_ID  = S.FK_GEOGRAPHY_ID  
GROUP BY G.REGION_NAME
--��Ƶ��G�̰ϰ쪺�ө��ӼƥѤj�ܤp�Ƨ�
ORDER BY AVG(S.SALES) ASC;

-- �~�d��
SELECT SUM(S.SALES) 
FROM STORE_INFORMATION S WHERE S.STORE_NAME IN (
  -- ���d��
  SELECT S.STORE_NAME FROM STORE_INFORMATION S WHERE S.FK_GEOGRAPHY_ID = 2
);

-- �����l�d��
-- �~�d��
SELECT SUM(S.SALES) FROM STORE_INFORMATION S WHERE S.FK_GEOGRAPHY_ID IN (
    -- ���d��
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






