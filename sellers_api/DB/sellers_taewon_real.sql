-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: 222.96.66.21    Database: sellers
-- ------------------------------------------------------
-- Server version	5.7.17-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `anal_individual_time`
--

DROP TABLE IF EXISTS `anal_individual_time`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `anal_individual_time` (
  `ANAL_TIME_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '시간분석아이디',
  `MEMBER_ID_NUM` varchar(10) NOT NULL COMMENT '사번',
  `ANAL_DATE` date NOT NULL COMMENT '분석일자',
  `ANAL_BASIS_TIME` int(11) NOT NULL COMMENT '분석일기준시간',
  `ACTIVITY_CODE_1_TIME` decimal(6,1) DEFAULT NULL COMMENT '코드_1_시간',
  `ACTIVITY_CODE_2_TIME` decimal(6,1) DEFAULT NULL COMMENT '코드_2_시간',
  `ACTIVITY_CODE_3_TIME` decimal(6,1) DEFAULT NULL COMMENT '코드_3_시간',
  `ACTIVITY_CODE_4_TIME` decimal(6,1) DEFAULT NULL COMMENT '코드_4_시간',
  `ACTIVITY_CODE_5_TIME` decimal(6,1) DEFAULT NULL COMMENT '코드_5_시간',
  `ACTIVITY_CODE_6_TIME` decimal(6,1) DEFAULT NULL COMMENT '코드_6_시간',
  `ACTIVITY_CODE_7_TIME` decimal(6,1) DEFAULT NULL COMMENT '코드_7_시간',
  `ACTIVITY_CODE_11_TIME` decimal(6,1) DEFAULT NULL COMMENT '코드_8_시간',
  `ACTIVITY_CODE_12_TIME` decimal(6,1) DEFAULT NULL COMMENT '코드_9_시간',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  PRIMARY KEY (`ANAL_TIME_ID`),
  KEY `idx_ANAL_INDIVIDUAL_TIME_01` (`MEMBER_ID_NUM`,`ANAL_DATE`,`ANAL_BASIS_TIME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='생산성분석';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `biz_file_store`
--

DROP TABLE IF EXISTS `biz_file_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `biz_file_store` (
  `FILE_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '파일아이디',
  `BIZ_ID` bigint(20) unsigned NOT NULL COMMENT '사업전략아이디',
  `CREATOR_ID` varchar(20) NOT NULL COMMENT '작성자아이디',
  `CREATE_DATETIME` datetime NOT NULL COMMENT '작성일시',
  `FILE_NAME` varchar(128) NOT NULL COMMENT '파일명',
  `FILE_PATH` varchar(512) NOT NULL COMMENT '파일저장위치',
  `FILE_TYPE` varchar(10) DEFAULT NULL COMMENT '파일형식',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  PRIMARY KEY (`FILE_ID`),
  KEY `idx_BIZ_FILE_STORE_01` (`BIZ_ID`,`CREATOR_ID`,`CREATE_DATETIME`,`FILE_NAME`),
  CONSTRAINT `biz_file_store_ibfk_1` FOREIGN KEY (`BIZ_ID`) REFERENCES `biz_strategy` (`BIZ_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='사업전략_파일저장정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `biz_milestone`
--

DROP TABLE IF EXISTS `biz_milestone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `biz_milestone` (
  `MILESTONE_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '마일스톤아이디',
  `BIZ_ID` bigint(20) unsigned NOT NULL COMMENT '사업전략아이디',
  `Category` varchar(10) NOT NULL COMMENT '카테고리',
  `CREATOR_ID` varchar(20) NOT NULL COMMENT '작성자아이디',
  `CREATE_DATETIME` datetime NOT NULL COMMENT '작성일시',
  `KEY_MILESTONE` varchar(200) NOT NULL COMMENT '키마일스톤',
  `ACT_ID` varchar(20) NOT NULL COMMENT '실행담당자',
  `STATUS` varchar(10) NOT NULL COMMENT '상태',
  `ACT_DUE_DATE` date DEFAULT NULL COMMENT '실행기한일자',
  `ACT_CLOSE_DATE` date DEFAULT NULL COMMENT '실행완료일자',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  PRIMARY KEY (`MILESTONE_ID`),
  KEY `idx_BIZ_MILESTONE_01` (`BIZ_ID`,`Category`,`CREATOR_ID`,`CREATE_DATETIME`,`KEY_MILESTONE`),
  CONSTRAINT `biz_milestone_ibfk_1` FOREIGN KEY (`BIZ_ID`) REFERENCES `biz_strategy` (`BIZ_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='사업전략_마일스톤';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `biz_project_amount`
--

DROP TABLE IF EXISTS `biz_project_amount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `biz_project_amount` (
  `AMOUNT_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '개별금액아이디',
  `PROJECT_ID` bigint(20) unsigned NOT NULL COMMENT '프로젝트아이디',
  `CREATOR_ID` varchar(20) NOT NULL COMMENT '작성자아이디',
  `CREATE_DATETIME` datetime NOT NULL COMMENT '작성일시',
  `BASIS_MONTH` date DEFAULT NULL COMMENT '매출기준월',
  `BASIS_PLAN_REVENUE_AMOUNT` decimal(12,0) DEFAULT NULL COMMENT '계획매출금액',
  `BASIS_ACTUAL_REVENUE_AMOUNT` decimal(12,0) DEFAULT NULL COMMENT '실제매출금액',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `AMOUNT_TYPE` char(1) DEFAULT NULL COMMENT '추정금액_실제금액타입',
  PRIMARY KEY (`AMOUNT_ID`),
  KEY `idx_BIZ_PROJECT_AMOUNT_01` (`PROJECT_ID`,`CREATOR_ID`,`CREATE_DATETIME`,`BASIS_MONTH`),
  CONSTRAINT `biz_project_amount_ibfk_1` FOREIGN KEY (`PROJECT_ID`) REFERENCES `biz_project_plan` (`PROJECT_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='프로젝트_계약금액상세';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `biz_project_invest`
--

DROP TABLE IF EXISTS `biz_project_invest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `biz_project_invest` (
  `AMOUNT_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '개별금액아이디',
  `PROJECT_ID` bigint(20) unsigned NOT NULL COMMENT '프로젝트아이디',
  `CREATOR_ID` varchar(20) NOT NULL COMMENT '작성자아이디',
  `CREATE_DATETIME` datetime NOT NULL COMMENT '작성일시',
  `BASIS_MONTH` date DEFAULT NULL COMMENT '매출기준월',
  `BASIS_PLAN_INVEST_AMOUNT` decimal(12,0) DEFAULT NULL COMMENT '계획투자금액',
  `BASIS_ACTUAL_INVEST_AMOUNT` decimal(12,0) DEFAULT NULL COMMENT '실제투자금액',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `AMOUNT_TYPE` char(1) DEFAULT NULL COMMENT '금액타입(추정:p 실제:a)',
  PRIMARY KEY (`AMOUNT_ID`),
  KEY `idx_BIZ_PROJECT_INVEST_01` (`PROJECT_ID`,`CREATOR_ID`,`CREATE_DATETIME`,`BASIS_MONTH`),
  CONSTRAINT `biz_project_invest_ibfk_1` FOREIGN KEY (`PROJECT_ID`) REFERENCES `biz_project_plan` (`PROJECT_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='프로젝트_투자금액상세';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `biz_project_milestone`
--

DROP TABLE IF EXISTS `biz_project_milestone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `biz_project_milestone` (
  `MILESTONE_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '마일스톤아이디',
  `PROJECT_ID` bigint(20) unsigned NOT NULL COMMENT '프로젝트아이디',
  `Category` varchar(10) NOT NULL COMMENT '카테고리',
  `CREATOR_ID` varchar(20) NOT NULL COMMENT '작성자아이디',
  `CREATE_DATETIME` datetime NOT NULL COMMENT '작성일시',
  `KEY_MILESTONE` varchar(200) NOT NULL COMMENT '키마일스톤',
  `ACT_ID` varchar(20) NOT NULL COMMENT '실행담당자',
  `ACT_DUE_DATE` date DEFAULT NULL COMMENT '실행기한일자',
  `ACT_CLOSE_DATE` date DEFAULT NULL COMMENT '실행완료일자',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `STATUS` char(1) DEFAULT NULL COMMENT '상태',
  PRIMARY KEY (`MILESTONE_ID`),
  KEY `idx_BIZ_PROJECT_MILESTONE_01` (`PROJECT_ID`,`Category`,`CREATOR_ID`,`CREATE_DATETIME`,`KEY_MILESTONE`),
  CONSTRAINT `biz_project_milestone_ibfk_1` FOREIGN KEY (`PROJECT_ID`) REFERENCES `biz_project_plan` (`PROJECT_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='프로젝트_마일스톤';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `biz_project_plan`
--

DROP TABLE IF EXISTS `biz_project_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `biz_project_plan` (
  `PROJECT_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '프로젝트아이디',
  `CREATOR_ID` varchar(20) DEFAULT NULL COMMENT '작성자아이디',
  `CREATE_DATETIME` datetime DEFAULT NULL COMMENT '작성일시',
  `Category` varchar(10) DEFAULT NULL COMMENT '카테고리',
  `EXEC_OWNER` varchar(10) DEFAULT NULL COMMENT '실행책임자',
  `SALES_OWNER` varchar(10) DEFAULT NULL COMMENT '영업담당자',
  `CLIENT_NAME` varchar(10) DEFAULT NULL COMMENT '고객사명',
  `SUBJECT` varchar(200) DEFAULT NULL COMMENT '프로젝트제목',
  `DETAIL_CONTENTS` varchar(1024) DEFAULT NULL COMMENT '프로젝트상세내용',
  `START_DATE` date DEFAULT NULL COMMENT '시작일자',
  `END_DATE` date DEFAULT NULL COMMENT '종료일자',
  `CONTRACT_AMOUNT_TOTAL` decimal(12,0) DEFAULT NULL COMMENT '계약금액합계',
  `CONTRACT_AMOUNT_UNIT` char(1) DEFAULT NULL COMMENT '계약금액단위',
  `INVEST_AMOUNT` decimal(12,0) DEFAULT NULL COMMENT '투자금액합계',
  `INVEST_AMOUNT_UNIT` char(1) DEFAULT NULL COMMENT '투자금액단위',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `COMPANY_ID` bigint(20) unsigned DEFAULT NULL COMMENT '고객사아이디',
  PRIMARY KEY (`PROJECT_ID`),
  KEY `idx_BIZ_PROJECT_PLAN_01` (`CREATOR_ID`,`Category`,`CREATE_DATETIME`,`SUBJECT`,`SALES_OWNER`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='프로젝트계획';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `biz_project_plan_action_plan`
--

DROP TABLE IF EXISTS `biz_project_plan_action_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `biz_project_plan_action_plan` (
  `ACTION_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '액션플랜아이디',
  `PROJECT_ID` bigint(20) unsigned NOT NULL COMMENT '프로젝트아이디',
  `CREATOR_ID` varchar(20) NOT NULL COMMENT '작성자',
  `CREATE_DATETIME` datetime NOT NULL COMMENT '작성일시',
  `ISSUE_NAME` varchar(50) DEFAULT NULL COMMENT '이슈영역',
  `ISSUE_ITEM` varchar(100) DEFAULT NULL COMMENT '이슈아이템',
  `ACTION_PLAN_NAME` varchar(200) DEFAULT NULL COMMENT '액션플랜명',
  `ACTION_OWNER` varchar(20) DEFAULT NULL COMMENT '액션담당자',
  `DUE_DATE` date DEFAULT NULL COMMENT '완료예정일자',
  `CLOSE_DATE` date DEFAULT NULL COMMENT '실제완료일자',
  `STATUS` char(1) DEFAULT NULL COMMENT '액션플랜상태',
  `NOTE` varchar(400) DEFAULT NULL COMMENT '비고',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  PRIMARY KEY (`ACTION_ID`),
  KEY `idx_BIZ_PROJECT_PLAN_ACTION_PLAN_01` (`PROJECT_ID`,`CREATOR_ID`,`ISSUE_NAME`,`ACTION_PLAN_NAME`,`ACTION_OWNER`,`STATUS`),
  CONSTRAINT `biz_project_plan_action_plan_ibfk_1` FOREIGN KEY (`PROJECT_ID`) REFERENCES `biz_project_plan` (`PROJECT_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='전략프로젝트_액션플랜';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `biz_project_plan_file_store`
--

DROP TABLE IF EXISTS `biz_project_plan_file_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `biz_project_plan_file_store` (
  `FILE_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '파일아이디',
  `PROJECT_ID` bigint(20) unsigned NOT NULL COMMENT '프로젝트아이디',
  `CREATOR_ID` varchar(20) NOT NULL COMMENT '작성자아이디',
  `CREATE_DATETIME` datetime NOT NULL COMMENT '작성일시',
  `FILE_NAME` varchar(128) NOT NULL COMMENT '파일명',
  `FILE_PATH` varchar(512) NOT NULL COMMENT '파일저장위치',
  `FILE_TYPE` varchar(10) DEFAULT NULL COMMENT '파일형식',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  PRIMARY KEY (`FILE_ID`),
  KEY `idx_BIZ_PROJECT_PLAN_FILE_STORE_01` (`PROJECT_ID`,`CREATOR_ID`,`CREATE_DATETIME`,`FILE_NAME`),
  CONSTRAINT `biz_project_plan_file_store_ibfk_1` FOREIGN KEY (`PROJECT_ID`) REFERENCES `biz_project_plan` (`PROJECT_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='프로젝트계획_파일저장정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `biz_strategy`
--

DROP TABLE IF EXISTS `biz_strategy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `biz_strategy` (
  `BIZ_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '사업전략아이디',
  `Category` varchar(10) NOT NULL COMMENT '카테고리',
  `CREATOR_ID` varchar(20) NOT NULL COMMENT '작성자아이디',
  `CREATE_DATETIME` datetime NOT NULL COMMENT '작성일시',
  `SUBJECT` varchar(200) NOT NULL COMMENT '제목',
  `REVIEW_CYCLE` varchar(20) NOT NULL COMMENT '리뷰주기',
  `KEY_CONTENTS` text COMMENT '주요내용',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `RESPONSIBILITY_LEADER` varchar(20) DEFAULT NULL COMMENT '책임리더',
  PRIMARY KEY (`BIZ_ID`),
  KEY `idx_biz_strategy_01` (`Category`,`CREATOR_ID`,`CREATE_DATETIME`,`SUBJECT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='사업전략';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `biz_strategy_action_plan`
--

DROP TABLE IF EXISTS `biz_strategy_action_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `biz_strategy_action_plan` (
  `ACTION_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '액션플랜아이디',
  `BIZ_ID` bigint(20) unsigned NOT NULL COMMENT '사업전략아이디',
  `CREATOR_ID` varchar(20) NOT NULL COMMENT '작성자',
  `CREATE_DATETIME` datetime NOT NULL COMMENT '작성일시',
  `ISSUE_NAME` varchar(50) DEFAULT NULL COMMENT '이슈영역',
  `ISSUE_ITEM` varchar(100) DEFAULT NULL COMMENT '이슈아이템',
  `ACTION_PLAN_NAME` varchar(200) DEFAULT NULL COMMENT '액션플랜명',
  `ACTION_OWNER` varchar(20) DEFAULT NULL COMMENT '액션담당자',
  `DUE_DATE` date DEFAULT NULL COMMENT '완료예정일자',
  `CLOSE_DATE` date DEFAULT NULL COMMENT '실제완료일자',
  `STATUS` char(1) DEFAULT NULL COMMENT '액션플랜상태',
  `NOTE` varchar(400) DEFAULT NULL COMMENT '비고',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  PRIMARY KEY (`ACTION_ID`),
  KEY `idx_BIZ_STRATEGY_ACTION_PLAN_01` (`BIZ_ID`,`CREATOR_ID`,`ISSUE_NAME`,`ACTION_PLAN_NAME`,`ACTION_OWNER`,`STATUS`),
  CONSTRAINT `biz_strategy_action_plan_ibfk_1` FOREIGN KEY (`BIZ_ID`) REFERENCES `biz_strategy` (`BIZ_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='사업전략_액션플랜';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calendar_event`
--

DROP TABLE IF EXISTS `calendar_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calendar_event` (
  `EVENT_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '이벤트아이디',
  `CALENDAR_ID` bigint(20) unsigned NOT NULL COMMENT '캘린더아이디',
  `MEMBER_ID_NUM` varchar(10) NOT NULL COMMENT '사번',
  `EVENT_CODE` varchar(40) NOT NULL COMMENT '이벤트코드',
  `EVENT_SUBJECT` varchar(512) NOT NULL COMMENT '이벤트제목',
  `EVENT_DETAIL` varchar(1024) DEFAULT NULL COMMENT '이벤트내용',
  `ALLDAY_YN` char(1) DEFAULT 'N' COMMENT '종일일정여부',
  `START_DATETIME` datetime DEFAULT NULL COMMENT '시작시각',
  `END_DATETIME` datetime DEFAULT NULL COMMENT '종료시각',
  `BEFORE_MOVE_TIME` int(11) DEFAULT NULL COMMENT '미팅 전 이동소요시간',
  `REPEAT_YN` char(1) DEFAULT 'N' COMMENT '반복일정여부',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `LOCATION` varchar(40) DEFAULT NULL COMMENT '장소',
  `AFTER_MOVE_TIME` int(11) DEFAULT NULL COMMENT '미팅 후 이동소요시간',
  `SHARE_YN` char(1) DEFAULT NULL COMMENT '일정Sync여부',
  `ALARM_PERIOD` datetime DEFAULT NULL COMMENT '알림 주기',
  `ALARM_TARGET` varchar(10) DEFAULT NULL COMMENT '알람 구분(메일, 쪽지등)',
  `ALARM_FLAG` varchar(1) DEFAULT NULL COMMENT '한시간하루전등',
  `DELETE_YN` varchar(1) DEFAULT NULL COMMENT '삭제YN',
  PRIMARY KEY (`EVENT_ID`),
  KEY `idx_OCALENDAR_EVENT_01` (`CALENDAR_ID`,`MEMBER_ID_NUM`,`EVENT_CODE`,`EVENT_SUBJECT`,`END_DATETIME`),
  CONSTRAINT `calendar_event_ibfk_1` FOREIGN KEY (`CALENDAR_ID`) REFERENCES `calendar_master` (`CALENDAR_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COMMENT='캘린더이벤트';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calendar_event_code`
--

DROP TABLE IF EXISTS `calendar_event_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calendar_event_code` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `EVENT_CODE_NAME` varchar(50) NOT NULL COMMENT '이벤트코드이름',
  `MENU_USE_YN` varchar(1) DEFAULT NULL COMMENT '이벤트코드 메뉴사용여부',
  `MODAL_USE_YN` varchar(1) DEFAULT NULL COMMENT '이벤트코드 모달사용여부',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `EVENT_CODE_ID` int(11) NOT NULL COMMENT '이벤트코드아이디',
  `IMG_ICON` varchar(100) DEFAULT NULL COMMENT '이미지',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calendar_holiday`
--

DROP TABLE IF EXISTS `calendar_holiday`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calendar_holiday` (
  `HOLIDAY_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '휴일아이디',
  `HOLIDAY_TYPE` char(1) NOT NULL COMMENT '휴일종류',
  `HOLIDAY_YYYYMMDD` varchar(8) NOT NULL COMMENT '휴일대상일자',
  `HOLIDAY_NAME` varchar(40) NOT NULL COMMENT '휴일명칭',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  PRIMARY KEY (`HOLIDAY_ID`),
  UNIQUE KEY `uidx_CALENDAR_HOLIDAY_01` (`HOLIDAY_ID`,`HOLIDAY_TYPE`,`HOLIDAY_YYYYMMDD`),
  KEY `idx_CALENDAR_HOLIDAY_01` (`HOLIDAY_ID`,`HOLIDAY_TYPE`,`HOLIDAY_YYYYMMDD`,`HOLIDAY_NAME`)
) ENGINE=InnoDB AUTO_INCREMENT=10003544 DEFAULT CHARSET=utf8 COMMENT='캘린더_휴일정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calendar_invite_event`
--

DROP TABLE IF EXISTS `calendar_invite_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calendar_invite_event` (
  `INVITE_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '일정초대아이디',
  `EVENT_ID` bigint(20) unsigned NOT NULL COMMENT '이벤트아이디',
  `MEMBER_ID_NUM` varchar(10) NOT NULL COMMENT '사번',
  `BASIC_CALENDAR_ID` bigint(20) unsigned DEFAULT NULL COMMENT '초대자기본캘린더아이디',
  `INVITE_YN` char(1) DEFAULT NULL COMMENT '수락여부',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `EMAIL` varchar(40) DEFAULT NULL COMMENT '전자메일주소',
  `CALENDAR_ID` bigint(20) unsigned NOT NULL COMMENT '캘린더아이디',
  `SEND_STATUS_YN` char(1) DEFAULT NULL,
  PRIMARY KEY (`INVITE_ID`),
  KEY `idx_CALENDAR_INVITE_EVENT_01` (`EVENT_ID`,`MEMBER_ID_NUM`,`BASIC_CALENDAR_ID`,`INVITE_YN`,`SYS_UPDATE_DATE`),
  CONSTRAINT `calendar_invite_event_ibfk_1` FOREIGN KEY (`EVENT_ID`) REFERENCES `calendar_event` (`EVENT_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='일정초대';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calendar_master`
--

DROP TABLE IF EXISTS `calendar_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calendar_master` (
  `CALENDAR_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '캘린더아이디',
  `MEMBER_ID_NUM` varchar(10) NOT NULL COMMENT '사번',
  `CALENDAR_NAME` varchar(100) NOT NULL COMMENT '캘린더이름',
  `CALENDAR_TYPE` varchar(20) NOT NULL DEFAULT '' COMMENT '캘린더타입',
  `TIME_ZONE` varchar(100) NOT NULL DEFAULT 'Asia/Seoul' COMMENT '표준시간대',
  `LOCATION` varchar(100) DEFAULT NULL COMMENT '위치',
  `REFERENCE_UID` varchar(512) DEFAULT NULL COMMENT '참조아이디',
  `DISPLAY_YN` char(1) DEFAULT NULL COMMENT '화면표시여부',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `GOOGLE_ICS` varchar(512) DEFAULT NULL COMMENT '구글_ICS_URL',
  `SYNC_YN` char(1) DEFAULT NULL COMMENT '싱크여부',
  PRIMARY KEY (`CALENDAR_ID`),
  KEY `idx_OUR_USERS_INFO_HISTORY_01` (`MEMBER_ID_NUM`,`CALENDAR_NAME`,`CALENDAR_TYPE`,`DISPLAY_YN`),
  CONSTRAINT `calendar_master_ibfk_1` FOREIGN KEY (`MEMBER_ID_NUM`) REFERENCES `our_users_info` (`MEMBER_ID_NUM`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=516 DEFAULT CHARSET=utf8 COMMENT='캘린더마스터';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calendar_repeat_rule`
--

DROP TABLE IF EXISTS `calendar_repeat_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calendar_repeat_rule` (
  `RECURRENCE_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '반복규칙아이디',
  `EVENT_ID` bigint(20) unsigned NOT NULL COMMENT '이벤트아이디',
  `RECURRENCE_FREQ` varchar(20) DEFAULT NULL COMMENT '반복빈도',
  `RECURRENCE_INTERVAL` int(2) DEFAULT NULL,
  `START_DATE` date DEFAULT NULL COMMENT '반복시작일',
  `END_DATE` date DEFAULT NULL COMMENT '반복종료일',
  `RECURRENCE_COUNT` int(11) DEFAULT NULL COMMENT '반복횟수',
  `RECURRENCE_BYWEEKDAY` varchar(100) DEFAULT NULL,
  `RECURRENCE_RULE` varchar(2048) NOT NULL COMMENT '반복규칙값',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `RECURRENCE_BYMONTHDAY` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`RECURRENCE_ID`),
  KEY `idx_CALENDAR_REPEAT_RULE_01` (`EVENT_ID`,`RECURRENCE_FREQ`,`START_DATE`,`END_DATE`),
  CONSTRAINT `calendar_repeat_rule_ibfk_1` FOREIGN KEY (`EVENT_ID`) REFERENCES `calendar_event` (`EVENT_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='캘린더반복규칙';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calendar_share`
--

DROP TABLE IF EXISTS `calendar_share`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calendar_share` (
  `SHARE_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '캘린더아이디',
  `MEMBER_ID_NUM` varchar(10) NOT NULL COMMENT '사번',
  `MEMBER_NAME` varchar(100) DEFAULT NULL COMMENT '캘린더이름',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `SHARE_MEMBER_NAME` varchar(100) DEFAULT NULL COMMENT '공유된 사람 이름',
  `SHARE_MEMBER_ID` varchar(10) DEFAULT NULL COMMENT '공유된 사람 아이디',
  `CALENDAR_ID` bigint(20) unsigned NOT NULL,
  `CALENDAR_NAME` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`SHARE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `client_company_info`
--

DROP TABLE IF EXISTS `client_company_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_company_info` (
  `COMPANY_ID` bigint(20) unsigned NOT NULL COMMENT '고객사아이디',
  `SEGMENT_CODE` varchar(6) NOT NULL DEFAULT 'ETC' COMMENT '산업분류코드',
  `ERP_REG_CODE` varchar(20) DEFAULT NULL COMMENT 'ERP등록코드',
  `COMPANY_NAME` varchar(100) NOT NULL COMMENT '고객사명',
  `CEO_NAME` varchar(40) DEFAULT NULL COMMENT '대표자명',
  `COMPANY_TELNO` varchar(20) DEFAULT NULL COMMENT '대표전화번호',
  `POSTAL_CODE` varchar(20) DEFAULT NULL COMMENT '우편번호',
  `POSTAL_ADDRESS` varchar(200) DEFAULT NULL COMMENT '우편주소',
  `BUSINESS_NUMBER` varchar(20) DEFAULT NULL COMMENT '사업자등록번호',
  `BUSINESS_TYPE` varchar(100) DEFAULT NULL COMMENT '업태',
  `BUSINESS_SECTOR` varchar(100) DEFAULT NULL COMMENT '종목',
  `COMPANY_STATUS` varchar(1) DEFAULT NULL COMMENT '거래처상태',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `CIO_NAME` varchar(40) DEFAULT NULL COMMENT '최고정보책임자',
  `CTO_NAME` varchar(40) DEFAULT NULL COMMENT '최고기술책임자',
  `CEO_ID` bigint(20) unsigned DEFAULT NULL COMMENT '대표자아이디',
  `CIO_ID` bigint(20) unsigned DEFAULT NULL COMMENT '최고정보책임자아이디',
  `CTO_ID` bigint(20) unsigned DEFAULT NULL COMMENT '최고기술책임자아이디',
  `CLIENT_CATEGORY` bigint(2) NOT NULL COMMENT '고객분류',
  PRIMARY KEY (`COMPANY_ID`),
  KEY `idx_CLIENT_COMPANY_INFO_01` (`SEGMENT_CODE`,`COMPANY_NAME`,`CEO_NAME`,`COMPANY_STATUS`),
  CONSTRAINT `client_company_info_ibfk_1` FOREIGN KEY (`SEGMENT_CODE`) REFERENCES `code_industry_segment` (`SEGMENT_CODE`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='고객사정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `client_company_info_file_store`
--

DROP TABLE IF EXISTS `client_company_info_file_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_company_info_file_store` (
  `FILE_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '파일아이디',
  `COMPANY_ID` bigint(20) unsigned NOT NULL COMMENT '고객사아이디',
  `CREATOR_ID` varchar(20) NOT NULL COMMENT '작성자아이디',
  `CREATE_DATETIME` datetime NOT NULL COMMENT '작성일시',
  `FILE_NAME` varchar(128) NOT NULL COMMENT '파일명',
  `FILE_PATH` varchar(512) NOT NULL COMMENT '파일저장위치',
  `FILE_TYPE` varchar(10) DEFAULT NULL COMMENT '파일형식',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  PRIMARY KEY (`FILE_ID`),
  KEY `idx_CLIENT_COMPANY_INFO_FILE_STORE_01` (`COMPANY_ID`,`CREATOR_ID`,`CREATE_DATETIME`,`FILE_NAME`),
  CONSTRAINT `client_company_info_file_store_ibfk_1` FOREIGN KEY (`COMPANY_ID`) REFERENCES `client_company_info` (`COMPANY_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='고객사정보_파일저장정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `client_event_action`
--

DROP TABLE IF EXISTS `client_event_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_event_action` (
  `ACTION_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '액션아이디',
  `EVENT_ID` bigint(20) unsigned NOT NULL COMMENT '이벤트아이디',
  `CREATOR_ID` varchar(20) NOT NULL COMMENT '작성자아이디',
  `ACTION_ITEM` varchar(200) DEFAULT NULL COMMENT 'Action Item',
  `CONTENTS` varchar(400) DEFAULT NULL COMMENT '진행내용',
  `SOLVE_ID` varchar(20) DEFAULT NULL COMMENT '해결담당자',
  `SOLVE_DUE_DATE` date DEFAULT NULL COMMENT '해결기한일자',
  `SOLVE_CLOSE_DATE` date DEFAULT NULL COMMENT '해결완료일자',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `STATUS` char(1) DEFAULT NULL COMMENT '상태',
  PRIMARY KEY (`ACTION_ID`),
  KEY `idx_CLIENT_EVENT_ACTION_01` (`ACTION_ID`,`EVENT_ID`,`CREATOR_ID`,`SYS_REGISTER_DATE`),
  KEY `client_event_action_ibfk_1` (`EVENT_ID`),
  CONSTRAINT `client_event_action_ibfk_1` FOREIGN KEY (`EVENT_ID`) REFERENCES `client_event_log` (`EVENT_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='고객컨택_액션';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `client_event_file_store`
--

DROP TABLE IF EXISTS `client_event_file_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_event_file_store` (
  `FILE_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '파일아이디',
  `EVENT_ID` bigint(20) unsigned NOT NULL COMMENT '이벤트아이디',
  `CREATOR_ID` varchar(20) NOT NULL COMMENT '작성자아이디',
  `CREATE_DATETIME` datetime NOT NULL COMMENT '작성일시',
  `FILE_NAME` varchar(128) NOT NULL COMMENT '파일명',
  `FILE_PATH` varchar(512) NOT NULL COMMENT '파일저장위치',
  `FILE_TYPE` varchar(10) DEFAULT NULL COMMENT '파일형식',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  PRIMARY KEY (`FILE_ID`),
  KEY `idx_CLIENT_EVENT_FILE_STORE_01` (`EVENT_ID`,`CREATOR_ID`,`CREATE_DATETIME`,`FILE_NAME`),
  CONSTRAINT `client_event_file_store_ibfk_1` FOREIGN KEY (`EVENT_ID`) REFERENCES `client_event_log` (`EVENT_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='고객이벤트_파일저장정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `client_event_log`
--

DROP TABLE IF EXISTS `client_event_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_event_log` (
  `EVENT_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '이벤트아이디',
  `CREATOR_ID` varchar(20) NOT NULL COMMENT '작성자아이디',
  `CREATE_DATETIME` datetime NOT NULL COMMENT '작성일시',
  `EVENT_OWNER` varchar(10) DEFAULT NULL COMMENT '이벤트오너',
  `CUSTOMER_ID` bigint(20) unsigned NOT NULL COMMENT '고객명',
  `CUSTOMER_RANK` varchar(100) DEFAULT NULL COMMENT '고객직급',
  `EVENT_DATE` date NOT NULL COMMENT '이벤트일자',
  `EVENT_CATEGORY` varchar(20) NOT NULL COMMENT '이벤트분류',
  `EVENT_SUBJECT` varchar(200) NOT NULL COMMENT '이벤트제목',
  `EVENT_CONTENTS` text COMMENT '이벤트내용',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `COMPANY_ID` bigint(20) unsigned NOT NULL COMMENT '고객사아이디',
  `FOLLOW_CONTENTS` text COMMENT 'FOLLOW-UP-ACTION 내용',
  `FOLLOW_MANAGER_ID` varchar(20) DEFAULT NULL COMMENT 'FOLLOW-UP-ACTION 담당자',
  `FOLLOW_DATE` date DEFAULT NULL COMMENT 'FOLLOW-UP-ACTION 완료예정일',
  PRIMARY KEY (`EVENT_ID`),
  KEY `idx_CLIENT_EVENT_LOG_01` (`CREATOR_ID`,`CREATE_DATETIME`,`CUSTOMER_ID`,`EVENT_CATEGORY`,`EVENT_SUBJECT`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='고객이벤트';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `client_individual_history`
--

DROP TABLE IF EXISTS `client_individual_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_individual_history` (
  `HISTORY_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '고객이력아이디',
  `CURRENT_CUST_ID` bigint(20) unsigned NOT NULL COMMENT '현재고객아이디',
  `BEFORE_CUST_ID` bigint(20) unsigned NOT NULL COMMENT '이전고객아이디',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `HIRE_DATE` date DEFAULT NULL COMMENT '입사일',
  `LEAVE_DATE` date DEFAULT NULL COMMENT '퇴사일',
  PRIMARY KEY (`HISTORY_ID`),
  UNIQUE KEY `idx_CLINET_INDIVIDUAL_HISTORY_01` (`CURRENT_CUST_ID`,`BEFORE_CUST_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='고객개인직이력';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `client_individual_info`
--

DROP TABLE IF EXISTS `client_individual_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_individual_info` (
  `CUSTOMER_ID` bigint(20) unsigned NOT NULL COMMENT '고객아이디',
  `COMPANY_ID` bigint(20) unsigned NOT NULL COMMENT '고객사아이디',
  `CUSTOMER_NAME` varchar(40) NOT NULL COMMENT '고객명',
  `DIVISION` varchar(40) DEFAULT NULL COMMENT '소속본부명',
  `POST` varchar(40) DEFAULT NULL COMMENT '소속부서명',
  `TEAM` varchar(40) DEFAULT NULL COMMENT '소속팀명',
  `POSITION` varchar(40) DEFAULT NULL COMMENT '현직급',
  `DUTY` varchar(200) DEFAULT NULL COMMENT '담당업무',
  `CELL_PHONE` varchar(40) DEFAULT NULL COMMENT '휴대전화',
  `PHONE` varchar(40) DEFAULT NULL COMMENT '일반전화',
  `EMAIL` varchar(200) DEFAULT NULL COMMENT '전자메일주소',
  `ADDRESS` varchar(400) DEFAULT NULL COMMENT '주소',
  `FRIENDSHIP_INFO` varchar(200) DEFAULT NULL COMMENT '사내친한직원',
  `INFO_SOURCE` varchar(512) DEFAULT NULL COMMENT '정보출처',
  `PINFO_CAREER` text COMMENT '개인정보_경력',
  `PINFO_SOCIAL_ACTS` text COMMENT '개인정보_사회활동',
  `PINFO_FAMILY` text COMMENT '개인정보_가족',
  `PINFO_INCLINATION` text COMMENT '개인정보_성향',
  `PINFO_FAMILIARS` text COMMENT '개인정보_친한사람',
  `PINFO_SNS` text COMMENT '개인정보_SNS',
  `PINFO_ETC` text COMMENT '개인정보_기타',
  `CREATOR_ID` varchar(10) DEFAULT NULL COMMENT '작성자',
  `CREATE_DATE` date DEFAULT NULL COMMENT '작성일자',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `REPORTING_LINE_DIVISION_ID` bigint(20) unsigned DEFAULT NULL COMMENT '결제라인_소속본부장_아이디',
  `REPORTING_LINE_POST_ID` bigint(20) unsigned DEFAULT NULL COMMENT '결제라인_소속부서장_아이디',
  `REPORTING_LINE_TEAM_ID` bigint(20) unsigned DEFAULT NULL COMMENT '결제라인_소속팀장_아이디',
  `PINFO_EDUCATION_PERSON` text COMMENT '개인정보_학력관련자',
  `PINFO_CAREER_PERSON` text COMMENT '개인정보_경력관련자',
  `PINFO_EDUCATION` text COMMENT '개인정보_학력',
  `PREV_SALES_MEMBER_ID` bigint(20) unsigned DEFAULT NULL COMMENT '이전고객담당_영업사원_ID',
  `POSITION_DUTY` varchar(40) DEFAULT NULL COMMENT '현직책',
  `PINFO_RELATIONSHIP` text COMMENT '개인정보_자사와의관계',
  `LIKEABILITY` varchar(20) DEFAULT NULL COMMENT '자사와의호감도',
  `RELATION` varchar(20) DEFAULT NULL COMMENT '자사와의관계',
  `DIRECTOR_ID` varchar(20) DEFAULT NULL COMMENT '책임자아이디',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용여부',
  PRIMARY KEY (`CUSTOMER_ID`),
  KEY `idx_CLIENT_INDIVIDUAL_INFO_01` (`COMPANY_ID`,`CUSTOMER_NAME`,`DIVISION`,`POST`,`TEAM`),
  CONSTRAINT `client_individual_info_ibfk_1` FOREIGN KEY (`COMPANY_ID`) REFERENCES `client_company_info` (`COMPANY_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='고객정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `client_individual_photo_store`
--

DROP TABLE IF EXISTS `client_individual_photo_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_individual_photo_store` (
  `FILE_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '파일아이디',
  `CUSTOMER_ID` bigint(20) unsigned NOT NULL COMMENT '고객아이디',
  `CREATOR_ID` varchar(20) NOT NULL COMMENT '작성자아이디',
  `CREATE_DATETIME` datetime NOT NULL COMMENT '작성일시',
  `FILE_NAME` varchar(128) NOT NULL COMMENT '파일명',
  `FILE_PATH` varchar(512) NOT NULL COMMENT '파일저장위치',
  `FILE_TYPE` varchar(10) DEFAULT NULL COMMENT '파일형식',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  PRIMARY KEY (`FILE_ID`),
  KEY `idx_CLIENT_INDIVIDUAL_PHOTO_STORE_01` (`CUSTOMER_ID`,`CREATOR_ID`,`CREATE_DATETIME`,`FILE_NAME`),
  CONSTRAINT `client_individual_photo_store_ibfk_1` FOREIGN KEY (`CUSTOMER_ID`) REFERENCES `client_individual_info` (`CUSTOMER_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='고객관리_고객개인정보_사진저장정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `client_individual_sales`
--

DROP TABLE IF EXISTS `client_individual_sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_individual_sales` (
  `SEQ_NUM` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `CUSTOMER_ID` bigint(20) unsigned NOT NULL COMMENT '고객아이디',
  `PROJECT_NAME` varchar(40) DEFAULT NULL COMMENT '프로젝트명',
  `ROLE` varchar(40) DEFAULT NULL COMMENT '역할',
  `DETAIL` varchar(200) DEFAULT NULL COMMENT '상세내용',
  `CREATOR_ID` varchar(10) DEFAULT NULL COMMENT '작성자아이디',
  `START_DATE` date DEFAULT NULL COMMENT '시작일자',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `END_DATE` date DEFAULT NULL COMMENT '종료일자',
  `POSITION` varchar(40) DEFAULT NULL COMMENT '포지션',
  PRIMARY KEY (`SEQ_NUM`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `client_issue_action_plan`
--

DROP TABLE IF EXISTS `client_issue_action_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_issue_action_plan` (
  `ACTION_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '액션아이디',
  `ISSUE_ID` bigint(20) unsigned NOT NULL COMMENT '이슈아이디',
  `SOLVE_PLAN` varchar(500) DEFAULT NULL COMMENT '이슈해결계획',
  `SOLVE_OWNER` varchar(100) DEFAULT NULL COMMENT '이슈해결책임자',
  `DUE_DATE` date DEFAULT NULL COMMENT '완료예정일자',
  `CLOSE_DATE` date DEFAULT NULL COMMENT '실제완료일자',
  `STATUS` char(1) DEFAULT NULL COMMENT '액션플랜상태',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `SOLVE_FLAG` varchar(1) NOT NULL COMMENT 'NCR,펀칭분류',
  PRIMARY KEY (`ACTION_ID`),
  KEY `idx_CLIENT_ISSUE_ACTION_PLAN_01` (`ACTION_ID`,`ISSUE_ID`),
  KEY `client_issue_action_plan_ibfk_1` (`ISSUE_ID`),
  CONSTRAINT `client_issue_action_plan_ibfk_1` FOREIGN KEY (`ISSUE_ID`) REFERENCES `client_issue_log` (`ISSUE_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='이슈 해결 계획';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `client_issue_file_store`
--

DROP TABLE IF EXISTS `client_issue_file_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_issue_file_store` (
  `FILE_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '파일아이디',
  `ISSUE_ID` bigint(20) unsigned NOT NULL COMMENT '이슈아이디',
  `CREATOR_ID` varchar(20) NOT NULL COMMENT '작성자아이디',
  `CREATE_DATETIME` datetime NOT NULL COMMENT '작성일시',
  `FILE_NAME` varchar(128) NOT NULL COMMENT '파일명',
  `FILE_PATH` varchar(512) NOT NULL COMMENT '파일저장위치',
  `FILE_TYPE` varchar(10) DEFAULT NULL COMMENT '파일형식',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  PRIMARY KEY (`FILE_ID`),
  KEY `idx_CLIENT_ISSUE_FILE_STORE_01` (`ISSUE_ID`,`CREATOR_ID`,`CREATE_DATETIME`,`FILE_NAME`),
  CONSTRAINT `client_issue_file_store_ibfk_1` FOREIGN KEY (`ISSUE_ID`) REFERENCES `client_issue_log` (`ISSUE_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='고객이슈_파일저장정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `client_issue_log`
--

DROP TABLE IF EXISTS `client_issue_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_issue_log` (
  `ISSUE_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '이슈아이디',
  `CREATOR_ID` varchar(20) NOT NULL COMMENT '작성자아이디',
  `COMPANY_ID` bigint(20) unsigned NOT NULL COMMENT '고객사아이디',
  `CUSTOMER_ID` bigint(20) unsigned DEFAULT NULL COMMENT '고객아이디',
  `ISSUE_CREATOR` varchar(10) DEFAULT NULL COMMENT '이슈제기자',
  `SALES_REPRESENTIVE_ID` varchar(10) DEFAULT NULL COMMENT '영업대표아이디',
  `ISSUE_CATEGORY` varchar(20) DEFAULT NULL COMMENT 'NCR/펀칭',
  `ISSUE_SUBJECT` varchar(200) NOT NULL COMMENT '이슈제목',
  `ISSUE_DATE` date NOT NULL COMMENT '이슈발생일자',
  `DUE_DATE` date DEFAULT NULL COMMENT '해결목표기한일자',
  `ISSUE_STATUS` char(1) DEFAULT NULL COMMENT '이슈상태',
  `ISSUE_DETAIL` varchar(1024) DEFAULT NULL COMMENT '이슈상세내용',
  `SOLVE_OWNER` varchar(20) DEFAULT NULL COMMENT '이슈해결책임자',
  `ISSUE_CLOSE_DATE` date DEFAULT NULL COMMENT '이슈해결일자',
  `SOLVE_EVIDENCE_YN` char(1) DEFAULT NULL COMMENT '이슈해결증빙여부',
  `SOLVE_EVIDENCE_DETAIL` text COMMENT '이슈해결증빙내용',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `SOLVE_PLAN` text COMMENT '이슈해결계획',
  `EVENT_ID` bigint(20) unsigned DEFAULT NULL COMMENT '이벤트아이디(고객컨택)',
  `CSAT_DETAIL_ID` bigint(20) unsigned DEFAULT NULL COMMENT '고객만족상세아이디',
  `ISSUE_CONFIRM_ID` varchar(10) DEFAULT NULL COMMENT '이슈해결확인자',
  PRIMARY KEY (`ISSUE_ID`),
  KEY `idx_CLIENT_ISSUE_LOG_LOG_01` (`COMPANY_ID`,`CUSTOMER_ID`,`ISSUE_CREATOR`,`ISSUE_CATEGORY`,`ISSUE_SUBJECT`,`ISSUE_DATE`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='고객이슈로그';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `client_punching_action_plan`
--

DROP TABLE IF EXISTS `client_punching_action_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_punching_action_plan` (
  `ACTION_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '액션아이디',
  `PUNCHING_ID` bigint(20) unsigned NOT NULL COMMENT '펀칭아이디',
  `SOLVE_PLAN` varchar(500) DEFAULT NULL COMMENT '펀칭해결계획',
  `SOLVE_OWNER` varchar(100) DEFAULT NULL COMMENT '펀칭해결책임자',
  `DUE_DATE` date DEFAULT NULL COMMENT '완료예정일자',
  `CLOSE_DATE` date DEFAULT NULL COMMENT '실제완료일자',
  `STATUS` char(1) DEFAULT NULL COMMENT '액션플랜상태',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `SOLVE_FLAG` varchar(1) NOT NULL COMMENT 'NCR,펀칭분류',
  PRIMARY KEY (`ACTION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='펀칭해결 계획';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `client_punching_log`
--

DROP TABLE IF EXISTS `client_punching_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_punching_log` (
  `PUNCHING_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '이슈아이디',
  `CREATOR_ID` varchar(20) NOT NULL COMMENT '작성자아이디',
  `COMPANY_ID` bigint(20) unsigned NOT NULL COMMENT '고객사아이디',
  `CUSTOMER_ID` bigint(20) unsigned DEFAULT NULL COMMENT '고객아이디',
  `ISSUE_CREATOR` varchar(10) DEFAULT NULL COMMENT '이슈제기자',
  `SALES_REPRESENTIVE_ID` varchar(10) DEFAULT NULL COMMENT '영업대표아이디',
  `ISSUE_CATEGORY` varchar(20) DEFAULT NULL COMMENT 'NCR/펀칭',
  `ISSUE_SUBJECT` varchar(200) NOT NULL COMMENT '이슈제목',
  `ISSUE_DATE` date NOT NULL COMMENT '이슈발생일자',
  `DUE_DATE` date DEFAULT NULL COMMENT '해결목표기한일자',
  `ISSUE_STATUS` char(1) DEFAULT NULL COMMENT '이슈상태',
  `ISSUE_DETAIL` varchar(1024) DEFAULT NULL COMMENT '이슈상세내용',
  `SOLVE_OWNER` varchar(20) DEFAULT NULL COMMENT '이슈해결책임자',
  `ISSUE_CLOSE_DATE` date DEFAULT NULL COMMENT '이슈해결일자',
  `SOLVE_EVIDENCE_YN` char(1) DEFAULT NULL COMMENT '이슈해결증빙여부',
  `SOLVE_EVIDENCE_DETAIL` text COMMENT '이슈해결증빙내용',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `SOLVE_PLAN` text COMMENT '이슈해결계획',
  `EVENT_ID` bigint(20) unsigned DEFAULT NULL COMMENT '이벤트아이디(고객컨택)',
  `CSAT_DETAIL_ID` bigint(20) unsigned DEFAULT NULL COMMENT '고객만족상세아이디',
  `ISSUE_CONFIRM_ID` varchar(10) DEFAULT NULL COMMENT '이슈해결확인자',
  PRIMARY KEY (`PUNCHING_ID`),
  KEY `idx_CLIENT_ISSUE_LOG_LOG_01` (`COMPANY_ID`,`CUSTOMER_ID`,`ISSUE_CREATOR`,`ISSUE_CATEGORY`,`ISSUE_SUBJECT`,`ISSUE_DATE`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='고객이슈로그';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `client_sat_file_store`
--

DROP TABLE IF EXISTS `client_sat_file_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_sat_file_store` (
  `FILE_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '파일아이디',
  `CSAT_ID` bigint(20) unsigned NOT NULL COMMENT '고객만족아이디',
  `CREATOR_ID` varchar(20) NOT NULL COMMENT '작성자아이디',
  `CREATE_DATETIME` datetime NOT NULL COMMENT '작성일시',
  `FILE_NAME` varchar(128) NOT NULL COMMENT '파일명',
  `FILE_PATH` varchar(512) NOT NULL COMMENT '파일저장위치',
  `FILE_TYPE` varchar(10) DEFAULT NULL COMMENT '파일형식',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  PRIMARY KEY (`FILE_ID`),
  KEY `idx_CLIENT_SAT_FILE_STORE_01` (`CSAT_ID`,`CREATOR_ID`,`CREATE_DATETIME`,`FILE_NAME`),
  CONSTRAINT `client_sat_file_store_ibfk_1` FOREIGN KEY (`CSAT_ID`) REFERENCES `client_sat_log` (`CSAT_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='고객만족_파일저장정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `client_sat_log`
--

DROP TABLE IF EXISTS `client_sat_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_sat_log` (
  `CSAT_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '고객만족아이디',
  `CREATOR_ID` varchar(20) NOT NULL COMMENT '작성자아이디',
  `CREATE_DATETIME` datetime NOT NULL COMMENT '작성일시',
  `CSAT_SUBJECT` varchar(200) NOT NULL COMMENT '제목',
  `CSAT_CATEGORY` varchar(10) NOT NULL COMMENT '고객만족구분',
  `REF_ID` bigint(20) unsigned DEFAULT NULL COMMENT '참조아이디',
  `CSAT_SURVEY_ID` varchar(20) DEFAULT NULL COMMENT '고객만족조사자아이디',
  `CSAT_SURVEY_DATE` date DEFAULT NULL COMMENT '고객만족조사일자',
  `CSAT_METHOD` varchar(200) DEFAULT NULL COMMENT '고객확인방법',
  `CSAT_DETAIL` text COMMENT '고객만족상세내용',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  PRIMARY KEY (`CSAT_ID`),
  KEY `idx_CLIENT_SAT_LOG_01` (`CSAT_SUBJECT`,`CSAT_CATEGORY`,`CSAT_SURVEY_ID`,`CSAT_SURVEY_DATE`,`CSAT_METHOD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='고객만족조사로그';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `client_sat_log_action_plan`
--

DROP TABLE IF EXISTS `client_sat_log_action_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_sat_log_action_plan` (
  `ACTION_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '액션아이디',
  `CSAT_ID` bigint(20) unsigned NOT NULL COMMENT '고객만족 이슈아이디',
  `SOLVE_PLAN` varchar(500) DEFAULT NULL COMMENT '고객만족 이슈해결계획',
  `SOLVE_OWNER` varchar(100) DEFAULT NULL COMMENT '고객만족 이슈해결책임자',
  `DUE_DATE` date DEFAULT NULL COMMENT '완료예정일자',
  `CLOSE_DATE` date DEFAULT NULL COMMENT '실제완료일자',
  `STATUS` char(1) DEFAULT NULL COMMENT '액션플랜상태',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `CSAT_ACTION_DETAIL` varchar(500) DEFAULT NULL COMMENT '이슈해결계획 상세내용',
  PRIMARY KEY (`ACTION_ID`),
  KEY `idx_CLIENT_SAT_LOG_ACTION_PLAN_01` (`ACTION_ID`,`CSAT_ID`),
  KEY `client_sat_log_action_plan_ibfk_1` (`CSAT_ID`),
  CONSTRAINT `client_sat_log_action_plan_ibfk_1` FOREIGN KEY (`CSAT_ID`) REFERENCES `client_sat_log` (`CSAT_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='고객만족 이슈 해결 계획';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `client_satdetail_log`
--

DROP TABLE IF EXISTS `client_satdetail_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_satdetail_log` (
  `CSAT_DETAIL_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '고객만족상세아이디',
  `CSAT_ID` bigint(20) unsigned NOT NULL COMMENT '고객만족아이디',
  `COMPANY_NAME` varchar(20) NOT NULL COMMENT '고객사명',
  `RESP_CUSTOMER_NAME` varchar(20) NOT NULL COMMENT '조사응답자',
  `CSAT_SURVEY_DATE` date NOT NULL COMMENT '고객만족조사일',
  `MEMBER_ID_NUM` varchar(20) DEFAULT NULL COMMENT '등록자사번',
  `CSAT_REG_DATE` date DEFAULT NULL COMMENT '등록일자',
  `CSAT_METHOD` varchar(200) DEFAULT NULL COMMENT '고객확인방법',
  `CSAT_VALUE` varchar(10) DEFAULT NULL COMMENT '고객만족밸류',
  `CSAT_DETAIL` text COMMENT '고객만족상세내용',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `CUSTOMER_NAME` varchar(20) DEFAULT NULL COMMENT '고객명',
  `COMPANY_ID` bigint(20) unsigned DEFAULT NULL COMMENT '고객사아이디',
  `RESP_CUSTOMER_ID` bigint(20) unsigned DEFAULT NULL COMMENT '조사응답자아이디',
  PRIMARY KEY (`CSAT_DETAIL_ID`),
  KEY `idx_CLIENT_SATDETAIL_LOG_01` (`CSAT_ID`,`COMPANY_NAME`,`RESP_CUSTOMER_NAME`,`CSAT_REG_DATE`,`CSAT_METHOD`),
  CONSTRAINT `client_satdetail_log_ibfk_1` FOREIGN KEY (`CSAT_ID`) REFERENCES `client_sat_log` (`CSAT_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='고객만족상세로그';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `code_industry_segment`
--

DROP TABLE IF EXISTS `code_industry_segment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `code_industry_segment` (
  `SEGMENT_CODE` varchar(6) NOT NULL COMMENT '산업분류코드',
  `SEGMENT_HAN_NAME` varchar(200) NOT NULL COMMENT '산업분류한글명칭',
  `SEGMENT_ENG_NAME` varchar(200) NOT NULL COMMENT '산업분류영문명칭',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `USE_YN` char(1) DEFAULT 'N',
  PRIMARY KEY (`SEGMENT_CODE`),
  KEY `idx_CODE_INDUSTRY_SEGMENT_01` (`SEGMENT_CODE`,`SEGMENT_HAN_NAME`,`SEGMENT_ENG_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='산업분류코드';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `code_partner_segment`
--

DROP TABLE IF EXISTS `code_partner_segment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `code_partner_segment` (
  `PARTNER_CODE` varchar(20) NOT NULL COMMENT '협력분류코드',
  `PARTNER_LEVEL` varchar(200) NOT NULL COMMENT '협력레벨',
  `PARTNER_DETAIL` varchar(2048) NOT NULL COMMENT '협력내용',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `USE_YN` char(1) DEFAULT 'N',
  `PARTNER_CATEGORY` bigint(2) DEFAULT NULL COMMENT '협력사분류코드(1_협력사 2_영업채널)',
  PRIMARY KEY (`PARTNER_CODE`),
  KEY `idx_CODE_PARTNER_SEGMENT_01` (`PARTNER_CODE`,`PARTNER_LEVEL`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='협력회사분류코드';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `com_authority`
--

DROP TABLE IF EXISTS `com_authority`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `com_authority` (
  `AUTHORITY_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '일련번호',
  `AUTHORITY_CODE` varchar(4) NOT NULL COMMENT '권한코드',
  `AUTHORITY_NAME` varchar(20) NOT NULL COMMENT '권한이름',
  `AUTHORITY_DETAIL` text COMMENT '권한설명',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용여부',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `MENU_AUTH` varchar(1000) DEFAULT NULL COMMENT '접근가능메뉴',
  PRIMARY KEY (`AUTHORITY_CODE`),
  KEY `idx_COM_AUTHORITY_01` (`AUTHORITY_ID`,`AUTHORITY_CODE`,`AUTHORITY_NAME`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='권한정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `com_authority_member`
--

DROP TABLE IF EXISTS `com_authority_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `com_authority_member` (
  `MEMBER_ID_NUM` varchar(10) NOT NULL COMMENT '로그인 아이디',
  `AUTHORITY_CODE` varchar(4) NOT NULL COMMENT '권한코드',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용여부',
  KEY `idx_COM_AUTHORITY_MEMBER_01` (`MEMBER_ID_NUM`,`AUTHORITY_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='아이디 권한';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `com_email_share_log`
--

DROP TABLE IF EXISTS `com_email_share_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `com_email_share_log` (
  `SHARE_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '공유 아이디',
  `REFERENCE_ID` bigint(20) unsigned NOT NULL COMMENT '참조 아이디',
  `REFERENCE_TABLE_NAME` varchar(50) NOT NULL COMMENT '참조 테이블명',
  `FROM_MEMBER_ID` varchar(10) NOT NULL COMMENT '보낸사람 아이디',
  `TO_MEMBER_ID` varchar(10) NOT NULL COMMENT '받은사람 아이디',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  PRIMARY KEY (`SHARE_ID`),
  KEY `idx_CLIENT_EVENT_SHARE_LOG_01` (`SHARE_ID`,`REFERENCE_ID`,`REFERENCE_TABLE_NAME`,`FROM_MEMBER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='메일공유로그';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `com_menu`
--

DROP TABLE IF EXISTS `com_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `com_menu` (
  `MENU_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '메뉴아이디',
  `MENU_TITLE` varchar(100) NOT NULL COMMENT '메뉴이름',
  `MENU_URL` varchar(500) NOT NULL DEFAULT '#' COMMENT '메뉴 URL',
  `MENU_PARENT` bigint(20) unsigned DEFAULT NULL COMMENT '상위 메뉴',
  `MENU_SEQ` smallint(6) DEFAULT NULL COMMENT '메뉴순서',
  `MENU_LEVEL` smallint(6) DEFAULT NULL COMMENT '메뉴레벨',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용여부',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `MENU_ICON` varchar(100) DEFAULT NULL COMMENT '메뉴아이콘',
  PRIMARY KEY (`MENU_ID`),
  KEY `idx_COM_MENU_01` (`MENU_ID`,`MENU_TITLE`,`MENU_URL`,`MENU_PARENT`)
) ENGINE=InnoDB AUTO_INCREMENT=10000053 DEFAULT CHARSET=utf8 COMMENT='메뉴';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cus_strategy`
--

DROP TABLE IF EXISTS `cus_strategy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cus_strategy` (
  `CUS_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '고객전략아이디',
  `TITLE` varchar(200) NOT NULL COMMENT '제목',
  `COMPANY_ID` bigint(20) unsigned NOT NULL COMMENT '고객사아이디',
  `REVIEW_CYCLE` varchar(20) NOT NULL COMMENT '리뷰주기',
  `CONTENTS` text COMMENT '내용',
  `CREATOR_ID` varchar(20) NOT NULL COMMENT '작성자아이디',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  PRIMARY KEY (`CUS_ID`),
  KEY `idx_cus_strategy_01` (`TITLE`,`COMPANY_ID`,`CREATOR_ID`,`SYS_REGISTER_DATE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='고객전략';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `erp_company_ar`
--

DROP TABLE IF EXISTS `erp_company_ar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `erp_company_ar` (
  `PROJECT_CODE` varchar(20) NOT NULL COMMENT '프로젝트코드',
  `CONTRACT_DATE` varchar(20) NOT NULL COMMENT '매출일자',
  `COMPANY_NAME` varchar(100) NOT NULL COMMENT '거래처명',
  `PROJECT_NAME` varchar(100) NOT NULL COMMENT '프로젝트명',
  `PROJECT_TYPE` varchar(10) DEFAULT NULL COMMENT '수주유형',
  `AR_AMOUNT` decimal(12,0) DEFAULT NULL COMMENT '미수금액',
  `COLLECT_DATE` varchar(20) NOT NULL COMMENT '수금예정일자',
  `SALES_REP_NAME` varchar(20) DEFAULT NULL COMMENT '담당자명',
  `MEMBER_DIVISION` varchar(20) DEFAULT NULL COMMENT '담당부서',
  `TCV_AMOUNT` decimal(12,0) DEFAULT NULL COMMENT '매출액',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  PRIMARY KEY (`PROJECT_CODE`,`CONTRACT_DATE`),
  KEY `idx_ERP_COMPANY_AR_01` (`PROJECT_CODE`,`CONTRACT_DATE`,`PROJECT_NAME`,`COLLECT_DATE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ERP_거래처_미수금현황';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `erp_company_credit`
--

DROP TABLE IF EXISTS `erp_company_credit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `erp_company_credit` (
  `COMPANY_CODE` varchar(10) NOT NULL COMMENT '거래처코드',
  `COMPANY_NAME` varchar(100) NOT NULL COMMENT '거래처명',
  `BUSINESS_NUMBER` varchar(20) NOT NULL COMMENT '사업자등록번호',
  `LOAN_GRADE` varchar(10) DEFAULT NULL COMMENT '여신등급',
  `CREDIT_AMOUNT` decimal(12,0) DEFAULT NULL COMMENT '여신급액',
  `BUSINESS_STATUS` varchar(10) DEFAULT NULL COMMENT '거래상태',
  `AUDIT_OPINION` varchar(10) DEFAULT NULL COMMENT '감사의견',
  `CREDIT_GRADE` varchar(10) DEFAULT NULL COMMENT '신용등급',
  `CASH_FLOW` varchar(10) DEFAULT NULL COMMENT '현금흐름',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  PRIMARY KEY (`COMPANY_CODE`),
  KEY `idx_ERP_COMPANY_CREDIT_01` (`COMPANY_CODE`,`COMPANY_NAME`,`BUSINESS_NUMBER`,`BUSINESS_STATUS`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ERP_거래처_신용평가';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `erp_sales_plan`
--

DROP TABLE IF EXISTS `erp_sales_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `erp_sales_plan` (
  `PERF_TARGET_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '성과목표아이디',
  `MEMBER_ID_NUM` varchar(10) DEFAULT NULL COMMENT '사번',
  `BASIS_DATE` date NOT NULL COMMENT '기준일',
  `BOOKING_TYPE` varchar(20) DEFAULT NULL COMMENT '수주형태',
  `TARGET_TCV_AMOUNT` decimal(12,0) DEFAULT NULL COMMENT '예상매출금액목표액',
  `TARGET_REV_AMOUNT` decimal(12,0) DEFAULT NULL COMMENT '매출금액목표액',
  `TARGET_GP_AMOUNT` decimal(12,0) DEFAULT NULL COMMENT '매출이익목표액',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  PRIMARY KEY (`PERF_TARGET_ID`),
  KEY `idx_ERP_SALES_PLAN_01` (`PERF_TARGET_ID`,`MEMBER_ID_NUM`,`BASIS_DATE`,`BOOKING_TYPE`)
) ENGINE=InnoDB AUTO_INCREMENT=10000002 DEFAULT CHARSET=utf8 COMMENT='성과관리_매출목표';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `erp_sales_project`
--

DROP TABLE IF EXISTS `erp_sales_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `erp_sales_project` (
  `PROJECT_CODE` varchar(20) NOT NULL COMMENT '프로젝트코드',
  `PROJECT_NAME` varchar(200) NOT NULL COMMENT '프로젝트명',
  `BOOKING_TYPE_NAME` varchar(20) NOT NULL COMMENT '수주유형명',
  `REVISON` varchar(200) NOT NULL COMMENT '차수',
  `CONTRACT_COMPANY` varchar(100) NOT NULL COMMENT '매출처명',
  `CLIENT_COMPANY` varchar(100) NOT NULL COMMENT '고객사명',
  `STATE` varchar(100) NOT NULL COMMENT '프로젝트상태',
  `SALES_REP_NAME` varchar(100) NOT NULL COMMENT '영업대표명',
  `CONTRACT_DATE` varchar(20) NOT NULL COMMENT '계약일자',
  `TCV_NET_AMOUNT` decimal(12,0) DEFAULT NULL COMMENT '매출금액',
  `TCV_VAT_AMOUNT` decimal(12,0) DEFAULT NULL COMMENT '부가세',
  `TCV_TOTAL_AMOUNT` decimal(12,0) DEFAULT NULL COMMENT '부가세합계',
  `SALES_DIVISION` varchar(20) DEFAULT NULL COMMENT '소속본부명',
  `MEMBER_ID_NUM` varchar(10) DEFAULT NULL COMMENT '사번',
  `BOOKING_TYPE` varchar(10) DEFAULT NULL COMMENT '수주유형코드',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  PRIMARY KEY (`PROJECT_CODE`),
  KEY `idx_ERP_SALES_PROJECT_01` (`PROJECT_CODE`,`CONTRACT_DATE`,`BOOKING_TYPE`,`CONTRACT_COMPANY`,`CLIENT_COMPANY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ERP_프로젝트수주현황';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notice_info`
--

DROP TABLE IF EXISTS `notice_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notice_info` (
  `NOTICE_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '알림아이디',
  `MEMBER_ID_NUM` varchar(10) NOT NULL COMMENT '유저아이디',
  `NOTICE_DETAIL` varchar(500) NOT NULL COMMENT '알림내용',
  `NOTICE_CONFIRM_YN` varchar(1) DEFAULT 'N' COMMENT '알림확인여부',
  `NOTICE_CONFIRM_DATE` datetime DEFAULT NULL COMMENT '알림확인시간',
  `NOTICE_SEND_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '알림발송시간',
  `NOTICE_CATEGORY` varchar(20) NOT NULL COMMENT '알림종류',
  `NOTICE_REDIRECT_URL` varchar(200) DEFAULT NULL COMMENT '알림 URL',
  `EVENT_ID` varchar(10) DEFAULT NULL COMMENT '알림이벤트ID',
  `NOTICE_CODE` varchar(100) DEFAULT NULL COMMENT '알림코드',
  `NOTICE_DEL_YN` varchar(1) DEFAULT NULL COMMENT '알림삭제여부',
  PRIMARY KEY (`NOTICE_ID`),
  KEY `idx_NOTICE_INFO_01` (`NOTICE_ID`,`MEMBER_ID_NUM`,`NOTICE_CONFIRM_DATE`,`NOTICE_SEND_DATE`),
  KEY `notice_info_ibfk_1` (`MEMBER_ID_NUM`),
  CONSTRAINT `notice_info_ibfk_1` FOREIGN KEY (`MEMBER_ID_NUM`) REFERENCES `our_members_info` (`MEMBER_ID_NUM`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='알림정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opportunity_action_plan`
--

DROP TABLE IF EXISTS `opportunity_action_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opportunity_action_plan` (
  `ACTION_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '액션플랜아이디',
  `OPPORTUNITY_ID` bigint(20) unsigned NOT NULL COMMENT '영업기회아이디',
  `CHECKLIST_ID` bigint(20) unsigned NOT NULL COMMENT '체크리스트아이디',
  `CREATOR_ID` varchar(20) NOT NULL COMMENT '작성자',
  `CREATE_DATETIME` datetime NOT NULL COMMENT '작성일시',
  `ACTION_PLAN_NAME` varchar(200) DEFAULT NULL COMMENT '액션플랜명',
  `ACTION_OWNER` varchar(20) DEFAULT NULL COMMENT '액션담당자',
  `DUE_DATE` date DEFAULT NULL COMMENT '완료예정일자',
  `CLOSE_DATE` date DEFAULT NULL COMMENT '실제완료일자',
  `STATUS` char(1) DEFAULT NULL COMMENT '액션플랜상태',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `ITEMS_TO_BE_FIXED` varchar(200) DEFAULT NULL COMMENT 'ITEMS_TO_BE_FIXED',
  PRIMARY KEY (`ACTION_ID`),
  KEY `CHECKLIST_ID` (`CHECKLIST_ID`),
  KEY `idx_OPPERTUNITY_ACTION_PLAN_01` (`OPPORTUNITY_ID`,`CHECKLIST_ID`,`CREATOR_ID`,`ACTION_PLAN_NAME`,`ACTION_OWNER`,`STATUS`),
  CONSTRAINT `opportunity_action_plan_ibfk_1` FOREIGN KEY (`CHECKLIST_ID`) REFERENCES `opportunity_checklist` (`CHECKLIST_ID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `opportunity_action_plan_ibfk_2` FOREIGN KEY (`OPPORTUNITY_ID`) REFERENCES `opportunity_log` (`OPPORTUNITY_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='영업기회_체크리스트';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opportunity_amount`
--

DROP TABLE IF EXISTS `opportunity_amount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opportunity_amount` (
  `AMOUNT_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '개별금액아이디',
  `OPPORTUNITY_ID` bigint(20) unsigned NOT NULL COMMENT '영업기회아이디',
  `CREATOR_ID` varchar(20) NOT NULL COMMENT '작성자아이디',
  `BASIS_MONTH` date DEFAULT NULL COMMENT '매출계획월',
  `BASIS_PLAN_REVENUE_AMOUNT` decimal(12,0) DEFAULT NULL COMMENT '매출계획금액',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `BASIS_PLAN_GP_AMOUNT` decimal(12,0) DEFAULT NULL COMMENT '매출계획금액GP',
  `DIVISION_NO` bigint(20) unsigned DEFAULT NULL COMMENT '부서번호',
  `PRODUCT_NO` bigint(20) unsigned DEFAULT NULL COMMENT '제품번호',
  PRIMARY KEY (`AMOUNT_ID`),
  KEY `idx_OPPERTUNITY_AMOUNT_01` (`OPPORTUNITY_ID`,`CREATOR_ID`,`BASIS_MONTH`),
  KEY `opportunity_amount_ibfk_2` (`PRODUCT_NO`),
  CONSTRAINT `opportunity_amount_ibfk_1` FOREIGN KEY (`OPPORTUNITY_ID`) REFERENCES `opportunity_log` (`OPPORTUNITY_ID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `opportunity_amount_ibfk_2` FOREIGN KEY (`PRODUCT_NO`) REFERENCES `our_product_info` (`PRODUCT_NO`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8 COMMENT='영업기회_매출계획금액';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opportunity_checklist`
--

DROP TABLE IF EXISTS `opportunity_checklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opportunity_checklist` (
  `CHECKLIST_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '체크리스트아이디',
  `OPPORTUNITY_ID` bigint(20) unsigned NOT NULL COMMENT '영업기회아이디',
  `CREATOR_ID` varchar(20) NOT NULL COMMENT '작성자',
  `CREATE_DATETIME` datetime NOT NULL COMMENT '작성일시',
  `CHECKLIST_NAME` varchar(200) NOT NULL COMMENT '체크리스트명',
  `CHECKLIST_SEQ` int(11) NOT NULL COMMENT '체크리스트순서',
  `STATUS` char(1) NOT NULL COMMENT '체크리스트상태',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `MEMO` text COMMENT '체크리스트 메모',
  PRIMARY KEY (`CHECKLIST_ID`),
  KEY `idx_OPPERTUNITY_CHECKLIST_01` (`OPPORTUNITY_ID`,`CREATOR_ID`,`CHECKLIST_NAME`,`STATUS`),
  CONSTRAINT `opportunity_checklist_ibfk_1` FOREIGN KEY (`OPPORTUNITY_ID`) REFERENCES `opportunity_log` (`OPPORTUNITY_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='영업기회_체크리스트';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opportunity_checklist_owner`
--

DROP TABLE IF EXISTS `opportunity_checklist_owner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opportunity_checklist_owner` (
  `CHECKLIST_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '체크리스트아이디',
  `OPPORTUNITY_ID` bigint(20) unsigned NOT NULL COMMENT '영업기회아이디',
  `CREATOR_ID` varchar(20) NOT NULL COMMENT '작성자',
  `CREATE_DATETIME` datetime NOT NULL COMMENT '작성일시',
  `CHECKLIST_NAME` varchar(200) NOT NULL COMMENT '체크리스트명',
  `CHECKLIST_SEQ` int(11) NOT NULL COMMENT '체크리스트순서',
  `STATUS` char(1) NOT NULL COMMENT '체크리스트상태',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `MEMO` text COMMENT '메모',
  PRIMARY KEY (`CHECKLIST_ID`),
  KEY `idx_OPPERTUNITY_CHECKLIST_OWNER_01` (`OPPORTUNITY_ID`,`CREATOR_ID`,`CHECKLIST_NAME`,`STATUS`),
  CONSTRAINT `opportunity_checklist_owner_ibfk_1` FOREIGN KEY (`OPPORTUNITY_ID`) REFERENCES `opportunity_log` (`OPPORTUNITY_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='영업기회_owner_체크리스트';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opportunity_file_store`
--

DROP TABLE IF EXISTS `opportunity_file_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opportunity_file_store` (
  `FILE_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '파일아이디',
  `OPPORTUNITY_ID` bigint(20) unsigned NOT NULL COMMENT '영업기회아이디',
  `CREATOR_ID` varchar(20) NOT NULL COMMENT '작성자아이디',
  `CREATE_DATETIME` datetime NOT NULL COMMENT '작성일시',
  `FILE_NAME` varchar(128) NOT NULL COMMENT '파일명',
  `FILE_PATH` varchar(512) NOT NULL COMMENT '파일저장위치',
  `FILE_TYPE` varchar(10) DEFAULT NULL COMMENT '파일형식',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  PRIMARY KEY (`FILE_ID`),
  KEY `idx_OPPERTUNITY_FILE_STORE_01` (`OPPORTUNITY_ID`,`CREATOR_ID`,`CREATE_DATETIME`,`FILE_NAME`),
  CONSTRAINT `opportunity_file_store_ibfk_1` FOREIGN KEY (`OPPORTUNITY_ID`) REFERENCES `opportunity_log` (`OPPORTUNITY_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='영업기회_파일저장정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opportunity_hidden_action`
--

DROP TABLE IF EXISTS `opportunity_hidden_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opportunity_hidden_action` (
  `ACTION_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '액션 아이디',
  `OPPORTUNITY_HIDDEN_ID` bigint(20) unsigned NOT NULL COMMENT '잠재영업기회 아이디',
  `CATEGORY` varchar(20) DEFAULT NULL COMMENT '액션 영역',
  `DETAIL_CONENTS` text COMMENT '액션 내용',
  `ACTION_OWNER` varchar(10) DEFAULT NULL COMMENT '담당자',
  `DUE_DATE` date DEFAULT NULL COMMENT '완료예정일자',
  `CLOSE_DATE` date DEFAULT NULL COMMENT '실제완료일자',
  `CREATOR_ID` varchar(20) NOT NULL COMMENT '작성자 아이디',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `STATUS` varchar(10) DEFAULT NULL COMMENT '상태',
  PRIMARY KEY (`ACTION_ID`),
  KEY `idx_OPPORTUNITY_HIDDEN_ACTION_01` (`ACTION_ID`,`OPPORTUNITY_HIDDEN_ID`,`CATEGORY`,`CREATOR_ID`),
  KEY `opportunity_hidden_action_ibfk_1` (`OPPORTUNITY_HIDDEN_ID`),
  CONSTRAINT `opportunity_hidden_action_ibfk_1` FOREIGN KEY (`OPPORTUNITY_HIDDEN_ID`) REFERENCES `opportunity_hidden_log` (`OPPORTUNITY_HIDDEN_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='잠재영업기회 액션플랜';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opportunity_hidden_log`
--

DROP TABLE IF EXISTS `opportunity_hidden_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opportunity_hidden_log` (
  `OPPORTUNITY_HIDDEN_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '잠재영업기회 아이디',
  `SUBJECT` varchar(200) NOT NULL COMMENT '잠재영업기회 제목',
  `DETAIL_CONENTS` text COMMENT '잠재영업기회 주요내용',
  `CATEGORY` varchar(100) DEFAULT NULL COMMENT '잠재영업기회 항목',
  `OPPORTUNITY_AMOUNT` decimal(12,0) DEFAULT NULL COMMENT '예상영업기회규모',
  `SALESMAN_ID` varchar(10) NOT NULL COMMENT '책임영업대표 아이디',
  `SALESMAN_DIVISION` varchar(30) DEFAULT NULL COMMENT '책임영업대표 본부',
  `CONTRACT_START_DATE` date DEFAULT NULL COMMENT '예상계약시점',
  `SALES_CHANGE_DATE` date DEFAULT NULL COMMENT '영업전환시점',
  `COMPANY_ID` varchar(10) NOT NULL COMMENT '고객사 아이디',
  `CUSTOMER_ID` bigint(20) unsigned NOT NULL COMMENT '고객명 아이디',
  `CREATOR_ID` varchar(20) NOT NULL COMMENT '작성자아이디',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `EVENT_ID` bigint(20) unsigned DEFAULT NULL COMMENT '이벤트아이디(고객컨택)',
  `SALES_RESULT` varchar(20) DEFAULT NULL COMMENT '결과',
  PRIMARY KEY (`OPPORTUNITY_HIDDEN_ID`),
  KEY `idx_OPPORTUNITY_HIDDEN_01` (`OPPORTUNITY_HIDDEN_ID`,`CATEGORY`,`COMPANY_ID`,`CUSTOMER_ID`,`CREATOR_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='잠재영업기회로그';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opportunity_log`
--

DROP TABLE IF EXISTS `opportunity_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opportunity_log` (
  `OPPORTUNITY_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '영업기회아이디',
  `EXEC_ID` varchar(10) NOT NULL COMMENT '실행임원',
  `COMPANY_ID` varchar(10) NOT NULL COMMENT '고객사명  ',
  `CUSTOMER_ID` bigint(20) unsigned NOT NULL COMMENT '고객명',
  `SUBJECT` varchar(200) NOT NULL COMMENT '영업기회제목',
  `CONTRACT_AMOUNT` decimal(12,0) NOT NULL COMMENT '예상계약금액',
  `BIZ_MIX` varchar(200) DEFAULT NULL COMMENT '비즈믹스',
  `CONTRACT_DATE` date DEFAULT NULL COMMENT '예상계약시점',
  `OWNER_ID` varchar(10) DEFAULT NULL COMMENT '영업기회오너',
  `SALES_CYCLE` varchar(20) DEFAULT NULL COMMENT '세일즈사이클',
  `FORECAST_YN` varchar(3) DEFAULT NULL COMMENT '포캐스트여부',
  `ROUTE` varchar(100) DEFAULT NULL COMMENT '라우터',
  `SALES_PARTNER` varchar(100) DEFAULT NULL COMMENT '영업파트너사',
  `DETAIL_CONENTS` text COMMENT '상세내용',
  `CURRENT_MILESTONE` varchar(10) DEFAULT NULL COMMENT '현재마일스톤',
  `CLOSE_CATEGORY` varchar(100) DEFAULT NULL COMMENT '종결구분',
  `CLOSE_DETAIL` text COMMENT '종결사유',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `CREATOR_ID` varchar(20) NOT NULL COMMENT '작성자아이디',
  `CONTRACT_TERM` varchar(2) DEFAULT NULL COMMENT '예상계약기간',
  `DISCRIMINATE_VALUE` text COMMENT '차별화가치',
  `IDENTIFIER_ID` varchar(10) DEFAULT NULL COMMENT '영업기회사원',
  `OPPORTUNITY_HIDDEN_ID` bigint(20) unsigned DEFAULT NULL COMMENT '잠재영업기회 아이디',
  `PARTNER_ROLE` text COMMENT '파트너사 역할',
  `GP_AMOUNT` decimal(12,0) DEFAULT NULL COMMENT '예상GP금액',
  PRIMARY KEY (`OPPORTUNITY_ID`),
  KEY `idx_OPPERTUNITY_LOG_01` (`EXEC_ID`,`COMPANY_ID`,`CUSTOMER_ID`,`SUBJECT`,`OWNER_ID`,`FORECAST_YN`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='영업기회로그';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opportunity_log_history`
--

DROP TABLE IF EXISTS `opportunity_log_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opportunity_log_history` (
  `HISTORY_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '히스토리 아이디',
  `OPPORTUNITY_ID` bigint(20) unsigned NOT NULL COMMENT '영업기회 아이디',
  `CONTRACT_DATE` date NOT NULL COMMENT '예상계약일자',
  `DIVISION_NO` bigint(20) unsigned NOT NULL COMMENT '부서아이디',
  `TCV_PLAN` decimal(12,0) DEFAULT '0' COMMENT 'TCV_PLAN',
  `TCV_GP_PLAN` decimal(12,0) DEFAULT '0' COMMENT 'TCV_GP_PLAN',
  `REV_PLAN` decimal(12,0) DEFAULT '0' COMMENT 'REV_PLAN',
  `GP_PLAN` decimal(12,0) DEFAULT '0' COMMENT 'GP_PLAN',
  `FORECAST_YN` varchar(3) DEFAULT NULL COMMENT 'FORECAST_YN',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  PRIMARY KEY (`HISTORY_ID`),
  KEY `idx_OPPORTUNITY_LOG_HISTORY_01` (`HISTORY_ID`,`OPPORTUNITY_ID`,`DIVISION_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='영업기회 히스토리';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opportunity_milestone`
--

DROP TABLE IF EXISTS `opportunity_milestone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opportunity_milestone` (
  `MILESTONE_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '마일스톤아이디',
  `OPPORTUNITY_ID` bigint(20) unsigned NOT NULL COMMENT '영업기회아이디',
  `CREATOR_ID` varchar(20) NOT NULL COMMENT '작성자',
  `KEY_MILESTONE` varchar(200) NOT NULL COMMENT '키마일스톤',
  `MILESTONE_SEQ` int(11) DEFAULT NULL COMMENT '마일스톤순서',
  `DUE_DATE` date DEFAULT NULL COMMENT '완료예정일자',
  `CLOSE_DATE` date DEFAULT NULL COMMENT '실제완료일자',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `STATUS` char(1) DEFAULT NULL COMMENT '상태',
  `ACT_ID` varchar(20) DEFAULT NULL COMMENT '담당자',
  PRIMARY KEY (`MILESTONE_ID`),
  KEY `idx_OPPERTUNITY_MILESTONE_01` (`OPPORTUNITY_ID`,`CREATOR_ID`,`KEY_MILESTONE`,`DUE_DATE`),
  CONSTRAINT `opportunity_milestone_ibfk_1` FOREIGN KEY (`OPPORTUNITY_ID`) REFERENCES `opportunity_log` (`OPPORTUNITY_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='영업기회_마일스톤';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opportunity_win_plan`
--

DROP TABLE IF EXISTS `opportunity_win_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opportunity_win_plan` (
  `WINPLAN_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '윈플랜아이디',
  `OPPORTUNITY_ID` bigint(20) unsigned NOT NULL COMMENT '영업기회아이디',
  `CHECKLIST_ID` bigint(20) unsigned NOT NULL COMMENT '체크리스트아이디',
  `CREATOR_ID` varchar(20) NOT NULL COMMENT '작성자',
  `CREATE_DATETIME` datetime NOT NULL COMMENT '작성일시',
  `ITEM_2BE_FIXED` varchar(200) NOT NULL COMMENT '해결아이템',
  `ACTION_PLAN_NAME` varchar(200) NOT NULL COMMENT '액션플랜명',
  `ACTION_OWNER` varchar(20) NOT NULL COMMENT '액션담당자',
  `DUE_DATE` date DEFAULT NULL COMMENT '해결기한일자',
  `CLOSE_DATE` date DEFAULT NULL COMMENT '실제완료일자',
  `STATUS` char(1) NOT NULL COMMENT '액션플랜상태',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  PRIMARY KEY (`WINPLAN_ID`),
  KEY `idx_OPPERTUNITY_WIN_PLAN_01` (`OPPORTUNITY_ID`,`CHECKLIST_ID`,`CREATOR_ID`,`ACTION_PLAN_NAME`,`ACTION_OWNER`,`STATUS`),
  CONSTRAINT `opportunity_win_plan_ibfk_1` FOREIGN KEY (`OPPORTUNITY_ID`) REFERENCES `opportunity_log` (`OPPORTUNITY_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='영업기회_윈_플랜';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `our_division_info`
--

DROP TABLE IF EXISTS `our_division_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `our_division_info` (
  `DIVISION_NO` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '본부번호',
  `DIVISION_NAME` varchar(100) NOT NULL COMMENT '본부이름',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `DIVISION_TYPE` char(1) DEFAULT NULL COMMENT '본부직군',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용여부',
  `DIVISION_LEADER` varchar(20) DEFAULT NULL COMMENT '본부장',
  PRIMARY KEY (`DIVISION_NO`),
  KEY `idx_OUR_DIVISION_INFO_01` (`DIVISION_NO`,`DIVISION_NAME`)
) ENGINE=InnoDB AUTO_INCREMENT=10000009 DEFAULT CHARSET=utf8 COMMENT='부서정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `our_members_info`
--

DROP TABLE IF EXISTS `our_members_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `our_members_info` (
  `MEMBER_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '직원아이디',
  `MEMBER_DIVISION` bigint(20) unsigned DEFAULT NULL COMMENT '소속본부',
  `MEMBER_POST` varchar(20) DEFAULT NULL COMMENT '소속부서명',
  `MEMBER_TEAM` bigint(20) unsigned DEFAULT NULL COMMENT '소속팀',
  `MEMBER_ID_NUM` varchar(10) NOT NULL COMMENT '사번',
  `HAN_NAME` varchar(20) NOT NULL COMMENT '이름',
  `POSITION_STATUS` varchar(20) NOT NULL COMMENT '직위',
  `POSITION_RANK` varchar(20) DEFAULT NULL COMMENT '직급',
  `POSITION_DUTY` varchar(20) DEFAULT NULL COMMENT '직책',
  `POSITION_TYPE` varchar(20) DEFAULT NULL COMMENT '직군',
  `BUSINESS_DUTY` varchar(100) DEFAULT NULL COMMENT '담당업무',
  `JOIN_DATE` date DEFAULT NULL COMMENT '입사일자',
  `STOP_DATE` date DEFAULT NULL COMMENT '퇴사일자',
  `CELL_PHONE` varchar(20) DEFAULT NULL COMMENT '휴대전화',
  `PHONE` varchar(20) DEFAULT NULL COMMENT '일반전화',
  `EMAIL` varchar(40) DEFAULT NULL COMMENT '전자메일주소',
  `FRIENDSHIP_COMPANY` varchar(1024) DEFAULT NULL COMMENT '가징친한고객사',
  `FRIENDSHIP_CUSTOMER` varchar(1024) DEFAULT NULL COMMENT '가장친한고객',
  `PERSONAL_PHOTO` blob COMMENT '개인사진',
  `PHOTO_TYPE` varchar(20) DEFAULT NULL COMMENT '사진형식',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용여부',
  PRIMARY KEY (`MEMBER_ID`),
  UNIQUE KEY `idx_OUR_MEMBERS_INFO_00` (`MEMBER_ID_NUM`),
  KEY `idx_OUR_MEMBERS_INFO_01` (`MEMBER_POST`,`HAN_NAME`,`BUSINESS_DUTY`),
  KEY `idx_OUR_MEMBERS_INFO_02` (`MEMBER_ID_NUM`,`POSITION_STATUS`,`POSITION_RANK`,`POSITION_TYPE`,`BUSINESS_DUTY`,`CELL_PHONE`)
) ENGINE=InnoDB AUTO_INCREMENT=10000188 DEFAULT CHARSET=utf8 COMMENT='우리직원정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `our_product_info`
--

DROP TABLE IF EXISTS `our_product_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `our_product_info` (
  `PRODUCT_NO` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '제품번호',
  `PRODUCT_NAME` varchar(100) NOT NULL COMMENT '제품이름',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용여부',
  PRIMARY KEY (`PRODUCT_NO`),
  KEY `idx_OUR_PRODUCT_INFO_01` (`PRODUCT_NO`,`PRODUCT_NAME`)
) ENGINE=InnoDB AUTO_INCREMENT=10000007 DEFAULT CHARSET=utf8 COMMENT='제품정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `our_team_info`
--

DROP TABLE IF EXISTS `our_team_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `our_team_info` (
  `TEAM_NO` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '팀번호',
  `TEAM_NAME` varchar(100) NOT NULL COMMENT '팀이름',
  `TEAM_LEADER` varchar(20) DEFAULT NULL COMMENT '팀장',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용여부',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `DIVISION_NO` bigint(20) unsigned DEFAULT NULL COMMENT '본부번호',
  `TEAM_TYPE` char(1) DEFAULT NULL,
  PRIMARY KEY (`TEAM_NO`),
  KEY `idx_OUR_TEAM_INFO_01` (`TEAM_NO`,`TEAM_NAME`)
) ENGINE=InnoDB AUTO_INCREMENT=10000053 DEFAULT CHARSET=utf8 COMMENT='팀정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `our_users_info`
--

DROP TABLE IF EXISTS `our_users_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `our_users_info` (
  `MEMBER_ID_NUM` varchar(10) NOT NULL COMMENT '사번',
  `PASSWORD_ENC` varchar(512) NOT NULL COMMENT '암호화패스워드',
  `LOGIN_TRY_COUNT` int(11) DEFAULT '0' COMMENT '로그인시도횟수',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  PRIMARY KEY (`MEMBER_ID_NUM`),
  KEY `idx_OUR_MEMBERS_INFO_01` (`MEMBER_ID_NUM`,`PASSWORD_ENC`,`LOGIN_TRY_COUNT`),
  CONSTRAINT `our_users_info_ibfk_1` FOREIGN KEY (`MEMBER_ID_NUM`) REFERENCES `our_members_info` (`MEMBER_ID_NUM`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='셀러스사용자정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `our_users_info_history`
--

DROP TABLE IF EXISTS `our_users_info_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `our_users_info_history` (
  `HISTORY_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '변경기록아이디',
  `MEMBER_ID_NUM` varchar(10) NOT NULL COMMENT '사번',
  `PASSWORD_ENC` varchar(512) NOT NULL COMMENT '암호화패스워드',
  `LOGIN_TRY_COUNT` int(11) DEFAULT '0' COMMENT '로그인시도횟수',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  PRIMARY KEY (`HISTORY_ID`),
  KEY `idx_OUR_USERS_INFO_HISTORY_01` (`MEMBER_ID_NUM`,`PASSWORD_ENC`,`LOGIN_TRY_COUNT`),
  CONSTRAINT `our_users_info_history_ibfk_1` FOREIGN KEY (`MEMBER_ID_NUM`) REFERENCES `our_users_info` (`MEMBER_ID_NUM`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='사용자정보변경기록';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `partner_align_byclient`
--

DROP TABLE IF EXISTS `partner_align_byclient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partner_align_byclient` (
  `ALIGNMENT_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '얼라인먼트아이디',
  `FISCAL_YEAR` year(4) NOT NULL COMMENT '회계연도',
  `COMPANY_ID` bigint(20) unsigned NOT NULL COMMENT '고객사코드',
  `PARTNER_CODE` varchar(20) NOT NULL COMMENT '협력사업코드',
  `ALIGNED_CNT` int(11) DEFAULT NULL COMMENT '얼라인개수',
  `ALIGNED_STATUS` char(1) DEFAULT NULL COMMENT '얼라인상태',
  `BIZ_BUDGET_AMOUNT` decimal(12,0) DEFAULT NULL COMMENT '고객예산',
  `BIZ_PLAN_TCV` decimal(12,0) DEFAULT NULL COMMENT '영업매출계획',
  `BIZ_ACTUAL_TCV` decimal(12,0) DEFAULT NULL COMMENT '영업매출결과',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `CONDITIONS` varchar(20) DEFAULT NULL COMMENT '현황',
  PRIMARY KEY (`ALIGNMENT_ID`),
  UNIQUE KEY `uidx_PARTNER_ALIGN_BYCLIENT_01` (`FISCAL_YEAR`,`COMPANY_ID`,`PARTNER_CODE`),
  KEY `COMPANY_ID` (`COMPANY_ID`),
  KEY `PARTNER_CODE` (`PARTNER_CODE`),
  KEY `idx_PARTNER_ALIGN_BYCLIENT_01` (`FISCAL_YEAR`,`COMPANY_ID`,`PARTNER_CODE`,`ALIGNED_CNT`,`ALIGNED_STATUS`),
  CONSTRAINT `partner_align_byclient_ibfk_1` FOREIGN KEY (`COMPANY_ID`) REFERENCES `client_company_info` (`COMPANY_ID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `partner_align_byclient_ibfk_2` FOREIGN KEY (`PARTNER_CODE`) REFERENCES `code_partner_segment` (`PARTNER_CODE`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='파트너얼라인먼트_고객사별맵';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `partner_align_byclient_gap`
--

DROP TABLE IF EXISTS `partner_align_byclient_gap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partner_align_byclient_gap` (
  `ALIGNMENT_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '얼라인먼트아이디',
  `GAP_AREA` varchar(1024) DEFAULT NULL COMMENT '갭영역',
  `RECOVERY_PLAN` text COMMENT '보완계획',
  `SOLVE_MANAGER_ID` varchar(10) DEFAULT NULL COMMENT '해결담당자',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `SOLVE_DATE` date DEFAULT NULL COMMENT '해결목표일자',
  `SOLVE_STATUS` varchar(10) DEFAULT NULL COMMENT '해결상황',
  PRIMARY KEY (`ALIGNMENT_ID`),
  KEY `idx_PARTNER_ALIGN_BYCLIENT_GAP_01` (`ALIGNMENT_ID`,`SOLVE_MANAGER_ID`),
  CONSTRAINT `partner_align_byclient_gap_ibfk_1` FOREIGN KEY (`ALIGNMENT_ID`) REFERENCES `partner_align_byclient` (`ALIGNMENT_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='파트너얼라인먼트_산업별갭';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `partner_align_byclient_list`
--

DROP TABLE IF EXISTS `partner_align_byclient_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partner_align_byclient_list` (
  `PARTNER_LIST_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '파트너리스트아이디',
  `ALIGNMENT_ID` bigint(20) unsigned NOT NULL COMMENT '얼라인먼트아이디',
  `PARTNER_ID` bigint(20) unsigned DEFAULT NULL COMMENT '협력회사아이디',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  PRIMARY KEY (`PARTNER_LIST_ID`),
  KEY `idx_PARTNER_ALIGN_BYCLIENT_LIST_01` (`ALIGNMENT_ID`,`PARTNER_ID`),
  CONSTRAINT `partner_align_byclient_list_ibfk_1` FOREIGN KEY (`ALIGNMENT_ID`) REFERENCES `partner_align_byclient` (`ALIGNMENT_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='파트너얼라인먼트_고객사별리스트';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `partner_align_bysegment`
--

DROP TABLE IF EXISTS `partner_align_bysegment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partner_align_bysegment` (
  `ALIGNMENT_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '얼라인먼트아이디',
  `FISCAL_YEAR` year(4) NOT NULL COMMENT '회계연도',
  `SEGMENT_CODE` varchar(6) NOT NULL COMMENT '산업분류코드',
  `PARTNER_CODE` varchar(20) NOT NULL COMMENT '협력사업코드',
  `ALIGNED_CNT` int(11) DEFAULT NULL COMMENT '얼라인개수',
  `ALIGNED_STATUS` char(1) DEFAULT NULL COMMENT '얼라인상태',
  `BIZ_BUDGET_AMOUNT` decimal(12,0) DEFAULT NULL COMMENT '고객예산',
  `BIZ_PLAN_TCV` decimal(12,0) DEFAULT NULL COMMENT '영업매출계획',
  `BIZ_ACTUAL_TCV` decimal(12,0) DEFAULT NULL COMMENT '영업매출결과',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `CONDITIONS` varchar(20) DEFAULT NULL COMMENT '현황',
  PRIMARY KEY (`ALIGNMENT_ID`),
  UNIQUE KEY `uidx_PARTNER_ALIGN_BYSEGMENT_01` (`FISCAL_YEAR`,`SEGMENT_CODE`,`PARTNER_CODE`),
  KEY `SEGMENT_CODE` (`SEGMENT_CODE`),
  KEY `PARTNER_CODE` (`PARTNER_CODE`),
  KEY `idx_PARTNER_ALIGN_BYSEGMENT_01` (`FISCAL_YEAR`,`SEGMENT_CODE`,`PARTNER_CODE`,`ALIGNED_CNT`,`ALIGNED_STATUS`),
  CONSTRAINT `partner_align_bysegment_ibfk_1` FOREIGN KEY (`SEGMENT_CODE`) REFERENCES `code_industry_segment` (`SEGMENT_CODE`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `partner_align_bysegment_ibfk_2` FOREIGN KEY (`PARTNER_CODE`) REFERENCES `code_partner_segment` (`PARTNER_CODE`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='파트너얼라인먼트_산업별맵';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `partner_align_bysegment_gap`
--

DROP TABLE IF EXISTS `partner_align_bysegment_gap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partner_align_bysegment_gap` (
  `ALIGNMENT_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '얼라인먼트아이디',
  `GAP_AREA` varchar(1024) DEFAULT NULL COMMENT '갭영역',
  `RECOVERY_PLAN` text COMMENT '보완계획',
  `SOLVE_MANAGER_ID` varchar(10) DEFAULT NULL COMMENT '해결담당자',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `SOLVE_DATE` date DEFAULT NULL COMMENT '해결목표일자',
  `SOLVE_STATUS` varchar(10) DEFAULT NULL COMMENT '해결상황',
  PRIMARY KEY (`ALIGNMENT_ID`),
  KEY `idx_PPARTNER_ALIGN_BYSEGMENT_GAP_01` (`ALIGNMENT_ID`,`SOLVE_MANAGER_ID`),
  CONSTRAINT `partner_align_bysegment_gap_ibfk_1` FOREIGN KEY (`ALIGNMENT_ID`) REFERENCES `partner_align_bysegment` (`ALIGNMENT_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='파트너얼라인먼트_산업별갭';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `partner_align_bysegment_list`
--

DROP TABLE IF EXISTS `partner_align_bysegment_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partner_align_bysegment_list` (
  `PARTNER_LIST_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '파트너리스트아이디',
  `ALIGNMENT_ID` bigint(20) unsigned NOT NULL COMMENT '얼라인먼트아이디',
  `PARTNER_ID` bigint(20) unsigned DEFAULT NULL COMMENT '협력회사아이디',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  PRIMARY KEY (`PARTNER_LIST_ID`),
  KEY `idx_PARTNER_ALIGN_BYSEGMENT_LIST_01` (`PARTNER_LIST_ID`,`ALIGNMENT_ID`,`PARTNER_ID`),
  KEY `partner_align_bysegment_list_ibfk_1` (`ALIGNMENT_ID`),
  CONSTRAINT `partner_align_bysegment_list_ibfk_1` FOREIGN KEY (`ALIGNMENT_ID`) REFERENCES `partner_align_bysegment` (`ALIGNMENT_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='파트너얼라인먼트_산업별리스트';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `partner_cadence_action_plan`
--

DROP TABLE IF EXISTS `partner_cadence_action_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partner_cadence_action_plan` (
  `ACTION_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '액션 아이디',
  `CADENCE_ID` bigint(20) unsigned NOT NULL COMMENT '케이던스아이디',
  `DETAIL_CONENTS` text COMMENT '액션 내용',
  `ACTION_OWNER` varchar(10) DEFAULT NULL COMMENT '담당자',
  `DUE_DATE` date DEFAULT NULL COMMENT '완료예정일자',
  `CLOSE_DATE` date DEFAULT NULL COMMENT '실제완료일자',
  `CREATOR_ID` varchar(20) NOT NULL COMMENT '작성자 아이디',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `STATUS` varchar(10) DEFAULT NULL COMMENT '상태',
  PRIMARY KEY (`ACTION_ID`),
  KEY `idx_PARTNER_CADENCE_ACTION_PLAN_01` (`ACTION_ID`,`CADENCE_ID`,`SYS_REGISTER_DATE`,`SYS_UPDATE_DATE`,`STATUS`),
  KEY `partner_cadence_action_plan_ibfk_1` (`CADENCE_ID`),
  CONSTRAINT `partner_cadence_action_plan_ibfk_1` FOREIGN KEY (`CADENCE_ID`) REFERENCES `partner_cadence_log` (`CADENCE_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='파트너협업_액션플랜';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `partner_cadence_log`
--

DROP TABLE IF EXISTS `partner_cadence_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partner_cadence_log` (
  `CADENCE_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '케이던스아이디',
  `LINKAGE_ID` bigint(20) unsigned NOT NULL COMMENT '세일즈링키지아이디',
  `EXEC_DATE` date DEFAULT NULL COMMENT '실행일자',
  `EXEC_CONTENT` varchar(4096) DEFAULT NULL COMMENT '실행내용',
  `PARTNER_VOICE` varchar(4096) DEFAULT NULL COMMENT '파트너보이스',
  `CREATOR_ID` varchar(10) DEFAULT NULL COMMENT '작성자',
  `CREATE_DATE` date DEFAULT NULL COMMENT '작성일자',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  PRIMARY KEY (`CADENCE_ID`),
  KEY `idx_PARTNER_CADENCE_LOG_01` (`LINKAGE_ID`,`EXEC_DATE`,`CREATOR_ID`,`CREATE_DATE`),
  CONSTRAINT `partner_cadence_log_ibfk_1` FOREIGN KEY (`LINKAGE_ID`) REFERENCES `partner_sales_linakge` (`LINKAGE_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='파트너_케이던스로그';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `partner_company_info`
--

DROP TABLE IF EXISTS `partner_company_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partner_company_info` (
  `PARTNER_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '협력회사아이디',
  `PARTNER_CODE` varchar(20) NOT NULL COMMENT '협력분류코드',
  `COMPANY_NAME` varchar(100) NOT NULL COMMENT '협력회사명',
  `CEO_NAME` varchar(40) DEFAULT NULL COMMENT '대표자명',
  `COMPANY_TELNO` varchar(40) DEFAULT NULL COMMENT '대표전화번호',
  `POSTAL_CODE` varchar(20) DEFAULT NULL COMMENT '우편번호',
  `POSTAL_ADDRESS` varchar(200) DEFAULT NULL COMMENT '우편주소',
  `BUSINESS_NUMBER` varchar(20) DEFAULT NULL COMMENT '사업자등록번호',
  `BUSINESS_TYPE` varchar(100) DEFAULT NULL COMMENT '업태',
  `BUSINESS_SECTOR` varchar(100) DEFAULT NULL COMMENT '업종',
  `COMPANY_STATUS` varchar(1) DEFAULT NULL COMMENT '거래처상태',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `company_enname` varchar(100) DEFAULT NULL COMMENT '협력회사영문명',
  `CEO_ID` bigint(20) unsigned DEFAULT NULL COMMENT '대표자아이디',
  `PARTNER_CATEGORY` bigint(2) DEFAULT NULL COMMENT '협력사분류코드(1_협력사 2_영업채널)',
   `COMPANY_ITEM` varchar(200) DEFAULT NULL COMMENT '취급Item',
  `COMPANY_HOMEPAGE` varchar(200) DEFAULT NULL COMMENT '홈페이지주소',
  `COMPANY_FAXNO` varchar(40) DEFAULT NULL COMMENT '팩스번호',
  PRIMARY KEY (`PARTNER_ID`),
  KEY `idx_PARTNER_COMPANY_INFO_01` (`PARTNER_CODE`,`COMPANY_NAME`,`CEO_NAME`,`COMPANY_TELNO`,`COMPANY_STATUS`),
  CONSTRAINT `partner_company_info_ibfk_1` FOREIGN KEY (`PARTNER_CODE`) REFERENCES `code_partner_segment` (`PARTNER_CODE`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1000850 DEFAULT CHARSET=utf8 COMMENT='협력회사정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `partner_company_order_status`
--

DROP TABLE IF EXISTS `partner_company_order_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partner_company_order_status` (
  `STATUS_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '발주현황아이디',
  `PARTNER_ID` bigint(20) unsigned NOT NULL COMMENT '파트너사아이디',
  `CREATOR_ID` varchar(20) NOT NULL COMMENT '작성자아이디',
  `CREATE_DATETIME` datetime NOT NULL COMMENT '작성일시',
  `ORDER_NAME` varchar(200) NOT NULL COMMENT '발주명',
  `MATERIAL_NAME` varchar(200) NOT NULL COMMENT '자재명',
  `STATUS_DATE` date DEFAULT NULL COMMENT '발주일',
  `STATUS_AMOUNT` decimal(12,0) DEFAULT NULL COMMENT '발주량',
  `PRICE` decimal(12,0) DEFAULT NULL COMMENT '단가',
  `TOTAL_AMOUNT` decimal(12,0) DEFAULT NULL COMMENT '총금액',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  PRIMARY KEY (`STATUS_ID`),
  KEY `idx_PARTNER_COMPANY_ORDER_STATUS_01` (`PARTNER_ID`,`CREATOR_ID`,`CREATE_DATETIME`),
  CONSTRAINT `partner_company_order_status_ibfk_1` FOREIGN KEY (`PARTNER_ID`) REFERENCES `partner_company_info` (`PARTNER_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='파트너사_발주현황'
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `partner_company_sale_status`
--

DROP TABLE IF EXISTS `partner_company_sale_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partner_company_sale_status` (
  `STATUS_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '매출현황아이디',
  `PARTNER_ID` bigint(20) unsigned NOT NULL COMMENT '파트너사아이디',
  `CREATOR_ID` varchar(20) NOT NULL COMMENT '작성자아이디',
  `CREATE_DATETIME` datetime NOT NULL COMMENT '작성일시',
  `SALE_NAME` varchar(200) NOT NULL COMMENT '매출명',
  `PRODUCT_NAME` varchar(200) NOT NULL COMMENT '제품명',
  `STATUS_DATE` date DEFAULT NULL COMMENT '매출일',
  `STATUS_AMOUNT` decimal(12,0) DEFAULT NULL COMMENT '매출량',
  `PRICE` decimal(12,0) DEFAULT NULL COMMENT '단가',
  `TOTAL_AMOUNT` decimal(12,0) DEFAULT NULL COMMENT '총금액',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  PRIMARY KEY (`STATUS_ID`),
  KEY `idx_PARTNER_COMPANY_SALE_STATUS_01` (`PARTNER_ID`,`CREATOR_ID`,`CREATE_DATETIME`),
  CONSTRAINT `partner_company_sale_status_ibfk_1` FOREIGN KEY (`PARTNER_ID`) REFERENCES `partner_company_info` (`PARTNER_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='파트너사_매출현황'
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `partner_company_info_file_store`
--

DROP TABLE IF EXISTS `partner_company_info_file_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partner_company_info_file_store` (
  `FILE_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '파일아이디',
  `PARTNER_ID` bigint(20) unsigned NOT NULL COMMENT '파트너사아이디',
  `CREATOR_ID` varchar(20) NOT NULL COMMENT '작성자아이디',
  `CREATE_DATETIME` datetime NOT NULL COMMENT '작성일시',
  `FILE_NAME` varchar(128) NOT NULL COMMENT '파일명',
  `FILE_PATH` varchar(512) NOT NULL COMMENT '파일저장위치',
  `FILE_TYPE` varchar(10) DEFAULT NULL COMMENT '파일형식',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  PRIMARY KEY (`FILE_ID`),
  KEY `idx_PARTNER_COMPANY_INFO_FILE_STORE_01` (`PARTNER_ID`,`CREATOR_ID`,`CREATE_DATETIME`,`FILE_NAME`),
  CONSTRAINT `partner_company_info_file_store_ibfk_1` FOREIGN KEY (`PARTNER_ID`) REFERENCES `partner_company_info` (`PARTNER_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='파트너사정보_파일저장정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `partner_crb_client_log`
--

DROP TABLE IF EXISTS `partner_crb_client_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partner_crb_client_log` (
  `CRB_LOG_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'CRB아이디',
  `CRB_ID` bigint(20) unsigned NOT NULL COMMENT 'CRB 마스터 아이디',
  `PARTNER_NAME` varchar(500) DEFAULT NULL COMMENT '파트너사 이름',
  `RECOMMENDER` varchar(100) DEFAULT NULL COMMENT '추천자',
  `EVAL_ITEM1_RESULT` char(1) DEFAULT NULL COMMENT '평가항목1_결과',
  `EVAL_ITEM2_RESULT` char(1) DEFAULT NULL COMMENT '평가항목2_결과',
  `EVAL_ITEM3_RESULT` char(1) DEFAULT NULL COMMENT '평가항목3_결과',
  `EVAL_ITEM4_RESULT` char(1) DEFAULT NULL COMMENT '평가항목4_결과',
  `EVAL_ITEM5_RESULT` char(1) DEFAULT NULL COMMENT '평가항목5_결과',
  `EVAL_FINAL_RESULT` varchar(10) DEFAULT NULL COMMENT '최종평가결과',
  `CRB_DATE` date DEFAULT NULL COMMENT '평가일자',
  `CRB_MEMBERS` varchar(512) DEFAULT NULL COMMENT '평가자',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `COMPANY_NAME` varchar(100) DEFAULT NULL COMMENT '고객사',
  `PARTNER_CODE` varchar(100) DEFAULT NULL COMMENT '파트너 코드',
  `ALIGNMENT_ID` bigint(20) unsigned NOT NULL COMMENT '얼라인먼트아이디',
  `CRB_CATEGORY` varchar(10) DEFAULT NULL COMMENT '평가종류',
  PRIMARY KEY (`CRB_LOG_ID`),
  KEY `idx_PARTNER_CRB_CLIENT_LOG_01` (`CRB_LOG_ID`,`CRB_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='파트너_리크루트_로그';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `partner_crb_file_store`
--

DROP TABLE IF EXISTS `partner_crb_file_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partner_crb_file_store` (
  `FILE_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '파일아이디',
  `BIZ_SEGMENT` varchar(20) NOT NULL COMMENT '산업구분 고객/산업',
  `CREATOR_ID` varchar(20) NOT NULL COMMENT '작성자아이디',
  `CREATE_DATETIME` datetime NOT NULL COMMENT '작성일시',
  `FILE_NAME` varchar(128) NOT NULL COMMENT '파일명',
  `FILE_PATH` varchar(512) NOT NULL COMMENT '파일저장위치',
  `FILE_TYPE` varchar(10) DEFAULT NULL COMMENT '파일형식',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `FISCAL_YEAR` year(4) NOT NULL COMMENT '회계년도',
  `CRB_SEQ` int(11) DEFAULT NULL COMMENT '평가회차',
  PRIMARY KEY (`FILE_ID`),
  KEY `idx_PARTNER_CRB_FILE_STORE_01` (`FILE_ID`,`BIZ_SEGMENT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CRB 로그 파일정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `partner_crb_master`
--

DROP TABLE IF EXISTS `partner_crb_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partner_crb_master` (
  `CRB_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '리크루트아이디',
  `BIZ_SEGMENT` varchar(20) NOT NULL COMMENT '사업부문',
  `FISCAL_YEAR` year(4) NOT NULL COMMENT '회계연도',
  `CRB_SEQ` int(11) NOT NULL COMMENT '평가차수',
  `CRB_MEMBERS` varchar(512) DEFAULT NULL COMMENT '평가위원',
  `CRB_DATE` date DEFAULT NULL COMMENT '평가일자',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  PRIMARY KEY (`CRB_ID`),
  KEY `idx_PARTNER_CRB_MASTER_01CRB_SEQ` (`BIZ_SEGMENT`,`FISCAL_YEAR`,`CRB_SEQ`,`CRB_MEMBERS`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='파트너_리크루트_마스터';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `partner_crb_segment_log`
--

DROP TABLE IF EXISTS `partner_crb_segment_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partner_crb_segment_log` (
  `CRB_LOG_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'CRB 아이디',
  `CRB_ID` bigint(20) unsigned NOT NULL COMMENT 'CRB 마스터 아이디',
  `PARTNER_NAME` varchar(500) DEFAULT NULL COMMENT '파트너사 이름',
  `RECOMMENDER` varchar(100) DEFAULT NULL COMMENT '추천자',
  `EVAL_ITEM1_RESULT` char(1) DEFAULT NULL COMMENT '평가항목1_결과',
  `EVAL_ITEM2_RESULT` char(1) DEFAULT NULL COMMENT '평가항목2_결과',
  `EVAL_ITEM3_RESULT` char(1) DEFAULT NULL COMMENT '평가항목3_결과',
  `EVAL_ITEM4_RESULT` char(1) DEFAULT NULL COMMENT '평가항목4_결과',
  `EVAL_ITEM5_RESULT` char(1) DEFAULT NULL COMMENT '평가항목5_결과',
  `EVAL_FINAL_RESULT` varchar(10) DEFAULT NULL COMMENT '최종평가결과',
  `CRB_DATE` date DEFAULT NULL COMMENT '평가일자',
  `CRB_MEMBERS` varchar(512) DEFAULT NULL COMMENT '평가자',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `SEGMENT_NAME` varchar(100) DEFAULT NULL COMMENT '산업명',
  `PARTNER_CODE` varchar(100) DEFAULT NULL COMMENT '파트너 코드',
  `ALIGNMENT_ID` bigint(20) unsigned DEFAULT NULL COMMENT '얼라인먼트아이디',
  `CRB_CATEGORY` varchar(10) DEFAULT NULL COMMENT '평가종류',
  PRIMARY KEY (`CRB_LOG_ID`),
  KEY `idx_PARTNER_CRB_SEGMENT_LOG_01` (`CRB_LOG_ID`,`CRB_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='파트너_리크루트_로그';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `partner_enable_file_store`
--

DROP TABLE IF EXISTS `partner_enable_file_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partner_enable_file_store` (
  `FILE_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '파일아이디',
  `EDU_PLAN_ID` bigint(20) unsigned NOT NULL COMMENT '교육계획아이디',
  `CREATOR_ID` varchar(20) NOT NULL COMMENT '작성자아이디',
  `CREATE_DATETIME` datetime NOT NULL COMMENT '작성일시',
  `FILE_NAME` varchar(128) NOT NULL COMMENT '파일명',
  `FILE_PATH` varchar(512) NOT NULL COMMENT '파일저장위치',
  `FILE_TYPE` varchar(10) DEFAULT NULL COMMENT '파일형식',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  PRIMARY KEY (`FILE_ID`),
  KEY `idx_PARTNER_ENABLE_FILE_STORE_01` (`EDU_PLAN_ID`,`CREATOR_ID`,`CREATE_DATETIME`,`FILE_NAME`),
  CONSTRAINT `partner_enable_file_store_ibfk_1` FOREIGN KEY (`EDU_PLAN_ID`) REFERENCES `partner_enable_plan` (`EDU_PLAN_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='교육계획_파일저장정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `partner_enable_log`
--

DROP TABLE IF EXISTS `partner_enable_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partner_enable_log` (
  `EDU_LOG_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '교육로그아이디',
  `EDU_PLAN_ID` bigint(20) unsigned NOT NULL COMMENT '교육계획아이디',
  `CREATOR_ID` varchar(10) NOT NULL COMMENT '작성자',
  `CREATE_DATE` date NOT NULL COMMENT '작성일자',
  `PARTNER_INDIVIDUAL_ID` bigint(20) unsigned NOT NULL COMMENT '피교육자아이디',
  `ATTENDED_HOURS` int(11) DEFAULT NULL COMMENT '총교육참석시간',
  `CERTIFICATION_YN` char(1) DEFAULT NULL COMMENT '수료여부',
  `SAT_VALUE` int(11) DEFAULT NULL COMMENT '만족도',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `PARTNER_ID` bigint(20) unsigned DEFAULT NULL COMMENT '파트너아이디',
  PRIMARY KEY (`EDU_LOG_ID`),
  KEY `idx_PARTNER_ENABLE_LOG_01` (`EDU_PLAN_ID`,`CREATOR_ID`,`CREATE_DATE`,`PARTNER_INDIVIDUAL_ID`),
  CONSTRAINT `partner_enable_log_ibfk_1` FOREIGN KEY (`EDU_PLAN_ID`) REFERENCES `partner_enable_plan` (`EDU_PLAN_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='파트너_교육로그';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `partner_enable_plan`
--

DROP TABLE IF EXISTS `partner_enable_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partner_enable_plan` (
  `EDU_PLAN_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '교육계획아이디',
  `CREATOR_ID` varchar(10) NOT NULL COMMENT '작성자',
  `CREATE_DATE` date NOT NULL COMMENT '작성일자',
  `EDU_AREA` bigint(20) unsigned NOT NULL COMMENT '교육영역',
  `EDU_KIND` varchar(10) NOT NULL COMMENT '신규구분',
  `EDU_SUBJECT` varchar(100) NOT NULL COMMENT '교육제목',
  `EDU_TARGET` varchar(1024) DEFAULT NULL COMMENT '교육목표',
  `EDU_BUDGET` decimal(12,0) DEFAULT NULL COMMENT '교육예산',
  `START_DATE` date DEFAULT NULL COMMENT '시작일자',
  `END_DATE` date DEFAULT NULL COMMENT '종료일자',
  `TOTAL_HOURS` int(11) DEFAULT NULL COMMENT '총교육시간',
  `EDU_CONTENT` text COMMENT '교육내용',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `EDU_LEVEL` varchar(10) DEFAULT NULL COMMENT '교육레벨',
  PRIMARY KEY (`EDU_PLAN_ID`),
  KEY `idx_PARTNER_ENABLE_PLAN_01` (`CREATOR_ID`,`CREATE_DATE`,`EDU_AREA`,`EDU_KIND`,`EDU_SUBJECT`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='파트너_교육계획';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `partner_individual_history`
--

DROP TABLE IF EXISTS `partner_individual_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partner_individual_history` (
  `HISTORY_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '고객이력아이디',
  `CURRENT_INDIVIDUAL_ID` bigint(20) unsigned NOT NULL COMMENT '현재파트너개인아이디',
  `BEFORE_INDIVIDUAL_ID` bigint(20) unsigned NOT NULL COMMENT '이전파트너개인아이디',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  PRIMARY KEY (`HISTORY_ID`),
  UNIQUE KEY `idx_PARTNER_INDIVIDUAL_HISTORY_01` (`CURRENT_INDIVIDUAL_ID`,`BEFORE_INDIVIDUAL_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='고객개인직이력';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `partner_individual_info`
--

DROP TABLE IF EXISTS `partner_individual_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partner_individual_info` (
  `PARTNER_INDIVIDUAL_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '협력회사직원아이디',
  `PARTNER_ID` bigint(20) unsigned NOT NULL COMMENT '협력회사아이디',
  `PARTNER_PERSONAL_NAME` varchar(20) NOT NULL COMMENT '협력회사직원명',
  `DIVISION` varchar(20) NOT NULL COMMENT '소속본부명',
  `POST` varchar(20) NOT NULL COMMENT '소속부서명',
  `TEAM` varchar(20) NOT NULL COMMENT '소속팀명',
  `POSITION` varchar(20) NOT NULL COMMENT '현직급',
  `SKILL_TYPE` varchar(20) NOT NULL COMMENT '역할구분',
  `DUTY` varchar(100) NOT NULL COMMENT '담당업무',
  `CELL_PHONE` varchar(20) NOT NULL COMMENT '휴대전화',
  `PHONE` varchar(20) DEFAULT NULL COMMENT '일반전화',
  `EMAIL` varchar(20) DEFAULT NULL COMMENT '전자메일주소',
  `FRIENDSHIP_COMPANY` varchar(1024) DEFAULT NULL COMMENT '가징친한고객사',
  `FRIENDSHIP_CUSTOMER` varchar(1024) DEFAULT NULL COMMENT '가장친한고객',
  `PERSONAL_INFO` text COMMENT '개인정보',
  `PERSONAL_PHOTO` blob COMMENT '개인사진',
  `PHOTO_TYPE` varchar(20) DEFAULT NULL COMMENT '사진형식',
  `FRIENDSHIP_INFO` varchar(200) DEFAULT NULL COMMENT '사내친한직원',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `CREATOR_ID` varchar(10) DEFAULT NULL COMMENT '작성자',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용여부',
  `POSITION_DUTY` varchar(40) DEFAULT NULL COMMENT '현직책',
  PRIMARY KEY (`PARTNER_INDIVIDUAL_ID`),
  KEY `idx_PARTNER_INDIVIDUAL_INFO_INFO_01` (`PARTNER_ID`,`PARTNER_PERSONAL_NAME`,`DIVISION`,`TEAM`,`SKILL_TYPE`,`DUTY`),
  CONSTRAINT `partner_individual_info_ibfk_1` FOREIGN KEY (`PARTNER_ID`) REFERENCES `partner_company_info` (`PARTNER_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='협력회사직원정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `partner_individual_photo_store`
--

DROP TABLE IF EXISTS `partner_individual_photo_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partner_individual_photo_store` (
  `FILE_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '파일아이디',
  `PARTNER_INDIVIDUAL_ID` bigint(20) unsigned NOT NULL COMMENT '협력사직원아이디',
  `CREATOR_ID` varchar(20) NOT NULL COMMENT '작성자아이디',
  `CREATE_DATETIME` datetime NOT NULL COMMENT '작성일시',
  `FILE_NAME` varchar(128) NOT NULL COMMENT '파일명',
  `FILE_PATH` varchar(512) NOT NULL COMMENT '파일저장위치',
  `FILE_TYPE` varchar(10) DEFAULT NULL COMMENT '파일형식',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  PRIMARY KEY (`FILE_ID`),
  KEY `idx_PARTNER_INDIVIDUAL_PHOTO_STORE_01` (`PARTNER_INDIVIDUAL_ID`,`CREATOR_ID`,`CREATE_DATETIME`,`FILE_NAME`),
  CONSTRAINT `partner_individual_photo_store_ibfk_1` FOREIGN KEY (`PARTNER_INDIVIDUAL_ID`) REFERENCES `partner_individual_info` (`PARTNER_INDIVIDUAL_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='고객관리_협력사개인정보_사진저장정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `partner_recruitment_byclient`
--

DROP TABLE IF EXISTS `partner_recruitment_byclient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partner_recruitment_byclient` (
  `RECRUITMENT_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '리크루트아이디',
  `ALIGNMENT_ID` bigint(20) NOT NULL COMMENT '얼라인먼트아이디',
  `STATUS` varchar(10) DEFAULT NULL COMMENT '진행상태',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최종변경일시',
  PRIMARY KEY (`RECRUITMENT_ID`),
  KEY `idx_PARTNER_RECRUITMENT_BYCLIENT_01` (`RECRUITMENT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='파트너_리크루트_고객';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `partner_recruitment_bysegment`
--

DROP TABLE IF EXISTS `partner_recruitment_bysegment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partner_recruitment_bysegment` (
  `RECRUITMENT_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '리크루트아이디',
  `ALIGNMENT_ID` bigint(20) NOT NULL COMMENT '얼라인먼트아이디',
  `STATUS` varchar(10) DEFAULT NULL COMMENT '진행상태',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최종변경일시',
  PRIMARY KEY (`RECRUITMENT_ID`),
  KEY `idx_PARTNER_RECRUITMENT_BYSEGMENT_01` (`RECRUITMENT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='파트너_리크루트_산업';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `partner_sales_linakge`
--

DROP TABLE IF EXISTS `partner_sales_linakge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partner_sales_linakge` (
  `LINKAGE_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '세일즈링키지아이디',
  `PARTNER_ID` bigint(20) unsigned NOT NULL COMMENT '협력회사아이디',
  `FISCAL_YEAR` year(4) NOT NULL COMMENT '회계연도',
  `BIZ_SEGMENT` varchar(20) NOT NULL COMMENT '사업부문',
  `SALES_REP_ID` varchar(20) DEFAULT NULL COMMENT '자사영업직원아이디',
  `RELATED_STAFF` varchar(20) DEFAULT NULL COMMENT '자사관련직원',
  `DIGITAL` varchar(20) DEFAULT NULL COMMENT '디지털',
  `CADENCE_CYCLE` varchar(20) DEFAULT NULL COMMENT '케이던스주기',
  `CADENCE_TYPE` varchar(20) DEFAULT NULL COMMENT '케이던스타입',
  `PARTNER_INDIVIDUAL_ID` varchar(500) DEFAULT NULL COMMENT '협력회사직원아이디',
  `CREATOR_ID` varchar(10) DEFAULT NULL COMMENT '작성자',
  `CREATE_DATE` date DEFAULT NULL COMMENT '작성일자',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `PARTNER_CODE` varchar(100) DEFAULT NULL COMMENT '협력분류코드',
  PRIMARY KEY (`LINKAGE_ID`),
  KEY `idx_PARTNER_SALES_LINAKGE_01` (`PARTNER_ID`,`FISCAL_YEAR`,`BIZ_SEGMENT`,`SALES_REP_ID`,`CREATOR_ID`,`CREATE_DATE`,`PARTNER_INDIVIDUAL_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2022 DEFAULT CHARSET=utf8 COMMENT='파트너_세일즈링크';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `partner_sales_linakge_file_store`
--

DROP TABLE IF EXISTS `partner_sales_linakge_file_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partner_sales_linakge_file_store` (
  `FILE_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '파일아이디',
  `LINKAGE_ID` bigint(20) unsigned NOT NULL COMMENT '파트너협업 아이디',
  `CREATOR_ID` varchar(20) NOT NULL COMMENT '작성자아이디',
  `CREATE_DATETIME` datetime NOT NULL COMMENT '작성일시',
  `FILE_NAME` varchar(128) NOT NULL COMMENT '파일명',
  `FILE_PATH` varchar(512) NOT NULL COMMENT '파일저장위치',
  `FILE_TYPE` varchar(10) DEFAULT NULL COMMENT '파일형식',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `CADENCE_ID` bigint(20) unsigned NOT NULL COMMENT '케이던스아이디',
  PRIMARY KEY (`FILE_ID`),
  KEY `idx_PARTNER_SALES_LINAKGE_FILE_STORE_01` (`LINKAGE_ID`,`CREATOR_ID`,`CREATE_DATETIME`,`FILE_NAME`),
  CONSTRAINT `partner_sales_linakge_file_store_ibfk_1` FOREIGN KEY (`LINKAGE_ID`) REFERENCES `partner_sales_linakge` (`LINKAGE_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='파트너협업_파일저장정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `partner_skill_map`
--

DROP TABLE IF EXISTS `partner_skill_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partner_skill_map` (
  `SKILL_MAP_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '스킬맵아이디',
  `PARTNER_INDIVIDUAL_ID` bigint(20) unsigned NOT NULL COMMENT '협력회사직원아이디',
  `SOLUTION_ID` bigint(20) unsigned NOT NULL COMMENT '솔루션아이디',
  `SKILL_CATEGORY` varchar(1) NOT NULL COMMENT '스킬구분',
  `SKILL_LEVEL` varchar(1) NOT NULL COMMENT '스킬레벨',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  PRIMARY KEY (`SKILL_MAP_ID`),
  KEY `idx_PARTNER_SKILL_MAP_01` (`PARTNER_INDIVIDUAL_ID`,`SOLUTION_ID`,`SKILL_CATEGORY`,`SKILL_LEVEL`),
  KEY `SOLUTION_ID` (`SOLUTION_ID`),
  CONSTRAINT `partner_skill_map_ibfk_1` FOREIGN KEY (`SOLUTION_ID`) REFERENCES `vendor_solution_area` (`SOLUTION_ID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `partner_skill_map_ibfk_2` FOREIGN KEY (`PARTNER_INDIVIDUAL_ID`) REFERENCES `partner_individual_info` (`PARTNER_INDIVIDUAL_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='협력회사스킬맵';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project_mgmt`
--

DROP TABLE IF EXISTS `project_mgmt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_mgmt` (
  `PROJECT_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '프로젝트아이디',
  `CREATOR_ID` varchar(20) NOT NULL COMMENT '작성자명',
  `CREATE_DATETIME` datetime DEFAULT NULL COMMENT '작성일시',
  `PROJECT_SUBJECT` varchar(200) NOT NULL COMMENT '프로젝트제목',
  `DETAIL_CONTENTS` text COMMENT '상세내용',
  `START_DATE` date NOT NULL COMMENT '시작일자',
  `END_DATE` date NOT NULL COMMENT '종료일자',
  `CLIENT_COMPANY_ID` bigint(20) unsigned NOT NULL COMMENT '고객사아이디',
  `CUSTOMER_ID` bigint(20) unsigned NOT NULL COMMENT '고객아이디',
  `CLIENT_PM_ID` bigint(20) unsigned NOT NULL COMMENT '고객PM아이디',
  `CLIENT_EXEC_PM_ID` bigint(20) unsigned NOT NULL COMMENT '고객수행PM아이디',
  `OUR_PM_ID` bigint(20) unsigned NOT NULL COMMENT '우리PM아이디',
  `OUR_EXEC_PM_ID` bigint(20) unsigned NOT NULL COMMENT '우리수행PM아이디',
  `PARTNER_NAMES` varchar(100) DEFAULT NULL COMMENT '파트너사명',
  `PARTNER_SALES_REPS` varchar(100) DEFAULT NULL COMMENT '파트너영업대표',
  `AUDIT_COMPANY_NAME` varchar(100) DEFAULT NULL COMMENT '감리회사명',
  `AUDIT_INDIVIDUAL_NAMES` varchar(200) DEFAULT NULL COMMENT '감리사명',
  `AUDIT_INDIVIDUAL_CONTACTS` varchar(200) DEFAULT NULL COMMENT '감리사연락처',
  `CONTRACT_AMOUNT_TOTAL` decimal(12,0) DEFAULT NULL COMMENT '계약금액합계',
  `CONTRACT_AMOUNT_1Q` decimal(12,0) DEFAULT NULL COMMENT '계약금액_1Q',
  `CONTRACT_AMOUNT_2Q` decimal(12,0) DEFAULT NULL COMMENT '계약금액_2Q',
  `CONTRACT_AMOUNT_3Q` decimal(12,0) DEFAULT NULL COMMENT '계약금액_3Q',
  `CONTRACT_AMOUNT_4Q` decimal(12,0) DEFAULT NULL COMMENT '계약금액_4Q',
  `CONTRACT_AMOUNT_NAME_1Q` varchar(20) DEFAULT NULL COMMENT '계약금액_명칭_1Q',
  `CONTRACT_AMOUNT_NAME_2Q` varchar(20) DEFAULT NULL COMMENT '계약금액_명칭_2Q',
  `CONTRACT_AMOUNT_NAME_3Q` varchar(20) DEFAULT NULL COMMENT '계약금액_명칭_3Q',
  `CONTRACT_AMOUNT_NAME_4Q` varchar(20) DEFAULT NULL COMMENT '계약금액_명칭_4Q',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `SALES_REPRESENTIVE_ID` bigint(20) unsigned DEFAULT NULL COMMENT '영업대표아이디',
  `CLIENT_RELATION_NAMES` varchar(500) DEFAULT NULL COMMENT '고객주요이해당사자',
  `PROGRESS` int(11) DEFAULT NULL COMMENT '진행율',
  `CONTRACT_AMOUNT_UNIT` char(1) DEFAULT NULL COMMENT '계약금액단위',
  PRIMARY KEY (`PROJECT_ID`),
  KEY `idx_PROJECT_MGMT_01` (`PROJECT_SUBJECT`,`START_DATE`,`CLIENT_PM_ID`,`CLIENT_EXEC_PM_ID`,`OUR_PM_ID`,`OUR_EXEC_PM_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='프로젝트관리';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project_mgmt_amount`
--

DROP TABLE IF EXISTS `project_mgmt_amount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_mgmt_amount` (
  `AMOUNT_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '개별금액아이디',
  `PROJECT_ID` bigint(20) unsigned NOT NULL COMMENT '프로젝트아이디',
  `CREATOR_ID` varchar(20) NOT NULL COMMENT '작성자아이디',
  `CREATE_DATETIME` datetime NOT NULL COMMENT '작성일시',
  `BASIS_MONTH` date DEFAULT NULL COMMENT '매출기준월',
  `BASIS_PLAN_REVENUE_AMOUNT` decimal(12,0) DEFAULT NULL COMMENT '계획매출금액',
  `BASIS_ACTUAL_REVENUE_AMOUNT` decimal(12,0) DEFAULT NULL COMMENT '실제매출금액',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  PRIMARY KEY (`AMOUNT_ID`),
  KEY `idx_PROJECT_MGMT_AMOUNT_01` (`PROJECT_ID`,`CREATOR_ID`,`CREATE_DATETIME`,`BASIS_MONTH`),
  CONSTRAINT `project_mgmt_amount_ibfk_1` FOREIGN KEY (`PROJECT_ID`) REFERENCES `project_mgmt` (`PROJECT_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='프로젝트_계약금액상세';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project_mgmt_file_store`
--

DROP TABLE IF EXISTS `project_mgmt_file_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_mgmt_file_store` (
  `FILE_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '파일아이디',
  `PROJECT_ID` bigint(20) unsigned NOT NULL COMMENT '프로젝트아이디',
  `CREATOR_ID` varchar(20) NOT NULL COMMENT '작성자아이디',
  `CREATE_DATETIME` datetime NOT NULL COMMENT '작성일시',
  `FILE_NAME` varchar(128) NOT NULL COMMENT '파일명',
  `FILE_PATH` varchar(512) NOT NULL COMMENT '파일저장위치',
  `FILE_TYPE` varchar(10) DEFAULT NULL COMMENT '파일형식',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  PRIMARY KEY (`FILE_ID`),
  KEY `idx_PROJECT_MGMT_FILE_STORE_01` (`PROJECT_ID`,`CREATOR_ID`,`CREATE_DATETIME`,`FILE_NAME`),
  CONSTRAINT `project_mgmt_file_store_ibfk_1` FOREIGN KEY (`PROJECT_ID`) REFERENCES `project_mgmt` (`PROJECT_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='프로젝트계획_파일저장정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project_mgmt_issue`
--

DROP TABLE IF EXISTS `project_mgmt_issue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_mgmt_issue` (
  `ISSUE_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '이슈아이디',
  `PROJECT_ID` bigint(20) unsigned NOT NULL COMMENT '프로젝트아이디',
  `ISSUE_DATE` date NOT NULL COMMENT '이슈발생일자',
  `DUE_DATE` date NOT NULL COMMENT '해결목표기한일자',
  `ISSUE_STATUS` char(1) NOT NULL COMMENT '이슈상태',
  `ISSUE_DETAIL` varchar(1024) NOT NULL COMMENT '이슈상세내용',
  `SOLVE_PLAN` text COMMENT '이슈해결계획',
  `SOLVE_OWNER` varchar(20) DEFAULT NULL COMMENT '이슈해결책임자',
  `ISSUE_CLOSE_DATE` date DEFAULT NULL COMMENT '이슈해결일자',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `CHECKLIST_SEQ` int(11) DEFAULT NULL,
  `CHECKLIST_NAME` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`ISSUE_ID`),
  KEY `idx_PROJECT_MGMT_ISSUE_01` (`PROJECT_ID`,`DUE_DATE`,`ISSUE_DATE`,`ISSUE_STATUS`,`SOLVE_OWNER`),
  CONSTRAINT `project_mgmt_issue_ibfk_1` FOREIGN KEY (`PROJECT_ID`) REFERENCES `project_mgmt` (`PROJECT_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='프로젝트관리_마일스톤';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project_mgmt_milestone`
--

DROP TABLE IF EXISTS `project_mgmt_milestone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_mgmt_milestone` (
  `MILESTONE_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '마일스톤아이디',
  `PROJECT_ID` bigint(20) unsigned NOT NULL COMMENT '프로젝트아이디',
  `Category` varchar(10) NOT NULL COMMENT '카테고리',
  `CREATOR_ID` varchar(20) NOT NULL COMMENT '작성자아이디',
  `CREATE_DATETIME` datetime NOT NULL COMMENT '작성일시',
  `KEY_MILESTONE` varchar(200) NOT NULL COMMENT '키마일스톤',
  `ACT_ID` varchar(20) NOT NULL COMMENT '실행담당자',
  `ACT_DUE_DATE` date DEFAULT NULL COMMENT '실행기한일자',
  `ACT_CLOSE_DATE` date DEFAULT NULL COMMENT '실행완료일자',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `MILESTONE_SEQ` int(11) NOT NULL COMMENT '마일스톤순서',
  PRIMARY KEY (`MILESTONE_ID`),
  KEY `idx_PROJECT_MILESTONE_01` (`PROJECT_ID`,`Category`,`CREATOR_ID`,`CREATE_DATETIME`,`KEY_MILESTONE`),
  CONSTRAINT `project_mgmt_milestone_ibfk_1` FOREIGN KEY (`PROJECT_ID`) REFERENCES `project_mgmt` (`PROJECT_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='프로젝트관리_마일스톤';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project_plan`
--

DROP TABLE IF EXISTS `project_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_plan` (
  `PROJECT_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '프로젝트아이디',
  `CREATOR_ID` varchar(20) NOT NULL COMMENT '작성자명',
  `CREATE_DATETIME` datetime DEFAULT NULL COMMENT '작성일시',
  `Category` varchar(10) DEFAULT NULL COMMENT '카테고리',
  `COMPANY_ID` bigint(20) unsigned DEFAULT NULL COMMENT '고객사아이디',
  `EXEC_OWNER` varchar(10) DEFAULT NULL COMMENT '실행책임자',
  `SALES_OWNER` varchar(10) DEFAULT NULL COMMENT '영업담당자',
  `SUBJECT` varchar(200) DEFAULT NULL COMMENT '프로젝트제목',
  `DETAIL_CONTENTS` varchar(1024) DEFAULT NULL COMMENT '프로젝트상세내용',
  `START_DATE` date DEFAULT NULL COMMENT '시작일자',
  `END_DATE` date DEFAULT NULL COMMENT '종료일자',
  `CONTRACT_AMOUNT_TOTAL` decimal(12,0) DEFAULT NULL COMMENT '계약금액합계',
  `CONTRACT_AMOUNT_1Q` decimal(12,0) DEFAULT NULL COMMENT '계약금액_1Q',
  `CONTRACT_AMOUNT_2Q` decimal(12,0) DEFAULT NULL COMMENT '계약금액_2Q',
  `CONTRACT_AMOUNT_3Q` decimal(12,0) DEFAULT NULL COMMENT '계약금액_3Q',
  `CONTRACT_AMOUNT_4Q` decimal(12,0) DEFAULT NULL COMMENT '계약금액_4Q',
  `CONTRACT_AMOUNT_NAME_1Q` varchar(20) DEFAULT NULL COMMENT '계약금액_명칭_1Q',
  `CONTRACT_AMOUNT_NAME_2Q` varchar(20) DEFAULT NULL COMMENT '계약금액_명칭_2Q',
  `CONTRACT_AMOUNT_NAME_3Q` varchar(20) DEFAULT NULL COMMENT '계약금액_명칭_3Q',
  `CONTRACT_AMOUNT_NAME_4Q` varchar(20) DEFAULT NULL COMMENT '계약금액_명칭_4Q',
  `INVEST_AMOUNT_TOTAL` decimal(12,0) DEFAULT NULL COMMENT '투자금액합계',
  `INVEST_AMOUNT_1Q` decimal(12,0) DEFAULT NULL COMMENT '투자금액_1Q',
  `INVEST_AMOUNT_2Q` decimal(12,0) DEFAULT NULL COMMENT '투자금액_2Q',
  `INVEST_AMOUNT_3Q` decimal(12,0) DEFAULT NULL COMMENT '투자금액_3Q',
  `INVEST_AMOUNT_4Q` decimal(12,0) DEFAULT NULL COMMENT '투자금액_4Q',
  `INVEST_AMOUNT_NAME_1Q` varchar(20) DEFAULT NULL COMMENT '투자금액_명칭_1Q',
  `INVEST_AMOUNT_NAME_2Q` varchar(20) DEFAULT NULL COMMENT '투자금액_명칭_2Q',
  `INVEST_AMOUNT_NAME_3Q` varchar(20) DEFAULT NULL COMMENT '투자금액_명칭_3Q',
  `INVEST_AMOUNT_NAME_4Q` varchar(20) DEFAULT NULL COMMENT '투자금액_명칭_4Q',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  PRIMARY KEY (`PROJECT_ID`),
  KEY `idx_PROJECT_PLAN_01` (`Category`,`CREATE_DATETIME`,`SUBJECT`,`SALES_OWNER`)
) ENGINE=InnoDB AUTO_INCREMENT=10000012 DEFAULT CHARSET=utf8 COMMENT='프로젝트계획';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project_plan_file_store`
--

DROP TABLE IF EXISTS `project_plan_file_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_plan_file_store` (
  `FILE_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '파일아이디',
  `PROJECT_ID` bigint(20) unsigned NOT NULL COMMENT '프로젝트아이디',
  `CREATOR_ID` varchar(20) NOT NULL COMMENT '작성자아이디',
  `CREATE_DATETIME` datetime NOT NULL COMMENT '작성일시',
  `FILE_NAME` varchar(128) NOT NULL COMMENT '파일명',
  `FILE_PATH` varchar(512) NOT NULL COMMENT '파일저장위치',
  `FILE_TYPE` varchar(10) DEFAULT NULL COMMENT '파일형식',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  PRIMARY KEY (`FILE_ID`),
  KEY `idx_PROJECT_PLAN_FILE_STORE_01` (`PROJECT_ID`,`CREATOR_ID`,`CREATE_DATETIME`,`FILE_NAME`),
  CONSTRAINT `project_plan_file_store_ibfk_1` FOREIGN KEY (`PROJECT_ID`) REFERENCES `project_plan` (`PROJECT_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='프로젝트계획_파일저장정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `proposal_file_store`
--

DROP TABLE IF EXISTS `proposal_file_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proposal_file_store` (
  `FILE_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '파일아이디',
  `PROPOSAL_ID` bigint(20) unsigned NOT NULL COMMENT '제안아이디',
  `CREATOR_ID` varchar(20) NOT NULL COMMENT '작성자아이디',
  `CREATE_DATETIME` datetime NOT NULL COMMENT '작성일시',
  `FILE_NAME` varchar(128) NOT NULL COMMENT '파일명',
  `FILE_PATH` varchar(512) NOT NULL COMMENT '파일저장위치',
  `FILE_TYPE` varchar(10) DEFAULT NULL COMMENT '파일형식',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  PRIMARY KEY (`FILE_ID`),
  KEY `idx_PROPOSAL_FILE_STORE_01` (`PROPOSAL_ID`,`CREATOR_ID`,`CREATE_DATETIME`,`FILE_NAME`),
  CONSTRAINT `proposal_file_store_ibfk_1` FOREIGN KEY (`PROPOSAL_ID`) REFERENCES `proposal_mgmt` (`PROPOSAL_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='제안관리_파일저장정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `proposal_mgmt`
--

DROP TABLE IF EXISTS `proposal_mgmt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proposal_mgmt` (
  `PROPOSAL_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '제안아이디',
  `CATEGORY_PRODUCT` varchar(400) NOT NULL COMMENT '제안영역_제품',
  `PROPOSAL_SUBJECT` varchar(400) NOT NULL COMMENT '제안제목',
  `DETAIL_CONTENTS` text COMMENT '상세내용',
  `COMPANY_ID` bigint(20) unsigned DEFAULT NULL COMMENT '고객사아이디',
  `PROPOSAL_LEADER_ID` varchar(40) DEFAULT NULL COMMENT '제안책임자',
  `PROPOSAL_START_DATE` date DEFAULT NULL COMMENT '제안시작일자',
  `PROPOSAL_END_DATE` date DEFAULT NULL COMMENT '제안제출일자',
  `PROPOSAL_PT_DATE` date DEFAULT NULL COMMENT '제안발표일자',
  `PROPOSAL_RESULT_DATE` date DEFAULT NULL COMMENT '제안결과일자',
  `PROPOSAL_AMOUNT` decimal(12,0) DEFAULT NULL COMMENT '제안금액',
  `PROPOSAL_COST_AMOUNT` decimal(12,0) DEFAULT NULL COMMENT '제안비용',
  `PROPOSAL_COST_DETAIL` varchar(1024) DEFAULT NULL COMMENT '제안비용상세',
  `PROPOSAL_RESULT` varchar(20) DEFAULT NULL COMMENT '제안결과',
  `PROPOSAL_RESULT_DETAIL` text COMMENT '제안결과상세',
  `CREATOR_ID` varchar(10) DEFAULT NULL COMMENT '작성자',
  `CREATE_DATE` date DEFAULT NULL COMMENT '작성일자',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `CATEGORY_BIZ` varchar(20) DEFAULT NULL COMMENT '제안영역_비지니스',
  `PROGRESS_STATUS` varchar(10) DEFAULT NULL COMMENT '제안진행상태',
  `PROPOSAL_AMOUNT_DETAIL` varchar(1024) DEFAULT NULL COMMENT '제안금액상세',
  `CUSTOMER_ID` bigint(20) unsigned DEFAULT NULL COMMENT '고객아이디',
  PRIMARY KEY (`PROPOSAL_ID`),
  KEY `idx_PROPOSAL_MGMT_01` (`CATEGORY_PRODUCT`,`COMPANY_ID`,`PROPOSAL_LEADER_ID`,`CREATOR_ID`,`CREATE_DATE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='제안관리';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `rival_company_file_store`
--

DROP TABLE IF EXISTS `rival_company_file_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rival_company_file_store` (
  `FILE_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '파일아이디',
  `RIVAL_COMPANY_ID` bigint(20) unsigned NOT NULL COMMENT '이벤트아이디',
  `CREATOR_ID` varchar(20) NOT NULL COMMENT '작성자아이디',
  `CREATE_DATETIME` datetime NOT NULL COMMENT '작성일시',
  `FILE_NAME` varchar(128) NOT NULL COMMENT '파일명',
  `FILE_PATH` varchar(512) NOT NULL COMMENT '파일저장위치',
  `FILE_TYPE` varchar(10) DEFAULT NULL COMMENT '파일형식',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  PRIMARY KEY (`FILE_ID`),
  KEY `idx_RIVAL_COMPANY_FILE_STORE_01` (`RIVAL_COMPANY_ID`,`CREATOR_ID`,`CREATE_DATETIME`,`FILE_NAME`),
  CONSTRAINT `rival_company_file_store_ibfk_1` FOREIGN KEY (`RIVAL_COMPANY_ID`) REFERENCES `rival_company_log` (`RIVAL_COMPANY_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='경쟁사_파일저장정보';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `rival_company_finance_condition`
--

DROP TABLE IF EXISTS `rival_company_finance_condition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rival_company_finance_condition` (
  `FINANCE_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '재무현황아이디',
  `TOTAL_ASSET` varchar(50) DEFAULT NULL COMMENT '총자산',
  `TOTAL_DEBT` varchar(50) DEFAULT NULL COMMENT '부채총계',
  `SALES_ACCOUNT` varchar(50) DEFAULT NULL COMMENT '매출액',
  `OPERATION_PROFIT` varchar(50) DEFAULT NULL COMMENT '영업이익',
  `NET_PROFIT` varchar(50) DEFAULT NULL COMMENT '당기순이익',
  `SALES_GROWTH_RATE` varchar(10) DEFAULT NULL COMMENT '매출성장률',
  `BUSINESS_GROWTH_RATE` varchar(10) DEFAULT NULL COMMENT '영업이익률',
  `NET_PROFIT_MARGIN` varchar(10) DEFAULT NULL COMMENT '순이익률',
  `CURRENT_RATIO` varchar(10) DEFAULT NULL COMMENT '유동비율',
  `DEBT_RATIO` varchar(10) DEFAULT NULL COMMENT '부채비율',
  `TOTAL_BORROWINGS_TO_TOTAL_ASSETS` varchar(10) DEFAULT NULL COMMENT '차입금의존도',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `RIVAL_COMPANY_ID` bigint(20) unsigned NOT NULL COMMENT '경쟁사회사아이디',
  `STANDARD_YEAR` varchar(4) DEFAULT NULL COMMENT '기준년도',
  `TOTAL` varchar(50) DEFAULT NULL COMMENT '자본총계',
  `MATERIAL_COST` varchar(50) DEFAULT NULL COMMENT '재료비',
  `LABOR_COST` varchar(50) DEFAULT NULL COMMENT '노무비',
  `OUTSIDE_ORDER_EXPENSES` varchar(50) DEFAULT NULL COMMENT '외주비',
  `EXPENSES` varchar(50) DEFAULT NULL COMMENT '경비',
  `SELL_AND_MANAGE_EXPENSES` varchar(50) DEFAULT NULL COMMENT '판매비와 관리비',
  PRIMARY KEY (`FINANCE_ID`),
  KEY `idx_OUR_MEMBERS_INFO_01` (`TOTAL_ASSET`,`SALES_ACCOUNT`,`NET_PROFIT_MARGIN`),
  KEY `idx_OUR_MEMBERS_INFO_02` (`OPERATION_PROFIT`,`NET_PROFIT`,`BUSINESS_GROWTH_RATE`,`NET_PROFIT_MARGIN`,`TOTAL_BORROWINGS_TO_TOTAL_ASSETS`)
) ENGINE=InnoDB AUTO_INCREMENT=10000046 DEFAULT CHARSET=utf8 COMMENT='경쟁사';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rival_company_log`
--

DROP TABLE IF EXISTS `rival_company_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rival_company_log` (
  `RIVAL_COMPANY_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '경쟁사아이디',
  `RIVAL_COMPANY_NAME` varchar(20) DEFAULT NULL COMMENT '경쟁사이름',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `TEL` varchar(20) DEFAULT NULL COMMENT '전화번호',
  `RIVAL_COMPANY_CEO` varchar(10) DEFAULT NULL COMMENT '대표자',
  `SETUP_DATE` datetime DEFAULT NULL COMMENT '설립일',
  `LOCATION` varchar(50) DEFAULT NULL COMMENT '주소',
  `INDUSTRY_CATEGORY` varchar(20) DEFAULT NULL COMMENT '산업분류',
  PRIMARY KEY (`RIVAL_COMPANY_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10000042 DEFAULT CHARSET=utf8 COMMENT='경쟁사';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rival_company_major_products`
--

DROP TABLE IF EXISTS `rival_company_major_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rival_company_major_products` (
  `PRODUCT_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '주요제품아이디',
  `RIVAL_COMPANY_ID` bigint(20) unsigned DEFAULT NULL COMMENT '경쟁사회사아이디',
  `MAJOR_PRODUCTS` varchar(40) DEFAULT NULL COMMENT '주요제품',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  PRIMARY KEY (`PRODUCT_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10000024 DEFAULT CHARSET=utf8 COMMENT='경쟁사';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rival_company_major_stockholder`
--

DROP TABLE IF EXISTS `rival_company_major_stockholder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rival_company_major_stockholder` (
  `MAJOR_STOCKHOLDER_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '주요주주아이디',
  `RIVAL_COMPANY_ID` bigint(20) unsigned DEFAULT NULL COMMENT '경쟁사회사아이디',
  `MAJOR_STOCKHOLDER_NAME` varchar(40) DEFAULT NULL COMMENT '주요주주이름',
  `MAJOR_STOCKHOLDER_PERCENT` varchar(20) DEFAULT NULL COMMENT '주요주주%',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  PRIMARY KEY (`MAJOR_STOCKHOLDER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10000052 DEFAULT CHARSET=utf8 COMMENT='경쟁사';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rival_company_management_condition`
--

DROP TABLE IF EXISTS `rival_company_management_condition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rival_company_management_condition` (
  `MANAGEMENT_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '경영현황아이디',
  `TOTAL_MEMBER` varchar(40) DEFAULT NULL COMMENT '직원수',
  `BUSINESS_SCALE` varchar(1024) DEFAULT NULL COMMENT '기업규모',
  `BUSINESS_TYPE` varchar(1024) DEFAULT NULL COMMENT '기업형태',
  `CAPITAL` varchar(50) DEFAULT NULL COMMENT '자본금',
  `MAIN_BANK` varchar(20) DEFAULT NULL COMMENT '주거래은행',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `RIVAL_COMPANY_ID` bigint(20) unsigned DEFAULT NULL COMMENT '경쟁사회사아이디',
  PRIMARY KEY (`MANAGEMENT_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10000006 DEFAULT CHARSET=utf8 COMMENT='경쟁사';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rival_company_store`
--

DROP TABLE IF EXISTS `rival_company_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rival_company_store` (
  `STORE_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '판매처아이디',
  `RIVAL_COMPANY_ID` bigint(20) unsigned DEFAULT NULL COMMENT '경쟁사회사아이디',
  `STORE_NAME` varchar(40) DEFAULT NULL COMMENT '판매처이름',
  `STORE_PERCENT` varchar(20) DEFAULT NULL COMMENT '판매처%',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  PRIMARY KEY (`STORE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10000010 DEFAULT CHARSET=utf8 COMMENT='경쟁사';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales_territory_align_map`
--

DROP TABLE IF EXISTS `sales_territory_align_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_territory_align_map` (
  `ST_ALIGN_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '영업영역얼라인아이디',
  `MEMBER_ID_NUM` varchar(10) NOT NULL COMMENT '사번',
  `COMPANY_ID` bigint(20) unsigned NOT NULL COMMENT '고객사아이디',
  `GRANTOR_MEMBER_ID_NUM` varchar(10) DEFAULT NULL COMMENT '허가자사번',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  PRIMARY KEY (`ST_ALIGN_ID`),
  UNIQUE KEY `idx_SALES_TERRITORY_ALIGN_MAP_01` (`MEMBER_ID_NUM`,`COMPANY_ID`),
  KEY `COMPANY_ID` (`COMPANY_ID`),
  CONSTRAINT `sales_territory_align_map_ibfk_1` FOREIGN KEY (`MEMBER_ID_NUM`) REFERENCES `our_members_info` (`MEMBER_ID_NUM`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `sales_territory_align_map_ibfk_2` FOREIGN KEY (`COMPANY_ID`) REFERENCES `client_company_info` (`COMPANY_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10020650 DEFAULT CHARSET=utf8 COMMENT='영업영역얼라인먼트맵';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sequence_info`
--

DROP TABLE IF EXISTS `sequence_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sequence_info` (
  `SEQUENCE_INFO_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '시퀀스정보아이디',
  `CLIENT_COMPANY_SEQUENCE_1` bigint(20) unsigned DEFAULT NULL COMMENT '고객사 시퀀스1',
  `CLIENT_COMPANY_SEQUENCE_2` bigint(20) unsigned DEFAULT NULL COMMENT '고객사 시퀀스2',
  `CLIENT_COMPANY_SEQUENCE_3` bigint(20) unsigned DEFAULT NULL COMMENT '고객사 시퀀스3',
  `CLIENT_INDIVIDUAL_SEQUENCE_1` bigint(20) unsigned DEFAULT NULL COMMENT '고객개인 시퀀스1',
  `CLIENT_INDIVIDUAL_SEQUENCE_2` bigint(20) unsigned DEFAULT NULL COMMENT '고객개인 시퀀스2',
  `CLIENT_INDIVIDUAL_SEQUENCE_3` bigint(20) unsigned DEFAULT NULL COMMENT '고객개인 시퀀스3',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `CLIENT_COMPANY_SEQUENCE_4` bigint(20) unsigned DEFAULT NULL COMMENT '고객사 시퀀스4',
  `CLIENT_COMPANY_SEQUENCE_5` bigint(20) unsigned DEFAULT NULL COMMENT '고객사 시퀀스5',
  `CLIENT_COMPANY_SEQUENCE_6` bigint(20) unsigned DEFAULT NULL COMMENT '고객사 시퀀스6',
  `CLIENT_INDIVIDUAL_SEQUENCE_4` bigint(20) unsigned DEFAULT NULL COMMENT '고객개인 시퀀스4',
  `CLIENT_INDIVIDUAL_SEQUENCE_5` bigint(20) unsigned DEFAULT NULL COMMENT '고객개인 시퀀스5',
  `CLIENT_INDIVIDUAL_SEQUENCE_6` bigint(20) unsigned DEFAULT NULL COMMENT '고객개인 시퀀스6',
  PRIMARY KEY (`SEQUENCE_INFO_ID`),
  KEY `idx_SEQUENCE_INFO_01` (`CLIENT_COMPANY_SEQUENCE_1`,`CLIENT_COMPANY_SEQUENCE_2`,`CLIENT_COMPANY_SEQUENCE_3`,`CLIENT_INDIVIDUAL_SEQUENCE_1`,`CLIENT_INDIVIDUAL_SEQUENCE_2`,`CLIENT_INDIVIDUAL_SEQUENCE_3`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='시퀀스 정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vendor_solution_area`
--

DROP TABLE IF EXISTS `vendor_solution_area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vendor_solution_area` (
  `SOLUTION_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '솔루션아이디',
  `PRODUCT_VENDOR` varchar(50) NOT NULL COMMENT '제조사',
  `PRODUCT_GROUP` varchar(100) NOT NULL COMMENT '제품그룹',
  `SOLUTION_AREA` varchar(100) NOT NULL COMMENT '솔루션영역',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `USE_YN` char(1) DEFAULT 'N',
  PRIMARY KEY (`SOLUTION_ID`),
  KEY `idx_VENDOR_SOLUTION_AREA_01` (`PRODUCT_VENDOR`,`PRODUCT_GROUP`,`SOLUTION_AREA`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='벤더솔루션영역';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'sellers'
--
/*!50003 DROP PROCEDURE IF EXISTS `gen_opportunity_history_byweekly` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`192.168.1.178` PROCEDURE `gen_opportunity_history_byweekly`(
)
BEGIN
	
	DELETE FROM SELLERS.OPPORTUNITY_LOG_HISTORY
	WHERE DATE_FORMAT(SYS_REGISTER_DATE,'%Y-%m-%d') = DATE_FORMAT(CURRENT_TIMESTAMP,'%Y-%m-%d');
	
	
	INSERT INTO SELLERS.OPPORTUNITY_LOG_HISTORY
	(OPPORTUNITY_ID, CONTRACT_DATE, DIVISION_NO, TCV_PLAN, TCV_GP_PLAN, REV_PLAN, GP_PLAN, FORECAST_YN, SYS_REGISTER_DATE)
	SELECT 
		OL.OPPORTUNITY_ID, 
		OL.CONTRACT_DATE,
		OA.DIVISION_NO,
		IF(OMI.MEMBER_ID_NUM IS NOT NULL,OL.CONTRACT_AMOUNT,0) AS CONTRACT_AMOUNT,
		IF(OMI.MEMBER_ID_NUM IS NOT NULL,OL.GP_AMOUNT,0) AS GP_AMOUNT,
		OA.BASIS_PLAN_REVENUE_AMOUNT, 
		OA.BASIS_PLAN_GP_AMOUNT,
		OL.FORECAST_YN,
		CURRENT_TIMESTAMP
	FROM 
		SELLERS.OPPORTUNITY_LOG AS OL
		INNER JOIN
		SELLERS.OPPORTUNITY_AMOUNT AS OA ON OA.OPPORTUNITY_ID = OL.OPPORTUNITY_ID AND YEAR(OL.CONTRACT_DATE) = YEAR(OA.BASIS_MONTH) AND QUARTER(OL.CONTRACT_DATE) = QUARTER(OA.BASIS_MONTH) 
		LEFT OUTER JOIN
		SELLERS.OUR_MEMBERS_INFO AS OMI ON OL.OWNER_ID = OMI.MEMBER_ID_NUM AND OA.DIVISION_NO = OMI.MEMBER_DIVISION;
	COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `gen_timecode_statics_bydaily` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`192.168.1.35` PROCEDURE `gen_timecode_statics_bydaily`(
	IN	GEN_YYYYMMDD	VARCHAR(20)
)
begin
	DECLARE m_HOLIDAY_YYYYMMDD varchar(20);
	DECLARE m_basis_time int;
	DECLARE m_weekofday int;
	DECLARE m_gen_date date;

	set m_gen_date = (select DATE_FORMAT(GEN_YYYYMMDD, '%Y%m%d'));
	set m_basis_time =  8;

	
	select HOLIDAY_YYYYMMDD
	into   m_HOLIDAY_YYYYMMDD
	from calendar_holiday
	where HOLIDAY_YYYYMMDD = GEN_YYYYMMDD
	and HOLIDAY_TYPE <= '3'
	limit 1;
	

	
	
	if (m_HOLIDAY_YYYYMMDD is null )
	then
		set @m_basis_time =  0;
	end if;

	
	set m_weekofday = (select dayofweek(GEN_YYYYMMDD));
	if (m_weekofday = 1 or m_weekofday = 7 )
	then
		set m_basis_time =  0;
	end if;



	
	DELETE FROM sellers.anal_individual_time
	WHERE ANAL_DATE = GEN_YYYYMMDD;
	
	
	INSERT INTO sellers.anal_individual_time
	( MEMBER_ID_NUM, ANAL_DATE, ANAL_BASIS_TIME, ACTIVITY_CODE_1_TIME, ACTIVITY_CODE_2_TIME, ACTIVITY_CODE_3_TIME, ACTIVITY_CODE_4_TIME, ACTIVITY_CODE_5_TIME, ACTIVITY_CODE_6_TIME, ACTIVITY_CODE_7_TIME, ACTIVITY_CODE_11_TIME, ACTIVITY_CODE_12_TIME)
	select  AA.MEMBER_ID_NUM,
		m_gen_date as ANAL_DATE,
        8 as ANAL_BASIS_TIME ,
        COALESCE(BB.EVENT_1,0) as ACTIVITY_CODE_1_TIME,
        COALESCE(BB.EVENT_2,0) as ACTIVITY_CODE_2_TIME,
        COALESCE(BB.EVENT_3,0) as ACTIVITY_CODE_3_TIME,
        COALESCE(BB.EVENT_4,0) as ACTIVITY_CODE_4_TIME,
        COALESCE(BB.EVENT_5,0) as ACTIVITY_CODE_5_TIME,
        COALESCE(BB.EVENT_6,0) as ACTIVITY_CODE_6_TIME,
        COALESCE(BB.EVENT_7,0) as ACTIVITY_CODE_7_TIME,
        COALESCE(BB.EVENT_11,0) as ACTIVITY_CODE_11_TIME,
        COALESCE(BB.EVENT_12,0) as ACTIVITY_CODE_12_TIME
	from
	(
			SELECT m_gen_date as basis_date, MEMBER_ID_NUM
			FROM SELLERS.our_members_info as omi
			where omi.JOIN_DATE <= m_gen_date
			and omi.STOP_DATE is null
	) as AA left outer join (
			SELECT 
                     MEMBER_ID_NUM,
                     SUM(IF(CE.EVENT_CODE = 1,TIMESTAMPDIFF(MINUTE, CE.START_DATETIME, CE.END_DATETIME)/60,0)) AS EVENT_1,                     
                     SUM(IF(CE.EVENT_CODE = 2,TIMESTAMPDIFF(MINUTE, CE.START_DATETIME, CE.END_DATETIME)/60,0)) AS EVENT_2,
                     SUM(IF(CE.EVENT_CODE = 3,TIMESTAMPDIFF(MINUTE, CE.START_DATETIME, CE.END_DATETIME)/60,0)) AS EVENT_3,
                     SUM(IF(CE.EVENT_CODE = 4,TIMESTAMPDIFF(MINUTE, CE.START_DATETIME, CE.END_DATETIME)/60,0)) AS EVENT_4,
                     SUM(IF(CE.EVENT_CODE = 5,TIMESTAMPDIFF(MINUTE, CE.START_DATETIME, CE.END_DATETIME)/60,0)) AS EVENT_5,
                     SUM(IF(CE.EVENT_CODE = 6,TIMESTAMPDIFF(MINUTE, CE.START_DATETIME, CE.END_DATETIME)/60,0)) AS EVENT_6,
                     SUM(IF(CE.EVENT_CODE = 7,TIMESTAMPDIFF(MINUTE, CE.START_DATETIME, CE.END_DATETIME)/60,0)) AS EVENT_7,
                     SUM(IF(CE.EVENT_CODE = 11,TIMESTAMPDIFF(MINUTE, CE.START_DATETIME, CE.END_DATETIME)/60,0)) AS EVENT_11,
                     SUM(IF(CE.EVENT_CODE = 12,TIMESTAMPDIFF(MINUTE, CE.START_DATETIME, CE.END_DATETIME)/60,0)) AS EVENT_12
           FROM SELLERS.CALENDAR_EVENT as  CE
           where START_DATETIME >= m_gen_date
           AND START_DATETIME < date_add(m_gen_date,interval 1 day)
	) as BB
	on AA.MEMBER_ID_NUM = BB.MEMBER_ID_NUM
	;
	
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `upload_customer_from_usms` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`192.168.1.35` PROCEDURE `upload_customer_from_usms`(
	IN	CREATOR_NAME	VARCHAR(20),
	IN	IN_COMPANY_NAME	VARCHAR(40),
	IN	CUSTOMER_NAME	VARCHAR(40),
	IN	CUSTOMER_POSITION	VARCHAR(40),
	IN	CELL_PHONE			VARCHAR(40),
	IN	PHONE				VARCHAR(40),
	IN	EMAIL				VARCHAR(100),
	in	ADDRESS				VARCHAR(200),
	in	PERSONAL_INFO		VARCHAR(1024)
)
BEGIN
	DECLARE m_company_id BIGINT;
	DECLARE m_creator_id varchar(100);
	declare m_company_name varchar(40);
	declare m_msg	varchar(1024);
	
	set m_company_name = '';
	set m_company_id = null;
	
	if (IN_COMPANY_NAME = '' or IN_COMPANY_NAME is null)
	then
		set m_company_name =  concat('NotSpecified','');
	else
		set m_company_name =  concat(IN_COMPANY_NAME , '');
	end if;


	
	select company_id 
	into   m_company_id
	from sellers.client_company_info
	where COMPANY_NAME like concat( '%',m_company_name, '%')
	limit 1;
	
	
	if (m_company_id is null )
	then
		set m_company_id =  10000000;
	end if;
	
	
	select MEMBER_ID_NUM 
	into   m_creator_id
	from sellers.our_members_info A
	where A.HAN_NAME = CREATOR_NAME
	limit 1;
	
	if (m_creator_id is null )
	then 
		set m_creator_id = "0199";
	end if;





	insert into sellers.client_individual_info (
		CREATOR_ID	
		,COMPANY_ID	
		,CUSTOMER_NAME	
		,POSITION
		,CELL_PHONE		
		,PHONE			
		,EMAIL			
		,ADDRESS			
		,PERSONAL_INFO	
		,INFO_SOURCE
		,CREATE_DATE
	) values (
		m_creator_id	
		,m_company_id	
		,CUSTOMER_NAME	
		,CUSTOMER_POSITION
		,CELL_PHONE		
		,PHONE			
		,EMAIL			
		,ADDRESS			
		,PERSONAL_INFO	
		,'2008년까지의 USMS에서 로드'
		,'2008-01-01'
	);
	
	
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-02-10 16:17:18
