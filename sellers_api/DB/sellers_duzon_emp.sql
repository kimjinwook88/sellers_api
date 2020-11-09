-- sellers_test에서 부서, 팀, 사원 연동 작업 sellers_duzon DDL 실행 후 !!!!!

-- 2018 - 03 - 16
-- 부서 테이블 초기화 
DELETE FROM our_division_info;

-- duzon/selectOurDivisionInfo.do 호출 후 아래 부서 타입 맞추기
/*
	BA사업 본부				T
	Dynatrace 사업본부	S
	Enterprise 사업본부	S
	I&P 본부					T
	IBM HW 사업본부		S
	IBM SW 사업본부		S
	영업지원					T
	Software 사업본부	S
	경영지원부				O
	연구소						M
	마케팅팀					M
	보안사업본부				S
	부산사무소				S
	비즈니스서비스사업부	T
	시스템서비스본부		T
	임원실						O
	임원실						T
*/

-- 2018-03-19
-- 팀 테이블 초기화 
DELETE FROM our_team_info;

-- duzon/selectOurTeamInfo.do 호출 후 타입 또는 팀장 설정