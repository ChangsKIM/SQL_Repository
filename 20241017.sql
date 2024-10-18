-- 조인
-- inner join : 두 테이블에서 조건이 일치하는 행만 반환
-- 동일, 자연, 크로스 조인이 있음
CREATE TABLE A(
    CODE CHAR(1),
    VAL NUMBER(1)
);
CREATE TABLE B(
    CODE CHAR(1),
    UNIT CHAR(1)
);
INSERT INTO A VALUES('A',1);
INSERT INTO A VALUES('B',2);
INSERT INTO A VALUES('C',3);
INSERT INTO A VALUES('D',4);

INSERT INTO B VALUES('A','+');
INSERT INTO B VALUES('B','-');
INSERT INTO B VALUES('C','*');
INSERT INTO B VALUES('F','/');

SELECT * FROM A;
SELECT * FROM B;

-- 동일 조인(EQUI JOIN)
-- 방법01
SELECT A.CODE, A.VAL, B.CODE, B.UNIT 
FROM A, B
WHERE A.CODE = B.CODE;
-- 방법02 <선호01>
SELECT A.CODE, A.VAL, B.CODE, B.UNIT 
FROM A INNER JOIN B
ON A.CODE = B.CODE;
-- INNER JOIN(내부조인)
-- 	조인 조건을 만족하는 모든 행을 결합
SELECT A.CODE, A.VAL, B.CODE, B.UNIT 
FROM A INNER JOIN B
ON A.CODE <> B.CODE;
-- 방법03 <선호02>
SELECT A.CODE, A.VAL, B.CODE, B.UNIT 
FROM A JOIN B
ON A.CODE = B.CODE;

-- 자연 조인(NATURAL JOIN)
SELECT * FROM A NATURAL JOIN B;

-- 크로스 조인(CROSS JOIN)
SELECT * FROM A CROSS JOIN B;


-----------------------------------------------------------------
-----------------------------------------------------------------
-- 연습문제03
-- 학생 테이블을 이용한 조인 예제

-- 학생 테이블에 학과명만 중복없이 조회
SELECT DISTINCT STD_MAJOR FROM STUDENT;
SELECT DISTINCT STD_MAJOR FROM STUDENT;

-- 학과명, 행번호
SELECT 
	TO_CHAR(ROWNUM, 'FM00') AS 학과번호, 
	STD_MAJOR AS 학과명
FROM (SELECT DISTINCT STD_MAJOR FROM STUDENT);


-- 01. 학과 테이블 생성
CREATE TABLE MAJOR
AS 
SELECT 
	TO_CHAR(ROWNUM, 'FM00') AS 학과번호, 
	STD_MAJOR AS 학과명
FROM (SELECT DISTINCT STD_MAJOR FROM STUDENT);

SELECT * FROM MAJOR;

-- 02. 학생 테이블에 학과 컬럼 추가
ALTER TABLE STUDENT
ADD MAJOR_NO VARCHAR2(3);

-- 03. 학생 테이블에 학과 번호 업데이트
UPDATE STUDENT 
	SET MAJOR_NO = 
		(SELECT MAJOR_NO FROM MAJOR WHERE MAJOR_NAME = STD_MAJOR);

SELECT * FROM STUDENT;

-- 04. 학생 테이블의 학과명 컬럼 삭제
ALTER TABLE STUDENT DROP COLUMN STD_MAJOR;

-- 05. 학생정보 조회시 학번, 이름, 학과명, 평점 조회
-- 동일 조인
SELECT S.STD_NO, S.STD_NAME, M.MAJOR_NAME, S.STD_SCORE
FROM STUDENT S 
JOIN MAJOR M 
ON S.MAJOR_NO = M.MAJOR_NO ;

-- 자연 조인
SELECT * 
FROM STUDENT 
NATURAL JOIN MAJOR;

-- 크로스 조인
SELECT * FROM STUDENT CROSS JOIN MAJOR;


-----------------------------------------------------------------


