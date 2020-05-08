use AGENT_DB;

-- DROP TABLE TBL_CF_AGT_CODE;
CREATE TABLE TBL_CF_AGT_CODE
(
	CODE_CLASS		VARCHAR(32) NOT NULL,
	CODE_ID			VARCHAR(32) NOT NULL,
	CODE_NAME		VARCHAR(80) NOT NULL,
	CODE_VALUE		VARCHAR(128),
	DISP_NO			decimal(3,0)
) ;
ALTER TABLE TBL_CF_AGT_CODE ADD CONSTRAINT PK_TBL_CF_AGT_CODE PRIMARY KEY ( CODE_CLASS,CODE_ID );


-- DROP TABLE TBL_CF_AGT_USER;
CREATE TABLE TBL_CF_AGT_USER
(
  USER_ID	VARCHAR(50) NOT NULL,
  USER_PWD	VARCHAR(256) NOT NULL,
  USER_NAME	VARCHAR(128) NOT NULL,
  CREATE_DATE	VARCHAR(16) default DATE_FORMAT(now(),'%Y%m%d%H%i%s'),
  LOGIN_DATE	VARCHAR(16),
  LOGOUT_DATE	VARCHAR(16),
  LOGIN_STS	decimal(3,0) default 0,
  USED		decimal(3,0) default 1
);
ALTER TABLE TBL_CF_AGT_USER ADD CONSTRAINT PK_TBL_CF_AGT_USER PRIMARY KEY ( USER_ID );


-- DROP TABLE TBL_SEND_SMS;
CREATE TABLE TBL_SEND_SMS
(
  MSG_KEY		decimal(10,0) 	NOT NULL,
  CALLER_NO		VARCHAR(32)	NOT NULL,
  CALLEE_NO		VARCHAR(32)	NOT NULL,
  CALLBACK_NO		VARCHAR(32)	NOT NULL,
  SMS_MSG		VARCHAR(256)	NOT NULL,
  ORDER_FLAG		decimal(3,0) 	default 0,
  READ_REPLY_FLAG	decimal(3,0) 	default 1,
  SAVE_DT		VARCHAR(16)	default DATE_FORMAT(now(),'%Y%m%d%H%i%s'),
  RESERVATION_DT		VARCHAR(16) 	default DATE_FORMAT(now(),'%Y%m%d%H%i%s'),
  WORKER_DT		VARCHAR(16),
  DELIVERY_DT		VARCHAR(16),
  REPORT_DT		VARCHAR(16),
  READ_REPLY_DT		VARCHAR(16),
  PROC_STS		decimal(3,0)  	default 0,
  SEND_COUNT		decimal(3,0) 	default 0,
  PROC_RESULT		decimal(5,0) 	default 0,
  RESULT_MSG		VARCHAR(128),
  ERROR_CODE		VARCHAR(16),
  ERROR_DESCRIPTION	VARCHAR(256),
  USER_VAR1		VARCHAR(80),
  USER_VAR2		VARCHAR(80),
  USER_VAR3		VARCHAR(80),
  USER_VAR4		VARCHAR(80),
  USER_VAR5		VARCHAR(80),
  USER_VAR6		VARCHAR(80),
  USER_VAR7		VARCHAR(80),
  USER_VAR8		VARCHAR(80),
  USER_VAR9		VARCHAR(80),
  USER_VAR10		VARCHAR(80),
  QUERYSESSIONKEY	VARCHAR(64),
  TRANSACTIONID		VARCHAR(128)
);
ALTER TABLE TBL_SEND_SMS ADD CONSTRAINT PK_TBL_SEND_SMS PRIMARY KEY ( MSG_KEY );
ALTER TABLE TBL_SEND_SMS ADD INDEX IX_TBL_SEND_SMS_RPT_KEY ( QUERYSESSIONKEY );

