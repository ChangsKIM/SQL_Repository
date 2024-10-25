-- PL/SQL
-- 데이터 베이스에서 사용되는 절차적 언어
-- 프로시저, 함수, 트리거 등의 형태로 작성을 할 수 있음
-- 데이터 조작 및 비지니스 로직을 데이터베이스 내에서 직접 처리 할 수 있음

-- 함수 - 실습코드01 :
CREATE OR REPLACE FUNCTION GET_ODD_EVEN(N IN NUMBER)
RETURN VARCHAR2 IS 
	-- 함수에서 사용할 변수를 선언하는 영역
	MSG VARCHAR2(100);
BEGIN 
	-- 실행하는 영역
	IF N = 0	THEN
		MSG := '0 입니다.';
	ELSIF MOD(N, 2) = 0 THEN
		MSG := '짝수입니다.';
	ELSE
		MSG := '홀수입니다.';
	END IF;
	RETURN MSG;
END;

SELECT 
	GET_ODD_EVEN(5), 
	GET_ODD_EVEN(15),
	GET_ODD_EVEN(20),
	GET_ODD_EVEN(87) 
FROM DUAL;


-- 함수 - 실습코드02 :
CREATE OR REPLACE FUNCTION GET_SCORE_GRADE(SCORE IN NUMBER)
RETURN VARCHAR2
IS
	MSG VARCHAR2(100);
	USER_EXCEPTION EXCEPTION; -- 이셉션 객체 생성
BEGIN 
	IF SCORE < 0 THEN
		RAISE USER_EXCEPTION;	
	END IF;
	IF SCORE >= 95 AND 91 >= SCORE THEN
		MSG := 'A+';
	ELSIF SCORE >= 90 THEN
		MSG := 'A';
	ELSIF SCORE >= 85 THEN
		MSG := 'B+';
	ELSIF SCORE >= 80 THEN
		MSG := 'B';
	ELSIF SCORE >= 75 THEN
		MSG := 'C+';
	ELSIF SCORE >= 70 THEN
		MSG := 'C';
	ELSIF SCORE >= 65 THEN
		MSG := 'D+';
	ELSIF SCORE >= 60 THEN
		MSG := 'D'; 
	ELSE
		MSG := 'F';		
	END IF;
	RETURN MSG;
EXCEPTION 
	WHEN USER_EXCEPTION THEN
		RETURN '점수는 0이상 입력';
	WHEN OTHERS THEN
		RETURN '알 수 없는 에러';
END;

SELECT 
	GET_SCORE_GRADE(96) AS 학생01,
	GET_SCORE_GRADE(72) AS 학생02,
	GET_SCORE_GRADE(83) AS 학생03,
	GET_SCORE_GRADE(55) AS 학생04,
	GET_SCORE_GRADE(0) AS 학생05,
	GET_SCORE_GRADE(-1) AS 학생06,
	GET_SCORE_GRADE(61) AS 학생07
	FROM dual;

-- 함수 - 실습코드03 :
-- 학과 번호를 받아서 학과명을 리턴하는 함수
-- 없는 번호를 입력했을 때의 대처
CREATE OR REPLACE FUNCTION GET_MAJOR_NAME(V_MAJOR_NO IN VARCHAR2)
RETURN VARCHAR2
IS
	MSG VARCHAR2(30);	
BEGIN 
		-- 문자열
	SELECT M.MAJOR_NAME INTO MSG
	FROM MAJOR M 
	WHERE M.MAJOR_NO = V_MAJOR_NO;
	RETURN MSG;
EXCEPTION 
	WHEN OTHERS THEN
		RETURN '데이터 없음';
END;

SELECT 
	GET_MAJOR_NAME('20')
FROM DUAL;

SELECT 	GET_MAJOR_NAME('03') 
FROM DUAL;

-- 함수 - 실습코드04 :
-- 반복문
CREATE OR REPLACE FUNCTION GET_TOTAL(N1 IN NUMBER, N2 IN NUMBER)
RETURN NUMBER 
IS
	TOTAL NUMBER;  -- 합계를 0으로 초기화
	I NUMBER; -- I는 N1 값으로 초기화
