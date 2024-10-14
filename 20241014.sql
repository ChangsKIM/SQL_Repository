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

