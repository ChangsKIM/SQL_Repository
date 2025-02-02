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
SELECT RTRIM('AAABBBCCCDDDCCCBBBAAA', 'AB') FROM DUAL;
SELECT LTRIM('AAABBBCCCDDDCCCBBBAAA', 'AB') FROM DUAL;

-- CONCAT 두 문자열을 연결
SELECT CONCAT('HELLO', 'WORLD') FROM DUAL; -- 2개만 가능
-- || 양 쪽에 있는 문자를 하나로 합쳐줌
SELECT 'HELLO' || ' ' || 'WORLD' FROM DUAL; -- 뭐든지 가능함
-- PERSON 테이블에서 내용을 김철수-20 이런 식으로 배열

-- 모든 테이블 DROP SQL문 작성
SELECT 'DROP TABLE' || TABLE_NAME || ';' FROM USER_TABLE

-- SUVSTR 문자열 추출 : 문자열 부분 추출
SELECT SUBSTR('1234567890', 5, 4) FROM DUAL; -- 5번째부터 + 4번째까지 추출
SELECT SUBSTR ('안녕하세요', 1,2) FROM DUAL;
SELECT SUBSTR('ABCDEFG', 2,3) FROM DUAL; 


------------------------------------------------------

-- 숫자열 함수

-- ROUND ; 지정한 숫자만큼 해당 숫자의 자릿수에서 반올림
-- 1 2 3 . 4 5 6
SELECT ROUND (123.456,-2) FROM DUAL; -- 100
SELECT ROUND (123.456,-1) FROM DUAL; -- 120
SELECT ROUND (123.456,0) FROM DUAL; -- 123
SELECT ROUND (123.456,1) FROM DUAL; -- 123.5
SELECT ROUND (123.456,2) FROM DUAL; -- 123.46

-- CEIL ; 올림 / FLOOR ; 내림
SELECT CEIL(123.456), FLOOR(123.456) FROM DUAL; -- 124 / 123
  
-- TRUNC ; 숫자를 지정한 자릿수로 자름
SELECT TRUNC(123.456,-2) FROM DUAL; -- 100
SELECT TRUNC(123.456,-1) FROM DUAL; -- 120
SELECT TRUNC(123.456,0) FROM DUAL; -- 123
SELECT TRUNC(123.456,1) FROM DUAL; -- 123.4
SELECT TRUNC(123.456,2) FROM DUAL; -- 123.45

------ SAVE ------

-- MOD ; 나눗셈을 해서 나머지 값을 출력
SELECT MOD(26,4) FROM DUAL; -- 2

-- POWER ; 제곱 값 출력
SELECT POWER(2,10) FROM DUAL; -- 1,024

-- 덧셈연산 (기본 적으로 형변환이 이루어져 계산이 됨)
SELECT 123 + '123', 123 + '123' / 3 FROM DUAL; -- 246 / 164
SELECT TO_NUMBER('123') / 3 FROM DUAL; -- 41('123'을 숫자로 변환)
------ SAVE ------

-- 날짜시간
 SELECT SYSDATE FROM DUAL;
    -- 24/10/15
-- 오클리에서 저장된 현재 날짜 시간의 출력 포멧을 변경
 ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
    -- 출력 포멧 변경
SELECT SYSDATE FROM DUAL;
    -- 2024-10-15 00 : 00 : 00
ALTER SESSION SET NLS_DATE_FORMAT = 'YY/MM/DD';

-- TO_CHAR(데이터, '형식') 날짜를 문자열로 변환
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI;SS'), 
TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') FROM DUAL; 

SELECT TO_CHAR(SYSDATE, 'MON DY / MONTH DAY') FROM DUAL; -- 10월 화 / 10월 화요일
SELECT TO_CHAR(SYSDATE, 'MON DY / MONTH DAY', 
'NLS_DATE_LANGUAGE=ENGLISH') FROM DUAL; -- OCT TUE / OCTOBER   TUESDAY  

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI;SS AM') FROM DUAL; -- 2024-10-15 11:54;26 오전

SELECT TO_CHAR(TO_DATE('2024-10-15 15:00:11', 'YYYY-MM-DD HH24:MI:SS'), 
'Q YYYY-MM-DD HH:MI;SS AM') FROM DUAL; -- 2024-10-15 03:00;11 오후 Q = 분기
------ SAVE ------

FROM DUAL;
-- 숫자 포멧
-- 9 : 숫자 한자리, 자리가 없으면 공백
-- 0 : 숫자 한자리, 자리가 업으면 0으로 채움
SELECT TO_CHAR(1234567.89, '99999999.000') FROM DUAL;
-- L : 통화 기호(지역 설정 기준)
SELECT TO_CHAR(1234567.89, 'L99999999.000') FROM DUAL; -- ￦1234567.890
-- $ : 통화 기호(달러)
SELECT TO_CHAR(1234567.89, '$99999999.000') FROM DUAL; -- $1234567.890
-- , : 천단위 구분 기호, . : 소수점
SELECT TO_CHAR(1234567.89, '$99,999,999.000') FROM DUAL; -- $1,234,567.890
SELECT TO_CHAR(1234567.89, 'L99,999,999.000') FROM DUAL; -- ￦1,234,567.890
-- G : 천단위 구분 히고, D: 소수점 기호
SELECT TO_CHAR(1234567.89, '99G999G999D000') FROM DUAL;
-- FM : 앞뒤의 불필요한 공백을 제거
SELECT TO_CHAR(1234567.89, '99999999.000') FROM DUAL;
SELECT TO_CHAR(1234567.89, 'FM99999999.000') FROM DUAL; 
-- S : +, - 표시
SELECT TO_CHAR(-1234567, 'S9,999,999') FROM DUAL;
SELECT TO_CHAR(1234567, 'S9,999,999') FROM DUAL;
-- PR : -일 때 < >
SELECT TO_CHAR(-1234567, '9,999,999PR') FROM DUAL;
SELECT TO_CHAR(1234567, '9,999,999PR') FROM DUAL;
FROM DUAL;
------ SAVE ------


