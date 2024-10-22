CREATE TABLE `board_member` (
	`id`	VARCHAR2(50)	NOT NULL,
	`password`	CHAR(128)	NOT NULL,
	`username`	VARCHAR2(50)	NOT NULL,
	`nickname`	VARCHAR2(50)	NOT NULL
);

CREATE TABLE `board` (
	`bno`	NUMBER	NOT NULL,
	`id`	VARCHAR2(50)	NOT NULL,
	`title`	varchar2(150)	NOT NULL,
	`bcontent`	clob	NOT NULL,
	`write_date`	date	NOT NULL	DEFAULT sysdate,
	`write_update_date`	date	NOT NULL	DEFAULT sysdate,
	`bcount`	number	NULL	DEFAULT 0
);

CREATE TABLE `board_like` (
	`bno2`	NUMBER	NOT NULL,
	`id`	VARCHAR2(50)	NOT NULL
);

CREATE TABLE `board_file` (
	`fno`	char(10)	NOT NULL,
	`id`	VARCHAR2(50)	NOT NULL,
	`id2`	VARCHAR2(50)	NOT NULL,
	`fpath`	varchar2(256)	NULL,
	`fname`	varchar2(50)	NULL,
	`update_date`	date	NULL
);

CREATE TABLE `comment` (
	`cno`	number	NOT NULL,
	`bno`	NUMBER	NOT NULL,
	`id2`	VARCHAR2(50)	NOT NULL,
	`ccontent`	varchar2(1000)	NULL,
	`cdate`	date	NULL	DEFAULT sysdate
);

CREATE TABLE `board_dislike` (
	`id3`	VARCHAR2(50)	NOT NULL,
	`bno`	NUMBER	NOT NULL
);

CREATE TABLE `board_comment_like` (
	`cno`	number	NOT NULL,
	`id`	VARCHAR2(50)	NOT NULL
);

CREATE TABLE `borad_comment_dislike` (
	`cno`	number	NOT NULL,
	`id`	VARCHAR2(50)	NOT NULL
);

ALTER TABLE `board_member` ADD CONSTRAINT `PK_BOARD_MEMBER` PRIMARY KEY (
	`id`
);

ALTER TABLE `board` ADD CONSTRAINT `PK_BOARD` PRIMARY KEY (
	`bno`,
	`id`
);

ALTER TABLE `board_like` ADD CONSTRAINT `PK_BOARD_LIKE` PRIMARY KEY (
	`bno2`,
	`id`
);

ALTER TABLE `board_file` ADD CONSTRAINT `PK_BOARD_FILE` PRIMARY KEY (
	`fno`,
	`id`,
	`id2`
);

ALTER TABLE `comment` ADD CONSTRAINT `PK_COMMENT` PRIMARY KEY (
	`cno`,
	`bno`,
	`id2`
);

ALTER TABLE `board_dislike` ADD CONSTRAINT `PK_BOARD_DISLIKE` PRIMARY KEY (
	`id3`,
	`bno`
);

ALTER TABLE `board_comment_like` ADD CONSTRAINT `PK_BOARD_COMMENT_LIKE` PRIMARY KEY (
	`cno`,
	`id`
);

ALTER TABLE `borad_comment_dislike` ADD CONSTRAINT `PK_BORAD_COMMENT_DISLIKE` PRIMARY KEY (
	`cno`,
	`id`
);

ALTER TABLE `board` ADD CONSTRAINT `FK_board_member_TO_board_1` FOREIGN KEY (
	`id`
)
REFERENCES `board_member` (
	`id`
);

ALTER TABLE `board_like` ADD CONSTRAINT `FK_board_TO_board_like_1` FOREIGN KEY (
	`bno2`
)
REFERENCES `board` (
	`bno`
);

ALTER TABLE `board_like` ADD CONSTRAINT `FK_board_member_TO_board_like_1` FOREIGN KEY (
	`id`
)
REFERENCES `board_member` (
	`id`
);

ALTER TABLE `board_file` ADD CONSTRAINT `FK_board_TO_board_file_1` FOREIGN KEY (
	`id`
)
REFERENCES `board` (
	`id`
);

ALTER TABLE `board_file` ADD CONSTRAINT `FK_board_member_TO_board_file_1` FOREIGN KEY (
	`id2`
)
REFERENCES `board_member` (
	`id`
);

ALTER TABLE `comment` ADD CONSTRAINT `FK_board_TO_comment_1` FOREIGN KEY (
	`bno`
)
REFERENCES `board` (
	`bno`
);

ALTER TABLE `comment` ADD CONSTRAINT `FK_board_member_TO_comment_1` FOREIGN KEY (
	`id2`
)
REFERENCES `board_member` (
	`id`
);

ALTER TABLE `board_dislike` ADD CONSTRAINT `FK_board_member_TO_board_dislike_1` FOREIGN KEY (
	`id3`
)
REFERENCES `board_member` (
	`id`
);

ALTER TABLE `board_dislike` ADD CONSTRAINT `FK_board_TO_board_dislike_1` FOREIGN KEY (
	`bno`
)
REFERENCES `board` (
	`bno`
);

ALTER TABLE `board_comment_like` ADD CONSTRAINT `FK_comment_TO_board_comment_like_1` FOREIGN KEY (
	`cno`
)
REFERENCES `comment` (
	`cno`
);

ALTER TABLE `board_comment_like` ADD CONSTRAINT `FK_board_member_TO_board_comment_like_1` FOREIGN KEY (
	`id`
)
REFERENCES `board_member` (
	`id`
);

ALTER TABLE `borad_comment_dislike` ADD CONSTRAINT `FK_comment_TO_borad_comment_dislike_1` FOREIGN KEY (
	`cno`
)
REFERENCES `comment` (
	`cno`
);

ALTER TABLE `borad_comment_dislike` ADD CONSTRAINT `FK_board_member_TO_borad_comment_dislike_1` FOREIGN KEY (
	`id`
)
REFERENCES `board_member` (
	`id`
);