-- DROP TABLE TBL_HIST_SMS;
CREATE TABLE TBL_HIST_SMS
(
  MSG_KEY		decimal(10,0) 	NOT NULL,
  CALLER_NO		VARCHAR(32)	NOT NULL,
  CALLEE_NO		VARCHAR(32)	NOT NULL,
  CALLBACK_NO		VARCHAR(32)	NOT NULL,
  SMS_MSG		VARCHAR(256)	NOT NULL,
  ORDER_FLAG		decimal(3,0) 	default 0,
  READ_REPLY_FLAG	decimal(3,0) 	default 1,
  SAVE_DT		VARCHAR(16)	default DATE_FORMAT(now(),'%Y%m%d%H%i%s'),
  RESERVATION_DT		VARCHAR(16) 	default DATE_FORMAT(now(),'%Y%m%d%H%i%s'),
  WORKER_DT		VARCHAR(16),
  DELIVERY_DT		VARCHAR(16),
  REPORT_DT		VARCHAR(16),
  READ_REPLY_DT		VARCHAR(16),
  PROC_STS		decimal(3,0)  	default 0,
  SEND_COUNT		decimal(3,0) 	default 0,
  PROC_RESULT		decimal(5,0) 	default 0,
  RESULT_MSG		VARCHAR(128),
  ERROR_CODE		VARCHAR(16),
  ERROR_DESCRIPTION	VARCHAR(256),
  USER_VAR1		VARCHAR(80),
  USER_VAR2		VARCHAR(80),
  USER_VAR3		VARCHAR(80),
  USER_VAR4		VARCHAR(80),
  USER_VAR5		VARCHAR(80),
  USER_VAR6		VARCHAR(80),
  USER_VAR7		VARCHAR(80),
  USER_VAR8		VARCHAR(80),
  USER_VAR9		VARCHAR(80),
  USER_VAR10		VARCHAR(80),
  QUERYSESSIONKEY	VARCHAR(64),
  TRANSACTIONID		VARCHAR(128)
);
ALTER TABLE TBL_HIST_SMS ADD CONSTRAINT PK_TBL_HIST_SMS PRIMARY KEY ( RESERVATION_DT,MSG_KEY );
ALTER TABLE TBL_HIST_SMS ADD INDEX IX_TBL_HIST_SMS_TERM ( CALLEE_NO,RESERVATION_DT );



-- DROP TABLE TBL_SEND_LMS;
CREATE TABLE TBL_SEND_LMS
(
  MSG_KEY		decimal(10,0) 	NOT NULL,
  CALLER_NO		VARCHAR(32)	NOT NULL,
  CALLEE_NO		VARCHAR(32)	NOT NULL,
  CALLBACK_NO		VARCHAR(32)	NOT NULL,
  SUBJECT		VARCHAR(128)	NOT NULL,
  SMS_MSG		VARCHAR(4000)	NOT NULL,
  ORDER_FLAG		decimal(3,0) 	default 0,
  READ_REPLY_FLAG	decimal(3,0) 	default 1,
  SAVE_DT		VARCHAR(16)	default DATE_FORMAT(now(),'%Y%m%d%H%i%s'),
  RESERVATION_DT		VARCHAR(16) 	default DATE_FORMAT(now(),'%Y%m%d%H%i%s'),
  WORKER_DT		VARCHAR(16),
  DELIVERY_DT		VARCHAR(16),
  REPORT_DT		VARCHAR(16),
  READ_REPLY_DT		VARCHAR(16),
  PROC_STS		decimal(3,0)  	default 0,
  SEND_COUNT		decimal(3,0) 	default 0,
  PROC_RESULT		decimal(5,0) 	default 0,
  RESULT_MSG		VARCHAR(128),
  ERROR_CODE		VARCHAR(16),
  ERROR_DESCRIPTION	VARCHAR(256),
  USER_VAR1		VARCHAR(80),
  USER_VAR2		VARCHAR(80),
  USER_VAR3		VARCHAR(80),
  USER_VAR4		VARCHAR(80),
  USER_VAR5		VARCHAR(80),
  USER_VAR6		VARCHAR(80),
  USER_VAR7		VARCHAR(80),
  USER_VAR8		VARCHAR(80),
  USER_VAR9		VARCHAR(80),
  USER_VAR10		VARCHAR(80),
  QUERYSESSIONKEY	VARCHAR(64),
  TRANSACTIONID		VARCHAR(128)
);
ALTER TABLE TBL_SEND_LMS ADD CONSTRAINT PK_TBL_SEND_LMS PRIMARY KEY ( MSG_KEY );
ALTER TABLE TBL_SEND_LMS ADD INDEX IX_TBL_SEND_LMS_RPT_KEY ( QUERYSESSIONKEY );