BEGIN 
	-- 초기화
	TOTAL := 0;
	I := N1;
-- 루프 시작: N1부터 N2까지 더하는 작업
	LOOP
		TOTAL := TOTAL + I; -- I 값을 TOTAL에 더함
		I := I + 1; -- I 값을 1씩 증가시킴
		EXIT WHEN I > N2;	-- I가 N2보다 커지면 루프 종료	 
	END LOOP;
	-- 최종 결과 반환
	RETURN TOTAL;
END;

-- WHILE문
CREATE OR REPLACE FUNCTION GET_TOTAL(N1 IN NUMBER, N2 IN NUMBER)
RETURN NUMBER 
IS
	TOTAL NUMBER;  -- 합계를 0으로 초기화
	I NUMBER; -- I는 N1 값으로 초기화
BEGIN 
--	 초기화
	TOTAL := 0;
	I := N1;
-- 루프 시작: N1부터 N2까지 더하는 작업
	WHILE(I <= N2)
	LOOP
		TOTAL := TOTAL + I; -- I 값을 TOTAL에 더함
		I := I + 1; -- I 값을 1씩 증가시킴
	END LOOP;
	-- 최종 결과 반환
	RETURN TOTAL;
END;

-- FOR문
CREATE OR REPLACE FUNCTION GET_TOTAL(N1 IN NUMBER, N2 IN NUMBER)
RETURN NUMBER 
IS
	TOTAL NUMBER;  -- 합계를 0으로 초기화
	I NUMBER; -- I는 N1 값으로 초기화
BEGIN 
--	 초기화
	TOTAL := 0;
	I := N1;
-- 루프 시작: N1부터 N2까지 더하는 작업
	FOR I IN N1 .. N2
	LOOP
		TOTAL := TOTAL + I; -- I 값을 TOTAL에 더함
	END LOOP;
	-- 최종 결과 반환
	RETURN TOTAL;
END;

-- 결과 값 출력
SELECT GET_TOTAL(1, 100) FROM DUAL;


-------------------------------------------------------------------------
-------------------------------------------------------------------------

-- 트리거
-- 데이터베이스에서 발생하는 이벤트에 대한 반응으로 자동으로 실행되는 SQL
-- INSERT, UPDATE, DELETE 등의 이벤트에 대한 반응으로 실행
-- 테이블에 대한 이벤트가 발생하면 자동으로 실행되는 PL/SQL블록
-- 트리거는 테이블에 종속적이기 때문에 테이블 생성 후 트리거 생성
-- 트리거는 테이블에 종속적이기 때문에 테이블 삭제 후 트리거 삭제

-- 트리거 - 실습코드01
CREATE TABLE DATA_LOG(
	LOG_DATE DATE DEFAULT SYSDATE,
	LOG_DETAIL VARCHAR2(1000)
);

-- MAJOR 테이블에 내용이 UPDATE되면 해당 기록을 저장하는 트리거
CREATE OR REPLACE TRIGGER UPDATE_MAJOR_LOG
AFTER 
	UPDATE ON MAJOR
FOR EACH ROW
BEGIN
	INSERT INTO DATA_LOG(LOG_DETAIL)
	VALUES(:OLD.MAJOR_NO || '_' || :NEW.MAJOR_NO
	|| ',' || :OLD.MAJOR_NAME || '_' || :NEW.MAJOR_NAME);
	END;

UPDATE MAJOR SET MAJOR_NAME = '디지털문화콘테츠학과'
WHERE MAJOR_NO = 'A9';


-- 트리거 - 실습코드02
-- MAJOR에 학과 정보 추가시 발동되는 트리거
CREATE OR REPLACE TRIGGER INSERT_MAJOR_TRIGGER
AFTER
	INSERT ON MAJOR
FOR EACH ROW
BEGIN
	INSERT INTO DATA_LOG(LOG_DETAIL)
	VALUES(:NEW.MAJOR_NO || '-' || :NEW.MAJOR_NAME);
END;

-- 학과정보 추가
INSERT INTO MAJOR VALUES('C9', '주짓수학과');


