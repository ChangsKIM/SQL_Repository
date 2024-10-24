-- PL/SQL
-- 데이터 베이스에서 사용되는 절차적 언어
-- 프로시저, 함수, 트리거 등의 형태로 작성을 할 수 있음
-- 데이터 조작 및 비지니스 로직을 데이터베이스 내에서 직접 처리 할 수 있음

-- 함수
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


-- 실습문제01

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
----------------------------------------------

-- 실습문제 02

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


----------------------------------------------

-- 실습문제 03
-- 반복문
-----------------------------------------------------------------
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
-----------------------------------------------------------------
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
-----------------------------------------------------------------
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
-----------------------------------------------------------------

SELECT GET_TOTAL(1, 100) FROM DUAL;