-- DROP TABLE TBL_HIST_LMS;
CREATE TABLE TBL_HIST_LMS
(
  MSG_KEY		decimal(10,0) 	NOT NULL,
  CALLER_NO		VARCHAR(32)	NOT NULL,
  CALLEE_NO		VARCHAR(32)	NOT NULL,
  CALLBACK_NO		VARCHAR(32)	NOT NULL,
  SUBJECT		VARCHAR(128)	NOT NULL,
  SMS_MSG		VARCHAR(4000)	NOT NULL,
  ORDER_FLAG		decimal(3,0) 	default 0,
  READ_REPLY_FLAG	decimal(3,0) 	default 1,
  SAVE_DT		VARCHAR(16)	default DATE_FORMAT(now(),'%Y%m%d%H%i%s'),
  RESERVATION_DT		VARCHAR(16) 	default DATE_FORMAT(now(),'%Y%m%d%H%i%s'),
  WORKER_DT		VARCHAR(16),
  DELIVERY_DT		VARCHAR(16),
  REPORT_DT		VARCHAR(16),
  READ_REPLY_DT		VARCHAR(16),
  PROC_STS		decimal(3,0)  	default 0,
  SEND_COUNT		decimal(3,0) 	default 0,
  PROC_RESULT		decimal(5,0) 	default 0,
  RESULT_MSG		VARCHAR(128),
  ERROR_CODE		VARCHAR(16),
  ERROR_DESCRIPTION	VARCHAR(256),
  USER_VAR1		VARCHAR(80),
  USER_VAR2		VARCHAR(80),
  USER_VAR3		VARCHAR(80),
  USER_VAR4		VARCHAR(80),
  USER_VAR5		VARCHAR(80),
  USER_VAR6		VARCHAR(80),
  USER_VAR7		VARCHAR(80),
  USER_VAR8		VARCHAR(80),
  USER_VAR9		VARCHAR(80),
  USER_VAR10		VARCHAR(80),
  QUERYSESSIONKEY	VARCHAR(64),
  TRANSACTIONID		VARCHAR(128)
);
ALTER TABLE TBL_HIST_LMS ADD CONSTRAINT PK_TBL_HIST_LMS PRIMARY KEY ( RESERVATION_DT,MSG_KEY );
ALTER TABLE TBL_HIST_LMS ADD INDEX IX_TBL_HIST_LMS_TERM ( CALLEE_NO,RESERVATION_DT );





