-- TABLE 목록
SELECT * FROM PERSON;
SELECT * FROM NEW_PERSON;
SELECT * FROM EMPLOYEE;
SELECT * FROM EMPLOYEE2;
SELECT * FROM STUDENT;

-- 데이터 수정 ; UPDATE
-- UPDATE 테이블명 SET WHERE
-- 형식 : UPDATE 테이블명 SET 수정할 컴럼명1 = 수정 값1, 수정할 컬럼명2 = 수정 값2, ….  WHERE 조건절 
-- 사용가능 연산자 : +, -, *, /


-- 문제 : PERSON 테이블의 데이터 중 20세 미만인 데이터는 나이를 99로 수정
UPDATE NEW_PERSON SET PAGE = 99 WHERE PAGE < 21;
-- 문제 : PERSON 테이블 데이터 중 30세 미만인 데이터에 나이를 현재 값에 5씩 빼서 저장
UPDATE  NEW_PERSON SET PAGE = PAGE-5 WHERE PAGE < 40;
-- 문제 : 학생 데이터 중 점수 1.5 미만이면 이름을 재적으로 수정
UPDATE STUDENT SET STD_NAME = '재적' WHERE SCORE < 2.7;

SELECT * FROM STUDENT WHERE SCORE < 2.7;
SELECT * FROM STUDENT WHERE STD_NAME LIKE '재적';
SELECT * FROM STUDENT;
SELECT * FROM NEW_PERSON;