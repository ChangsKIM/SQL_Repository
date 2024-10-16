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

-- 05. 학생정보 조회시, 학번 이름 학과명 평점 조회
SELECT S.STD_NO, S.STD_NAME, M.MAJOR_NAME, S.STD_SCORE
FROM STUDENT S JOIN MAJOR M ON S.MAJOR_NO = M.MAJOR_NO ;