-- 문자열을 날짜로 변경
SELECT TO_DATE('2020-11-11','YYYY-MM-DD') FROM DUAL; --2020-11-11 00:00:00.000
-- 오늘 날짜부터 지정된 날짜가지 남은 개월 수
SELECT MONTHS_BETWEEN(SYSDATE, '2024-12-31') FROM DUAL; -- -2.4976
-- 지정된 날짜부터 몇 개월 후 날짜
SELECT ADD_MONTHS(SYSDATE,2) FROM DUAL; -- 2024-12-15 13:47:13.000
-- 지정된 날짜(돌아오는 요일)
SELECT NEXT_DAY(SYSDATE, '수') FROM DUAL; -- 2024-10-16 13:49:57.000
SELECT NEXT_DAY(SYSDATE, '월') FROM DUAL; -- 2024-10-21 13:49:46.000
-- 주어진 날짜 기준으로 날짜가 속한 달의 마지막 날
SELECT LAST_DAY(SYSDATE) FROM DUAL; 
-- 내일 날짜 출력
SELECT SYSDATE+1 FROM DUAL;

-- 연습문제
-- D-DAY출력 (수능)
SELECT '수능 D-' || TRUNC(TO_DATE('2024-11-14', 'YYYY/MM/DD')-SYSDATE) AS D_DAY FROM DUAL; 
SELECT '수능 D-' || CEIL(TO_DATE('2024-11-14', 'YYYY-MM-DD')-SYSDATE) AS D_DAY FROM DUAL;
------ SAVE ------

-- 윈도우 함수
-- 키워드 : OVER(), PARTITION BY, ORDER BY
-- 순위 함수
-- ROW_NUMBER(): 행에 고유한 번호를 부여
-- RANK(): 동일한 값이 있을 경우 같은 순위를 부여하고, 그 다음 순위는 건너뜀
-- DENSE_RANK(): 동일한 값이 있을 경우 같은 순위를 부여하지만, 다음 순위는 건너뛰지 않음

-- 나이가 적은 순위
SELECT RANK() OVER(ORDER BY PAGE), P.* FROM PERSON P;
-- 나이가 많은 순위
SELECT RANK() OVER(ORDER BY PAGE DESC), P.* FROM PERSON P;
SELECT DENSE_RANK() OVER(ORDER BY PAGE DESC), P.* FROM PERSON P;
-- 줄 번호 생성
SELECT ROW_NUMBER() OVER(ORDER BY PAGE ) AS RW, P.* FROM PERSON P;
SELECT ROW_NUMBER() OVER(ORDER BY PAGE DESC) AS RW, P.* FROM PERSON P;

SELECT ROW_NUMBER() OVER(ORDER BY PAGE ) AS RW,
RANK() OVER(ORDER BY PAGE ASC) AS RANK,
P.* FROM PERSON P

SELECT * FROM PERSON; 
------ SAVE ------

-- 현재 행을 기준으로 다음 위치에 해당하는 값을 읽어오는 함수
-- LEAD 다음 데이터 확인 (LEAD(PNAME, 2, NULL값 수정)
-- 다음 행의 값을 가져오는 윈도우 함수
SELECT P.*, LEAD(PNAME) OVER(ORDER BY PAGE) FROM PERSON P;
-- 현재 행을 기준으로 이전 위치에 해당하는 값을 읽어오는 함수
SELECT P.*, LAG(PNAME) OVER(ORDER BY PAGE) AS PREV_PNAME FROM PERSON P;
SELECT P.*, LAG(PNAME, 2) OVER(ORDER BY PAGE) AS PREV_PNAME FROM PERSON P;
SELECT P.*, LAG(PNAME, 2, '데이터 없음') OVER(ORDER BY PAGE) AS PREV_PNAME FROM PERSON P;
------ SAVE ------
------------------------------------------------------------------------

-- 연습문제
-- 학생 테이블(STUDENT)의 평점(SCORE)을 기준으로 성적 순위를 출력
-- 성적순은 내림차순으로 처리, 순위는 건너뛰지 않음
-- 컬럼 STD_NO, STD_NAME, MAJOR_NAME, SCORE
-- 정답
-- 성적순으로 배열, 순위는 건너뒤지 않음
SELECT S.*, DENSE_RANK() OVER(ORDER BY SCORE DESC) AS RANK FROM STUDENT S;
-- 학과명끼리 분류(PARTITION)하여, 성적순으로 배열
SELECT S.*, DENSE_RANK() OVER(PARTITION BY S.MAJOR_NAME ORDER BY SCORE DESC) AS RANK FROM STUDENT S;


-- NULL 값 처리 함수
-- NVL : 첫번째 값이 NULL일 땐 두번재 값을 리턴, NULL이 아닐시 현재값 리턴
SELECT NVL(NULL, '널값'), NVL('100', '널값') FROM DUAL;
SELECT NVL2((NULL, '널이 아닐때 값', '널일 때 값'), NVL2('100', '널이 아닐 때 값', '널일 때 값') 






------------------------------------------------------------------------
-- 연습문제
-- 1. 제품 테이블 : 샘플 데이터 50건 - 제품번호, 제품명, 제조사번호, 금액
-- 2. 제조사 테이블 : 샘플 데이터 5건 - 제조사번호, 제조사명
-- 3. 테이블 생성 > 데이터 셋팅
--     - SELECT, INSERT, UPDATE, DELETE 연습
--     - MariaDB로도 연습해보기