-- 제조사 테이블 생성
CREATE TABLE MANUFACTURERS (
    MANUFACTURER_ID CHAR(10) PRIMARY KEY,   -- 제조사번호
    MANUFACTURER_NAME VARCHAR2(60)  -- 제조사명
);

SELECT * FROM MANUFACTURERS;
DROP TABLE MANUFACTURERS;

-- 제품 테이블 생성
CREATE TABLE PRODUCTS (
    PRODUCT_ID CHAR(10) PRIMARY KEY,        -- 제품번호
    PRODUCT_NAME VARCHAR2(120),  -- 제품명
    MANUFACTURER_ID CHAR(10),   -- 제조사번호
    PRICE NUMBER,             -- 금액
    FOREIGN KEY (MANUFACTURER_ID) REFERENCES MANUFACTURERS(MANUFACTURER_ID)
);


-- 제품 정보 조회시
-- 제품번호, 제품명, 제조사명, 금액
SELECT 
    P.PRODUCT_ID,
    P.PRODUCT_NAME,
    M.MANUFACTURER_NAME,
    P.PRICE 
FROM MANUFACTURERS M 
JOIN PRODUCTS P 
ON M.MANUFACTURER_ID = P.MANUFACTURER_ID;

-----------------------------------------------------------------------

-- 장학금 테이블
-- 데이터 30건 추가
CREATE TABLE STUDENT_SCHOLARSHIP(
	SCHOLARSHIP_NO NUMBER,
	STD_NO CHAR(8),
	MONEY NUMBER
);

SELECT * FROM STUDENT_SCHOLARSHIP;

SELECT 
    SS.SCHOLARSHIP_NO,
    S.STD_NO,
    SS.MONEY     
FROM STUDENT S 
JOIN STUDENT_SCHOLARSHIP SS 
ON S.STD_NO = SS.STD_NO;

-- 문제01 ; 장학금을 받는 학생 조회
SELECT
	SS.SCHOLARSHIP_NO,
	S.STD_NAME, 
	S.STD_NO,
	SS.MONEY
FROM STUDENT S JOIN STUDENT_SCHOLARSHIP SS
ON S.STD_NO = SS.STD_NO ;

-- 문제02 ; 장학금을 받는 학생 조회시
-- 학번, 이름, 학과명, 평점, 성별, 받은 금액

SELECT
	SS.SCHOLARSHIP_NO,
	S.STD_NAME, 
	S.STD_NO,
	SS.MONEY,
	M.MAJOR_NAME,
	S.STD_SCORE,
	S.STD_GENDER 
FROM STUDENT S 
JOIN STUDENT_SCHOLARSHIP SS ON S.STD_NO = SS.STD_NO
JOIN MAJOR m ON S.MAJOR_NO = M.MAJOR_NO; 
-- FROM 순서는 상관 없음 / 조인 결정은 ON에서 실시 / ON에서 조인을 실시하면 SELECT에서 출력함

-- 학과 테이블 데이터 2건 추가
INSERT INTO MAJOR VALUES('A9', '국어국문학과');
INSERT INTO MAJOR VALUES('B2', '생활체육학과');
	
-- 외부 조인(OUTER JOIN)
-- 조인 조건에 맞지 않는 행도 결과에 포함시킬 때 사용하는 조인
-- A : A=1,B=2,C=3,D=4 
-- B : A=+,B=-,C=*,F=/

-- LEFT OUTER JOIN
SELECT A.*, B.*
FROM A LEFT OUTER JOIN B ON A.CODE = B.CODE ;


-- RIGHT OUTER JOIN
SELECT A.*, B.*
FROM A RIGHT OUTER JOIN B ON A.CODE = B.CODE ;

-- FULL JOIN 
SELECT A.*, B.*
FROM A 
FULL OUTER JOIN B ON A.CODE = B.CODE ;

---------------------------------------------------------------------------
---------------------------------------------------------------------------

