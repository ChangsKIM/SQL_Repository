
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

-- 01. 아래 SQL문으로 테이블을 생성하니까 음식점 테이블에 아이디 값이 기본키인데 
-- 중복으로 저장이 되는 오류와, 음식 메뉴 테이블에도 메뉴 번호가 기본키인데 데이터가 중복이 되었다.
-- 그리고 메뉴 테이블에 음식점 아이디 컬럼이 음식점 테이블 음식점 아이디에 외래키로 지정하였는데, 
-- 아무런 값이 등록이 되는 문제가 생겼으며, 메뉴금액이 음수가 등록되는 문제가 생겼다.
-- 아래 SQL문을 참고하여 누락된 부분이나, 에러의 원인을 쓰고, 수정한 SQL문을 제출하세요.

-- 음식점 테이블 생성 (기본키 및 제약 조건 추가)
CREATE TABLE STORE (
    STORE_ID CHAR(4) PRIMARY KEY, -- 음식점 아이디를 기본키로 설정
    STORE_NAME VARCHAR2(50),
    STORE_OWNER VARCHAR2(30),
    STORE_TEL CHAR(11),
    STORE_ADDRESS VARCHAR2(200)
);

-- 음식 메뉴 테이블 생성 (기본키, 외래키, 및 제약 조건 추가)
CREATE TABLE FOOD_MENU (
    MENU_NO CHAR(4) PRIMARY KEY, -- 메뉴 번호를 기본키로 설정
    MENU_NAME VARCHAR2(100),
    PRICE NUMBER(5) CHECK (PRICE >= 0), -- 가격이 음수일 수 없도록 제약 추가
    IS_SOLD CHAR(1),
    STORE_ID CHAR(4),
    CONSTRAINT FK_STORE_ID FOREIGN KEY (STORE_ID) REFERENCES STORE(STORE_ID) -- 외래키 제약 추가
);

INSERT INTO STORE (STORE_ID, STORE_NAME, STORE_OWNER, STORE_TEL, STORE_ADDRESS) VALUES
('0001', '맛있는 떡볶이 가게', '김철수', '01012345678', '서울시 강남구 역삼동 123-456');
INSERT INTO STORE (STORE_ID, STORE_NAME, STORE_OWNER, STORE_TEL, STORE_ADDRESS) VALUES
('0002', '행복한 김밥 가게', '이영희', '01023456789', '서울시 서초구 서초동 789-123');
INSERT INTO STORE (STORE_ID, STORE_NAME, STORE_OWNER, STORE_TEL, STORE_ADDRESS) VALUES
('0003', '새콤달콤 과일 가게', '박영자', '01034567890', '서울시 송파구 잠실동 456-789');
INSERT INTO STORE (STORE_ID, STORE_NAME, STORE_OWNER, STORE_TEL, STORE_ADDRESS) VALUES
('0004', '친절한 커피숍', '정민수', '01045678901', '서울시 강동구 천호동 987-654');
INSERT INTO STORE (STORE_ID, STORE_NAME, STORE_OWNER, STORE_TEL, STORE_ADDRESS) VALUES
('0005', '신선한 생선 가게', '홍길동', '01056789012', '서울시 마포구 망원동 321-654');
INSERT INTO FOOD_MENU (MENU_NO, MENU_NAME, PRICE, IS_SOLD, STORE_ID) VALUES
('0001', '매운 떡볶이', 5000, 'Y', '0001');
INSERT INTO FOOD_MENU (MENU_NO, MENU_NAME, PRICE, IS_SOLD, STORE_ID) VALUES
('0002', '치즈 떡볶이', 6000, 'Y', '0001');
INSERT INTO FOOD_MENU (MENU_NO, MENU_NAME, PRICE, IS_SOLD, STORE_ID) VALUES
('0003', '맛있는 김밥', 3000, 'Y', '0002');
INSERT INTO FOOD_MENU (MENU_NO, MENU_NAME, PRICE, IS_SOLD, STORE_ID) VALUES
('0004', '치즈 김밥', 3500, 'Y', '0002');
INSERT INTO FOOD_MENU (MENU_NO, MENU_NAME, PRICE, IS_SOLD, STORE_ID) VALUES
('0005', '달달한 과일샐러드', 7000, 'Y', '0003');
INSERT INTO FOOD_MENU (MENU_NO, MENU_NAME, PRICE, IS_SOLD, STORE_ID) VALUES
('0006', '상큼한 과일주스', 5000, 'Y', '0003');
INSERT INTO FOOD_MENU (MENU_NO, MENU_NAME, PRICE, IS_SOLD, STORE_ID) VALUES
('0007', '아메리카노', 3500, 'Y', '0004');
INSERT INTO FOOD_MENU (MENU_NO, MENU_NAME, PRICE, IS_SOLD, STORE_ID) VALUES
('0008', '카페라떼', 4000, 'Y', '0004');
INSERT INTO FOOD_MENU (MENU_NO, MENU_NAME, PRICE, IS_SOLD, STORE_ID) VALUES
('0009', '생선구이', 8000, 'Y', '0003');
INSERT INTO FOOD_MENU (MENU_NO, MENU_NAME, PRICE, IS_SOLD, STORE_ID) VALUES
('0010', '회덮밥', 7000, 'Y', '0004');




