-- NULL 값 처리 함수
-- NVL : 첫번째 값이 NULL일 땐 두번재 값을 리턴, NULL이 아닐시 현재값 리턴
SELECT NVL(NULL, '널값'), NVL('100', '널값') FROM DUAL;
-- NVL2 : 첫번째 값이 NULL일 땐 세번째 값 리턴 / 첫번째 값이 NULL이 아닐 땐 두번째 값 리턴
SELECT NVL2(NULL, '널이 아닐때 값', '널일 때 값'), 
	NVL2('100', '널이 아닐 때 값', '널일 때 값') FROM DUAL;

-- 첫번재 값을 가지고 매칭 되는 값의 오른쪽에 있는 데이터 리턴
-- 매칭되는 값이 없을시 마지막 값(DEFAULT)을 리턴
-- 숫자만 지원
SELECT DECODE(1, 1,'A',2,'B','C') FROM DUAL;
SELECT DECODE(2, 1,'A',2,'B','C') FROM DUAL;
SELECT DECODE(4, 1,'A',2,'B',3,'C',4,'D','F') FROM DUAL;

-------------------------------------------------------------------------------------

-- 그룹함수
-- 테이블에 있는 데이터를 특정 컬럼을 기준으로 통계 값을 구하는 함수
-- 윈도우 함수의 PARTITION처럼 특정 컬럼에 동일한 데이터들을 묶어서 통계 값을 구함
-- 예) 학생 테이블에서 학과별 평점의 평균, 학과별 인원수
-- SUM, AVG, COUNT, MAX, MIN, STDDEV, VARIANCE
-- SUM ; 합

SELECT MAJOR_NAME, SUM(SCORE)
FROM STUDENT
GROUP BY MAJOR_NAME;

SELECT MAJOR_NAME, TRUNC(AVG(SCORE), 2)
FROM STUDENT
GROUP BY MAJOR_NAME;
-- 학과별 평점의 최대 값, 최소 값
SELECT MAJOR_NAME, MAX(SCORE), MIN(SCORE), COUNT(SCORE)
FROM STUDENT
GROUP BY MAJOR_NAME;
-- 학과별 인원수를 조회, 평점이 3.0 이상인 학생들만 조회
SELECT MAJOR_NAME, COUNT(SCORE)  --4
FROM STUDENT -- 1
WHERE SCORE > 3.0  -- 2
GROUP BY MAJOR_NAME; -- 3
--학과별 인원수를 조회, 평점이 2.0 이하인 학생들만 조회
SELECT MAJOR_NAME, COUNT(SCORE)
FROM STUDENT
WHERE SCORE <= 3.0
GROUP BY MAJOR_NAME;

SELECT MAJOR_NAME, COUNT(SCORE), AVG(SCORE)
FROM STUDENT
GROUP BY MAJOR_NAME HAVING AVG(SCORE) <= 3.0;

-- 현재 학생 테이블에 있는 데이터를 기준으로 학과별, 인원수를 조회
-- 단, 조회하는 인원수가 6명 이상인 학과만 조회
SELECT MAJOR_NAME, COUNT(*)
FROM STUDENT
GROUP BY MAJOR_NAME; HAVING COUNT(*) >=3;


--
-- 학번 2020-2024 00008자리 / 성별 추가 / 각 학년별로 100건씩 저장
-- 학생 테이블 생성
CREATE TABLE STUDENT(
	STD_NO CHAR(8) PRIMARY KEY,
	STD_NAME VARCHAR2(30) NOT NULL,
	STD_MAJOR VARCHAR2(30),
	STD_SCORE NUMBER(3,2) DEFAULT 0 NOT NULL,
	STD_GENDER CHAR(1)
);

-- 1. 입학한 년도별, 학과별, 성별로 인원수, 평점 평균, 평점 총합을 조회
SELECT 
    SUBSTR(STD_NO, 1, 4) AS 입학년도,
    STD_MAJOR AS 학과,
    STD_GENDER AS 성별,
    COUNT(*) AS 인원수,
    TRUNC(AVG(STD_SCORE),2) AS 평점평균,
    SUM(STD_SCORE) AS 평점총합
FROM STUDENT
GROUP BY SUBSTR(STD_NO, 1, 4), STD_MAJOR, STD_GENDER

-- 2. 입학한 년도별, 학과별로 인원수, 평점 평균, 평점 총합을 조회
SELECT 
	SUBSTR(STD_NO, 1, 4) AS 입학년도,
	STD_MAJOR AS 학과,
	COUNT(*) AS 인원수,
	TRUNC(AVG(STD_SCORE), 2) AS 평점평균,
	SUM(STD_SCORE) AS 평점총합
FROM STUDENT
GROUP BY SUBSTR(STD_NO,1,4), STD_MAJOR; 