-- 학과 확인
SELECT * FROM MAJOR;

-- 트리거 - 실습코드03
-- 학과 정보 삭제시 발동되는 트리거
CREATE OR REPLACE TRIGGER DELETE_MAJOR_TRIGGER
AFTER
	DELETE ON MAJOR
FOR EACH ROW
BEGIN
	INSERT INTO DATA_LOG(LOG_DETAIL)
	VALUES(:OLD.MAJOR_NO || '-' || :OLD.MAJOR_NAME);
END;

-- 삭제
DELETE FORM MAJOR WHERE MAJOR_NO = 'C9';

-- 로그 검색
SELECT * FROM DATA_LOG;


-------------------------------------------------------------------------
-------------------------------------------------------------------------

-- 트리거 - 실습코드04
-- 트리거 INSERT, UPDATE, DELETE 합치기
CREATE OR REPLACE MAJOR_TRIGGER
AFTER
	INSERT OR UPDATE OR DELETE ON MAJOR
FOR EACH ROW
BEGIN
	IF INSERT THEN
	INSERT INTO DATA_LOG(LOG_DETAIL)
	VALUES('INSERT' || :NEW.MAJOR_NO || '-' || :NEW.MAJOR_NAME);

	ELSIF UPDATE THEN
	INSERT INTO DATA_LOG(LOG_DETAIL)
	VALUES('UPDATE' || :OLD.MAJOR_NO || '_' || :NEW.MAJOR_NO
	|| ',' || :OLD.MAJOR_NAME || '_' || :NEW.MAJOR_NAME);

	ELSE DELETE THEN
INSERT INTO DATA_LOG(LOG_DETAIL)
	VALUES('DELETE' || :OLD.MAJOR_NO || '-' || :OLD.MAJOR_NAME);

	END IF;

END;


-- 트리거 - 실습코드05
CREATE OR REPLACE MAJOR_TRIGGER
AFTER
	INSERT OR UPDATE OR DELETE ON MAJOR
FOR EACH ROW
BEGIN
	IF INSERTING THEN
	INSERT INTO DATA_LOG(LOG_DETAIL)
	VALUES('INSERT' || :NEW.MAJOR_NO || '-' || :NEW.MAJOR_NAME || '/' || SYS_CONTEXT('USERENV', 'SESSION_USER'));

	ELSIF UPDATING THEN
	INSERT INTO DATA_LOG(LOG_DETAIL)
	VALUES('UPDATE' || :OLD.MAJOR_NO || '_' || :NEW.MAJOR_NO
	|| ',' || :OLD.MAJOR_NAME || '_' || :NEW.MAJOR_NAME || '/' || SYS_CONTEXT('USERENV', 'SESSION_USER'));

	ELSE DELETING THEN
	INSERT INTO DATA_LOG(LOG_DETAIL)
	VALUES('DELETE' || :OLD.MAJOR_NO || '-' || :OLD.MAJOR_NAME || '/' || SYS_CONTEXT('USERENV', 'SESSION_USER'));
	END IF;
END;


-------------------------------------------------------------------------
-------------------------------------------------------------------------

-- 다른 계정으로 C##COTT 에서 작업하기
-- system 로그인 후 
-- 새로운 계정 생성 :
CREATE USER C##CHANGS IDENTIFIED BY 123456;

-- 권한(데이터 권한, 접속 권한) : 
GRANT RESOURCE, CONNECT TO C##CHANGS;

 -- 테이블스페이스에서 데이터 저장 용량에 제한 :  
ALTER USER C##CHANGS DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;


-- C##COTT의 계정에 권한을 주는 명령어(권한 ; 4가지) 구체적으로 입력
GRANT
	INSERT, UPDATE, DELETE, SELECT ON C##COTT.MAJOR TO C##CHANGS;


-- 추가
INSERT INTO MAJOR VALUES('C11', '유도학과');
-- 삭제
DELETE FROM MAJOR WHERE MAJOR_NO = 'C11';
-- 확인
SELECT * FROM MAJOR;

-- 적속한 사용자 확인
SELECT SYS_CONTEXT('USERENV', 'SESSION_USER') FROM DUAL;