-- 02. 메뉴 조회시 메뉴 번호, 메뉴명, 금액, 음식점 명이 나오게끔 처리했는데 메뉴명 컬럼에서 
-- 오류가 발생하였다. 아래 SQL문을 참고하여 원인을 쓰고, 수정한 SQL문을 제출하세요.
SELECT FM.MENU_NO, FM.MENU_NAME, FM.PRICE, S.STORE_NAME
FROM FOOD_MENU FM JOIN STORE s ON FM.STORE_ID = S.STORE_ID ;

-- 03. 제일 비싼 메뉴 정보를 출력하는데, 
-- 조회할 컬럼은 메뉴 테이블에 있는 모든 컬럼인데 조건식에서 오류가 발생하였다.
-- 아래 SQL문을 참고하여 원인을 쓰고, 수정한 SQL문을 제출하세요
SELECT 
	FM.MENU_NAME ,
	FM.PRICE
FROM FOOD_MENU fm 
WHERE PRICE = (SELECT MAX(PRICE) FROM FOOD_MENU);


-- 04. 가계별로 메뉴개수, 메뉴의 평균 금액, 최대 메뉴 금액, 최저 메뉴 금액을 조회하는데, 오류가 발생
-- 조회할 컬럼명은 가계 아이디, 가계 명, 평균 금액, 최대 메뉴 금액, 최저 메뉴 금액이고, 
-- 모든 음식점 데이터가 출력되어야 한다.
-- 평균 값의 경우 소수점을 절삭 해야하며, 매칭되지않아 NULL 값인 나오는 경우 0으로 출력해야 한다.
-- 아래 SQL문을 참고하여 원인을 쓰고, 수정한 SQL문을 제출하세요

SELECT 
	S.STORE_NAME AS 가게이름,
	COUNT(FM.MENU_NO) AS 메뉴개수,
	COALESCE(TRUNC(AVG(FM.PRICE), 0),0) AS 평균금액,
	COALESCE(MAX(FM.PRICE), 0) AS 최대금액,
	COALESCE(MIN(FM.PRICE),0) AS 최소금액
FROM STORE s JOIN FOOD_MENU fm ON S.STORE_ID = FM.STORE_ID 
GROUP BY S.STORE_ID , S.STORE_NAME ;

SELECT 
	S.STORE_NAME AS 가게이름,
	COUNT(FM.MENU_NO) AS 메뉴개수,
	TRUNC(AVG(FM.PRICE), 0) AS 평균금액,
	COALESCE(MAX(FM.PRICE), 0) AS 최대금액,
	COALESCE(MIN(FM.PRICE),0) AS 최소금액
FROM STORE s JOIN FOOD_MENU fm ON S.STORE_ID = FM.STORE_ID 
GROUP BY S.STORE_ID , S.STORE_NAME ;


-- 05.메뉴를 하나도 등록을 하지 않은 가계들을 삭제하는 SQL문이다, 삭제가 되지 않는 문제가 생겼다.
-- 아래 SQL문을 참고하여 원인을 쓰고, 수정한 SQL문을 제출하세요

DELETE FROM STORE 
WHERE STORE_ID = (SELECT STORE_ID FROM FOOD_MENU FM WHERE MENU_NO IS NULL);


서브쿼리의 문제: SELECT STORE_ID FROM FOOD_MENU FM WHERE MENU_NO IS NULL은 메뉴 번호가 
NULL인 가게의 STORE_ID를 찾는 쿼리입니다. 그러나 MENU_NO는 메뉴의 고유 번호로, 
정상적으로 등록된 메뉴라면 NULL일 수 없습니다. 이로 인해 서브쿼리에서 STORE_ID를 찾지 못하고, 
삭제되지 않는 문제가 발생합니다.

DELETE FROM STORE
WHERE STORE_ID NOT IN (SELECT STORE_ID FROM FOOD_MENU);