-- 연습문제01
-- 학생 정보 출력시 학생테이블, 학과 테이블에 있는 모든 데이터를 조회
-- 모든 컬럼 조회, 연결되지 않는 학과도 전부 조회
SELECT
S.*, M.*
FROM STUDENT S RIGHT OUTER JOIN MAJOR M
ON S.MAJOR_NO = M.MAJOR_NO; -- STE_NO, STD_NAME, STD_SCORE, STD_GENDER = NULL

-- 연습문제02
-- 학생이 한명도 없는 학과를 조회
SELECT
    M.*, S.STD_NO 
FROM STUDENT S 
RIGHT OUTER JOIN MAJOR M 
ON S.MAJOR_NO = M.MAJOR_NO
WHERE S.STD_NAME IS NULL;

-- 연습문제03
-- 장학금을 받지 못한 학생들의 정보를 조회
SELECT
	SS.SCHOLARSHIP_NO,
	S.STD_NAME, 
	S.STD_NO,
	SS.MONEY
FROM STUDENT S 
LEFT OUTER JOIN STUDENT_SCHOLARSHIP SS
ON S.STD_NO = SS.STD_NO
WHERE SS.SCHOLARSHIP_NO IS NULL ;

-- 학과명 추가
SELECT
	SS.SCHOLARSHIP_NO,
	S.STD_NAME, 
	S.STD_NO,
	S.STD_GENDER,
	M.MAJOR_NAME,
	SS.MONEY
FROM STUDENT S 
LEFT OUTER JOIN STUDENT_SCHOLARSHIP SS
ON S.STD_NO = SS.STD_NO
JOIN MAJOR m ON S.MAJOR_NO = M.MAJOR_NO;
WHERE SS.SCHOLARSHIP_NO IS NULL

-- 연습문제04(JOIN, GROUP BY)
-- 학과별로 장학금을 받은 학생들의 학과별, 성별을 기준으로 인원수, 최고평점, 최저평점 조회
SELECT
	M.MAJOR_NAME AS 학과명,
	S.STD_GENDER AS 성별,
	COUNT(*) AS 인원수,
	MAX(S.STD_SCORE) AS 최고평점,
	MIN(S.STD_SCORE) AS 최소평점
FROM STUDENT S
JOIN STUDENT_SCHOLARSHIP SS ON S.STD_NO = SS.STD_NO
JOIN MAJOR M ON S.MAJOR_NO = M.MAJOR_NO
GROUP BY ROLLUP(M.MAJOR_NAME, S.STD_GENDER);
-- WHERE
SELECT 
	M.MAJOR_NAME, S.STD_GENDER, 
	COUNT(*) AS STD_COUNT, 
	MAX(S.STD_SCORE) AS MAX_SCORE,
	MIN(S.STD_SCORE) AS MIN_SCORE 
FROM STUDENT S , MAJOR M, STUDENT_SCHOLARSHIP SS
WHERE S.MAJOR_NO = M.MAJOR_NO AND S.STD_NO = SS.STD_NO
GROUP BY M.MAJOR_NAME, S.STD_GENDER;

-- 연습문제05(JOIN, GROUP BY)
-- 학과별로 장학금을 못받은 학생들 숫자를 조회
-- 학과명, 학생수만 출력
SELECT
	M.MAJOR_NAME AS 학과명,
	COUNT(*) AS 인원수
FROM STUDENT S 
LEFT OUTER JOIN STUDENT_SCHOLARSHIP SS
ON S.STD_NO = SS.STD_NO
JOIN MAJOR m ON S.MAJOR_NO = M.MAJOR_NO
WHERE SS.SCHOLARSHIP_NO IS NULL
GROUP BY M.MAJOR_NAME;

--------------------------------------------------------------------
--------------------------------------------------------------------

-- CAR TABLE 
-- 제조사 코드 형식 AA-0-000
SELECT DBMS_RANDOM.STRING('X', 2) || '-' ||
	TRUNC(DBMS_RANDOM.VALUE(0,10),0) || '-' ||
	TRUNC(DBMS_RANDOM.VALUE(100,1000),0)
