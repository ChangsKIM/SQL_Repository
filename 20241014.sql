-- 함수
-- DUAL : 임시 테이블, 값을 확인하는 용도(함수 결과 값, 계산 결과 값)
-- SYSDATE : 현재 날짜 시간값

SELECT 'Hello', 10 + 2 FROM DUAL;
SELECT SYSDATE FROM DUAL;

-- 문자열 데이터
-- INITCAP : 각 단어별 첫글자는 대문자로 변환, 나머지 글자는 소문자로 변환
SELECT INITCAP('HELL WORD') FROM DUAL;
SELECT INITCAP('hell word') FROM DUAL;
-- LOWER : 알파벳을 전부 소문자로 변환
-- UPPER : 알파벳을 전부 대문자로 변환
SELECT LOWER('Hello World'), UPPER('Hello World') FROM DUAL;  
-- LENGTH :
SELECT LENGTH('Hollo'), LENGTH ('안녕하세요') FROM DUAL;
-- LENGTHB :
SELECT LENGTHB('Hollo'), LENGTHB('안녕하세요') FROM DUAL;

-- PERSON 테이블의 이름 글자개수와 글자개수의 바이트수를 출력
-- EX) 김창수 3, 9
SELECT LENGTH('김철수'), LENGTHB('김철수') FROM DUAL;
SELECT PNAME, LENGTH(PNAME), LENGTHB(PNAME) FROM PERSON;

-- PERSON 테이블에서 PAGE에 있는 NULL값을 가진 레코드를 조회
SELECT * FROM NEW_PERSON WHERE PAGE IS NULL;

-- INSTR ; 문자열 검색(특정 문자열이 처음으로 나타나는 위치 반환)
SELECT INSTR('ABCDEFG','CD') FROM DUAL;  -- 3 
SELECT INSTR('ABCDEFG','CDF') FROM DUAL; -- 0
-- 문자열 공백 체크
SELECT INSTR('동해물과 백두산이 마르고 닳도록', ' ') FROM DUAL;
-- 테이블의 NAME 컬럼에 공백을 넣지 않는 조건

CREATE TABLE PERSON(
	PNAME VARCHAR2(30),
	PAGE NUMBER(3),
	CONSTRAINT CHK_NAME CHECK(INSTR(PNAME, ' ') = 0),
	CONSTRAINT CHK_AGE CHECK(PAGE > 0)
);
INSERT INTO PERSON VALUES('김철수',10); -- 등록o
INSERT INTO PERSON VALUES('김 철수',10); -- 등록x
INSERT INTO PERSON VALUES('김철수',0); -- 등록x

SELECT * FROM PERSON;
SELECT * FROM USER_CONSTRAINTS; -- 사용자가 지정한 조건에 대한 목록 출력

-- REPLACE ; 문자열 바꾸기
SELECT REPLACE ('AAAAACCCCCCDDDDDD', 'C', 'F') FROM DUAL;

-- 학생테이블의 학과명에서 공학을 학으로 변경하는 UPDATE문을 작성
-- 학과명에 공학이 있는 경우에만 동작하게끔 처리
SELECT * FROM STUDENT;
UPDATE STUDENT SET MAJOR_NAME = REPLACE(MAJOR_NAME,'공학', '학') WHERE MAJOR_NAME LIKE '%학과';
UPDATE STUDENT SET MAJOR_NAME = REPLACE(MAJOR_NAME,'공학', '학') WHERE INSTR(MAJOR_NAME,'공학') <> 0;

-- LPAD, RPAD ; 원하는 문자열 개수만큼 남은 부분에 저장하는 함수
SELECT RPAD('991122-1',14,'*') FROM DUAL; 
SELECT LPAD('991122-1',14,'*') FROM DUAL;
SELECT RPAD('ABC',10,'1234') FROM DUAL;
SELECT LPAD('ABC',10,'1234') FROM DUAL;
-- TRIM 및 LENGTH
SELECT LENGTH(TRIM('   A   B   C   D   E   ')),LENGTH('   A   B   C   D   E   ') FROM DUAL;
--LTRIM, RTRIM ; 좌우에 지정한 문자 제거
SELECT LTRIM('AAABBBCCCDDDCCCBBBAAA', 'A') FROM DUAL;
SELECT RTRIM('AAABBBCCCDDDCCCBBBAAA', 'A') FROM DUAL;

-- 연습문제
-- 1. 제품 테이블 : 샘플 데이터 50건 - 제품번호, 제품명, 제조사번호, 금액
-- 2. 제조사 테이블 : 샘플 데이터 5건 - 제조사번호, 제조사명
-- 3. 테이블 생성 > 데이터 셋팅
--     - SELECT, INSERT, UPDATE, DELETE 연습
--     - MariaDB로도 연습해보기