-- 트리거 - 실습코드06
--로그를 저장할 테이블
CREATE TABLE BOARD_LOG (
    LOG_ID          NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    ACTION_TYPE     VARCHAR2(10),
    USER_ID         VARCHAR2(50),
    BOARD_NO         NUMBER,
    POST_TITLE      VARCHAR2(150),
    POST_CONTENT    VARCHAR2(3000),
    BEFORE_TITLE    VARCHAR2(150),
    BEFORE_CONTENT  VARCHAR2(3000),
    ACTION_TIMESTAMP TIMESTAMP DEFAULT SYSTIMESTAMP
);

--게시판 테이블 트리거 생성
-- INSERT, UPDATE, DELETE 에 대응하는 트리거
CREATE OR REPLACE TRIGGER TRG_BOARD_ACTIONS
AFTER
	INSERT OR UPDATE OR DELETE ON BOARD
FOR EACH ROW
DECLARE
	V_USER_ID VARCHAR2(50);
BEGIN
	SELECT 
		SYS_CONTEXT('USERENV','SESSION_USER') INTO V_USER_ID 
	FROM DUAL;

	IF INSERTING THEN
		INSERT INTO 
			BOARD_LOG(
				ACTION_TYPE, USER_ID, BOARD_NO, 
				POST_TITLE, POST_CONTENT)
		VALUES('INSERT', V_USER_ID, :NEW.BNO, 
			:NEW.TITLE, :NEW.CONTENT);
	ELSIF UPDATING THEN
		INSERT INTO 
			BOARD_LOG(
				ACTION_TYPE, USER_ID, BOARD_NO, 
				POST_TITLE, POST_CONTENT,
				BEFORE_TITLE, BEFORE_CONTENT)
		VALUES('UPDATE', V_USER_ID, :NEW.BNO, 
			:NEW.TITLE, :NEW.CONTENT,
			:OLD.TITLE, :OLD.CONTENT);
	ELSIF DELETING THEN
		INSERT INTO 
			BOARD_LOG(
				ACTION_TYPE, USER_ID, BOARD_NO, 
				BEFORE_TITLE, BEFORE_CONTENT)
		VALUES('DELETE', V_USER_ID, :OLD.BNO, 
			:OLD.TITLE, :OLD.CONTENT);
	END IF;
END;

--게시판 테이블에 대한 트리거 테스트
INSERT INTO BOARD(BNO,TITLE, CONTENT, ID) 
VALUES(999999,'제목1','내용1','com.wikia.Prodder');
DELETE FROM BOARD WHERE BNO = 999999;
UPDATE BOARD SET TITLE = '제목2', CONTENT = '내용2' WHERE BNO = 999999;

SELECT * FROM BOARD_LOG;

-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-- 프로시저
-- sql 쿼리문으로 로직을 조합해서 사용하는 데이터베이스 코드
-- sql문과 제어문을 이용해서, 데이터를 검색, 삽입, 수정, 삭제를 할 수 있음
-- 결과를 외부로 전달할 수 있음
-- 하나의 트랜잭션 구성시 사용을 함.

-- 실습코드01
CREATE OR REPLACE PROCEDURE PROCEDURE_EX1
IS
	-- 변수 선언
	TEST_VAR VARCHAR2(100);

BEGIN
	-- 실행부
	TEST_VAR := 'HELLO WORLD';
	DBMS_OUTPUT.PUT_LINE(TEST_VAR);
END;


-- DBMS_OUTPUT을 활성화
SET SERVEROUTPUT ON;

-- 프로시저 실행되는 부분
BEGIN
	PROCEDURE_EX1;
END;

-- GPT 예제코드 :
CREATE OR REPLACE PROCEDURE calculate_sum (
    num1 IN NUMBER,  -- 첫 번째 입력값
    num2 IN NUMBER   -- 두 번째 입력값
) 
IS
    result NUMBER;   -- 합을 저장할 변수
BEGIN
    -- 두 입력값의 합을 계산하여 result에 저장
    result := num1 + num2;
    
    -- 결과 출력
    DBMS_OUTPUT.PUT_LINE('The sum of ' || num1 || ' and ' || num2 || ' is: ' || result);