FROM DUAL;

-- TABLE 생성 CARSELL(판매)
CREATE TABLE CAR_SELL(
	CAR_SELL_NO NUMBER PRIMARY KEY,
	CAR_ID VARCHAR2(10),
	CAR_SELL_EA NUMBER(3),
	CAR_SELL_PRICE NUMBER(10),
	CAR_SELL_DATE DATE DEFAULT SYSDATE
);

-- 자동차 제조사만 조회 _ 중복 내용 제거
SELECT DISTINCT CAR_MAKER AS 제조사 FROM CAR;

-- 자동차 제조사 코드, 자동차 제조사명
SELECT 
	DBMS_RANDOM.STRING('X', 2) || '-' ||
	TRUNC(DBMS_RANDOM.VALUE(0,10),0) || '-' ||
	TRUNC(DBMS_RANDOM.VALUE(100,1000),0) AS CAR_MARKER_CODE,
	CAR_MAKER 
FROM (SELECT DISTINCT CAR_MAKER FROM CAR) ;

-- 자동차 제조사 테이블 생성
CREATE TABLE CAR_MAKER
AS
SELECT
	DBMS_RANDOM.STRING('X', 2) || '-' ||
	TRUNC(DBMS_RANDOM.VALUE(0,10),0) || '-' ||
	TRUNC(DBMS_RANDOM.VALUE(100,1000),0) AS CAR_MARKER_CODE,
	CAR_MAKER AS CAR_MAKER_NAME
FROM (SELECT DISTINCT CAR_MAKER FROM CAR) ;


-- 자동차 테이블에 제조사 코드 컬럼 추가
ALTER TABLE CAR ADD CAR_MAKER_CODE VARCHAR2(10);

-- 자동차 테이블에 제조사 코드 컬럼 수정
UPDATE CAR C SET C.CAR_MAKER_CODE = 
(SELECT CM.CAR_MARKER_CODE 
	FROM CAR_MAKER CM
	WHERE C.CAR_MAKER = CM.CAR_MAKER_NAME);

-- 자동차 테이블에 제조사명 컬럼 삭제
ALTER TABLE CAR DROP COLUMN CAR_MAKER;


-- 자동차 정보 조회시 ; 자동차 번호, 자동차 모델명, 제조사명, 제조년도, 금액
SELECT 
	c.CAR_ID ,
	cm.CAR_MAKER_NAME ,
	c.CAR_MAKER_CODE ,
	c.CAR_MAKE_YEAR ,
	c.CAR_PRICE 
FROM CAR c 
LEFT OUTER JOIN CAR_MAKER cm ON c.CAR_MAKER_CODE = cm.CAR_MARKER_CODE ;


-- 자동차 제조사별 자동차 제품 개수, 평균가, 최고가, 최소가 조회
SELECT 
	cm.CAR_MAKER_NAME ,
	TRUNC(AVG(c.CAR_PRICE)), COUNT(*), 
	MAX(c.CAR_PRICE),
	MIN(c.CAR_PRICE)	
FROM CAR c 
LEFT OUTER JOIN CAR_MAKER cm 
ON c.CAR_MAKER_CODE = cm.CAR_MARKER_CODE 
GROUP BY cm.CAR_MAKER_NAME ;

-- 자동차 제조사별, 제조년도별, 출시된 제품 개수를 조회
-- 단, 금액이 10,000이상인 것들만 대상으로 출력
SELECT 
	CM.CAR_MAKER_NAME, 
	C.CAR_MAKE_YEAR, 
	COUNT(*) 
FROM CAR C
LEFT OUTER JOIN CAR_MAKER CM
ON C.CAR_MAKER_CODE = CM.CAR_MARKER_CODE
WHERE C.CAR_PRICE < 10000
GROUP BY CM.CAR_MAKER_NAME, C.CAR_MAKE_YEAR;

