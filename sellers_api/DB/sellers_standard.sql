-- 모바일 디바이스 토큰 테이블
CREATE TABLE `our_user_mobile_device_key` (
  `DEVICE_KEY_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '모바일 디바이스 id',
  `MEMBER_ID_NUM` varchar(10) NOT NULL COMMENT '사번',
  `DEVICE_KEY` text NOT NULL COMMENT '디바이스 키',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  PRIMARY KEY (`DEVICE_KEY_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='사용자 모바일 디바이스 키'

-- 코칭톡 테이블 
CREATE TABLE `coaching_talk` (
  `COACHING_TALK_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '코칭톡아이디',
  `CATEGORY` varchar(10) NOT NULL COMMENT '구분',
  `ID` bigint(20) unsigned NOT NULL COMMENT '데이터아이디',
  `COACHING_TALK_DETAIL` text COMMENT '코칭톡상세내용',
  `MEMBER_ID_NUM` varchar(10) NOT NULL COMMENT '작성자사번',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  `DELETE_YN` char(1) DEFAULT 'N' COMMENT '삭제여부',
  PRIMARY KEY (`COACHING_TALK_ID`),
  KEY `idx_COACHING_TALK_01` (`ID`,`MEMBER_ID_NUM`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='코칭_톡'

-- 서비스프로젝트 팀 관리
CREATE TABLE `com_member_list` (
  `COM_MEMBER_LIST_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '프로젝트팀아이디',
  `LOG_ID` bigint(20) unsigned NOT NULL COMMENT '연관프로젝트아이디',
  `MEMBER_ID_NUM` varchar(10) NOT NULL COMMENT '사번',
  `CATEGORY` varchar(10) DEFAULT NULL COMMENT '구분_사용안함',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  PRIMARY KEY (`COM_MEMBER_LIST_ID`),
  KEY `idx_COM_MEMBER_LIST_01` (`COM_MEMBER_LIST_ID`,`LOG_ID`,`MEMBER_ID_NUM`)
) ENGINE=InnoDB AUTO_INCREMENT=10000393 DEFAULT CHARSET=utf8 COMMENT='프로젝트 팀 관리'

-- 페이징 개인화 관리
CREATE TABLE `com_user_page` (
	`COM_USER_PAGE_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '페이징개인화아이디',
	`MEMBER_ID_NUM` varchar(10) NOT NULL COMMENT '사번',
	`CATEGORY` varchar(20) NOT NULL COMMENT '메뉴카테고리',
	`PAGE_ROWCOUNT` bigint(3) unsigned NOT NULL DEFAULT '15' COMMENT '가져올_리스트_개수',
	`SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
	`SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
	PRIMARY KEY (`COM_USER_PAGE_ID`),
	KEY `idx_COM_USER_PAGE_01` (`COM_USER_PAGE_ID`,`MEMBER_ID_NUM`,`CATEGORY`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='페이징 개인화 관리'
/* 
CATEGORY 
	0 : 전체 기본값
 	1 : 고객컨택 
 	2 : 영업기회 
 	3 : 잠재영업기회 
 	4 : 고객이슈 
	5 : 고객만족도
	6 : 서비스프로젝트
	7 : 제안서정보
	8 : 회사/부문별전략
	9 : 고객별전략
	10 : 전략프로젝트
*/
-- 전 메뉴 기본값 rowCount 15생성
INSERT INTO com_user_page(MEMBER_ID_NUM, CATEGORY, PAGE_ROWCOUNT, SYS_REGISTER_DATE, SYS_UPDATE_DATE) VALUES('default', '0', 15, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);


-- 고객컨택 시작,종료시간,캘린더연동아이디 컬럼 추가
ALTER TABLE sellers_test.client_event_log ADD EVENT_START_TIME TIME DEFAULT NULL COMMENT '컨택시작시간' ;
ALTER TABLE sellers_test.client_event_log ADD EVENT_END_TIME TIME DEFAULT NULL COMMENT '컨택종료시간' ;
ALTER TABLE sellers_test.client_event_log ADD CALENDAR_EVENT_ID BIGINT(20) unsigned NULL COMMENT '일정연동아이디' ;

-- 모바일 랜딩페이지 사용여부 컬럼 추가
ALTER TABLE sellers_test.com_menu ADD MOBILE_LANDING_PAGE_USE_YN CHAR(1) DEFAULT 'N' NULL COMMENT '모바일랜딩페이지사용여부' ;

-- 메뉴테이블에 모바일 페이지 데이터 추가
-- 관리자페이지에서 관리가능하도록 모바일랜딩화면 데이터 부터 추가 : MENU_SEQ 확인 후 추가
INSERT INTO sellers_test.com_menu(MENU_TITLE, MENU_URL, USE_YN, MENU_ICON, MOBILE_LANDING_PAGE_USE_YN, MENU_LEVEL, MENU_SEQ)VALUES
('모바일랜딩화면','#','N','menu_icon menu_icon_custom','N', '1', '10');
-- 먼저 추가한 모바일랜딩화면 id 값을 MENU_PARENT에 입력 후 인서트!!
INSERT INTO sellers_test.com_menu(MENU_TITLE, MENU_URL, USE_YN, MENU_ICON, MOBILE_LANDING_PAGE_USE_YN, MENU_LEVEL, MENU_SEQ, MENU_PARENT)VALUES
('고객사정보','/clientManagement/viewClientCompanyInfoGate.do','N','menu_icon menu_icon_custom','Y', '2', '1',),
('고객개인정보','/clientManagement/viewClientIndividualInfoGate.do','N','menu_icon menu_icon_company','Y', '2', '2',),
('고객컨택내용','/clientSalesActive/viewClientContactList.do','N','menu_icon menu_icon_contact','Y', '2', '3',),
('영업기회','/clientSalesActive/viewOpportunityList.do','N','menu_icon menu_icon_opp','Y', '2', '4',),
('잠재영업기회','/clientSalesActive/viewHiddenOpportunityList.do','N','menu_icon menu_icon_opphidden','Y', '2', '5',),
('고객이슈','/clientSatisfaction/viewClientIssueList.do','N','menu_icon menu_icon_issue','Y', '2', '6',),
('고객만족도','/clientSatisfaction/viewClientSatisfactionList.do','N','menu_icon menu_icon_rate','Y', '2', '7',),
('파트너사협업','/partnerManagement/viewPartnerSalesLinkage.do','N','menu_icon menu_icon_cadence','Y', '2', '8',),
('파트너사정보','/partnerManagement/viewPartnerCompanyInfoGate.do','N','menu_icon menu_icon_company','Y', '2', '9',),
('파트너사개인정보','/partnerManagement/viewPartnerIndividualInfoGate.do','N','menu_icon menu_icon_partner','Y', '2', '10',),
('회사/부문별전략','/bizStrategy/viewBizStrategyCompany.do','N','menu_icon menu_icon_strategy','Y', '2', '11',),
('고객별전략','/bizStrategy/viewBizStrategyClient.do','N','menu_icon menu_icon_strategy','Y', '2', '12',),
('전략프로젝트','/bizStrategy/viewBizStrategyProjectPlan.do','N','menu_icon menu_icon_strategy','Y', '2', '13',),
('일정관리','/calendar/viewCalendar.do','N','menu_icon menu_icon_calendar','Y', '2', '14',),
('마이페이지','/main/myActivePage.do','N','menu_icon menu_icon_mypage','Y', '2', '15',);

-- 모바일 랜딩페이지 사용자 설정 관리 테이블 추가
CREATE TABLE `com_user_mobile_landing_page` (
  `LANDING_PAGE_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '모바일랜딩페이지아이디',
  `MEMBER_ID_NUM` varchar(10) NOT NULL COMMENT '사번',
  `MENU_ID` bigint(20) unsigned NOT NULL COMMENT '메뉴아이디',
  `MENU_SEQ` smallint(6) NOT NULL COMMENT '메뉴순서',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  PRIMARY KEY (`LANDING_PAGE_ID`),
  KEY `idx_MOBILE_LANDING_ID_01` (`LANDING_PAGE_ID`,`MEMBER_ID_NUM`,`MENU_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10000001 DEFAULT CHARSET=utf8 COMMENT='모바일 랜딩페이지 사용자 설정 관리'

-- 기본 사용자 설정 데이터 입력 : 위에 추가한 메뉴아이디값 일력하고 인서트!!
INSERT INTO sellers_test.com_user_mobile_landing_page(MEMBER_ID_NUM, MENU_ID, MENU_SEQ) VALUES
('default', , 1),
('default', , 2),
('default', , 3),
('default', , 4),
('default', , 5),
('default', , 6);

-- 개인 알림설정 테이블
CREATE TABLE `com_user_tracking` (
  `COM_USER_TRACKING_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '알림설정개인화아이디',
  `MEMBER_ID_NUM` varchar(10) NOT NULL COMMENT '사번',
  `TRACKING_CATEGORY` bigint(20) unsigned NOT NULL COMMENT '트래킹메뉴카테고리',
  `TRACKING_CATEGORY_NAME` varchar(20) NOT NULL COMMENT '트래킹메뉴명',
  `FULL_USE_YN` char(1) DEFAULT 'Y' COMMENT '전체알림사용여부',
  `ALARM_USE_YN` char(1) DEFAULT 'Y' COMMENT '알람알림사용여부',
  `MAIL_USE_YN` char(1) DEFAULT 'Y' COMMENT '메일알림사용여부',
  `MOBILE_USE_YN` char(1) DEFAULT 'Y' COMMENT '모바일알림사용여부',
  `BEFORE_DUE_DATE` bigint(3) unsigned NOT NULL DEFAULT '15' COMMENT '기준일 *일 이전 알림',
  `AFTER_DUE_DATE` bigint(3) unsigned NOT NULL DEFAULT '30' COMMENT '기준일 *일 까지  알림',
  `FRQNC_BEFROE_USE_YN` char(1) DEFAULT 'N' COMMENT 'duedate이전빈도사용여부',
  `FRQNC_BEFROE` TEXT NULL COMMENT 'duedate이전빈도',
  `FRQNC_AFTER_USE_YN` char(1) DEFAULT 'N' COMMENT 'duedate이후빈도사용여부',
  `FRQNC_AFTER` TEXT NULL COMMENT 'duedate이후빈도',
  `SYS_REGISTER_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초등록일시',
  `SYS_UPDATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종변경일시',
  PRIMARY KEY (`COM_USER_TRACKING_ID`),
  KEY `idx_COM_USER_TRACKING_01` (`COM_USER_TRACKING_ID`,`MEMBER_ID_NUM`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='개인 알림설정  관리'

-- 기본 설정 데이터 입력
insert sellers_test.com_user_tracking(MEMBER_ID_NUM, TRACKING_CATEGORY, TRACKING_CATEGORY_NAME, BEFORE_DUE_DATE, AFTER_DUE_DATE, FRQNC_BEFROE_USE_YN, FRQNC_BEFROE, FRQNC_AFTER_USE_YN, FRQNC_AFTER) VALUES
('default', '1', '고객컨택_팔로업액션', '7', '30', 'Y', '7,3', 'N', ''),
('default', '2', '영업기회_마일스톤', '7', '30', 'Y', '7,3', 'N', ''),
('default', '3', '영업기회_윈플랜', '7', '30', 'Y', '7,3', 'N', ''),
('default', '4', '영업기회_계약일', '7', '30', 'Y', '7,3', 'N', ''),
('default', '5', '영업기회_매출계획일', '7', '30', 'Y', '7,3', 'N', ''),
('default', '6', '영업기회_수금계획일', '7', '30', 'Y', '7,3', 'N', ''),
('default', '7', '잠재영업기회_액션플랜', '15', '30', 'Y', '15,7', 'N', ''),
('default', '8', '고객이슈_해결목표일', '15', '30', 'Y', '15,7,3', 'N', ''),
('default', '9', '고객이슈_액션플랜', '15', '30', 'Y', '15,7,3', 'N', ''),
('default', '10', '고객만족도_팔로업액션', '15', '30', 'Y', '15,7,3', 'N', ''),
('default', '11', '서비스프로젝트_마일스톤', '15', '30', 'Y', '15,7,3', 'N', ''),
('default', '12', '서비스프로젝트_이슈', '15', '30', 'Y', '15,7,3', 'N', ''),
('default', '13', '제안서정보_제출일', '1', '0', 'Y', '1', 'N', ''),
('default', '14', '제안서정보_제안발표일', '1', '0', 'Y', '1', 'N', ''),
('default', '15', '제안서정보_결과발표일', '1', '0', 'Y', '1', 'N', ''),
('default', '16', '회사/부문전략_키마일스톤', '30', '30', 'Y', '30,15,7,3', 'N', ''),
('default', '17', '회사/부문전략_이슈', '30', '30', 'Y', '30,15,7,3', 'N', ''),
('default', '18', '고객별전략_키마일스톤', '30', '30', 'Y', '30,15,7,3', 'N', ''),
('default', '19', '고객별전략_이슈', '30', '30', 'Y', '30,15,7,3', 'N', ''),
('default', '20', '전략프로젝트_마일스톤', '30', '30', 'Y', '30,15,7,3', 'N', ''),
('default', '21', '전략프로젝트_이슈', '30', '30', 'Y', '30,15,7,3', 'N', '');
