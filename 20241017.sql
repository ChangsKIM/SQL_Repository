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
FROM STUDENT S LEFT OUTER JOIN STUDENT_SCHOLARSHIP SS
ON S.STD_NO = SS.STD_NO
WHERE SS.SCHOLARSHIP_NO IS NULL ;