-- 자동차 판매 정보 조회
-- 판매 번호, 판매된 모델명, 판매일, 판매개수, 판매금액
SELECT 
	CS.CAR_SELL_NO ,
	C.CAR_ID ,
	C.CAR_MAKER_CODE ,
	CS.CAR_SELL_DATE ,
	CS.CAR_SELL_EA ,
	CS.CAR_SELL_PRICE 
FROM CAR C
LEFT OUTER JOIN CAR_SELL CS
ON C.CAR_ID = CS.CAR_ID ;


-- 한번도 판매되지 않은 자동차 목록 조회
-- 자동차 번호, 자동차 모델명, 제조사명, 제조년도, 금액
SELECT
	C.CAR_ID ,
	CM.CAR_MAKER_NAME ,
	C.CAR_MAKE_YEAR ,
	C.CAR_PRICE 
FROM CAR C
LEFT OUTER JOIN CAR_SELL CS
ON C.CAR_ID = CS.CAR_ID 
JOIN CAR_MAKER CM
ON C.CAR_MAKER_CODE = CM.CAR_MARKER_CODE 
WHERE CS.CAR_ID IS NULL;

-- 판매 연도별, 제조사별, 판매 대수 총합, 판매금액 총합, 판매금액 평균을 조회
SELECT
	TO_CHAR(CS.CAR_SELL_DATE, 'YYYY') AS 판매년도 ,
	CM.CAR_MAKER_NAME AS 제조사 ,
	SUM(CS.CAR_SELL_EA) AS "판매 대수 총합",
	SUM(CS.CAR_SELL_PRICE) AS "판매금액 총합" ,
	TRUNC(AVG(CS.CAR_SELL_PRICE)) AS "판매금액 평균"	
FROM CAR C
LEFT OUTER JOIN CAR_SELL CS
ON C.CAR_ID = CS.CAR_ID
JOIN CAR_MAKER CM 
ON C.CAR_MAKER_CODE = CM.CAR_MARKER_CODE
GROUP BY TO_CHAR(CS.CAR_SELL_DATE, 'YYYY') , CM.CAR_MAKER_NAME ;

-- 판매 연도/원별, 제조사별, 판매 대수 총합, 판매금액 총합, 판매금액 편균을 조회
SELECT
	TO_CHAR( CS.CAR_SELL_DATE, 'YYYY/MM') AS 판매년도 ,
	CM.CAR_MAKER_NAME AS 제조사 ,
	SUM(CS.CAR_SELL_EA) AS "판매 대수 총합",
	SUM(CS.CAR_SELL_PRICE) AS "판매금액 총합" ,
	TRUNC(AVG(CS.CAR_SELL_PRICE), 2) AS "판매금액 평균"	
FROM CAR C
LEFT OUTER JOIN CAR_SELL CS
ON C.CAR_ID = CS.CAR_ID
JOIN CAR_MAKER CM 
ON C.CAR_MAKER_CODE = CM.CAR_MARKER_CODE
GROUP BY TO_CHAR(CS.CAR_SELL_DATE, 'YYYY/MM') , CM.CAR_MAKER_NAME ;

-- 판매 연도/분기, 판매 대수 총합, 판매금액 총합, 판매금액 평균을 조회
SELECT
	TO_CHAR( CS.CAR_SELL_DATE, 'YYYY/Q') AS 판매년도 ,
	SUM(CS.CAR_SELL_EA) AS "판매 대수 총합",
	SUM(CS.CAR_SELL_PRICE) AS "판매금액 총합" ,
	TRUNC(AVG(CS.CAR_SELL_PRICE), 2) AS "판매금액 평균"	
FROM CAR C
LEFT OUTER JOIN CAR_SELL CS
ON C.CAR_ID = CS.CAR_ID
JOIN CAR_MAKER CM 
ON C.CAR_MAKER_CODE = CM.CAR_MARKER_CODE
GROUP BY TO_CHAR(CS.CAR_SELL_DATE, 'YYYY/Q') ;





