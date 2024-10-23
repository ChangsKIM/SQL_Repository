-- 01 테이블 생성 및 기본키, 외래키 설정
-- 회원 테이블
CREATE TABLE board_member (
    id VARCHAR2(50) ,          -- 회원 아이디
    password CHAR(128) ,       -- 암호
    username VARCHAR2(50) ,    -- 이름
    nickname VARCHAR2(50) ,    -- 닉네임
    PRIMARY KEY (id)                   -- 기본키 설정
);

-- 게시판 테이블
CREATE TABLE board (
    bno NUMBER ,               -- 글 번호
    id VARCHAR2(50) ,          -- 회원 아이디 (외래키)
    title VARCHAR2(150) ,      -- 목
    content CLOB ,             -- 내용
    write_date DATE DEFAULT SYSDATE,   -- 작성일
    write_update_date DATE DEFAULT SYSDATE, -- 수정일
    bcount NUMBER DEFAULT 0,           -- 조회수
    PRIMARY KEY (bno),                 -- 기본키 설정
    FOREIGN KEY (id) REFERENCES board_member(id) -- 회원 테이블 참조 (외래키)
);

-- 게시글 좋아요 테이블
CREATE TABLE board_content_like (
    bno NUMBER ,               -- 글 번호 (외래키)
    id VARCHAR2(50) ,          -- 회원 아이디 (외래키)
    PRIMARY KEY (bno, id),             -- 복합키 설정 (글 번호, 회원 아이디)
    FOREIGN KEY (bno) REFERENCES board(bno),  -- 게시판 테이블 참조
    FOREIGN KEY (id) REFERENCES board_member(id) -- 회원 테이블 참조
);

-- 게시글 싫어요 테이블
CREATE TABLE board_content_hate (
    bno NUMBER ,               -- 글 번호 (외래키)
    id VARCHAR2(50) ,          -- 회원 아이디 (외래키)
    PRIMARY KEY (bno, id),             -- 복합키 설정 (글 번호, 회원 아이디)
    FOREIGN KEY (bno) REFERENCES board(bno),  -- 게시판 테이블 참조
    FOREIGN KEY (id) REFERENCES board_member(id) -- 회원 테이블 참조
);

-- 댓글 테이블
CREATE TABLE board_comment (
    cno NUMBER,               -- 댓글 번호
    bno NUMBER ,               -- 글 번호 (외래키)
    id VARCHAR2(50) ,          -- 회원 아이디 (외래키)
    content VARCHAR2(1000) ,   -- 댓글 내용
    cdate DATE DEFAULT SYSDATE,        -- 댓글 작성일
    PRIMARY KEY (cno),                 -- 기본키 설정
    FOREIGN KEY (bno) REFERENCES board(bno),  -- 게시판 테이블 참조
    FOREIGN KEY (id) REFERENCES board_member(id) -- 회원 테이블 참조
);

-- 댓글 좋아요 테이블
CREATE TABLE board_comment_like (
    cno NUMBER ,               -- 댓글 번호 (외래키)
    id VARCHAR2(50),          -- 회원 아이디 (외래키)
    PRIMARY KEY (cno, id),             -- 복합키 설정 (댓글 번호, 회원 아이디)
    FOREIGN KEY (cno) REFERENCES board_comment(cno),  -- 댓글 테이블 참조
    FOREIGN KEY (id) REFERENCES board_member(id) -- 회원 테이블 참조
);

-- 댓글 싫어요 테이블
CREATE TABLE board_comment_hate (
    cno NUMBER ,               -- 댓글 번호 (외래키)
    id VARCHAR2(50) ,          -- 회원 아이디 (외래키)
    PRIMARY KEY (cno, id),             -- 복합키 설정 (댓글 번호, 회원 아이디)
    FOREIGN KEY (cno) REFERENCES board_comment(cno),  -- 댓글 테이블 참조
    FOREIGN KEY (id) REFERENCES board_member(id) -- 회원 테이블 참조
);

-- 첨부파일 테이블
CREATE TABLE board_file (
    fno CHAR(10) ,             -- 파일 번호
    bno NUMBER ,               -- 글 번호 (외래키)
    fpath VARCHAR2(256) ,          -- 파일 경로
    PRIMARY KEY (fno),                 -- 기본키 설정
    FOREIGN KEY (bno) REFERENCES board(bno) -- 게시판 테이블 참조
);


-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- 코드
-- 데이터를 효율적이고, 정확하게 처리하기 위해 부여하는 기호, 문자, 숫자 조합으로
-- 체계적으로 만든 값
-- ex) 바코드, isbn, 주민등록번호, 로트번호 등등..

-- 간결성, 일관성, 유연성, 명확성

-- 1. 순차(순서) 코드(sequence Code, 일련 번호 코드)
-- 		- 일정 기준에 따라 처음부터 차례로 일련번호를 부여한느 방법
-- 		- ex) 게시판 글번호, 키오스크 주문번호, 

-- 2. 블록코드(Block Code, 구분 코드)
--		- 공통성이 있는 항목들을 블록으로 구분해서 블록 내에서 일련번호를 부여하는 방법
-- 		- ex) 사원번호의 경우 입사년도 + 숫자범위
-- 		- 20241000 ~ 20241999 ; 2024년도에 입사한 총무부 직원
-- 		- 20242000 ~ 20242999 ; 2024년도에 입사한 개발부 직원 등등

