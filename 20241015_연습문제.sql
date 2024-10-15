-- 문제 1
-- 학생 테이블(STDENT)에서 학생정보를 조회할 때, 
-- 학번의 경우 앞에 4자리만 출력하고 나머지 4자리는 *로 출력되도록 조회

SELECT SUBSTR(STD_NO, 1, 4) || '****',
	STD_NAME, MAJOR_NAME, SCORE FROM STUDENT;
SELECT RPAD(SUBSTR(STD_NO, 1, 4), 8,'*'),
	STD_NAME, MAJOR_NAME, SCORE FROM STUDENT;
SELECT CONCAT(SUBSTR(STD_NO, 1, 4), '****')
	STD_NAME, MAJOR_NAME, SCORE FROM STUDENT;


-- 문제 2
-- 사원 테이블(EMPLOYEE)에서 데이터에서 연봉 순위를 조회
-- 단, 입사일은 입사년도만 출력 / 연봉을 출력시 천단위 기호가 붙도록 처리 / 순위는 건너 뛰지 않음
SELECT EP_NO, EP_NAME, TO_CHAR(EP_HIRE_DATE, 'YYYY') AS YEAR, 
	TO_CHAR(EP_SALRY, 'FM999,999,999,999') AS SALARY FROM EMPLOYEE;



-- 문제 3
-- 학생 테이블(STUDENT)에서 성씨로 점수 순위를 내림차순으로 조회
-- 단, 출력 형태는 '순위-학번-성씨-학과명-평점'순으로 조회하며, 순위는 건너뛰지 않음
SELECT 
	DENSE_RANK() OVER(PARTITION BY SUBSTR(S.STD_NAME, 1, 1) 
	ORDER BY S.SCORE) AS SCORE_RANK, S.* 
	FROM STUDENT S;
	
-- 입학년도 별로 순위 구하기
SELECT 
	DENSE_RANK() OVER(PARTITION BY SUBSTR(S.STD_NO, 1, 4) 
	ORDER BY S.SCORE) AS SCORE_RANK, S.* 
	FROM STUDENT S;