-- DROP TABLE TBL_SEND_MMS;
CREATE TABLE TBL_SEND_MMS
(
  MSG_KEY		decimal(10,0) 	NOT NULL,
  CALLER_NO		VARCHAR(32)	NOT NULL,
  CALLEE_NO		VARCHAR(32)	NOT NULL,
  CALLBACK_NO		VARCHAR(32)	NOT NULL,
  SUBJECT		VARCHAR(128)	NOT NULL,
  SMS_MSG		VARCHAR(4000)	NOT NULL,
  FILE_NAME		VARCHAR(4000)	NOT NULL,
  ORDER_FLAG		decimal(3,0) 	default 0,
  READ_REPLY_FLAG	decimal(3,0) 	default 1,
  SAVE_DT		VARCHAR(16)	default DATE_FORMAT(now(),'%Y%m%d%H%i%s'),
  RESERVATION_DT		VARCHAR(16) 	default DATE_FORMAT(now(),'%Y%m%d%H%i%s'),
  WORKER_DT		VARCHAR(16),
  DELIVERY_DT		VARCHAR(16),
  REPORT_DT		VARCHAR(16),
  READ_REPLY_DT		VARCHAR(16),
  PROC_STS		decimal(3,0)  	default 0,
  SEND_COUNT		decimal(3,0) 	default 0,
  PROC_RESULT		decimal(5,0) 	default 0,
  RESULT_MSG		VARCHAR(128),
  ERROR_CODE		VARCHAR(16),
  ERROR_DESCRIPTION	VARCHAR(256),
  USER_VAR1		VARCHAR(80),
  USER_VAR2		VARCHAR(80),
  USER_VAR3		VARCHAR(80),
  USER_VAR4		VARCHAR(80),
  USER_VAR5		VARCHAR(80),
  USER_VAR6		VARCHAR(80),
  USER_VAR7		VARCHAR(80),
  USER_VAR8		VARCHAR(80),
  USER_VAR9		VARCHAR(80),
  USER_VAR10		VARCHAR(80),
  QUERYSESSIONKEY	VARCHAR(64),
  TRANSACTIONID		VARCHAR(128)
);
ALTER TABLE TBL_SEND_MMS ADD CONSTRAINT PK_TBL_SEND_LMS PRIMARY KEY ( MSG_KEY );
ALTER TABLE TBL_SEND_MMS ADD INDEX IX_TBL_SEND_MMS_RPT_KEY ( QUERYSESSIONKEY );

-- DROP TABLE TBL_HIST_MMS;
CREATE TABLE TBL_HIST_MMS
(
  MSG_KEY		decimal(10,0) 	NOT NULL,
  CALLER_NO		VARCHAR(32)	NOT NULL,
  CALLEE_NO		VARCHAR(32)	NOT NULL,
  CALLBACK_NO		VARCHAR(32)	NOT NULL,
  SUBJECT		VARCHAR(128)	NOT NULL,
  SMS_MSG		VARCHAR(4000)	NOT NULL,
  FILE_NAME		VARCHAR(4000)	NOT NULL,
  ORDER_FLAG		decimal(3,0) 	default 0,
  READ_REPLY_FLAG	decimal(3,0) 	default 1,
  SAVE_DT		VARCHAR(16)	default DATE_FORMAT(now(),'%Y%m%d%H%i%s'),
  RESERVATION_DT		VARCHAR(16) 	default DATE_FORMAT(now(),'%Y%m%d%H%i%s'),
  WORKER_DT		VARCHAR(16),
  DELIVERY_DT		VARCHAR(16),
  REPORT_DT		VARCHAR(16),
  READ_REPLY_DT		VARCHAR(16),
  PROC_STS		decimal(3,0)  	default 0,
  SEND_COUNT		decimal(3,0) 	default 0,
  PROC_RESULT		decimal(5,0) 	default 0,
  RESULT_MSG		VARCHAR(128),
  ERROR_CODE		VARCHAR(16),
  ERROR_DESCRIPTION	VARCHAR(256),
  USER_VAR1		VARCHAR(80),
  USER_VAR2		VARCHAR(80),
  USER_VAR3		VARCHAR(80),
  USER_VAR4		VARCHAR(80),
  USER_VAR5		VARCHAR(80),
  USER_VAR6		VARCHAR(80),
  USER_VAR7		VARCHAR(80),
  USER_VAR8		VARCHAR(80),
  USER_VAR9		VARCHAR(80),
  USER_VAR10		VARCHAR(80),
  QUERYSESSIONKEY	VARCHAR(64),
  TRANSACTIONID		VARCHAR(128)
);
ALTER TABLE TBL_HIST_MMS ADD CONSTRAINT PK_TBL_HIST_MMS PRIMARY KEY ( RESERVATION_DT,MSG_KEY );
ALTER TABLE TBL_HIST_MMS ADD INDEX IX_TBL_HIST_MMS_TERM ( CALLEE_NO,RESERVATION_DT );




