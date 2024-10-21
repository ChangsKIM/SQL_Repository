
-- SQL 활용 능력단위 평가 

-- 01. 다음은 음식점의 메뉴 테이블을 생성한 SQL문이다.
-- 메뉴명이 반드시 저장되야 되는데 메뉴명을 넣지 않아도 등록되는 문제가 발생했고, 
-- 알수 없는 CREATE문의 문제도 생겼다.
-- 문제에 대한 원인과 이를 해결하는 SQL문을 작성하시오.

CREATE TABLE FOOD_MENU (
	MENU_NO CHAR(4) PRIMARY KEY, -- 메뉴번호
	MENU_NAME VARCHAR2(100), -- 메뉴명
	PRICE NUMBER(5), -- 금액
	IS_SOLD CHAR(1) -- 매진여부 ('Y' 또는 'N')
);

-- 02. 다음은 데이터 5건 추가되는 SQL문인데 오류가 생겼다.
-- 문제에 대한 원인과 이를 해결하는 SQL문을 작성하시오.
INSERT INTO FOOD_MENU VALUES ('0001', '치즈버거', 6000, 'Y');

INSERT INTO FOOD_MENU (MENU_NO, MENU_NAME, PRICE, IS_SOLD) 
VALUES ('0002', '감자튀김', 2000, 'N');

INSERT INTO FOOD_MENU (MENU_NO, MENU_NAME, PRICE, IS_SOLD) 
VALUES ('0003', '콜라', 1500, 'Y');

INSERT INTO FOOD_MENU (MENU_NO, MENU_NAME, PRICE, IS_SOLD) 
VALUES ('0004', '치킨버거', 6500, 'Y');

INSERT INTO FOOD_MENU (MENU_NO, MENU_NAME, PRICE, IS_SOLD) 
VALUES ('0005', '사이다', 1500, 'Y');

--03. 다음은 메뉴에 버거가 들어가는 메뉴를 조회 SQL문인데 조회가 되지 않는 문제가 발생했다.
-- 문제에 대한 원인과 이를 해결하는 SQL문을 작성하시오.
SELECT * FROM FOOD_MENU WHERE MENU_NAME LIKE '_버거';
SELECT * FROM FOOD_MENU WHERE MENU_NAME LIKE '%버거';

-- 04. 다음은 현재 판매중인 메뉴 중 금액인 3000원 이상, 
-- 7000원 이하인 메뉴를 조회 할려고 하니 조회결과가 잘못되었다.
-- 문제에 대한 원인과 이를 해결하는 SQL문을 작성하시오.

SELECT *	
SELECT * FROM FOOD_MENU
WHERE IS_SOLD = 'N' AND PRICE < 3000 AND PRICE > 7000;

-- 답
FROM FOOD_MENU
WHERE IS_SOLD = 'Y' AND PRICE BETWEEN 3000 AND 7000;

-- 0.5. 다음은 사이다와 콜라를 1000원씩 인상하는 SQL문인데 문제가 발생하였다.
-- 문제에 대한 원인과 이를 해결하는 SQL문을 작성하시오.
UPDATE FOOD_MENU SET PRICE = PRICE - 1000 WHERE MENU_NAME = ('사이다', '콜라');

SELECT * FROM FOOD_MENU ;


UPDATE FOOD_MENU SET PRICE = PRICE + 1000 WHERE MENU_NAME IN ('사이다', '콜라');


-- 06. FOOD 테이블에 메뉴 등록한 시간을 저장할려고 하여 
-- 메뉴 등록 시간을 추가하는 SQL문을 작성해서 실행 했으나 에러가 발생했다.
-- 발생한 이유와 이를 해결하는 SQL문을 작성하시오. 
-- 메뉴 등록시 기본값으로 현재 날짜 시간이 등록되어야 한다.

ALTER TABLE FOOD_MENU MODIFY COLUMN REGISTER_MENU_TIME DEFAULT SYSDATE;


ALTER TABLE FOOD_MENU ADD REGISTER_MENU_TIME DATE DEFAULT SYSDATE;


-- SQL 응용 능력단위 평가


