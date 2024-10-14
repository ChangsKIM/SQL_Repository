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

