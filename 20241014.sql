-- 함수
-- DUAL : 임시 테이블, 값을 확인하는 용도(함수 결과 값, 계산 결과 값)
-- SYSDATE : 현재 날짜 시간값

SELECT 'Hello', 10 + 2 FROM DUAL;
SELECT SYSDATE FROM DUAL;

-- 문자열 데이터
-- INITCAP : 각 단어별 첫글자는 대문자로 변환, 나머지 글자는 소문자로 변환
SELECT INITCAP('HELL WORD') FROM DUAL;
SELECT INITCAP('hell word') FROM DUAL;
-- LOWER :
-- UPPER :
SELECT LOWER('Hello World'), UPPER('Hello World') FROM DUAL;  