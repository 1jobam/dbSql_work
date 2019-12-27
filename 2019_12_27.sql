-- �����ͺ��̽� ���� �ǽ�
/* �Խ��� */
DROP TABLE boardMaster 
	CASCADE CONSTRAINTS;

/* ����� */
DROP TABLE users 
	CASCADE CONSTRAINTS;

/* �Խñ� */
DROP TABLE board 
	CASCADE CONSTRAINTS;

/* ��� */
DROP TABLE reply 
	CASCADE CONSTRAINTS;

/* ÷������ */
DROP TABLE attachfile 
	CASCADE CONSTRAINTS;

/* �Խ��� ������ */
DROP SEQUENCE seq_boardMaster;

/* �Խñ� ������ */
DROP SEQUENCE seq_board;

/* ��� ������ */
DROP SEQUENCE seq_reply;

/* ÷������ ������ */
DROP SEQUENCE seq_attachfile;

/* �Խ��� ������ */
CREATE SEQUENCE seq_boardMaster;

/* �Խñ� ������ */
CREATE SEQUENCE seq_board;

/* ��� ������ */
CREATE SEQUENCE seq_reply;

/* ÷������ ������ */
CREATE SEQUENCE seq_attachfile;

/* �Խ��� */
CREATE TABLE boardMaster (
	id NUMBER NOT NULL, /* �Խ���ID */
	nm VARCHAR2(150) NOT NULL, /* �Խ����̸� */
	ac_yn VARCHAR2(1) DEFAULT 'Y' NOT NULL, /* Ȱ������ */
	reg_id VARCHAR2(20) NOT NULL, /* �ۼ��� */
	reg_dt DATE NOT NULL /* �ۼ��Ͻ� */
);

COMMENT ON TABLE boardMaster IS '�Խ���';

COMMENT ON COLUMN boardMaster.id IS '�Խ���ID';

COMMENT ON COLUMN boardMaster.nm IS '�Խ����̸�';

COMMENT ON COLUMN boardMaster.ac_yn IS 'Ȱ������';

COMMENT ON COLUMN boardMaster.reg_id IS '�ۼ���';

COMMENT ON COLUMN boardMaster.reg_dt IS '�ۼ��Ͻ�';

CREATE UNIQUE INDEX PK_boardMaster
	ON boardMaster (
		id ASC
	);

ALTER TABLE boardMaster
	ADD
		CONSTRAINT PK_boardMaster
		PRIMARY KEY (
			id
		);

/* ����� */
CREATE TABLE users (
	userid VARCHAR2(20) NOT NULL, /* ����ھ��̵� */
	pass VARCHAR2(20), /* ��й�ȣ */
	usernm VARCHAR2(20), /* ������̸� */
	alias VARCHAR2(20) /* ���� */
);

COMMENT ON TABLE users IS '�����';

COMMENT ON COLUMN users.userid IS '����ھ��̵�';

COMMENT ON COLUMN users.pass IS '��й�ȣ';

COMMENT ON COLUMN users.usernm IS '������̸�';

COMMENT ON COLUMN users.alias IS '����';

CREATE UNIQUE INDEX PK_users
	ON users (
		userid ASC
	);

ALTER TABLE users
	ADD
		CONSTRAINT PK_users
		PRIMARY KEY (
			userid
		);

/* �Խñ� */
CREATE TABLE board (
	id NUMBER NOT NULL, /* �Խñ�ID */
	bm_id NUMBER NOT NULL, /* �Խ���ID */
	p_id NUMBER, /* �θ�Խñ۹�ȣ */
	title VARCHAR2(300) NOT NULL, /* ���� */
	cont CLOB NOT NULL, /* ���� */
	del_yn VARCHAR2(1) DEFAULT 'Y' NOT NULL, /* �������� */
	reg_id VARCHAR2(20) NOT NULL, /* �ۼ��� */
	reg_dt DATE NOT NULL /* �ۼ��Ͻ� */
);

COMMENT ON TABLE board IS '�Խñ�';

COMMENT ON COLUMN board.id IS '�Խñ�ID';

COMMENT ON COLUMN board.bm_id IS '�Խ���ID';

COMMENT ON COLUMN board.p_id IS '�θ�Խñ۹�ȣ';

COMMENT ON COLUMN board.title IS '����';

COMMENT ON COLUMN board.cont IS '����';

COMMENT ON COLUMN board.del_yn IS '��������';

COMMENT ON COLUMN board.reg_id IS '�ۼ���';

COMMENT ON COLUMN board.reg_dt IS '�ۼ��Ͻ�';

CREATE UNIQUE INDEX PK_board
	ON board (
		id ASC
	);