END;

-- 실행
BEGIN
    calculate_sum(10, 20);  -- 두 숫자 10과 20의 합을 계산
END;


-- 매개변수가 있는 프로시저
-- 실습코드 02
CREATE OR REPLACE PROCEDURE PROCEDURE_EX2(
    V_PID IN VARCHAR2,  -- 사람의 ID를 입력받는 매개변수
    V_PNAME IN VARCHAR2, -- 사람의 이름을 입력받는 매개변수
    V_AGE IN NUMBER -- 사람의 나이를 입력받는 매개변수
)
IS
    TEST_VAR VARCHAR2(100); -- 내부적으로 사용할 문자열 변수
BEGIN
    -- 테스트용 변수에 값 할당
    TEST_VAR := 'HELLO WORLD';

    -- 입력받은 매개변수를 출력
    DBMS_OUTPUT.PUT_LINE(V_PID || ' ' || V_PNAME || ' ' || V_AGE);

    -- PERSON 테이블에 입력받은 값 삽입
    INSERT INTO PERSON VALUES(V_PID, V_PNAME, V_AGE);

    -- 데이터 삽입 후 커밋, 데이터베이스에 영구 반영
    COMMIT; 
EXCEPTION
    -- 예외 처리: 모든 예외를 잡아내어 오류 메시지 출력 후 롤백 수행
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR');  -- 오류 메시지 출력
        ROLLBACK; -- 문제가 발생하면 모든 변경사항을 롤백
END;

-- 실행
BEGIN
	PROCEDURE_EX2('0004', '김씨', 50);
END;

-- 수정
UPDATE PERSON
SET PID = '0006'
WHERE PID = '0004';
COMMIT;

-- 프로시저 ; OUT
-- 값을 외부로 전달하는 프로시저
CREATE OR REPLACE PROCEDURE PROCEDURE_EX3(
    NUM IN NUMBER,    -- 입력값: 팩토리얼을 계산할 숫자
    RESULT OUT NUMBER -- OUT 매개변수: 팩토리얼 계산 결과를 반환
)
IS
    FACT NUMBER := 1; -- 팩토리얼 값을 계산할 변수
    I NUMBER;         -- 반복문에 사용할 변수
BEGIN
    -- 팩토리얼 계산 (1부터 NUM까지 곱함)
    IF NUM < 0 THEN
        RESULT := NULL;  -- 음수일 경우 팩토리얼을 계산할 수 없으므로 NULL 반환
    ELSE
        FOR I IN 1..NUM LOOP
            FACT := FACT * I;
        END LOOP;
        RESULT := FACT;  -- 계산한 팩토리얼 값을 RESULT에 저장
    END IF;
END;

-- 실행
DECLARE
    FACT_RESULT NUMBER;  -- 팩토리얼 결과를 저장할 변수
BEGIN
    -- NUM이 5인 경우 팩토리얼 계산
    PROCEDURE_EX3(5, FACT_RESULT);
    
    -- 팩토리얼 결과 출력
    DBMS_OUTPUT.PUT_LINE('The factorial of 5 is: ' || FACT_RESULT);
END;

-- 강사답
CREATE OR REPLACE PROCEDURE PROCEDURE_EX3(
	NUM IN NUMBER,
	RESULT OUT NUMBER)
IS
	I NUMBER;
	USER_EXCEPTION EXCEPTION;
BEGIN
	IF NUM <= 0 THEN
		RAISE USER_EXCEPTION;
	END IF;
	--반복문 이용해서 1~NUM까지 곱하는 팩토리얼 계산
	--결과 값을 RESULT에 저장
	RESULT := 1;
	FOR I IN 1 .. NUM
	LOOP
		RESULT := RESULT * I;
	END LOOP;
EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('숫자는 0보다 커야합니다.');
		RESULT := -1;
END;

-- 실행
DECLARE
	FAC NUMBER;
BEGIN
	PROCEDURE_EX3(5, FAC);
	DBMS_OUTPUT.PUT_LINE(FAC);
END;