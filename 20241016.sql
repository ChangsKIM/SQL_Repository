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