ALTER TABLE board
	ADD
		CONSTRAINT PK_board
		PRIMARY KEY (
			id
		);

/* ��� */
CREATE TABLE reply (
	id NUMBER NOT NULL, /* ���ID */
	b_id NUMBER NOT NULL, /* �Խñ�ID */
	cont VARCHAR2(1500) NOT NULL, /* ���� */
	userid VARCHAR2(20) NOT NULL, /* �ۼ��� */
	reg_dt DATE NOT NULL /* �ۼ��Ͻ� */
);

COMMENT ON TABLE reply IS '���';

COMMENT ON COLUMN reply.id IS '���ID';

COMMENT ON COLUMN reply.b_id IS '�Խñ�ID';

COMMENT ON COLUMN reply.cont IS '����';

COMMENT ON COLUMN reply.userid IS '�ۼ���';

COMMENT ON COLUMN reply.reg_dt IS '�ۼ��Ͻ�';

CREATE UNIQUE INDEX PK_reply
	ON reply (
		id ASC
	);

ALTER TABLE reply
	ADD
		CONSTRAINT PK_reply
		PRIMARY KEY (
			id
		);

/* ÷������ */
CREATE TABLE attachfile (
	id NUMBER NOT NULL, /* ÷������ID */
	b_id NUMBER NOT NULL, /* �Խñ�ID */
	nm VARCHAR2(500) NOT NULL /* ÷�����ϸ� */
);

COMMENT ON TABLE attachfile IS '÷������';

COMMENT ON COLUMN attachfile.id IS '÷������ID';

COMMENT ON COLUMN attachfile.b_id IS '�Խñ�ID';

COMMENT ON COLUMN attachfile.nm IS '÷�����ϸ�';

CREATE UNIQUE INDEX PK_attachfile
	ON attachfile (
		id ASC
	);

ALTER TABLE attachfile
	ADD
		CONSTRAINT PK_attachfile
		PRIMARY KEY (
			id
		);

ALTER TABLE boardMaster
	ADD
		CONSTRAINT FK_users_TO_boardMaster
		FOREIGN KEY (
			reg_id
		)
		REFERENCES users (
			userid
		);

ALTER TABLE board
	ADD
		CONSTRAINT FK_users_TO_board
		FOREIGN KEY (
			reg_id
		)
		REFERENCES users (
			userid
		);

ALTER TABLE board
	ADD
		CONSTRAINT FK_boardMaster_TO_board
		FOREIGN KEY (
			bm_id
		)
		REFERENCES boardMaster (
			id
		);

ALTER TABLE board
	ADD
		CONSTRAINT FK_board_TO_board
		FOREIGN KEY (
			p_id
		)
		REFERENCES board (
			id
		);

ALTER TABLE reply
	ADD
		CONSTRAINT FK_users_TO_reply
		FOREIGN KEY (
			userid
		)
		REFERENCES users (
			userid
		);

ALTER TABLE reply
	ADD
		CONSTRAINT FK_board_TO_reply
		FOREIGN KEY (
			b_id
		)
		REFERENCES board (
			id
		);

ALTER TABLE attachfile
	ADD
		CONSTRAINT FK_board_TO_attachfile
		FOREIGN KEY (
			b_id
		)
		REFERENCES board (
			id
		);
        
        
        
-- java db ������Ʈ ����

-- Maven ����� ������Ʈ
-- Maven : ���α׷� (���� ����)

-- > 1. ���� (deploy)

-- java == web(������ ���󵵰� ����) (�ȵ���̵� - ������ ���󵵰� ����)
-- web / �ȵ���̵� -- ���� java�� ���帹�� ����ϴ� ȯ��

-- war Ȯ���ڷ� ����

-- > 2. ������Ʈ (project)
--  - ������Ʈ���� ���Ǵ� ���̺귯�� ����(jar) --> 2000��� �ʹݿ��� ���̺귯���� �����ϴ� �ѻ���� ����(PL)
--                                          --> ����� Maven�� ����Ͽ� ���̺귯���� ����
--      . �������� (ibatis 2.x - > mybatis 3.x)
--      . �ϳ��� ���̺귯���� �ٸ� ���̺귯���� �����ϰ� �ִ°��
--  - ������Ʈ�� ����ܰ� ����Ѱ�
--      . java ������(���� ��� ����) 
--      . ���ҽ�(���������� ���� properties, xml) ����
--      . ��� ������ ���������� �׽�Ʈ �� �� �ִ� java code ������
--         (���ߴܰ迡�� ����� ���ϵ�)
--      . �������� (jar(�ڹ� ��ī�̺�), war(�� ��ī�̺�), aar(�ȵ���̵� ��ī�̺�))
-- https://mvnrepository.com/