-- 3. 입학한 년도별, 인원수, 평점 평균, 평점 총합을 조회
SELECT 
	SUBSTR(STD_NO, 1, 4) AS 입학년도,
	COUNT(*) AS 인원수,
	TRUNC(AVG(STD_SCORE), 2) AS 평점평균,
	SUM(STD_SCORE) AS 평점총합
FROM STUDENT
GROUP BY SUBSTR(STD_NO,1,4); 

-- 4. 학과별로 인원수, 평점 평균, 평점 총합을 조회
SELECT 
	STD_MAJOR AS 학과,
	COUNT(*) AS 인원수,
	TRUNC(AVG(STD_SCORE), 2) AS 평점평균,
	SUM(STD_SCORE) AS 평점총합
FROM STUDENT
GROUP BY STD_MAJOR;

-- 5. 학과별, 성별로 인원수, 평점 평균, 평점 총합을 조회
SELECT 
	STD_MAJOR AS 학과,
	STD_GENDER AS 성별,
	COUNT(*) AS 인원수,
	TRUNC(AVG(STD_SCORE), 2) AS 평점평균,
	SUM(STD_SCORE) AS 평점총합
FROM STUDENT
GROUP BY STD_MAJOR, STD_GENDER;

-- 6. 성별로 인원수, 평점 평균, 평점 총합을 조회
SELECT 
	STD_GENDER AS 성별,
	COUNT(*) AS 인원수,
	TRUNC(AVG(STD_SCORE), 2) AS 평점평균,
	SUM(STD_SCORE) AS 평점총합
FROM STUDENT
GROUP BY STD_GENDER;

-- 7. 전체 인원수, 평점 평균, 평점 총합을 조회
SELECT 
	COUNT(*) AS 인원수,
	TRUNC(AVG(STD_SCORE), 2) AS 평점평균,
	SUM(STD_SCORE) AS 평점총합
FROM STUDENT

-- CUBE 함수
-- 제공된 모든 컬럼의 모든 조함에 대한 집계 결과를 생성하는 함수
-- CUBE(A,B)
-- A에 대한 집계
-- B에 대한 집계
-- A, B에 대한 집계
-- 전체 집계
SELECT 
    SUBSTR(STD_NO,1,4) AS YEAR, STD_MAJOR, STD_GENDER,
    COUNT(*) AS STD_COUNT, 
    TRUNC(AVG(STD_SCORE),2) AS STD_AVG_SCORE,
    SUM(STD_SCORE) AS STD_SUM_SCORE
FROM STUDENT
GROUP BY CUBE (SUBSTR(STD_NO,1,4), STD_MAJOR, STD_GENDER);


-- ROLLUP
-- 계층적인 데이터 집계를 생성
-- 상위 수준의 요약정보를 상세한 수준으로 내려가면서 데이터를 집계
-- ROLLUP(A, B)
-- A, B에 대한 집계 결과
-- A에 대한 집계 결과
-- 전체 결과
SELECT 
    SUBSTR(STD_NO,1,4) AS YEAR, STD_MAJOR, STD_GENDER,
    COUNT(*) AS STD_COUNT, 
    TRUNC(AVG(STD_SCORE),2) AS STD_AVG_SCORE,
    SUM(STD_SCORE) AS STD_SUM_SCORE
FROM STUDENT
GROUP BY ROLLUP (SUBSTR(STD_NO,1,4), STD_MAJOR, STD_GENDER);

-- 입학년도, 학과별, 성씨를 기준으로 학생 인원수, 평점 평균 조회
-- 단, 입학년도는 학번 1~4자리, 평점은 평균 소수 둘째자리까지 출력
SELECT 
SUBSTR(STD_NO,1,4) AS 입학년도, 
STD_MAJOR AS 학과명, 
SUBSTR(STD_NAME,1,1) AS 성씨, 
COUNT(*) AS 인원수, 
TRUNC(AVG(STD_SCORE),2) AS "평점 평균" 
FROM STUDENT 
GROUP BY SUBSTR(STD_NO, 1, 4), STD_MAJOR, SUBSTR(STD_NAME,1,1);

-- CUBE
SELECT 
SUBSTR(STD_NO,1,4) AS 입학년도, 
STD_MAJOR AS 학과명, 
SUBSTR(STD_NAME,1,1) AS 성씨, 
COUNT(*) AS 인원수, 
TRUNC(AVG(STD_SCORE),2) AS "평점 평균" 
FROM STUDENT 
GROUP BY CUBE (SUBSTR(STD_NO, 1, 4), STD_MAJOR, SUBSTR(STD_NAME,1,1));
-- ROLLUP
SELECT 
SUBSTR(STD_NO,1,4) AS 입학년도, 
STD_MAJOR AS 학과명, 
SUBSTR(STD_NAME,1,1) AS 성씨, 
COUNT(*) AS 인원수, 
TRUNC(AVG(STD_SCORE),2) AS "평점 평균" 
FROM STUDENT 
GROUP BY ROLLUP(SUBSTR(STD_NO, 1, 4), STD_MAJOR, SUBSTR(STD_NAME,1,1));