-- 3. 10진 코드(Decimal Code)
-- 		- 0~9까지 10진 분할을 반복하여 세분화하는 방법
-- 		- ex) 학과 번호
-- 			1000 ; 공학
-- 			1200 ; 컴퓨터 공학
--			1300 ; 기계 공학
--			1210 ; 컴퓨터 인공지능 학과

-- 4. 그룹 분류 코드(Group Classification Code)
-- 		- 대분류, 중분류, 소분류 등으로 구분하고, 각 그룹내에서 일변련호를 부여하는 방법
--		- ex) isbn ; 국제 도서번호
--		-	  접두부(978/979) - 국제번호(89/11) - 발행자번호(5674) - 서명식별번호(901) - 체크기호(3) 
-- 				- 독자대상기호(1) - 발행형태기호(3) - 내용분류기호(000)

-- 5. 면상코드(Menmonic Code)
-- 		- 명칭이나 약어와 관련된 숫자나 문자, 기호를 이용하여 코드를 부여하는 방법
-- 		- ex) 24EA57VQ ; 24인치 LED 모니터로, 1920x1080 (FHD) 해상도, HDMI 및 DVI 단자 지원, 광시야각 등의 특징

-- 6. 표의 숫자코드(Significant Digit Code, 유효 숫자 코드)
-- 		- ex) 500-1200-500

-- 7. 합성 코드(Combined Code)
--		- 두가지 이상의 코드를 조합하여 만드는 방법
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------


-- 02. 시퀸스 생성
-- 게시글 번호 시퀸스 생성
CREATE SEQUENCE board_seq
START WITH 1
INCREMENT BY 1;

-- 댓글 번호 시퀸스 생성
CREATE SEQUENCE comment_seq
START WITH 1
INCREMENT BY 1;

-- 파일 번호 시퀸스 생성
CREATE SEQUENCE file_seq
START WITH 1
MINVALUE 1
MAXVALUE 9999999
INCREMENT BY 1
NOCYCLE;

SELECT * FROM USER_SEQUENCES;
SELECT * FROM BOARD;
SELECT * FROM BOARD_COMMENT; 

-- 03. 샘플 데이터 저장

-- 회원 데이터


-- 04. 암호화
SELECT standard_hash('암호화할 데이터', 'SHA512') FROM dual;
SELECT standard_hash('123456', 'SHA512') FROM dual;

-- 바이트 확인 LENGTHB
SELECT LENGTHB(standard_hash('암호화할 데이터', 'SHA512')) AS hash_length_in_bytes01
FROM dual;
SELECT LENGTHB(standard_hash('123^B6', 'SHA512')) AS hash_length_in_bytes02
FROM dual;

-- 다른 예 (바이트 크기)
SELECT LENGTHB(standard_hash('123^B6', 'SHA256')) AS hash_length_in_bytes02
FROM dual;
SELECT LENGTHB(standard_hash('123^B6', 'SHA1')) AS hash_length_in_bytes02
FROM dual;



SELECT 
	b.*, bm.NICKNAME	
FROM BOARD b 
JOIN BOARD_MEMBER bm on b.ID = bm.ID; 


-- 글번호, 제목, 작성자, 작성자 닉네임, 조회수, 작성일, 글내용, 좋아요, 싫어요
-- 글 번호별 좋아요 개수 조회

SELECT 
	bcl.BNO ,
	COUNT(*) AS clike
FROM BOARD_CONTENT_LIKE bcl 
GROUP BY bcl.BNO ;

SELECT
	bch.BNO ,
	COUNT(*) AS dislike
FROM BOARD_CONTENT_HATE bch
GROUP BY bch.BNO ;


--위에 SQL문을 기준으로 글번호 기준으로 내림차순 정렬
SELECT B.*, BM.NICKNAME, NVL(BLIKE,0) AS BLIKE , NVL(BHATE,0) AS BHATE
FROM BOARD B JOIN BOARD_MEMBER BM ON B.ID = BM.ID
LEFT OUTER JOIN (SELECT BNO, COUNT(*) AS BLIKE FROM BOARD_CONTENT_LIKE GROUP BY BNO) BL
ON BL.BNO = B.BNO
LEFT OUTER JOIN (SELECT BNO, COUNT(*) AS BHATE FROM BOARD_CONTENT_HATE GROUP BY BNO) BH
ON BH.BNO = B.BNO ORDER BY B.BNO DESC;



--뷰 생성
CREATE OR REPLACE VIEW BOARD_VIEW
AS
SELECT B.*, BM.NICKNAME, NVL(BLIKE,0) AS BLIKE , NVL(BHATE,0) AS BHATE
FROM BOARD B JOIN BOARD_MEMBER BM ON B.ID = BM.ID
LEFT OUTER JOIN (SELECT BNO, COUNT(*) AS BLIKE FROM BOARD_CONTENT_LIKE GROUP BY BNO) BL
ON BL.BNO = B.BNO
LEFT OUTER JOIN (SELECT BNO, COUNT(*) AS BHATE FROM BOARD_CONTENT_HATE GROUP BY BNO) BH
ON BH.BNO = B.BNO ORDER BY B.BNO DESC;

SELECT * FROM BOARD_VIEW;