-- GROUPING SETS
-- 특정 항목에 대한 집계하는 함수
-- GROUPING SETS(A, B)
-- A 그룹
-- B 그룹
-- GROUPING SETS(A,B,())
-- A그룹
-- B그룹
-- 전체 집계(총계)
-- GROUPING SETS(A,ROLLUP(B,C))
-- A그룹
-- B그룹, C그룹
-- B그룹
-- 전체 집계

SELECT 
SUBSTR(STD_NO,1,4) AS 입학년도, 
STD_MAJOR AS 학과명, 
SUBSTR(STD_NAME,1,1) AS 성씨, 
COUNT(*) AS 인원수, 
TRUNC(AVG(STD_SCORE),2) AS "평점 평균" 
FROM STUDENT 
GROUP BY GROUPING SETS(SUBSTR(STD_NO, 1, 4), STD_MAJOR, SUBSTR(STD_NAME,1,1));

-- EX 01)
SELECT 
	SUBSTR(STD_NO,1,4) AS 입학년도, 
	STD_MAJOR AS 학과명, 
	STD_GENDER AS 성별,
--	SUBSTR(STD_NAME,1,1) AS 성씨, 
	COUNT(*) AS 인원수, 
	TRUNC(AVG(STD_SCORE),2) AS "평점 평균" 
FROM STUDENT 
GROUP BY GROUPING SETS(
	SUBSTR(STD_NO, 1, 4), ROLLUP(STD_MAJOR, STD_GENDER));

-- EX 02)
SELECT SUBSTR(STD_NO,1,4) AS 입학년도, COUNT(*) AS 인원수, AVG(STD_SCORE) AS "학점 평균",
--	STD_MAJOR AS 학과명, 
--	STD_GENDER AS 성별,
--	SUBSTR(STD_NAME,1,1) AS 성씨, 
--	TRUNC(AVG(STD_SCORE),2) AS "평점 평균" 
FROM STUDENT 
GROUP BY GROUPING SETS(SUBSTR(STD_NO, 1, 4), ());


-- 연습문제
-- 사원데이터에서 부서별, 직급별, 인원수, 연봉 평균(수수점 x)
SELECT 
	EP_MAJOR AS 부서,
	EP_TITLE AS 직급,
	COUNT(*) AS 인원수,
	TRUNC(AVG(EP_SALRY)) AS "평균연봉"
FROM EMPLOYEE
GROUP BY GROUPING SETS(EP_MAJOR, EP_TITLE);

-- 사원데이터 부서별, 인원수, 연봉 평균(소수점 X)
SELECT 
	EP_MAJOR AS 부서,
--	EP_TITLE AS 직급,
	COUNT(*) AS 인원수,
	TRUNC(AVG(EP_SALRY),0) AS "평균연봉"
FROM EMPLOYEE
GROUP BY GROUPING SETS(EP_MAJOR);
	
-- ROLLUP
SELECT 
	EP_MAJOR AS 부서,
	EP_TITLE AS 직급,
	COUNT(*) AS 인원수,
	TRUNC(AVG(EP_SALRY)) AS "평균연봉"
FROM EMPLOYEE
GROUP BY ROLLUP(EP_MAJOR, EP_TITLE);

-- CUBE
SELECT 
	EP_MAJOR AS 부서,
	EP_TITLE AS 직급,
	COUNT(*) AS 인원수,
	TRUNC(AVG(EP_SALRY)) AS "평균연봉"
FROM EMPLOYEE
GROUP BY CUBE(EP_MAJOR, EP_TITLE);


-- 연습문제02
-- 자동차 테이블 : 제조사별, 연도별, 차량 개수, 차량 평균 금액
SELECT
	CAR_MAKER AS 제조사,
	CAR_MAKE_YEAR AS 연도,
	COUNT(*) AS 차량수,
	TRUNC(AVG(CAR_PRICE), 0) AS 평균금액
FROM CAR
GROUP BY CAR_MAKER , CAR_MAKE_YEAR;

-- ROLLUP
SELECT
	CAR_MAKER AS 제조사,
	CAR_MAKE_YEAR AS 연도,
	COUNT(*) AS 차량수,
	TRUNC(AVG(CAR_PRICE), 0) AS 평균금액
FROM CAR
GROUP BY ROLLUP(CAR_MAKER , CAR_MAKE_YEAR);

-- CUBE
SELECT
	CAR_MAKER AS 제조사,
	CAR_MAKE_YEAR AS 연도,
	COUNT(*) AS 차량수,
	TRUNC(AVG(CAR_PRICE), 0) AS 평균금액
FROM CAR
GROUP BY CUBE(CAR_MAKER , CAR_MAKE_YEAR);

