package com.uni.sellers.common;

import java.net.MalformedURLException;
import java.net.URL;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.annotation.Resource;
import javax.mail.Message;
import javax.mail.NoSuchProviderException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

// for SMTP Service
import com.uni.sellers.clientsalesactive.ClientSalesActiveDAO;
import com.uni.sellers.clientsatisfaction.ClientSatisfactionDAO;
import com.uni.sellers.etc.EtcDAO;
import com.uni.sellers.util.CommonDateUtils;
import com.uni.sellers.util.CommonUtils;


@Service("commonMailService")
public class CommonMailService{

	@Resource(name="commonDAO")
	private CommonDAO commonDAO;

	@Resource(name="clientSalesActiveDAO")
	private ClientSalesActiveDAO clientSalesActiveDAO;

	@Resource(name="clientSatisfactionDAO")
	private ClientSatisfactionDAO clientSatisfactionDAO;
	
	@Resource(name="etcDAO")
	private EtcDAO etcDAO;

	@Value("#{config['ip.addr']}")
	private String IP_ADDR;

	@Value("#{config['ip.mailhost']}")
	private String MAIL_HOST;

	@Value("#{config['ip.image']}")
	private String IMAGE_HOST;


	Logger log = LoggerFactory.getLogger(this.getClass());

	public int calendarMeetingSendMail(Map<String, Object> map, ArrayList<Object> toAddr, ArrayList<Object> answerList) throws Exception{

		int cnt = 0;

		String eventId 		= (String) map.get("EVENT_ID");
		//		String eventId 		= map.get("EVENT_ID").toString();
		String invitedId 	= (String) map.get("invitedMemberIdNum"); 		// 초대 받은자 ID
		String invitedEmail = (String) map.get("invitedMemberEmail"); 		// 초대 받은자 Email
		String invitedName 	= (String) map.get("invitedMemberName"); 		// 초대 받은자 이름

		String inviteEmail 	= (String) map.get("hiddenModalEmail"); 		// 초대 하는 사람 Email
		String inviteName 	= (String) map.get("hiddenModalHanName"); 		// 초대 하는 사람 이름

		// String inviteCalId = (String) map.get("inviteMemberCalId"); 		//초대자 기본캘린더 ID

		String subJect 		= (String) map.get("textModalEventSubject"); 	// 제목
		String location 	= (String) map.get("textModalEventLocation"); 	// 장소
		String eventDetail 	= (String) map.get("textareaModalEventDetail").toString().replaceAll("\r\n", "\n").replaceAll("\n", "<br>"); // 상세내용
		String startDate 	= (String) map.get("textModalStartDate"); 		// 일정시작
		String startTime 	= (String) map.get("selectModalStartDateTime"); // 일정시작시간
		String endDate 		= (String) map.get("textModalEndDate"); 		// 일정종료
		String endTime 		= (String) map.get("selectModalEndDateTime"); 	// 일정종료시간
		String eventCode 	= ""; 											// 일정분류

		if (map.get("selectModalEventCode").equals("1")) {
			eventCode = "고객컨택";
		} else if (map.get("selectModalEventCode").equals("2")) {
			eventCode = "컨택준비";
		} else if (map.get("selectModalEventCode").equals("3")) {
			eventCode = "내부회의";
		} else if (map.get("selectModalEventCode").equals("4")) {
			eventCode = "교육";
		} else if (map.get("selectModalEventCode").equals("6")) {
			eventCode = "기타";
		} else if (map.get("selectModalEventCode").equals("7")) {
			eventCode = "휴가";
		}

		//String sellersUrl = "192.168.1.15:3000/userManagement/cal";
		URL agreeUrl = null;
		URL cancelUrl = null;

		try {
			/*			agreeUrl	=	new URL("http://thesellers.unipoint.co.kr:30100/calendar/calendarEventConviteResult.do?status=0"+"&hiddenModalEventId="+eventId+"&inviteId="+invitedId);*/
			agreeUrl	=	new URL(IP_ADDR+"/calendar/calendarEventConviteResult.do?status=0"+"&hiddenModalEventId="+eventId+"&inviteId="+invitedId);
			cancelUrl	=	new URL(IP_ADDR+"/calendar/calendarEventConviteResult.do?status=1"+"&hiddenModalEventId="+eventId+"&inviteId="+invitedId);
		} catch (MalformedURLException e1) {
			e1.printStackTrace();
		}


		String mailSubject  = "[ "+inviteName+"님의 일정 초대_"+eventCode+" ] " + subJect;


		StringBuilder mailContent = new StringBuilder();

		//미팅 시작요일 가져오기
		CommonDateUtils cdu = new CommonDateUtils();
		String startDay = cdu.getDateDay(startDate);

		String startDateTime = startDate+"("+startDay+")" + "  "+ startTime;
		String endDateTime = "";

		//같은 날짜면 미팅 종료 날짜 생략하고 시간만 보낸다.
		if(startDate.equals(endDate)){
			endDateTime = endTime;
		}else{
			//미팅 종료요일 가져오기
			String endDay = cdu.getDateDay(endDate);
			endDateTime = endDate+"("+endDay+")" + "  "+ endTime;
		}

		mailContent.append("			<div class=\"contact_info mg_b30\">");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<strong><label class=\"bar\">일정 제목 : " + subJect +" </label></strong>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<strong><label class=\"bar\">일정 구분 : " + eventCode +" </label></strong>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<strong><label class=\"bar\">초대 일정 : " + startDateTime + " ~ " + endDateTime + "</label></strong>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<strong><label class=\"bar\">장     소 : " + location +"</label></strong>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<strong><label class=\"bar\">일정 내용 : " + eventDetail +"</label></strong>");
		mailContent.append("				</div>");

		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<strong><label class=\"bar\">참석자 명단 : ");
		for(int i=0; i<answerList.size(); i++){
			if(answerList.size()-1==i){
				mailContent.append("				"+ answerList.get(i));
			}else{
				mailContent.append("				"+ answerList.get(i) +", ");
			}
		}
		mailContent.append("					</label></strong>");
		/*
        mailContent.append("					<span class=\"cont_txt\">");
        for(int i=0; i<answerList.size(); i++){
        	if(answerList.size()-1==i){
        		mailContent.append("				"+ answerList.get(i));
        	}else{
        		mailContent.append("				"+ answerList.get(i) +", ");
        	}
        }
        mailContent.append("					</span>");
		 */
		mailContent.append("				</div>");

		/*mailContent.append("				<div class=\"pd_25\">");
        mailContent.append("					<strong><span>참석자 명단</span></strong>");
        mailContent.append("					<table class=\"base\">");
        mailContent.append("						<colgroup>");
        mailContent.append("							<col width=\"100px\"/>");
        mailContent.append("							<col width=\"100px\"/>");
        mailContent.append("							<col width=\"20px\"/>");
        mailContent.append("							<col width=\"20px\"/>");
        mailContent.append("							<col width=\"20px\"/>");
        mailContent.append("						</colgroup>");
        mailContent.append("");
        mailContent.append("						<thead>");
        mailContent.append("							<tr>");
        mailContent.append("								<th>이름</th>");
        mailContent.append("								<th>수락여부</th>");
        mailContent.append("								<th>-</th>");
        mailContent.append("								<th>-</th>");
        mailContent.append("								<th class=\"endcell\">-</th>");
        mailContent.append("							</tr>");
        mailContent.append("						</thead>");
        mailContent.append("");
        mailContent.append("						<tbody>");
        for(int i=0; i<answerList.size(); i++){
        			mailContent.append("							<tr>");
        			mailContent.append("								<td>"+ answerList.get(i) +"</td>");
        			mailContent.append("								<td>"+ answerList.get(i).get("INVITE_YN") +"</td>");
        			mailContent.append("								<td>-</td>");
        			mailContent.append("								<td>-</td>");
        			mailContent.append("								<td class=\"endcell status_yellow\">-</td>");
        			mailContent.append("							</tr>");

        			//mailContent.append(answerList.get(i).get("HAN_NAME") +"&emsp;&emsp;&emsp;&emsp;&emsp;" + answerList.get(i).get("INVITE_YN") +"<br />");
        		}*/
		mailContent.append("						</tbody>");
		mailContent.append("					</table>");
		mailContent.append("				</div>");
		mailContent.append("			</div>");
		mailContent.append("");
		mailContent.append("			<p class=\"ag_c mg_b30 pd_t10\">");
		mailContent.append("				<a href=\"" + agreeUrl.toString()+"\" class=\"btn btn-seller\" style=\"margin: 0 5px; border-radius: 3px; background-color: #2dbae7;  border-color: #2dbae7; color:#fff;\"><span class=\"v_m\"> 수 락 </span></a><span>&nbsp&nbsp</span>");
		mailContent.append("				<a href=\"" + cancelUrl.toString()+"\" class=\"btn btn-seller\" style=\"margin: 0 5px; border-radius: 3px; background-color: #2dbae7;  border-color: #2dbae7; color:#fff;\"><span class=\"v_m\"> 거 절 </span></a>");
		mailContent.append("			</p>");
		mailContent.append("");
		mailContent.append("		</div>");
		mailContent.append("		<!--// 콘텍정보 메일공유 -->");
		mailContent.append("	</div>");
		mailContent.append("	<!--// 콘텐츠 -->");


		//toAddr : 초대받는 사람들의 메일 주소를 array에 집어 넣고 한번에 보낼려고 사용하려다가 링크 문제가 있어 사용안함.
		//sendMailSMTP(mailSubject, mailHtml(mailContent.toString()), inviteEmail, inviteName, toAddr );
		cnt = sendMailCalendarInviteSMTP(mailSubject, mailHtml(mailContent.toString(), null), inviteEmail, inviteName, invitedEmail);

		return cnt;
	}
	
	/**
	 * 일정 초대후 일정 삭제하였을때, 취소 초대자 리스트들에게 초대메일을 보내준다
	 * @param map
	 * @param list
	 * @throws Exception
	 */
	public void calendarEventCanceledMailSend(Map<String, Object> map) throws Exception{
		String eventId 		= (String) map.get("EVENT_ID");
		//		String eventId 		= map.get("EVENT_ID").toString();
		String invitedId 	= (String) map.get("MEMBER_ID_NUM"); 							// 초대 받은자 ID
		String invitedEmail = (String) map.get("EMAIL"); 									// 초대 받은자 Email
		String invitedName 	= (String) map.get("HAN_NAME"); 								// 초대 받은자 이름

		String inviteEmail 	= (String) map.get("SEND_USER_EMAIL"); 							// 초대 하는 사람 Email
		String inviteName 	= (String) map.get("SEND_USER_NAME"); 							// 초대 하는 사람 이름

		String subJect 		= (String) map.get("EVENT_SUBJECT"); 							// 제목
		String startDate 	= map.get("START_DATETIME").toString().substring(0, 10); 		// 일정시작
		String startTime 	= map.get("START_DATETIME").toString().substring(11, 16); 		// 일정시작시간
		String endDate 		= map.get("END_DATETIME").toString().substring(0, 10); 			// 일정종료
		String endTime 		= map.get("END_DATETIME").toString().substring(11, 16); 		// 일정종료시간
		String eventCode 	= ""; 															// 일정분류

		if (map.get("selectModalEventCode").equals("1")) {
			eventCode = "고객컨택";
		} else if (map.get("selectModalEventCode").equals("2")) {
			eventCode = "컨택준비";
		} else if (map.get("selectModalEventCode").equals("3")) {
			eventCode = "내부회의";
		} else if (map.get("selectModalEventCode").equals("4")) {
			eventCode = "교육";
		} else if (map.get("selectModalEventCode").equals("6")) {
			eventCode = "기타";
		} else if (map.get("selectModalEventCode").equals("7")) {
			eventCode = "휴가";
		}

		String mailSubject  = "[ Canceled * "+inviteName+"님의 일정 초대_"+eventCode+" ] " + subJect +" 취소 되었습니다.";


		StringBuilder mailContent = new StringBuilder();

		//미팅 시작요일 가져오기
		CommonDateUtils cdu = new CommonDateUtils();
		String startDay = cdu.getDateDay(startDate);

		String startDateTime = startDate+"("+startDay+")" + "  "+ startTime;
		String endDateTime = "";

		//같은 날짜면 미팅 종료 날짜 생략하고 시간만 보낸다.
		if(startDate.equals(endDate)){
			endDateTime = endTime;
		}else{
			//미팅 종료요일 가져오기
			String endDay = cdu.getDateDay(endDate);
			endDateTime = endDate+"("+endDay+")" + "  "+ endTime;
		}

		mailContent.append("			<div class=\"contact_info mg_b30\">");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<strong><label class=\"bar\">일정 제목 : " + subJect +" 취소 되었습니다.</label></strong>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<strong><label class=\"bar\">일정 구분 : " + eventCode +" </label></strong>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<strong><label class=\"bar\">초대 일정 : " + startDateTime + " ~ " + endDateTime + "</label></strong>");
		mailContent.append("				</div>");
		mailContent.append("			</div>");
		mailContent.append("");
		mailContent.append("		</div>");
		mailContent.append("		<!--// 콘텍정보 메일공유 -->");
		mailContent.append("	</div>");
		mailContent.append("	<!--// 콘텐츠 -->");

		sendMailCalendarInviteSMTP(mailSubject, mailHtml(mailContent.toString(), null), inviteEmail, inviteName, invitedEmail);
	}
	

	/**
	 * 사용안함
	 * @author 	: 장성훈
	 * @Date	: 2016. 9. 29.
	 * @explain : 수락 또는 거절 회신메일
	 */
	public void answerMail(Map<String, Object> map, List<Map<String,Object>> answerList) throws Exception{

		String inviteEmail	=	(String) map.get("hiddenModalEmail");			//초대 하는 사람 Email
		String inviteName	=	(String) map.get("hiddenModalHanName");			//초대 하는 사람 이름

		String answerUserEmail = (String) map.get("EMAIL");   //초대메일을 보낸 당사자 이메일

		String hanName = (String) map.get("HAN_NAME");
		String position = (String) map.get("POSITION_STATUS");

		//미팅 내용
		String subJect = (String) map.get("EVENT_SUBJECT");

		Date start = new Date();
		Date end = new Date();
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		start = (Date) map.get("START_DATETIME");
		end = (Date) map.get("END_DATETIME");
		String startDateTime = transFormat.format(start);
		String endDateTime = transFormat.format(end);

		//		 String startDateTime = (String) map.get("START_DATETIME");
		//		 String endDateTime = (String) map.get("END_DATETIME");
		String eventDetail = (String) map.get("EVENT_DETAIL");
		String answerResult = (String) map.get("answerResult");

		if(answerResult.equals("Y")){
			answerResult = "수락";
		}else if(answerResult.equals("N")){
			answerResult = "거절";
		}

		String eventCode	=	"";	//일정분류

		if (map.get("EVENT_CODE").equals("1")){
			eventCode = "고객컨택";
		}else if (map.get("EVENT_CODE").equals("2")){
			eventCode = "컨택준비";
		}else if (map.get("EVENT_CODE").equals("3")){
			eventCode = "내부회의";
		}else if (map.get("EVENT_CODE").equals("4")){
			eventCode = "교육";
		}else if (map.get("EVENT_CODE").equals("5")){
			eventCode = "기타";
		}

		String mailSubject  = "[ 일정 초대_ "+eventCode+" 에 대한 수락여부 회신 ] ";

		StringBuilder bodyText = new StringBuilder();
		/*bodyText.append("[ "+hanName+" "+position+" ]" +" 일정 초대에 " + answerResult + "하였습니다.");
        bodyText.append("<br /><br />");
		bodyText.append("일정 제목 : " + subJect + "<br />");
		bodyText.append("일정 분류 : " + eventCode + "<br />"); 
		bodyText.append("일정 시작 : " + startDateTime + "<br />");
		bodyText.append("일정 종료 : " + endDateTime + "<br />");
		bodyText.append("일정 내용 : " + eventDetail + "<br />");
		bodyText.append("<br /><br />");

		bodyText.append("=======참석자 목록======="+ "<br />");
		bodyText.append(" 이름&emsp;&emsp;&emsp;&emsp;&emsp;수락여부 " + "<br />");
		bodyText.append("-------------------------"+ "<br />");


		for(int i=0; i<answerList.size(); i++){
			bodyText.append(answerList.get(i).get("HAN_NAME") +"&emsp;&emsp;&emsp;&emsp;&emsp;" + answerList.get(i).get("INVITE_YN") +"<br />");
		}*/

		bodyText.append("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">");
		bodyText.append("<html xmlns=\"http://www.w3.org/1999/xhtml\" lang=\"ko\">");
		bodyText.append("<head>");
		bodyText.append("<meta http-equiv=\"X-UA-Compatible\" content=\"IE=EmulateIE9\">");
		bodyText.append("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />");
		bodyText.append("<title>메일링</title>");
		bodyText.append("<link href=\"http://thesellers.unipoint.co.kr:30100/other/mailform/css/style.css\" rel=\"stylesheet\" type=\"text/css\" />");
		bodyText.append("</head>");

		bodyText.append("<body>");
		bodyText.append("<div class=\"wrap\">");
		bodyText.append("	<!-- 헤더 -->");
		bodyText.append("	<div class=\"header\">");
		bodyText.append("		<span>"+CommonUtils.currentDate("yyyy-MM-dd")+"</span>");
		bodyText.append("		<img src=\"http://thesellers.unipoint.co.kr:30100/other/mailform/images/header.jpg\" alt=\"\"/>");
		bodyText.append("	</div>");
		bodyText.append("	<!--// 헤더 -->");

		bodyText.append("	<!-- 콘텐츠 -->");
		bodyText.append("	<div class=\"content\">");
		bodyText.append("		<!-- 콘텍정보 메일공유 -->");
		bodyText.append("		<div class=\"contact_mag\">");
		bodyText.append("			<p class=\"mg_b10\">");
		bodyText.append("				<strong class=\"fc_sellers\">셀러스</strong>에서 메일을 보냈습니다.");
		bodyText.append("			</p>");
		bodyText.append("");
		bodyText.append("			<div class=\"contact_info mg_b30\">");
		bodyText.append("				<div class=\"row\">");
		bodyText.append("					<label class=\"bar\">일정 제목</label>");
		bodyText.append("					<div class=\"cont_txt\">" + subJect + "</div>");
		bodyText.append("				</div>");
		bodyText.append("");
		bodyText.append("				<div class=\"row\">");
		bodyText.append("					<label class=\"bar\">일정 구분</label>");
		bodyText.append("					<div class=\"cont_txt\">" + eventCode + "</div>");
		bodyText.append("				</div>");
		bodyText.append("");
		bodyText.append("				<div class=\"row\">");
		bodyText.append("					<label class=\"bar\">초대 일정</label>");
		bodyText.append("					<div class=\"cont_txt\">" + startDateTime + " ~ " + endDateTime + "</div>");
		bodyText.append("				</div>");
		bodyText.append("");
		bodyText.append("				<div class=\"row\">");
		bodyText.append("					<label class=\"bar\">일정 내용</label>");
		bodyText.append("					<div class=\"cont_txt\">" + eventDetail + "</div>");
		bodyText.append("				</div>");
		bodyText.append("");
		bodyText.append("				<div class=\"pd_25\">");
		bodyText.append("					<span>참석자 리스트</span>");
		bodyText.append("					<table class=\"base\">");
		bodyText.append("						<colgroup>");
		bodyText.append("							<col width=\"100px\"/>");
		bodyText.append("							<col width=\"100px\"/>");
		bodyText.append("							<col width=\"20px\"/>");
		bodyText.append("							<col width=\"20px\"/>");
		bodyText.append("							<col width=\"20px\"/>");
		bodyText.append("						</colgroup>");
		bodyText.append("");
		bodyText.append("						<thead>");
		bodyText.append("							<tr>");
		bodyText.append("								<th>이름</th>");
		bodyText.append("								<th>수락여부</th>");
		bodyText.append("								<th>-</th>");
		bodyText.append("								<th>-</th>");
		bodyText.append("								<th class=\"endcell\">-</th>");
		bodyText.append("							</tr>");
		bodyText.append("						</thead>");
		bodyText.append("");
		bodyText.append("						<tbody>");
		for(int i=0; i<answerList.size(); i++){
			bodyText.append("							<tr>");
			bodyText.append("								<td>"+ answerList.get(i).get("HAN_NAME") +"</td>");
			bodyText.append("								<td>"+ answerList.get(i).get("INVITE_YN") +"</td>");
			bodyText.append("								<td>-</td>");
			bodyText.append("								<td>-</td>");
			bodyText.append("								<td class=\"endcell status_yellow\">-</td>");
			bodyText.append("							</tr>");

			bodyText.append(answerList.get(i).get("HAN_NAME") +"&emsp;&emsp;&emsp;&emsp;&emsp;" + answerList.get(i).get("INVITE_YN") +"<br />");
		}
		bodyText.append("						</tbody>");
		bodyText.append("					</table>");
		bodyText.append("				</div>");
		bodyText.append("			</div>");
		bodyText.append("");
		bodyText.append("			<p class=\"ag_c mg_b30\">");
		bodyText.append("				<a href=\"#\" class=\"r2 btn_go\"><span class=\"v_m\">관련내용 바로가기</span> <img src=\"http://thesellers.unipoint.co.kr:30100/other/mailform/images/bullet_arrow.png\" class=\"v_m mg_l10\" alt=\"\"/> </a>");
		bodyText.append("			</p>");
		bodyText.append("");
		bodyText.append("		</div>");
		bodyText.append("		<!--// 콘텍정보 메일공유 -->");
		bodyText.append("	</div>");
		bodyText.append("	<!--// 콘텐츠 -->");
		bodyText.append("");
		bodyText.append("	<!-- 푸터 -->");
		bodyText.append("	<div class=\"footer\">");
		bodyText.append("		Copyright Seller’s Company © 2016. ALL RIGHTS RESERVED .");
		bodyText.append("	</div>");
		bodyText.append("	<!--// 푸터 -->");
		bodyText.append("</div>");
		bodyText.append("");
		bodyText.append("</body>");
		bodyText.append("</html>");

		//		sendMail(mailSubject, bodyText.toString(), answerUserEmail, "");

		//ArrayList<Object> toAddr 때문에 에러남. 수정해야함
		//        sendMailSMTP(mailSubject, bodyText.toString(), answerUserEmail, inviteEmail, inviteName);

	}

	//고객컨택 내용 공유
	public void shareContactSendMail(Map<String, Object> map, ArrayList<HashMap<String, Object>> actionGridList, ArrayList<Object> toAddr) throws Exception {
		String mailSubject = null;

		String fromMail 				= (String) map.get("hiddenModalEmail"); 			// 공유자 이메일
		String fromName 				= (String) map.get("hiddenModalHanName"); 			// 공유자 이름
		//String textCommonSearchCompany 	= (String) map.get("textCommonSearchCompany"); 		// 고객사
		//String textModalCustomerName 	= (String) map.get("textModalCustomerName"); 		// 고객명
		String hiddenModalCcList 		= (String) map.get("hiddenModalCcList"); 			// 고객명[고객사] 복수
		String selectModalCategory 		= (String) map.get("selectModalCategory"); 			// 컨택방법
		String textModalSubject 		= (String) map.get("textModalSubject"); 			// 제목
		String textModalEventDate 		= (String) map.get("textModalEventDate"); 			// 컨택일자
		String textareaModalEventContents = (String) map.get("textareaModalEventContents").toString().replaceAll("\r\n", "\n").replaceAll("\n", "<br>"); // 상세내용
		int event_id = (int) map.get("filePK");												//컨택 ID

		URL returnURL = null;

		try {
			returnURL	=	new URL(IP_ADDR+"/clientSalesActive/viewClientContactList.do?event_id="+event_id);
		} catch (MalformedURLException e1) {
			e1.printStackTrace();
		}

		//제목
		mailSubject = "["+hiddenModalCcList+"] 고객컨택 Call Report ("+fromName+")";

		StringBuilder mailContent = new StringBuilder();

		mailContent.append("			<div class=\"contact_info mg_b30\">");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">컨택 목적 : "+ textModalSubject +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">컨택 방법 : "+ selectModalCategory +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">컨택일 : "+ textModalEventDate +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		/*mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">고객사 : "+ textCommonSearchCompany +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">고객명 : "+ textModalCustomerName +"</label>");
		mailContent.append("				</div>");*/
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">고객명 : "+ hiddenModalCcList +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");

		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">컨택내용 : "+ textareaModalEventContents +"</label>");
		mailContent.append("				</div>");

		mailContent.append("				<div class=\"pd_25\">");
		mailContent.append("					<span>Follow-Up-Action</span>");
		mailContent.append("					<table class=\"base\">");
		mailContent.append("						<colgroup>");
		mailContent.append("							<col width=\"180px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"30px\"/>");
		mailContent.append("						</colgroup>");
		mailContent.append("");
		mailContent.append("						<thead>");
		mailContent.append("							<tr>");
		mailContent.append("								<th>내용</th>");
		mailContent.append("								<th>책임자</th>");
		mailContent.append("								<th>해결목표일</th>");
		mailContent.append("								<th>실제완료일</th>");
		mailContent.append("								<th class=\"endcell\">Status</th>");
		mailContent.append("							</tr>");
		mailContent.append("						</thead>");
		mailContent.append("");
		mailContent.append("						<tbody>");
		for(Map<String,Object> getMap : actionGridList){
			String closeDate = "";
			if(getMap.get("SOLVE_CLOSE_DATE") != null){
				closeDate = getMap.get("SOLVE_CLOSE_DATE").toString();
			}
			String statusColor = compareToDateColor(getMap.get("SOLVE_DUE_DATE").toString(), closeDate);// 날짜 비교 색상 
			
			mailContent.append("							<tr>");
			mailContent.append("								<td>"+ getMap.get("CONTENTS") +"</td>");
			mailContent.append("								<td>"+ getMap.get("SOLVE_OWNER_NAME") +"</td>");
			mailContent.append("								<td>"+ getMap.get("SOLVE_DUE_DATE") +"</td>");
			mailContent.append("								<td>"+ getMap.get("SOLVE_CLOSE_DATE") +"</td>");

			if("G".equals(statusColor)){
				mailContent.append("								<td class=\"endcell status_green\"><img src=\"http://thesellers.unipoint.co.kr:30100/other/mailform/images/green.png\" alt=\"\"/></td>");
			}else if("Y".equals(statusColor)){
				mailContent.append("								<td class=\"endcell status_yellow\"><img src=\"http://thesellers.unipoint.co.kr:30100/other/mailform/images/yellow.png\" alt=\"\"/></td>");
			}else if("R".equals(statusColor)){
				mailContent.append("								<td class=\"endcell status_red\"><img src=\"http://thesellers.unipoint.co.kr:30100/other/mailform/images/red.png\" alt=\"\"/></td>");
			}else{
				mailContent.append("								<td>-</td>");
			}

			mailContent.append("							</tr>");
		}
		mailContent.append("						</tbody>");
		mailContent.append("					</table>");
		mailContent.append("				</div>");
		mailContent.append("			</div>");
		mailContent.append("");
		mailContent.append("		</div>");
		mailContent.append("		<!--// 콘텍정보 메일공유 -->");
		mailContent.append("	</div>");
		mailContent.append("	<!--// 콘텐츠 -->");


		//sendMailSMTP(String mailSubject, String bodyText, String fromMail, String fromName, ArrayList<Object> toAddr){
		sendMailSMTP(mailSubject, mailHtml(mailContent.toString(), returnURL), fromMail, fromName, toAddr);
	}
	
	//고객컨택 내용 공유
	public void shareProjectServiceSendMail(Map<String, Object> map, ArrayList<HashMap<String, Object>> projectIssueList, ArrayList<Object> toAddr) throws Exception {
		String mailSubject = null;
		
		String fromMail 				= (String) map.get("hiddenModalEmail"); 			// 공유자 이메일
		String fromName 				= (String) map.get("hiddenModalHanName"); 			// 공유자 이름
		String textModalClientName 		= (String) map.get("clientName"); 		// 고객명
		String textModalClientPMName 	= (String) map.get("clientPmName"); 		// 고객총괄PM
		String textModalSubject 		= (String) map.get("textModalSubject"); 			// 제목
		String textModalStartDate 		= (String) map.get("textModalStartDate"); 			// 시작일
		String textModalEndDate 		= (String) map.get("textModalEndDate"); 			// 종료일
		String textModalOurPMName 		= (String) map.get("ourPmName"); 			// 자사총괄PM
		String textModalOurEXPMName 	= (String) map.get("ourSalesName"); 		// 자사수행PM
		
		String textareaModalContents = (String) map.get("textareaModalContents").toString().replaceAll("\r\n", "\n").replaceAll("\n", "<br>"); // 상세내용
		int serviceProject_id = (int) map.get("filePK");												//컨택 ID
		
		URL returnURL = null;
		
		try {
			returnURL	=	new URL(IP_ADDR+"/clientSatisfaction/viewServiceProject.do?returnProjectMGMTId="+serviceProject_id);
		} catch (MalformedURLException e1) {
			e1.printStackTrace();
		}
		
		//제목
		mailSubject = "["+textModalClientName+"] 서비스프로젝트 ("+fromName+")";
		
		StringBuilder mailContent = new StringBuilder();
		
		mailContent.append("			<div class=\"contact_info mg_b30\">");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">제목 : "+ textModalSubject +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">고객명 : "+ textModalClientName +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">고객총괄PM : "+ textModalClientPMName +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">자사총괄PM : "+ textModalOurPMName +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">영업대표 : "+ textModalOurEXPMName +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		/*mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">고객사 : "+ textCommonSearchCompany +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">고객명 : "+ textModalCustomerName +"</label>");
		mailContent.append("				</div>");*/
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">기간 : "+ textModalStartDate +" ~ "+ textModalEndDate +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">내용 : "+ textareaModalContents +"</label>");
		mailContent.append("				</div>");
		
		mailContent.append("				<div class=\"pd_25\">");
		mailContent.append("					<span>프로젝트 이슈</span>");
		mailContent.append("					<table class=\"base\">");
		mailContent.append("						<colgroup>");
		mailContent.append("							<col width=\"100px\"/>");
		mailContent.append("							<col width=\"100px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"30px\"/>");
		mailContent.append("						</colgroup>");
		mailContent.append("");
		mailContent.append("						<thead>");
		mailContent.append("							<tr>");
		mailContent.append("								<th>이슈내용</th>");
		mailContent.append("								<th>해결계획</th>");
		mailContent.append("								<th>책임자</th>");
		mailContent.append("								<th>해결기한</th>");
		mailContent.append("								<th>해결일</th>");
		mailContent.append("								<th class=\"endcell\">Status</th>");
		mailContent.append("							</tr>");
		mailContent.append("						</thead>");
		mailContent.append("");
		mailContent.append("						<tbody>");
		for(Map<String,Object> getMap : projectIssueList){
			String closeDate = "";
			if(getMap.get("ISSUE_CLOSE_DATE") != null){
				closeDate = getMap.get("ISSUE_CLOSE_DATE").toString();
			}
			String statusColor = compareToDateColor(getMap.get("DUE_DATE").toString(), closeDate);// 날짜 비교 색상 
			
			mailContent.append("							<tr>");
			mailContent.append("								<td>"+ getMap.get("ISSUE_DETAIL") +"</td>");
			mailContent.append("								<td>"+ getMap.get("SOLVE_PLAN") +"</td>");
			mailContent.append("								<td>"+ getMap.get("SOLVE_OWNER") +"</td>");
			mailContent.append("								<td>"+ getMap.get("DUE_DATE") +"</td>");
			mailContent.append("								<td>"+ getMap.get("ISSUE_CLOSE_DATE") +"</td>");
			if("G".equals(statusColor)){
				mailContent.append("								<td class=\"endcell status_green\"><img src=\"http://thesellers.unipoint.co.kr:30100/other/mailform/images/green.png\" alt=\"\"/></td>");
			}else if("Y".equals(statusColor)){
				mailContent.append("								<td class=\"endcell status_yellow\"><img src=\"http://thesellers.unipoint.co.kr:30100/other/mailform/images/yellow.png\" alt=\"\"/></td>");
			}else if("R".equals(statusColor)){
				mailContent.append("								<td class=\"endcell status_red\"><img src=\"http://thesellers.unipoint.co.kr:30100/other/mailform/images/red.png\" alt=\"\"/></td>");
			}else{
				mailContent.append("								<td>-</td>");
			}
			
			mailContent.append("							</tr>");
		}
		mailContent.append("						</tbody>");
		mailContent.append("					</table>");
		mailContent.append("				</div>");
		mailContent.append("			</div>");
		mailContent.append("");
		mailContent.append("		</div>");
		mailContent.append("		<!--// 콘텍정보 메일공유 -->");
		mailContent.append("	</div>");
		mailContent.append("	<!--// 콘텐츠 -->");
		
		
		//sendMailSMTP(String mailSubject, String bodyText, String fromMail, String fromName, ArrayList<Object> toAddr){
		sendMailSMTP(mailSubject, mailHtml(mailContent.toString(), returnURL), fromMail, fromName, toAddr);
	}


	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 9. 25.
	 * @explain	: 잠재영업기회 메일 공유
	 */
	public void shareHiddenOppSendMail(Map<String, Object> map, ArrayList<HashMap<String, Object>> actionGridList, ArrayList<Object> toAddr) throws Exception {
		String mailSubject = null;

		String fromMail 					= 	(String) map.get("hiddenModalEmail"); 				// 공유자 이메일
		String fromName 					= 	(String) map.get("hiddenModalHanName"); 				// 공유자 이름
		//String textCommonSearchCompany		=	(String) map.get("textCommonSearchCompany");		//매출처
		//String textModalCustomerName		=	(String) map.get("textModalCustomerName");			//endUser
		String salesClientName				=	(String) map.get("salesClientName");		//매출처
		String clientName					=	(String) map.get("clientName");			//endUser
		String textModalOppOwner			=	(String) map.get("hiddenModalOppOwnerName");		//영업대표
		String textModalSubject				=	(String) map.get("textModalSubject");				//제목
		String textareaModalDetail			=	(String) map.get("textareaModalDetail").toString().replaceAll("\r\n", "\n").replaceAll("\n", "<br>");			//내용
		String selectModalCategory			=	(String) map.get("selectModalCategory");			//영역
		String textModalAmount				=	(String) map.get("textModalAmount");				//규모
		String textModalSalesChangeDate		=	(String) map.get("textModalSalesChangeDate");		//영업기회전환시점
		String hiddenRelationOpportunityId	=	(String) map.get("hiddenRelationOpportunityId");	//결과
		int pkNo							=	(int) map.get("filePK");							//PK

		URL returnURL = null;

		try {
			returnURL	=	new URL(IP_ADDR+"/clientSalesActive/listHiddenOpportunity.do?opportunity_hidden_id="+pkNo);
		} catch (MalformedURLException e1) {
			e1.printStackTrace();
		}

		//제목
		mailSubject = "["+clientName+"] 잠재영업기회 Call Report ("+fromName+")";

		StringBuilder mailContent = new StringBuilder();

		mailContent.append("			<div class=\"contact_info mg_b30\">");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">잠재영업기회 제목 : "+textModalSubject+"</label>");
		mailContent.append("				</div>");

		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">잠재영업기회 내용 : "+textareaModalDetail+"</label>");
		mailContent.append("				</div>");

		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">매출처 : "+salesClientName+"</label>");
		mailContent.append("				</div>");

		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">End User : "+clientName+"</label>");
		mailContent.append("				</div>");

		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">영업대표 : "+textModalOppOwner+"</label>");
		mailContent.append("				</div>");

		/*mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">영역 : "+selectModalCategory+"</label>");
		mailContent.append("				</div>");*/

		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">규모 : "+textModalAmount+"</label>");
		mailContent.append("				</div>");

		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">영업기회전환시점 : "+textModalSalesChangeDate+"</label>");
		mailContent.append("				</div>");

		mailContent.append("				<div class=\"pd_25\">");
		mailContent.append("					<span>Follow-Up-Action</span>");
		mailContent.append("					<table class=\"base\">");
		mailContent.append("						<colgroup>");
		mailContent.append("							<col width=\"180px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"30px\"/>");
		mailContent.append("						</colgroup>");
		mailContent.append("");
		mailContent.append("						<thead>");
		mailContent.append("							<tr>");
		mailContent.append("								<th>내용</th>");
		mailContent.append("								<th>책임자</th>");
		mailContent.append("								<th>해결목표일</th>");
		mailContent.append("								<th>실제완료일</th>");
		mailContent.append("								<th class=\"endcell\">Status</th>");
		mailContent.append("							</tr>");
		mailContent.append("						</thead>");
		mailContent.append("");
		mailContent.append("						<tbody>");

		for(Map<String,Object> getMap : actionGridList){
			String closeDate = "";
			if(getMap.get("CLOSE_DATE") != null){
				closeDate = getMap.get("CLOSE_DATE").toString();
			}
			String statusColor = compareToDateColor(getMap.get("DUE_DATE").toString(), closeDate);// 날짜 비교 색상 
			
			mailContent.append("							<tr>");
			mailContent.append("								<td>"+ getMap.get("DETAIL_CONENTS") +"</td>");
			mailContent.append("								<td>"+ getMap.get("ACTION_OWNER") +"</td>");
			mailContent.append("								<td>"+ getMap.get("DUE_DATE") +"</td>");
			mailContent.append("								<td>"+ getMap.get("CLOSE_DATE") +"</td>");

			if("G".equals(statusColor)){
				mailContent.append("								<td class=\"endcell status_green\"><img src=\"http://thesellers.unipoint.co.kr:30100/other/mailform/images/green.png\" alt=\"\"/></td>");
			}else if("Y".equals(statusColor)){
				mailContent.append("								<td class=\"endcell status_yellow\"><img src=\"http://thesellers.unipoint.co.kr:30100/other/mailform/images/yellow.png\" alt=\"\"/></td>");
			}else if("R".equals(statusColor)){
				mailContent.append("								<td class=\"endcell status_red\"><img src=\"http://thesellers.unipoint.co.kr:30100/other/mailform/images/red.png\" alt=\"\"/></td>");
			}else{
				mailContent.append("								<td>-</td>");
			}

			mailContent.append("							</tr>");
		}

		mailContent.append("						</tbody>");
		mailContent.append("					</table>");
		mailContent.append("				</div>");
		mailContent.append("			</div>");
		mailContent.append("");
		mailContent.append("		</div>");
		mailContent.append("		<!--// 콘텍정보 메일공유 -->");
		mailContent.append("	</div>");
		mailContent.append("	<!--// 콘텐츠 -->");


		//sendMailSMTP(String mailSubject, String bodyText, String fromMail, String fromName, ArrayList<Object> toAddr){
		sendMailSMTP(mailSubject, mailHtml(mailContent.toString(), returnURL), fromMail, fromName, toAddr);
	}


	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 9. 25.
	 * @explain	: 고객이슈 메일 공유
	 */
	public void shareClientIssueSendMail(Map<String, Object> map, ArrayList<Object> toAddr) throws Exception {
		String mailSubject = null;

		String fromMail	= (String) map.get("hiddenModalEmail"); 							// 공유자 이메일
		String fromName	= (String) map.get("hiddenModalHanName"); 							// 공유자 이름
		//String textCommonSearchCompany = (String) map.get("textCommonSearchCompany"); 		// 고객사
		//String textModalCustomerName = (String) map.get("textModalCustomerName"); 			// 고객명
		String hiddenModalCcList 		= (String) map.get("hiddenModalCcList"); 			// 고객명[고객사] 복수
		String textModalSalesRepresentive = (String) map.get("textModalSalesRepresentive"); // 영업대표
		String textModalSubject = (String) map.get("textModalSubject"); 					// 제목
		String textareaModalIssueDetail = (String) map.get("textareaModalIssueDetail").toString().replaceAll("\r\n", "\n").replaceAll("\n", "<br>"); 	// 내용
		String textModalSolveOwner = (String) map.get("textModalSolveOwner"); 				// 이슈제기자
		String selectModalIssueCategory = (String) map.get("selectModalIssueCategory"); 	// 이슈종류
		String textModalIssueDate = (String) map.get("textModalIssueDate"); 				// 이슈발생일자
		String textModalDueDate = (String) map.get("textModalDueDate"); 					// 해결목표일
		String textModalIssueCloseDate = (String) map.get("textModalIssueCloseDate"); 		// 이슈해결일

		int pkNo = (int) map.get("filePK"); // PK

		URL returnURL = null;

		try {
			returnURL	=	new URL(IP_ADDR+"/clientSatisfaction/viewClientIssueList.do?issue_id="+pkNo);
		} catch (MalformedURLException e1) {
			e1.printStackTrace();
		}

		//제목
		mailSubject = "["+hiddenModalCcList+"] 고객이슈 Call Report ("+fromName+")";


		StringBuilder mailContent = new StringBuilder();

		mailContent.append("			<div class=\"contact_info mg_b30\">");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">이슈 제목 : "+ textModalSubject +"</label>");
		mailContent.append("				</div>");

		/*mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">고객사 : " +textCommonSearchCompany+ "</label>");
		mailContent.append("				</div>");*/
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">고객명 : "+ hiddenModalCcList +"</label>");
		mailContent.append("				</div>");
		/*mailContent.append("				<div class=\"row\">");
        mailContent.append("					<label class=\"bar\">고객명 : "+ textModalCustomerName +"</label>");
        mailContent.append("				</div>");

        mailContent.append("				<div class=\"row\">");
        mailContent.append("					<label class=\"bar\">영업대표 : "+ textModalSalesRepresentive +"</label>");
        mailContent.append("				</div>");
		 */
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">이슈해결책임자 : " + textModalSolveOwner +"</label>");
		mailContent.append("				</div>");
		/*
        mailContent.append("				<div class=\"row\">");
        mailContent.append("					<label class=\"bar\">이슈영역 : " + selectModalIssueCategory + "</label>");
        mailContent.append("				</div>");
		 */
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">이슈 내용 : " + textareaModalIssueDetail + "</label>");
		mailContent.append("				</div>");

		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">이슈발생일 : "+ textModalIssueDate +"</label>");
		mailContent.append("				</div>");

		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">해결목표일 : "+ textModalDueDate +"</label>");
		mailContent.append("				</div>");

		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">이슈해결일 : "+ textModalIssueCloseDate +"</label>");
		mailContent.append("				</div>");

		mailContent.append("				<div class=\"pd_25\">");
		mailContent.append("					<span>이슈해결계획</span>");
		mailContent.append("					<table class=\"base\">");
		mailContent.append("						<colgroup>");
		mailContent.append("							<col width=\"180px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"30px\"/>");
		mailContent.append("						</colgroup>");
		mailContent.append("");
		mailContent.append("						<thead>");
		mailContent.append("							<tr>");
		mailContent.append("								<th>해결계획</th>");
		mailContent.append("								<th>책임자</th>");
		mailContent.append("								<th>등록일</th>");
		mailContent.append("								<th>해결목표일</th>");
		mailContent.append("								<th>실제완료일</th>");
		mailContent.append("								<th class=\"endcell\">Status</th>");
		mailContent.append("							</tr>");
		mailContent.append("						</thead>");
		mailContent.append("");
		mailContent.append("						<tbody>");


		map.put("pkNo",pkNo);
		List<Map<String,Object>> actionGridList = clientSatisfactionDAO.selectSolvePlanIssue(map);

		for(Map<String,Object> getMap : actionGridList){
			String closeDate = "";
			if(getMap.get("CLOSE_DATE") != null){
				closeDate = getMap.get("CLOSE_DATE").toString();
			}
			String statusColor = compareToDateColor(getMap.get("DUE_DATE").toString(), closeDate);// 날짜 비교 색상 
			
			mailContent.append("							<tr>");
			mailContent.append("								<td class='ag_l'>"+ getMap.get("SOLVE_PLAN") +"</td>");
			mailContent.append("								<td>"+ getMap.get("SOLVE_OWNER") +"</td>");
			mailContent.append("								<td>"+ getMap.get("SYS_REGISTER_DATE") +"</td>");
			mailContent.append("								<td>"+ getMap.get("DUE_DATE") +"</td>");
			if(CommonUtils.isEmpty(getMap.get("CLOSE_DATE"))){
				mailContent.append("								<td></td>");
			}else{
				mailContent.append("								<td>"+ getMap.get("CLOSE_DATE") +"</td>");
			}
			if("G".equals(statusColor)){
				mailContent.append("								<td class=\"endcell status_green\"><img src=\"http://thesellers.unipoint.co.kr:30100/other/mailform/images/green.png\" alt=\"\"/></td>");
			}else if("Y".equals(statusColor)){
				mailContent.append("								<td class=\"endcell status_yellow\"><img src=\"http://thesellers.unipoint.co.kr:30100/other/mailform/images/yellow.png\" alt=\"\"/></td>");
			}else if("R".equals(statusColor)){
				mailContent.append("								<td class=\"endcell status_red\"><img src=\"http://thesellers.unipoint.co.kr:30100/other/mailform/images/red.png\" alt=\"\"/></td>");
			}else{
				mailContent.append("								<td>-</td>");
			}
			mailContent.append("							</tr>");
		}

		mailContent.append("						</tbody>");
		mailContent.append("					</table>");
		mailContent.append("				</div>");
		mailContent.append("			</div>");
		mailContent.append("");
		mailContent.append("		</div>");
		mailContent.append("		<!--// 콘텍정보 메일공유 -->");
		mailContent.append("	</div>");
		mailContent.append("	<!--// 콘텐츠 -->");

		sendMailSMTP(mailSubject, mailHtml(mailContent.toString(), returnURL), fromMail, fromName, toAddr);
	}

	
	/**
	 * @author 	: 장성훈
	 * @Date	: 2017. 4. 4.
	 * @explain	: Tracking_ISSUE 메일
	 */
	public void trackingSendMail(Map<String, Object> map, ArrayList<Object> toAddr) throws Exception {
		String mailSubject = null;

		String fromMail	= (String) map.get("hiddenModalEmail"); 							// 공유자 이메일
		String fromName	= (String) map.get("hiddenModalHanName"); 							// 공유자 이름
		String textCommonSearchCompany = (String) map.get("textCommonSearchCompany"); 		// 고객사
		String textModalSubject = (String) map.get("textModalSubject"); 					// 제목
		String textareaModalIssueDetail = (String) map.get("textareaModalIssueDetail").toString().replaceAll("\r\n", "\n").replaceAll("\n", "<br>"); 	// 내용
		String textModalSolveOwner = (String) map.get("textModalSolveOwner"); 				// 이슈제기자
		//String textModalIssueDate = (String) map.get("textModalIssueDate"); 				// 이슈발생일자
		//String textModalDueDate = (String) map.get("textModalDueDate"); 					// 해결목표일
		
		String textModalIssueDate = CommonDateUtils.dateToString((Date) map.get("textModalIssueDate"));
		String textModalDueDate = CommonDateUtils.dateToString((Date) map.get("textModalDueDate"));
		
		//String textModalIssueCloseDate = (String) map.get("textModalIssueCloseDate"); 		// 이슈해결일

		int pkNo = Integer.parseInt(map.get("filePK").toString());
		
//		int pkNo = (int) map.get("filePK"); // PK

		URL returnURL = null;

		try {
			returnURL	=	new URL(IP_ADDR+"/clientSatisfaction/viewClientIssueList.do?issue_id="+pkNo);
		} catch (MalformedURLException e1) {
			e1.printStackTrace();
		}

		//제목
		mailSubject = "["+textCommonSearchCompany+"] 고객이슈 - " + map.get("subject");


		StringBuilder mailContent = new StringBuilder();

		mailContent.append("			<div class=\"contact_info mg_b30\">");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">이슈 제목 : "+ textModalSubject +"</label>");
		mailContent.append("				</div>");

		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">고객사 : " +textCommonSearchCompany+ "</label>");
		mailContent.append("				</div>");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">이슈해결책임자 : " + textModalSolveOwner +"</label>");
		mailContent.append("				</div>");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">이슈 내용 : " + textareaModalIssueDetail + "</label>");
		mailContent.append("				</div>");

		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">이슈발생일 : "+ textModalIssueDate +"</label>");
		mailContent.append("				</div>");

		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">해결목표일 : "+ textModalDueDate +"</label>");
		mailContent.append("				</div>");
/*
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">이슈해결일 : "+ textModalIssueCloseDate +"</label>");
		mailContent.append("				</div>");
*/
		mailContent.append("				<div class=\"pd_25\">");
		mailContent.append("					<span>이슈해결계획</span>");
		mailContent.append("					<table class=\"base\">");
		mailContent.append("						<colgroup>");
		mailContent.append("							<col width=\"180px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"30px\"/>");
		mailContent.append("						</colgroup>");
		mailContent.append("");
		mailContent.append("						<thead>");
		mailContent.append("							<tr>");
		mailContent.append("								<th>해결계획</th>");
		mailContent.append("								<th>책임자</th>");
		mailContent.append("								<th>등록일</th>");
		mailContent.append("								<th>해결목표일</th>");
		mailContent.append("								<th>실제완료일</th>");
		mailContent.append("								<th class=\"endcell\">Status</th>");
		mailContent.append("							</tr>");
		mailContent.append("						</thead>");
		mailContent.append("");
		mailContent.append("						<tbody>");


		map.put("pkNo",pkNo);
		List<Map<String,Object>> actionGridList = clientSatisfactionDAO.selectSolvePlanIssue(map);

		for(Map<String,Object> getMap : actionGridList){
			String closeDate = "";
			if(getMap.get("CLOSE_DATE") != null){
				closeDate = getMap.get("CLOSE_DATE").toString();
			}
			String statusColor = compareToDateColor(getMap.get("DUE_DATE").toString(), closeDate);// 날짜 비교 색상 
			
			mailContent.append("							<tr>");
			mailContent.append("								<td class='ag_l'>"+ getMap.get("SOLVE_PLAN") +"</td>");
			mailContent.append("								<td>"+ getMap.get("SOLVE_OWNER") +"</td>");
			mailContent.append("								<td>"+ getMap.get("SYS_REGISTER_DATE") +"</td>");
			mailContent.append("								<td>"+ getMap.get("DUE_DATE") +"</td>");
			if(CommonUtils.isEmpty(getMap.get("CLOSE_DATE"))){
				mailContent.append("								<td></td>");
			}else{
				mailContent.append("								<td>"+ getMap.get("CLOSE_DATE") +"</td>");
			}
			if("G".equals(statusColor)){
				mailContent.append("								<td class=\"endcell status_green\"><img src=\"http://thesellers.unipoint.co.kr:30100/other/mailform/images/green.png\" alt=\"\"/></td>");
			}else if("Y".equals(statusColor)){
				mailContent.append("								<td class=\"endcell status_yellow\"><img src=\"http://thesellers.unipoint.co.kr:30100/other/mailform/images/yellow.png\" alt=\"\"/></td>");
			}else if("R".equals(statusColor)){
				mailContent.append("								<td class=\"endcell status_red\"><img src=\"http://thesellers.unipoint.co.kr:30100/other/mailform/images/red.png\" alt=\"\"/></td>");
			}else{
				mailContent.append("								<td>-</td>");
			}
			mailContent.append("							</tr>");
		}

		mailContent.append("						</tbody>");
		mailContent.append("					</table>");
		mailContent.append("				</div>");
		mailContent.append("			</div>");
		mailContent.append("");
		mailContent.append("		</div>");
		mailContent.append("		<!--// 콘텍정보 메일공유 -->");
		mailContent.append("	</div>");
		mailContent.append("	<!--// 콘텐츠 -->");

		sendMailSMTP(mailSubject, mailHtml(mailContent.toString(), returnURL), fromMail, fromName, toAddr);
	}
	
	/**
	 * @author 	: 봉준
	 * @Date	: 2018. 6. 27.
	 * @explain	: Tracking_회사/부문전략 키마일스톤 메일
	 */
	public void trackingMenuBizStrategyCompanyKeyMilestonesSendMail(Map<String, Object> map, ArrayList<Object> toAddr) throws Exception {
		String mailSubject = null;

		String fromMail 				= (String) map.get("fromMail"); 			// 공유자 이메일
		String fromName 				= (String) map.get("fromMailName"); 		// 공유자 이름
		String menuName 				= (String) map.get("menuName"); 			// tracking 메뉴
		String eventSubject				= (String) map.get("eventSubject"); 		// 이벤트 제목
		String delayItem				= (String) map.get("delayItem"); 			// tracking 세부항목 ex)액션플랜
		String delayItemDetail			= (String) map.get("delayItemDetail").toString().replaceAll("\r\n", "\n").replaceAll("\n", "<br>");		// tracking 세부항목 내용
		//String clientCompanyName		= (String) map.get("clientCompanyName"); 	// 고객사
		//String clientIndividualName		= (String) map.get("clientIndividualName");	// 고객명
		String dueDate					= (String) map.get("dueDate");				// 해결목표일
		String status					= (String) map.get("status");				// 비고
		String ownerName				= (String) map.get("ownerName");			// 해결담당자
		String position					= (String) map.get("position");				// 직급
		//String clientInfos				= (String) map.get("clientInfos");			// 복수 고객[고객사]
		
		if(null == position)
		{
			position = "";
		}
		
		/*if(null == clientIndividualName)
		{
			clientIndividualName = "";
		}*/
		
//		int event_id = (int) map.get("filePK");												//컨택 ID
//		int event_id = Integer.parseInt(map.get("filePK").toString());
		
		URL returnURL = null;

		try {
			returnURL	=	new URL(IP_ADDR+map.get("linkURL"));
		} catch (MalformedURLException e1) {
			e1.printStackTrace();
		}

		//제목
		/*mailSubject = "["++"] 고객컨택 Call Report ("+fromName+")";*/
		mailSubject = "["+map.get("menuName")+"]" + map.get("delayItem") +" 해결 목표일 임박!";

		StringBuilder mailContent = new StringBuilder();

		mailContent.append("			<div class=\"contact_info mg_b30\">");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">메     뉴 : "+ menuName +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">제      목 : "+ eventSubject +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">알림 대상  : "+ delayItem +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">알림 대상 내용 : "+ delayItemDetail +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">해결목표일 : "+ dueDate +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		
		/*if(!"".equals(clientInfos) && clientInfos != null){
			mailContent.append("				<div class=\"row\">");
			mailContent.append("					<label class=\"bar\">고객명 : "+ clientInfos +"</label>");
			mailContent.append("				</div>");
		}else{
			mailContent.append("				<div class=\"row\">");
			mailContent.append("					<label class=\"bar\">고객사 : "+ clientCompanyName +"</label>");
			mailContent.append("				</div>");
			mailContent.append("");
			mailContent.append("				<div class=\"row\">");
			mailContent.append("					<label class=\"bar\">고객명 : "+ clientIndividualName +"</label>");
			mailContent.append("				</div>");
		}*/
		
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">비  고 : "+ status +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		if(ownerName != null && !"".equals(ownerName)){
			mailContent.append("					<label class=\"bar\">해결담당자 : "+ ownerName +" "+position+"</label>");
		}else{
			mailContent.append("					<label class=\"bar\">해결담당자 : 담당자 미지정 </label>");
		}
		mailContent.append("				</div>");
		/*
		mailContent.append("				<div class=\"pd_25\">");
		mailContent.append("					<span>Follow-Up-Action</span>");
		mailContent.append("					<table class=\"base\">");
		mailContent.append("						<colgroup>");
		mailContent.append("							<col width=\"180px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"30px\"/>");
		mailContent.append("						</colgroup>");
		mailContent.append("");
		mailContent.append("						<thead>");
		mailContent.append("							<tr>");
		mailContent.append("								<th>내용</th>");
		mailContent.append("								<th>책임자</th>");
		mailContent.append("								<th>해결목표일</th>");
		mailContent.append("								<th>실제완료일</th>");
		mailContent.append("								<th class=\"endcell\">Status</th>");
		mailContent.append("							</tr>");
		mailContent.append("						</thead>");
		mailContent.append("");
		mailContent.append("						<tbody>");
		
		mailContent.append("						</tbody>");
		mailContent.append("					</table>");
		mailContent.append("				</div>");
		*/
		mailContent.append("			</div>");
		mailContent.append("");
		mailContent.append("		</div>");
		mailContent.append("		<!--// 콘텍정보 메일공유 -->");
		mailContent.append("	</div>");
		mailContent.append("	<!--// 콘텐츠 -->");


		//sendMailSMTP(String mailSubject, String bodyText, String fromMail, String fromName, ArrayList<Object> toAddr){
		sendMailSMTP(mailSubject, mailHtml(mailContent.toString(), returnURL), fromMail, fromName, toAddr);
	}
	
	/**
	 * @author 	: 봉준
	 * @Date	: 2018. 6. 27.
	 * @explain	: Tracking_회사/부문전략 이슈 메일
	 */
	public void trackingMenuBizStrategyCompanyIssueSendMail(Map<String, Object> map, ArrayList<Object> toAddr) throws Exception {
		String mailSubject = null;

		String fromMail 				= (String) map.get("fromMail"); 			// 공유자 이메일
		String fromName 				= (String) map.get("fromMailName"); 		// 공유자 이름
		String menuName 				= (String) map.get("menuName"); 			// tracking 메뉴
		String eventSubject				= (String) map.get("eventSubject"); 		// 이벤트 제목
		String delayItem				= (String) map.get("delayItem"); 			// tracking 세부항목 ex)액션플랜
		String delayItemDetail			= (String) map.get("delayItemDetail").toString().replaceAll("\r\n", "\n").replaceAll("\n", "<br>");		// tracking 세부항목 내용
		//String clientCompanyName		= (String) map.get("clientCompanyName"); 	// 고객사
		//String clientIndividualName		= (String) map.get("clientIndividualName");	// 고객명
		String dueDate					= (String) map.get("dueDate");				// 해결목표일
		String status					= (String) map.get("status");				// 비고
		String ownerName				= (String) map.get("ownerName");			// 해결담당자
		String position					= (String) map.get("position");				// 직급
		//String clientInfos				= (String) map.get("clientInfos");			// 복수 고객[고객사]
		
		if(null == position)
		{
			position = "";
		}
		
		/*if(null == clientIndividualName)
		{
			clientIndividualName = "";
		}*/
		
//		int event_id = (int) map.get("filePK");												//컨택 ID
//		int event_id = Integer.parseInt(map.get("filePK").toString());
		
		URL returnURL = null;

		try {
			returnURL	=	new URL(IP_ADDR+map.get("linkURL"));
		} catch (MalformedURLException e1) {
			e1.printStackTrace();
		}

		//제목
		/*mailSubject = "["++"] 고객컨택 Call Report ("+fromName+")";*/
		mailSubject = "["+map.get("menuName")+"]" + map.get("delayItem") +" 해결 목표일 임박!";

		StringBuilder mailContent = new StringBuilder();

		mailContent.append("			<div class=\"contact_info mg_b30\">");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">메     뉴 : "+ menuName +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">제      목 : "+ eventSubject +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">알림 대상  : "+ delayItem +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">알림 대상 내용 : "+ delayItemDetail +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">해결목표일 : "+ dueDate +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		
		/*if(!"".equals(clientInfos) && clientInfos != null){
			mailContent.append("				<div class=\"row\">");
			mailContent.append("					<label class=\"bar\">고객명 : "+ clientInfos +"</label>");
			mailContent.append("				</div>");
		}else{
			mailContent.append("				<div class=\"row\">");
			mailContent.append("					<label class=\"bar\">고객사 : "+ clientCompanyName +"</label>");
			mailContent.append("				</div>");
			mailContent.append("");
			mailContent.append("				<div class=\"row\">");
			mailContent.append("					<label class=\"bar\">고객명 : "+ clientIndividualName +"</label>");
			mailContent.append("				</div>");
		}*/
		
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">비  고 : "+ status +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">해결담당자 : "+ ownerName +" "+position+"</label>");
		mailContent.append("				</div>");
		/*
		mailContent.append("				<div class=\"pd_25\">");
		mailContent.append("					<span>Follow-Up-Action</span>");
		mailContent.append("					<table class=\"base\">");
		mailContent.append("						<colgroup>");
		mailContent.append("							<col width=\"180px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"30px\"/>");
		mailContent.append("						</colgroup>");
		mailContent.append("");
		mailContent.append("						<thead>");
		mailContent.append("							<tr>");
		mailContent.append("								<th>내용</th>");
		mailContent.append("								<th>책임자</th>");
		mailContent.append("								<th>해결목표일</th>");
		mailContent.append("								<th>실제완료일</th>");
		mailContent.append("								<th class=\"endcell\">Status</th>");
		mailContent.append("							</tr>");
		mailContent.append("						</thead>");
		mailContent.append("");
		mailContent.append("						<tbody>");
		
		mailContent.append("						</tbody>");
		mailContent.append("					</table>");
		mailContent.append("				</div>");
		*/
		mailContent.append("			</div>");
		mailContent.append("");
		mailContent.append("		</div>");
		mailContent.append("		<!--// 콘텍정보 메일공유 -->");
		mailContent.append("	</div>");
		mailContent.append("	<!--// 콘텐츠 -->");


		//sendMailSMTP(String mailSubject, String bodyText, String fromMail, String fromName, ArrayList<Object> toAddr){
		sendMailSMTP(mailSubject, mailHtml(mailContent.toString(), returnURL), fromMail, fromName, toAddr);
	}
	
	/**
	 * @author 	: 봉준
	 * @Date	: 2018. 6. 27.
	 * @explain	: Tracking_영업기회 체크리스트 액션플랜 메일
	 */
	public void trackingMenuOpportunityCheckListSendMail(Map<String, Object> map, ArrayList<Object> toAddr) throws Exception {
		String mailSubject = null;

		String fromMail 				= (String) map.get("fromMail"); 			// 공유자 이메일
		String fromName 				= (String) map.get("fromMailName"); 		// 공유자 이름
		String menuName 				= (String) map.get("menuName"); 			// tracking 메뉴
		String eventSubject				= (String) map.get("eventSubject"); 		// 이벤트 제목
		String delayItem				= (String) map.get("delayItem"); 			// tracking 세부항목 ex)액션플랜
		String delayItemDetail			= (String) map.get("delayItemDetail").toString().replaceAll("\r\n", "\n").replaceAll("\n", "<br>");		// tracking 세부항목 내용
		//String clientCompanyName		= (String) map.get("clientCompanyName"); 	// 고객사
		//String clientIndividualName	= (String) map.get("clientIndividualName");	// 고객명
		String client					= (String) map.get("clientCompanyName");	// 매출처
		String endUser					= (String) map.get("endUserCompanyName");	// 엔드유저
		String dueDate					= (String) map.get("dueDate");				// 해결목표일
		String status					= (String) map.get("status");				// 비고
		String ownerName				= (String) map.get("ownerName");			// 해결담당자
		String position					= (String) map.get("position");				// 직급
		String clientInfos				= (String) map.get("clientInfos");			// 복수 고객[고객사]
		
		if(position == null){
			position = "";
		}
		
//		int event_id = (int) map.get("filePK");												//컨택 ID
//		int event_id = Integer.parseInt(map.get("filePK").toString());
		
		URL returnURL = null;

		try {
			returnURL	=	new URL(IP_ADDR+map.get("linkURL"));
		} catch (MalformedURLException e1) {
			e1.printStackTrace();
		}

		//제목
		/*mailSubject = "["++"] 고객컨택 Call Report ("+fromName+")";*/
		mailSubject = "["+endUser+"]"+ map.get("menuName") +"-"+map.get("delayItem") +" 해결 목표일 임박!";

		StringBuilder mailContent = new StringBuilder();

		mailContent.append("			<div class=\"contact_info mg_b30\">");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">메     뉴 : "+ menuName +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">제      목 : "+ eventSubject +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">알림 대상  : "+ delayItem +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">알림 대상 내용 : "+ delayItemDetail +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">해결목표일 : "+ dueDate +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		
		if(!"".equals(clientInfos) && clientInfos != null){
			mailContent.append("				<div class=\"row\">");
			mailContent.append("					<label class=\"bar\">고객명 : "+ clientInfos +"</label>");
			mailContent.append("				</div>");
		}else{
			mailContent.append("				<div class=\"row\">");
			mailContent.append("					<label class=\"bar\">매출처 : "+ client +"</label>");
			mailContent.append("				</div>");
			mailContent.append("");
			mailContent.append("				<div class=\"row\">");
			mailContent.append("					<label class=\"bar\">End User : "+ endUser +"</label>");
			mailContent.append("				</div>");
		}
		
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">비  고 : "+ status +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">해결담당자 : "+ ownerName +" "+position+"</label>");
		mailContent.append("				</div>");
		/*
		mailContent.append("				<div class=\"pd_25\">");
		mailContent.append("					<span>Follow-Up-Action</span>");
		mailContent.append("					<table class=\"base\">");
		mailContent.append("						<colgroup>");
		mailContent.append("							<col width=\"180px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"30px\"/>");
		mailContent.append("						</colgroup>");
		mailContent.append("");
		mailContent.append("						<thead>");
		mailContent.append("							<tr>");
		mailContent.append("								<th>내용</th>");
		mailContent.append("								<th>책임자</th>");
		mailContent.append("								<th>해결목표일</th>");
		mailContent.append("								<th>실제완료일</th>");
		mailContent.append("								<th class=\"endcell\">Status</th>");
		mailContent.append("							</tr>");
		mailContent.append("						</thead>");
		mailContent.append("");
		mailContent.append("						<tbody>");
		
		mailContent.append("						</tbody>");
		mailContent.append("					</table>");
		mailContent.append("				</div>");
		*/
		mailContent.append("			</div>");
		mailContent.append("");
		mailContent.append("		</div>");
		mailContent.append("		<!--// 콘텍정보 메일공유 -->");
		mailContent.append("	</div>");
		mailContent.append("	<!--// 콘텐츠 -->");


		//sendMailSMTP(String mailSubject, String bodyText, String fromMail, String fromName, ArrayList<Object> toAddr){
		sendMailSMTP(mailSubject, mailHtml(mailContent.toString(), returnURL), fromMail, fromName, toAddr);
	}
	
	/**
	 * @author 	: 장성훈
	 * @Date	: 2017. 4. 4.
	 * @explain	: Tracking_고객별전략 키마일스톤 메일
	 */
	public void trackingMenuBizStrategyClientKeyMilestonesSendMail(Map<String, Object> map, ArrayList<Object> toAddr) throws Exception {
		String mailSubject = null;

		String fromMail 				= (String) map.get("fromMail"); 			// 공유자 이메일
		String fromName 				= (String) map.get("fromMailName"); 		// 공유자 이름
		String menuName 				= (String) map.get("menuName"); 			// tracking 메뉴
		String eventSubject				= (String) map.get("eventSubject"); 		// 이벤트 제목
		String delayItem				= (String) map.get("delayItem"); 			// tracking 세부항목 ex)액션플랜
		String delayItemDetail			= (String) map.get("delayItemDetail").toString().replaceAll("\r\n", "\n").replaceAll("\n", "<br>");		// tracking 세부항목 내용
		//String clientCompanyName		= (String) map.get("clientCompanyName"); 	// 고객사
		//String clientIndividualName		= (String) map.get("clientIndividualName");	// 고객명
		String dueDate					= (String) map.get("dueDate");				// 해결목표일
		String status					= (String) map.get("status");				// 비고
		String ownerName				= (String) map.get("ownerName");			// 해결담당자
		String position					= (String) map.get("position");				// 직급
		//String clientInfos				= (String) map.get("clientInfos");			// 복수 고객[고객사]
		
		if(null == position)
		{
			position = "";
		}
		
//		int event_id = (int) map.get("filePK");												//컨택 ID
//		int event_id = Integer.parseInt(map.get("filePK").toString());
		
		URL returnURL = null;

		try {
			returnURL	=	new URL(IP_ADDR+map.get("linkURL"));
		} catch (MalformedURLException e1) {
			e1.printStackTrace();
		}

		//제목
		/*mailSubject = "["++"] 고객컨택 Call Report ("+fromName+")";*/
		mailSubject = "["+map.get("menuName")+"]"+ map.get("delayItem") +" 해결 목표일 임박!";

		StringBuilder mailContent = new StringBuilder();

		mailContent.append("			<div class=\"contact_info mg_b30\">");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">메     뉴 : "+ menuName +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">제      목 : "+ eventSubject +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">알림 대상  : "+ delayItem +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">알림 대상 내용 : "+ delayItemDetail +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">해결목표일 : "+ dueDate +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">비  고 : "+ status +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		if(ownerName != null && !"".equals(ownerName)){
			mailContent.append("					<label class=\"bar\">해결담당자 : "+ ownerName +" "+position+"</label>");
		}else{
			mailContent.append("					<label class=\"bar\">해결담당자 : 담당자 미지정 </label>");
		}
		mailContent.append("				</div>");
		/*
		mailContent.append("				<div class=\"pd_25\">");
		mailContent.append("					<span>Follow-Up-Action</span>");
		mailContent.append("					<table class=\"base\">");
		mailContent.append("						<colgroup>");
		mailContent.append("							<col width=\"180px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"30px\"/>");
		mailContent.append("						</colgroup>");
		mailContent.append("");
		mailContent.append("						<thead>");
		mailContent.append("							<tr>");
		mailContent.append("								<th>내용</th>");
		mailContent.append("								<th>책임자</th>");
		mailContent.append("								<th>해결목표일</th>");
		mailContent.append("								<th>실제완료일</th>");
		mailContent.append("								<th class=\"endcell\">Status</th>");
		mailContent.append("							</tr>");
		mailContent.append("						</thead>");
		mailContent.append("");
		mailContent.append("						<tbody>");
		
		mailContent.append("						</tbody>");
		mailContent.append("					</table>");
		mailContent.append("				</div>");
		*/
		mailContent.append("			</div>");
		mailContent.append("");
		mailContent.append("		</div>");
		mailContent.append("		<!--// 콘텍정보 메일공유 -->");
		mailContent.append("	</div>");
		mailContent.append("	<!--// 콘텐츠 -->");


		//sendMailSMTP(String mailSubject, String bodyText, String fromMail, String fromName, ArrayList<Object> toAddr){
		sendMailSMTP(mailSubject, mailHtml(mailContent.toString(), returnURL), fromMail, fromName, toAddr);
	}
	
	/**
	 * @author 	: 장성훈
	 * @Date	: 2017. 4. 4.
	 * @explain	: Tracking_ClientContact 메일  _ 보류
	 */
	public void trackingMenuBizStrategyProjectPlanMilestonesSendMail(Map<String, Object> map, ArrayList<Object> toAddr) throws Exception {
		String mailSubject = null;

		String fromMail 				= (String) map.get("fromMail"); 			// 공유자 이메일
		String fromName 				= (String) map.get("fromMailName"); 		// 공유자 이름
		String menuName 				= (String) map.get("menuName"); 			// tracking 메뉴
		String eventSubject				= (String) map.get("eventSubject"); 		// 이벤트 제목
		String delayItem				= (String) map.get("delayItem"); 			// tracking 세부항목 ex)액션플랜
		String delayItemDetail			= (String) map.get("delayItemDetail").toString().replaceAll("\r\n", "\n").replaceAll("\n", "<br>");		// tracking 세부항목 내용
		String clientCompanyName		= (String) map.get("clientCompanyName"); 	// 고객사
		//String clientIndividualName		= (String) map.get("clientIndividualName");	// 고객명
		String dueDate					= (String) map.get("dueDate");				// 해결목표일
		String status					= (String) map.get("status");				// 비고
		String ownerName				= (String) map.get("ownerName");			// 해결담당자
		String position					= (String) map.get("position");				// 직급
		String clientInfos				= (String) map.get("clientInfos");			// 복수 고객[고객사]
		
		/*if(null == clientIndividualName)
		{
			clientIndividualName = "";
		}*/
		
//		int event_id = (int) map.get("filePK");												//컨택 ID
//		int event_id = Integer.parseInt(map.get("filePK").toString());
		
		URL returnURL = null;

		try {
			returnURL	=	new URL(IP_ADDR+map.get("linkURL"));
		} catch (MalformedURLException e1) {
			e1.printStackTrace();
		}

		//제목
		/*mailSubject = "["++"] 고객컨택 Call Report ("+fromName+")";*/
		mailSubject = "["+clientCompanyName+"]"+ map.get("menuName") +"-"+map.get("delayItem") +" 해결 목표일 임박!";

		StringBuilder mailContent = new StringBuilder();

		mailContent.append("			<div class=\"contact_info mg_b30\">");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">메     뉴 : "+ menuName +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">제      목 : "+ eventSubject +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">알림 대상  : "+ delayItem +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">알림 대상 내용 : "+ delayItemDetail +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">해결목표일 : "+ dueDate +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		
		if(!"".equals(clientInfos) && clientInfos != null){
			mailContent.append("				<div class=\"row\">");
			mailContent.append("					<label class=\"bar\">고객명 : "+ clientInfos +"</label>");
			mailContent.append("				</div>");
		}else{
			mailContent.append("				<div class=\"row\">");
			mailContent.append("					<label class=\"bar\">고객사 : "+ clientCompanyName +"</label>");
			mailContent.append("				</div>");
			/*mailContent.append("");
			mailContent.append("				<div class=\"row\">");
			mailContent.append("					<label class=\"bar\">고객명 : "+ clientIndividualName +"</label>");
			mailContent.append("				</div>");*/
		}
		
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">비  고 : "+ status +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		if(ownerName != null && !"".equals(ownerName)){
			mailContent.append("					<label class=\"bar\">해결담당자 : "+ ownerName +" "+position+"</label>");
		}else{
			mailContent.append("					<label class=\"bar\">해결담당자 : 담당자 미지정 </label>");
		}
		mailContent.append("				</div>");
		/*
		mailContent.append("				<div class=\"pd_25\">");
		mailContent.append("					<span>Follow-Up-Action</span>");
		mailContent.append("					<table class=\"base\">");
		mailContent.append("						<colgroup>");
		mailContent.append("							<col width=\"180px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"30px\"/>");
		mailContent.append("						</colgroup>");
		mailContent.append("");
		mailContent.append("						<thead>");
		mailContent.append("							<tr>");
		mailContent.append("								<th>내용</th>");
		mailContent.append("								<th>책임자</th>");
		mailContent.append("								<th>해결목표일</th>");
		mailContent.append("								<th>실제완료일</th>");
		mailContent.append("								<th class=\"endcell\">Status</th>");
		mailContent.append("							</tr>");
		mailContent.append("						</thead>");
		mailContent.append("");
		mailContent.append("						<tbody>");
		
		mailContent.append("						</tbody>");
		mailContent.append("					</table>");
		mailContent.append("				</div>");
		*/
		mailContent.append("			</div>");
		mailContent.append("");
		mailContent.append("		</div>");
		mailContent.append("		<!--// 콘텍정보 메일공유 -->");
		mailContent.append("	</div>");
		mailContent.append("	<!--// 콘텐츠 -->");


		//sendMailSMTP(String mailSubject, String bodyText, String fromMail, String fromName, ArrayList<Object> toAddr){
		sendMailSMTP(mailSubject, mailHtml(mailContent.toString(), returnURL), fromMail, fromName, toAddr);
	}
	
	/**
	 * @author 	: 장성훈
	 * @Date	: 2017. 4. 4.
	 * @explain	: Tracking_ClientContact 메일  _ 보류
	 */
	public void trackingMenuBizStrategyProjectPlanIssueSendMail(Map<String, Object> map, ArrayList<Object> toAddr) throws Exception {
		String mailSubject = null;

		String fromMail 				= (String) map.get("fromMail"); 			// 공유자 이메일
		String fromName 				= (String) map.get("fromMailName"); 		// 공유자 이름
		String menuName 				= (String) map.get("menuName"); 			// tracking 메뉴
		String eventSubject				= (String) map.get("eventSubject"); 		// 이벤트 제목
		String delayItem				= (String) map.get("delayItem"); 			// tracking 세부항목 ex)액션플랜
		String delayItemDetail			= (String) map.get("delayItemDetail").toString().replaceAll("\r\n", "\n").replaceAll("\n", "<br>");		// tracking 세부항목 내용
		String clientCompanyName		= (String) map.get("clientCompanyName"); 	// 고객사
		//String clientIndividualName		= (String) map.get("clientIndividualName");	// 고객명
		String dueDate					= (String) map.get("dueDate");				// 해결목표일
		String status					= (String) map.get("status");				// 비고
		String ownerName				= (String) map.get("ownerName");			// 해결담당자
		String position					= (String) map.get("position");				// 직급
		String clientInfos				= (String) map.get("clientInfos");			// 복수 고객[고객사]
		
		if(null == position)
		{
			position = "";
		}
		
//		int event_id = (int) map.get("filePK");												//컨택 ID
//		int event_id = Integer.parseInt(map.get("filePK").toString());
		
		URL returnURL = null;

		try {
			returnURL	=	new URL(IP_ADDR+map.get("linkURL"));
		} catch (MalformedURLException e1) {
			e1.printStackTrace();
		}

		//제목
		/*mailSubject = "["++"] 고객컨택 Call Report ("+fromName+")";*/
		mailSubject = "["+clientCompanyName+"]"+ map.get("menuName") +"-"+map.get("delayItem") +" 해결 목표일 임박!";

		StringBuilder mailContent = new StringBuilder();

		mailContent.append("			<div class=\"contact_info mg_b30\">");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">메     뉴 : "+ menuName +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">제      목 : "+ eventSubject +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">알림 대상  : "+ delayItem +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">알림 대상 내용 : "+ delayItemDetail +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">해결목표일 : "+ dueDate +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		
		if(!"".equals(clientInfos) && clientInfos != null){
			mailContent.append("				<div class=\"row\">");
			mailContent.append("					<label class=\"bar\">고객명 : "+ clientInfos +"</label>");
			mailContent.append("				</div>");
		}else{
			mailContent.append("				<div class=\"row\">");
			mailContent.append("					<label class=\"bar\">고객사 : "+ clientCompanyName +"</label>");
			mailContent.append("				</div>");
			/*mailContent.append("");
			mailContent.append("				<div class=\"row\">");
			mailContent.append("					<label class=\"bar\">고객명 : "+ clientIndividualName +"</label>");
			mailContent.append("				</div>");*/
		}
		
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">비  고 : "+ status +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		if(ownerName != null && !"".equals(ownerName)){
			mailContent.append("					<label class=\"bar\">해결담당자 : "+ ownerName +" "+position+"</label>");
		}else{
			mailContent.append("					<label class=\"bar\">해결담당자 : 담당자 미지정 </label>");
		}
		mailContent.append("				</div>");
		/*
		mailContent.append("				<div class=\"pd_25\">");
		mailContent.append("					<span>Follow-Up-Action</span>");
		mailContent.append("					<table class=\"base\">");
		mailContent.append("						<colgroup>");
		mailContent.append("							<col width=\"180px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"30px\"/>");
		mailContent.append("						</colgroup>");
		mailContent.append("");
		mailContent.append("						<thead>");
		mailContent.append("							<tr>");
		mailContent.append("								<th>내용</th>");
		mailContent.append("								<th>책임자</th>");
		mailContent.append("								<th>해결목표일</th>");
		mailContent.append("								<th>실제완료일</th>");
		mailContent.append("								<th class=\"endcell\">Status</th>");
		mailContent.append("							</tr>");
		mailContent.append("						</thead>");
		mailContent.append("");
		mailContent.append("						<tbody>");
		
		mailContent.append("						</tbody>");
		mailContent.append("					</table>");
		mailContent.append("				</div>");
		*/
		mailContent.append("			</div>");
		mailContent.append("");
		mailContent.append("		</div>");
		mailContent.append("		<!--// 콘텍정보 메일공유 -->");
		mailContent.append("	</div>");
		mailContent.append("	<!--// 콘텐츠 -->");


		//sendMailSMTP(String mailSubject, String bodyText, String fromMail, String fromName, ArrayList<Object> toAddr){
		sendMailSMTP(mailSubject, mailHtml(mailContent.toString(), returnURL), fromMail, fromName, toAddr);
	}
	
	/**
	 * @author 	: 장성훈
	 * @Date	: 2017. 4. 4.
	 * @explain	: Tracking_잠재영업기회 액션플랜 메일
	 */
	public void trackingMenuHiddenOpportunityActionPlanSendMail(Map<String, Object> map, ArrayList<Object> toAddr) throws Exception {
		String mailSubject = null;

		String fromMail 				= (String) map.get("fromMail"); 			// 공유자 이메일
		String fromName 				= (String) map.get("fromMailName"); 		// 공유자 이름
		String menuName 				= (String) map.get("menuName"); 			// tracking 메뉴
		String eventSubject				= (String) map.get("eventSubject"); 		// 이벤트 제목
		String delayItem				= (String) map.get("delayItem"); 			// tracking 세부항목 ex)액션플랜
		String delayItemDetail			= (String) map.get("delayItemDetail").toString().replaceAll("\r\n", "\n").replaceAll("\n", "<br>");		// tracking 세부항목 내용
		String clientCompanyName		= (String) map.get("clientCompanyName"); 	// 고객사
		String endUser					= (String) map.get("endUser"); 				// 앤드유저
		//String clientIndividualName		= (String) map.get("clientIndividualName");	// 고객명
		String dueDate					= (String) map.get("dueDate");				// 해결목표일
		String status					= (String) map.get("status");				// 비고
		String ownerName				= (String) map.get("ownerName");			// 해결담당자
		String position					= (String) map.get("position");				// 직급
		String clientInfos				= (String) map.get("clientInfos");			// 복수 고객[고객사]
		
		if(null == position)
		{
			position = "";
		}
		
//		int event_id = (int) map.get("filePK");												//컨택 ID
//		int event_id = Integer.parseInt(map.get("filePK").toString());
		
		URL returnURL = null;

		try {
			returnURL	=	new URL(IP_ADDR+map.get("linkURL"));
		} catch (MalformedURLException e1) {
			e1.printStackTrace();
		}

		//제목
		/*mailSubject = "["++"] 고객컨택 Call Report ("+fromName+")";*/
		mailSubject = "["+clientCompanyName+"]"+ map.get("menuName") +"-"+map.get("delayItem") +" 해결 목표일 임박!";

		StringBuilder mailContent = new StringBuilder();

		mailContent.append("			<div class=\"contact_info mg_b30\">");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">메     뉴 : "+ menuName +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">제      목 : "+ eventSubject +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">알림 대상  : "+ delayItem +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">알림 대상 내용 : "+ delayItemDetail +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">해결목표일 : "+ dueDate +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		
		if(!"".equals(clientInfos) && clientInfos != null){
			mailContent.append("				<div class=\"row\">");
			mailContent.append("					<label class=\"bar\">고객명 : "+ clientInfos +"</label>");
			mailContent.append("				</div>");
		}else{
			mailContent.append("				<div class=\"row\">");
			mailContent.append("					<label class=\"bar\">매출처 : "+ clientCompanyName +"</label>");
			mailContent.append("				</div>");
			mailContent.append("");
			mailContent.append("				<div class=\"row\">");
			mailContent.append("					<label class=\"bar\">End User : "+ endUser +"</label>");
			mailContent.append("				</div>");
		}
		
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">비  고 : "+ status +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">해결담당자 : "+ ownerName +" "+position+"</label>");
		mailContent.append("				</div>");
		/*
		mailContent.append("				<div class=\"pd_25\">");
		mailContent.append("					<span>Follow-Up-Action</span>");
		mailContent.append("					<table class=\"base\">");
		mailContent.append("						<colgroup>");
		mailContent.append("							<col width=\"180px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"30px\"/>");
		mailContent.append("						</colgroup>");
		mailContent.append("");
		mailContent.append("						<thead>");
		mailContent.append("							<tr>");
		mailContent.append("								<th>내용</th>");
		mailContent.append("								<th>책임자</th>");
		mailContent.append("								<th>해결목표일</th>");
		mailContent.append("								<th>실제완료일</th>");
		mailContent.append("								<th class=\"endcell\">Status</th>");
		mailContent.append("							</tr>");
		mailContent.append("						</thead>");
		mailContent.append("");
		mailContent.append("						<tbody>");
		
		mailContent.append("						</tbody>");
		mailContent.append("					</table>");
		mailContent.append("				</div>");
		*/
		mailContent.append("			</div>");
		mailContent.append("");
		mailContent.append("		</div>");
		mailContent.append("		<!--// 콘텍정보 메일공유 -->");
		mailContent.append("	</div>");
		mailContent.append("	<!--// 콘텐츠 -->");


		//sendMailSMTP(String mailSubject, String bodyText, String fromMail, String fromName, ArrayList<Object> toAddr){
		sendMailSMTP(mailSubject, mailHtml(mailContent.toString(), returnURL), fromMail, fromName, toAddr);
	}
	
	/**
	 * @author 	: 장성훈
	 * @Date	: 2017. 4. 4.
	 * @explain	: Tracking_영업기회 마일스톤 메일
	 */
	public void trackingMenuOpportunityMilestonesSendMail(Map<String, Object> map, ArrayList<Object> toAddr) throws Exception {
		String mailSubject = null;

		String fromMail 				= (String) map.get("fromMail"); 			// 공유자 이메일
		String fromName 				= (String) map.get("fromMailName"); 		// 공유자 이름
		String menuName 				= (String) map.get("menuName"); 			// tracking 메뉴
		String eventSubject				= (String) map.get("eventSubject"); 		// 이벤트 제목
		String delayItem				= (String) map.get("delayItem"); 			// tracking 세부항목 ex)액션플랜
		String delayItemDetail			= (String) map.get("delayItemDetail").toString().replaceAll("\r\n", "\n").replaceAll("\n", "<br>");		// tracking 세부항목 내용
		String clientCompanyName		= (String) map.get("clientCompanyName"); 	// 고객사
		String clientIndividualName		= (String) map.get("clientIndividualName");	// 고객명
		String dueDate					= (String) map.get("dueDate");				// 해결목표일
		String status					= (String) map.get("status");				// 비고
		String ownerName				= (String) map.get("ownerName");			// 해결담당자
		String position					= (String) map.get("position");				// 직급
		String clientInfos				= (String) map.get("clientInfos");			// 복수 고객[고객사]
		
		if(null == position)
		{
			position = "";
		}
		
//		int event_id = (int) map.get("filePK");												//컨택 ID
//		int event_id = Integer.parseInt(map.get("filePK").toString());
		
		URL returnURL = null;

		try {
			returnURL	=	new URL(IP_ADDR+map.get("linkURL"));
		} catch (MalformedURLException e1) {
			e1.printStackTrace();
		}

		//제목
		/*mailSubject = "["++"] 고객컨택 Call Report ("+fromName+")";*/
		mailSubject = "["+clientIndividualName+"]"+ map.get("menuName") +"-"+map.get("delayItem") +" 해결 목표일 임박!";

		StringBuilder mailContent = new StringBuilder();

		mailContent.append("			<div class=\"contact_info mg_b30\">");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">메     뉴 : "+ menuName +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">제      목 : "+ eventSubject +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">알림 대상  : "+ delayItem +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">알림 대상 내용 : "+ delayItemDetail +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">해결목표일 : "+ dueDate +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		
		if(!"".equals(clientInfos) && clientInfos != null){
			mailContent.append("				<div class=\"row\">");
			mailContent.append("					<label class=\"bar\">고객명 : "+ clientInfos +"</label>");
			mailContent.append("				</div>");
		}else{
			mailContent.append("				<div class=\"row\">");
			mailContent.append("					<label class=\"bar\">매출처 : "+ clientCompanyName +"</label>");
			mailContent.append("				</div>");
			mailContent.append("");
			mailContent.append("				<div class=\"row\">");
			mailContent.append("					<label class=\"bar\">End User : "+ clientIndividualName +"</label>");
			mailContent.append("				</div>");
		}
		
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">비  고 : "+ status +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		if(ownerName != null && !"".equals(ownerName)){
			mailContent.append("					<label class=\"bar\">해결담당자 : "+ ownerName +" "+position+"</label>");
		}else{
			mailContent.append("					<label class=\"bar\">해결담당자 : 담당자 미지정 </label>");
		}
		mailContent.append("				</div>");
		/*
		mailContent.append("				<div class=\"pd_25\">");
		mailContent.append("					<span>Follow-Up-Action</span>");
		mailContent.append("					<table class=\"base\">");
		mailContent.append("						<colgroup>");
		mailContent.append("							<col width=\"180px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"30px\"/>");
		mailContent.append("						</colgroup>");
		mailContent.append("");
		mailContent.append("						<thead>");
		mailContent.append("							<tr>");
		mailContent.append("								<th>내용</th>");
		mailContent.append("								<th>책임자</th>");
		mailContent.append("								<th>해결목표일</th>");
		mailContent.append("								<th>실제완료일</th>");
		mailContent.append("								<th class=\"endcell\">Status</th>");
		mailContent.append("							</tr>");
		mailContent.append("						</thead>");
		mailContent.append("");
		mailContent.append("						<tbody>");
		
		mailContent.append("						</tbody>");
		mailContent.append("					</table>");
		mailContent.append("				</div>");
		*/
		mailContent.append("			</div>");
		mailContent.append("");
		mailContent.append("		</div>");
		mailContent.append("		<!--// 콘텍정보 메일공유 -->");
		mailContent.append("	</div>");
		mailContent.append("	<!--// 콘텐츠 -->");


		//sendMailSMTP(String mailSubject, String bodyText, String fromMail, String fromName, ArrayList<Object> toAddr){
		sendMailSMTP(mailSubject, mailHtml(mailContent.toString(), returnURL), fromMail, fromName, toAddr);
	}
	
	/**
	 * @author 	: 봉준
	 * @Date	: 2018. 7. 18.
	 * @explain	: 사용자 오늘 일정 메일 알림
	 */
	public void trackingMenuCalendarEventMail(Map<String, Object> map, List<Map<String, Object>> list, ArrayList<Object> toAddr) throws Exception {
		String mailSubject = null;

		String fromMail 				= (String) map.get("fromMail"); 			// 공유자 이메일
		String fromName 				= (String) map.get("fromMailName"); 		// 공유자 이름
		String menuName 				= (String) map.get("menuName"); 		// 공유자 이름
		
		URL returnURL = null;

		try {
			returnURL	=	new URL(IP_ADDR+map.get("linkURL"));
		} catch (MalformedURLException e1) {
			e1.printStackTrace();
		}

		//제목
		/*mailSubject = "["++"] 고객컨택 Call Report ("+fromName+")";*/
		mailSubject = "["+map.get("menuName")+"]"+"오늘의 일정입니다.";

		StringBuilder mailContent = new StringBuilder();

		mailContent.append("			<div class=\"contact_info mg_b30\">");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">메     뉴 : "+ menuName +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		
		mailContent.append("				<div class=\"pd_25\">");
		mailContent.append("					<table class=\"base\">");
		mailContent.append("						<colgroup>");
		mailContent.append("							<col width=\"140px\"/>");
		mailContent.append("							<col width=\"30px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"80px\"/>");
		mailContent.append("							<col width=\"80px\"/>");
		mailContent.append("						</colgroup>");
		mailContent.append("");
		mailContent.append("						<thead>");
		mailContent.append("							<tr>");
		mailContent.append("								<th>일정 제목</th>");
		mailContent.append("								<th>일정 구분</th>");
		mailContent.append("								<th>장 소</th>");
		mailContent.append("								<th>시작시간</th>");
		mailContent.append("								<th>종료시간</th>");
		mailContent.append("							</tr>");
		mailContent.append("						</thead>");
		mailContent.append("");
		mailContent.append("						<tbody>");
		for(int i=0; i<list.size(); i++){
			String event_code = "";
			switch (list.get(i).get("EVENT_CODE").toString()) {
			case "1":
				event_code = "고객 대면";
				break;
			case "2":
				event_code = "대면 준비";
				break;
			case "3":
				event_code = "내부 회의";
				break;
			case "4":
				event_code = "교육";
				break;
			case "6":
				event_code = "휴가";
				break;
			case "7":
				event_code = "기타";
				break;
			case "10":
				event_code = "아웃룩 일정";
				break;
			default:
				event_code = "-";
				break;
			}
			
			mailContent.append("							<tr>");
			mailContent.append("								<td>"+ list.get(i).get("EVENT_SUBJECT") +"</td>");
			mailContent.append("								<td>"+ event_code +"</td>");
			mailContent.append("								<td>"+ list.get(i).get("LOCATION") +"</td>");
			mailContent.append("								<td>"+ list.get(i).get("START_DATETIME") +"</td>");
			mailContent.append("								<td>"+ list.get(i).get("END_DATETIME") +"</td>");
			mailContent.append("							</tr>");

			//mailContent.append(list.get(i).get("HAN_NAME") +"&emsp;&emsp;&emsp;&emsp;&emsp;" + list.get(i).get("INVITE_YN") +"<br />");
		}
		mailContent.append("						</tbody>");
		mailContent.append("					</table>");
		mailContent.append("				</div>");
		mailContent.append("			</div>");
		mailContent.append("");
		mailContent.append("		</div>");
		mailContent.append("		<!--// 콘텍정보 메일공유 -->");
		mailContent.append("	</div>");
		mailContent.append("	<!--// 콘텐츠 -->");

		sendMailSMTP(mailSubject, mailHtml(mailContent.toString(), returnURL), fromMail, fromName, toAddr);
	}
	
	/**
	 * @author 	: 봉준
	 * @Date	: 2018. 10. 11.
	 * @explain	: 사용자 매출,수금 계획일 알림
	 */
	public void trackingMenuOpportunityAmountEventMail(Map<String, Object> map, List<Map<String, Object>> list, ArrayList<Object> toAddr) throws Exception {
		String mailSubject = null;

		String fromMail 				= (String) map.get("fromMail"); 			// 공유자 이메일
		String fromName 				= (String) map.get("fromMailName"); 		// 공유자 이름
		String menuName 				= (String) map.get("menuName"); 		// 공유자 이름
		
		URL returnURL = null;

		//제목
		/*mailSubject = "["++"] 고객컨택 Call Report ("+fromName+")";*/
		mailSubject = "[매출/수금 계획]"+ map.get("status");

		StringBuilder mailContent = new StringBuilder();

		mailContent.append("			<div class=\"contact_info mg_b30\">");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">메     뉴 : "+ menuName +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		
		mailContent.append("				<div class=\"pd_25\">");
		mailContent.append("					<table class=\"base\">");
		mailContent.append("						<colgroup>");
		mailContent.append("							<col width=\"140px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"30px\"/>");
		mailContent.append("							<col width=\"40px\"/>");
		mailContent.append("							<col width=\"40px\"/>");
		mailContent.append("							<col width=\"40px\"/>");
		mailContent.append("							<col width=\"40px\"/>");
		mailContent.append("							<col width=\"30px\"/>");
		mailContent.append("						</colgroup>");
		mailContent.append("");
		mailContent.append("						<thead>");
		mailContent.append("							<tr>");
		mailContent.append("								<th rowspan=\"2\">제목</th>");
		mailContent.append("								<th rowspan=\"2\">End User</th>");
		mailContent.append("								<th rowspan=\"2\">담당<br/>영업대표</th>");
		mailContent.append("								<th rowspan=\"2\">매출<br/>계획일</th>");
		mailContent.append("								<th rowspan=\"2\">수금<br/>계획일</th>");
		mailContent.append("								<th colspan=\"4\">매출 / 수금 계획금액</th>");
		mailContent.append("								<th rowspan=\"2\">Link</th>");
		mailContent.append("							</tr>");
		mailContent.append("							<tr>");
		mailContent.append("								<th colspan=\"2\">예상매출 / 실제매출</th>");
		mailContent.append("								<th colspan=\"2\">예상이익 / 실제이익</th>");
		mailContent.append("							</tr>");
		mailContent.append("						</thead>");
		mailContent.append("");
		mailContent.append("						<tbody>");
		for(int i=0; i<list.size(); i++){
			String linkURL = IP_ADDR + "/clientSalesActive/viewOpportunityList.do?&opportunity_id="+list.get(i).get("OPPORTUNITY_ID");
			DecimalFormat comma = new DecimalFormat("###,###");
			mailContent.append("							<tr>");
			mailContent.append("								<td>"+ list.get(i).get("SUBJECT") +"</td>");
			mailContent.append("								<td>"+ list.get(i).get("END_CLIENT_NAME") +"</td>");
			mailContent.append("								<td>"+ list.get(i).get("IDENTIFIER_NAME") +"</td>");
			mailContent.append("								<td>"+ list.get(i).get("BASIS_MONTH") +"</td>");
			mailContent.append("								<td>"+ list.get(i).get("BASIS_MONTH_C") +"</td>");
			mailContent.append("								<td colspan=\"2\">"+ comma.format(list.get(i).get("BASIS_PLAN_REVENUE_AMOUNT")) + " / " + comma.format(list.get(i).get("ERP_REV")) +"</td>");
			mailContent.append("								<td colspan=\"2\">"+ comma.format(list.get(i).get("BASIS_PLAN_GP_AMOUNT")) + " / " + comma.format(list.get(i).get("ERP_GP")) +"</td>");
			mailContent.append("								<td><a href=\""+ linkURL +"\"><strong>[바로가기]</strong></a></td>");
			mailContent.append("							</tr>");

			//mailContent.append(list.get(i).get("HAN_NAME") +"&emsp;&emsp;&emsp;&emsp;&emsp;" + list.get(i).get("INVITE_YN") +"<br />");
		}
		mailContent.append("						</tbody>");
		mailContent.append("					</table>");
		mailContent.append("				</div>");
		mailContent.append("			</div>");
		mailContent.append("");
		mailContent.append("		</div>");
		mailContent.append("		<!--// 콘텍정보 메일공유 -->");
		mailContent.append("	</div>");
		mailContent.append("	<!--// 콘텐츠 -->");

		sendMailSMTP(mailSubject, mailHtml(mailContent.toString(), returnURL), fromMail, fromName, toAddr);
	}
	
	/**
	 * @author 	: 봉준
	 * @Date	: 2018. 8. 13.
	 * @explain	: 코칭톡 메일 알림
	 */
	public void sendCoachingTalkMail(Map<String, Object> map, ArrayList<Object> toAddr) throws Exception {
		String mailSubject = null;
		
		String fromMail 				= (String) map.get("fromMail"); 			// 공유자 이메일
		String fromName 				= (String) map.get("fromMailName"); 		// 공유자 이름
		String menuName 				= (String) map.get("menuName"); 			// 코칭톡 메세지 관련 메뉴
		String eventSubject				= (String) map.get("eventSubject"); 		// 이벤트 제목
		String eventDetail				= (String) map.get("eventDetail");			// 비고
		String talkUserName				= (String) map.get("talkUserName");				// 코칭톡 메세지남긴 사용자명
		
		URL returnURL = null;

		try {
			returnURL	=	new URL(IP_ADDR+map.get("linkURL"));
		} catch (MalformedURLException e1) {
			e1.printStackTrace();
		}
		
		mailSubject = "[코칭톡]"+ menuName +"'"+ eventSubject +"' - "+ talkUserName +"님의 메세지 알림!";

		StringBuilder mailContent = new StringBuilder();
		
		mailContent.append("			<div class=\"contact_info mg_b30\">");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">메     뉴 : "+ menuName +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">제      목 : "+ eventSubject +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">내      용  : "+ eventDetail +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("			</div>");
		mailContent.append("");
		mailContent.append("		</div>");
		mailContent.append("		<!--// 콘텍정보 메일공유 -->");
		mailContent.append("	</div>");
		mailContent.append("	<!--// 콘텐츠 -->");
		
		sendMailSMTP(mailSubject, mailHtml(mailContent.toString(), returnURL), fromMail, fromName, toAddr);
	}
	
	/**
	 * @author 	: 봉준
	 * @Date	: 2018. 10. 11.
	 * @explain	: 영업기회 계약일 Tracking
	 */
	public void trackingMenuOpportunityContractDateSendMail(Map<String, Object> map, ArrayList<Object> toAddr) throws Exception {
		String mailSubject = null;
		DecimalFormat comma = new DecimalFormat("###,###");

		String fromMail 				= (String) map.get("fromMail"); 			// 공유자 이메일
		String fromName 				= (String) map.get("fromMailName"); 		// 공유자 이름
		String menuName 				= (String) map.get("menuName"); 			// tracking 메뉴
		String eventSubject				= (String) map.get("eventSubject"); 		// 이벤트 제목
		String delayItem				= (String) map.get("delayItem"); 			// tracking 세부항목 ex)액션플랜
		String clientCompanyName		= (String) map.get("clientCompanyName"); 	// 고객사
		String clientIndividualName		= (String) map.get("clientIndividualName");	// 고객명
		String contractAmount			= comma.format(map.get("contractAmount"));		// 예상계약금액
		String contractDate				= (String) map.get("contractDate");			// 계약일
		String status					= (String) map.get("status");				// 비고
		String ownerName				= (String) map.get("ownerName");			// 해결담당자
		String position					= (String) map.get("position");				// 직급
		String clientInfos				= (String) map.get("clientInfos");			// 복수 고객[고객사]
		
		if(null == clientIndividualName)
		{
			clientIndividualName = "";
		}
		
//		int event_id = (int) map.get("filePK");												//컨택 ID
//		int event_id = Integer.parseInt(map.get("filePK").toString());
		
		URL returnURL = null;

		try {
			returnURL	=	new URL(IP_ADDR+map.get("linkURL"));
		} catch (MalformedURLException e1) {
			e1.printStackTrace();
		}

		//제목
		/*mailSubject = "["++"] 고객컨택 Call Report ("+fromName+")";*/
		mailSubject = "["+clientCompanyName+"]"+ map.get("menuName") +"-"+map.get("delayItem") +" 임박!";

		StringBuilder mailContent = new StringBuilder();

		mailContent.append("			<div class=\"contact_info mg_b30\">");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">메     뉴 : "+ menuName +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">제      목 : "+ eventSubject +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">알림 대상  : "+ delayItem +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">예상 계약금액 : "+ contractAmount +" 원</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">계약일 : "+ contractDate +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		
		if(!"".equals(clientInfos) && clientInfos != null){
			mailContent.append("				<div class=\"row\">");
			mailContent.append("					<label class=\"bar\">고객명 : "+ clientInfos +"</label>");
			mailContent.append("				</div>");
		}else{
			mailContent.append("				<div class=\"row\">");
			mailContent.append("					<label class=\"bar\">End User : "+ clientCompanyName +"</label>");
			mailContent.append("				</div>");
			mailContent.append("");
			mailContent.append("				<div class=\"row\">");
			mailContent.append("					<label class=\"bar\">매출처 : "+ clientIndividualName +"</label>");
			mailContent.append("				</div>");
		}
		
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">영업대표 : "+ ownerName +" "+position+"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">비  고 : "+ status +"</label>");
		mailContent.append("				</div>");
		/*
		mailContent.append("				<div class=\"pd_25\">");
		mailContent.append("					<span>Follow-Up-Action</span>");
		mailContent.append("					<table class=\"base\">");
		mailContent.append("						<colgroup>");
		mailContent.append("							<col width=\"180px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"30px\"/>");
		mailContent.append("						</colgroup>");
		mailContent.append("");
		mailContent.append("						<thead>");
		mailContent.append("							<tr>");
		mailContent.append("								<th>내용</th>");
		mailContent.append("								<th>책임자</th>");
		mailContent.append("								<th>해결목표일</th>");
		mailContent.append("								<th>실제완료일</th>");
		mailContent.append("								<th class=\"endcell\">Status</th>");
		mailContent.append("							</tr>");
		mailContent.append("						</thead>");
		mailContent.append("");
		mailContent.append("						<tbody>");
		
		mailContent.append("						</tbody>");
		mailContent.append("					</table>");
		mailContent.append("				</div>");
		*/
		mailContent.append("			</div>");
		mailContent.append("");
		mailContent.append("		</div>");
		mailContent.append("		<!--// 콘텍정보 메일공유 -->");
		mailContent.append("	</div>");
		mailContent.append("	<!--// 콘텐츠 -->");


		//sendMailSMTP(String mailSubject, String bodyText, String fromMail, String fromName, ArrayList<Object> toAddr){
		sendMailSMTP(mailSubject, mailHtml(mailContent.toString(), returnURL), fromMail, fromName, toAddr);
	}
	
	/**
	 * @author 	: 장성훈
	 * @Date	: 2017. 4. 4.
	 * @explain	: Tracking_ClientContact 메일  _ 보류
	 */
	public void trackingMenuClientSatisfactionActionPlanSendMail(Map<String, Object> map, ArrayList<Object> toAddr) throws Exception {
		String mailSubject = null;

		String fromMail 				= (String) map.get("fromMail"); 			// 공유자 이메일
		String fromName 				= (String) map.get("fromMailName"); 		// 공유자 이름
		String menuName 				= (String) map.get("menuName"); 			// tracking 메뉴
		String eventSubject				= (String) map.get("eventSubject"); 		// 이벤트 제목
		String delayItem				= (String) map.get("delayItem"); 			// tracking 세부항목 ex)액션플랜
		String delayItemDetail			= (String) map.get("delayItemDetail").toString().replaceAll("\r\n", "\n").replaceAll("\n", "<br>");		// tracking 세부항목 내용
		String dueDate					= (String) map.get("dueDate");				// 해결목표일
		String status					= (String) map.get("status");				// 비고
		String ownerName				= (String) map.get("ownerName");			// 해결담당자
		String position					= (String) map.get("position");				// 직급
		
//		int event_id = (int) map.get("filePK");												//컨택 ID
//		int event_id = Integer.parseInt(map.get("filePK").toString());
		
		URL returnURL = null;

		try {
			returnURL	=	new URL(IP_ADDR+map.get("linkURL"));
		} catch (MalformedURLException e1) {
			e1.printStackTrace();
		}

		//제목
		/*mailSubject = "["++"] 고객컨택 Call Report ("+fromName+")";*/
		mailSubject = "[THE Seller's]"+ map.get("menuName") +"-"+map.get("delayItem") +" 해결 목표일 임박!";

		StringBuilder mailContent = new StringBuilder();

		mailContent.append("			<div class=\"contact_info mg_b30\">");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">메     뉴 : "+ menuName +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">제      목 : "+ eventSubject +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">알림 대상  : "+ delayItem +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">알림 대상 내용 : "+ delayItemDetail +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">해결목표일 : "+ dueDate +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">비  고 : "+ status +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">해결담당자 : "+ ownerName +" "+position+"</label>");
		mailContent.append("				</div>");
		/*
		mailContent.append("				<div class=\"pd_25\">");
		mailContent.append("					<span>Follow-Up-Action</span>");
		mailContent.append("					<table class=\"base\">");
		mailContent.append("						<colgroup>");
		mailContent.append("							<col width=\"180px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"30px\"/>");
		mailContent.append("						</colgroup>");
		mailContent.append("");
		mailContent.append("						<thead>");
		mailContent.append("							<tr>");
		mailContent.append("								<th>내용</th>");
		mailContent.append("								<th>책임자</th>");
		mailContent.append("								<th>해결목표일</th>");
		mailContent.append("								<th>실제완료일</th>");
		mailContent.append("								<th class=\"endcell\">Status</th>");
		mailContent.append("							</tr>");
		mailContent.append("						</thead>");
		mailContent.append("");
		mailContent.append("						<tbody>");
		
		mailContent.append("						</tbody>");
		mailContent.append("					</table>");
		mailContent.append("				</div>");
		*/
		mailContent.append("			</div>");
		mailContent.append("");
		mailContent.append("		</div>");
		mailContent.append("		<!--// 콘텍정보 메일공유 -->");
		mailContent.append("	</div>");
		mailContent.append("	<!--// 콘텐츠 -->");


		//sendMailSMTP(String mailSubject, String bodyText, String fromMail, String fromName, ArrayList<Object> toAddr){
		sendMailSMTP(mailSubject, mailHtml(mailContent.toString(), returnURL), fromMail, fromName, toAddr);
	}
	
	/**
	 * @author 	: 장성훈
	 * @Date	: 2017. 4. 4.
	 * @explain	: Tracking_ClientContact 메일  _ 보류
	 */
	public void trackingTestSendMail(Map<String, Object> map, ArrayList<Object> toAddr) throws Exception {
		String mailSubject = null;

		String fromMail 				= (String) map.get("fromMail"); 			// 공유자 이메일
		String fromName 				= (String) map.get("fromMailName"); 		// 공유자 이름
		String menuName 				= (String) map.get("menuName"); 			// tracking 메뉴
		String eventSubject				= (String) map.get("eventSubject"); 		// 이벤트 제목
		String delayItem				= (String) map.get("delayItem"); 			// tracking 세부항목 ex)액션플랜
		String delayItemDetail			= (String) map.get("delayItemDetail").toString().replaceAll("\r\n", "\n").replaceAll("\n", "<br>");		// tracking 세부항목 내용
		String clientCompanyName		= (String) map.get("clientCompanyName"); 	// 고객사
		String clientIndividualName		= (String) map.get("clientIndividualName");	// 고객명
		String dueDate					= (String) map.get("dueDate");				// 해결목표일
		String status					= (String) map.get("status");				// 비고
		String ownerName				= (String) map.get("ownerName");			// 해결담당자
		String position					= (String) map.get("position");				// 직급
		String clientInfos				= (String) map.get("clientInfos");			// 복수 고객[고객사]
		
		if(null == clientIndividualName)
		{
			clientIndividualName = "";
		}
		
//		int event_id = (int) map.get("filePK");												//컨택 ID
//		int event_id = Integer.parseInt(map.get("filePK").toString());
		
		URL returnURL = null;

		try {
			returnURL	=	new URL(IP_ADDR+map.get("linkURL"));
		} catch (MalformedURLException e1) {
			e1.printStackTrace();
		}

		//제목
		/*mailSubject = "["++"] 고객컨택 Call Report ("+fromName+")";*/
		mailSubject = "["+clientInfos+"]"+ map.get("menuName") +"-"+map.get("delayItem") +" 해결 목표일 임박!";

		StringBuilder mailContent = new StringBuilder();

		mailContent.append("			<div class=\"contact_info mg_b30\">");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">메     뉴 : "+ menuName +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">제      목 : "+ eventSubject +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">알림 대상  : "+ delayItem +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">알림 대상 내용 : "+ delayItemDetail +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">해결목표일 : "+ dueDate +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		
		if(!"".equals(clientInfos) && clientInfos != null){
			mailContent.append("				<div class=\"row\">");
			mailContent.append("					<label class=\"bar\">고객명 : "+ clientInfos +"</label>");
			mailContent.append("				</div>");
		}else{
			mailContent.append("				<div class=\"row\">");
			mailContent.append("					<label class=\"bar\">고객사 : "+ clientCompanyName +"</label>");
			mailContent.append("				</div>");
			mailContent.append("");
			mailContent.append("				<div class=\"row\">");
			mailContent.append("					<label class=\"bar\">고객명 : "+ clientIndividualName +"</label>");
			mailContent.append("				</div>");
		}
		
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">비  고 : "+ status +"</label>");
		mailContent.append("				</div>");
		mailContent.append("");
		mailContent.append("				<div class=\"row\">");
		if(ownerName != null && !"".equals(ownerName)){
			mailContent.append("					<label class=\"bar\">해결담당자 : "+ ownerName +" "+position+"</label>");
		}else{
			mailContent.append("					<label class=\"bar\">해결담당자 : 담당자 미지정</label>");
		}
		mailContent.append("				</div>");
		/*
		mailContent.append("				<div class=\"pd_25\">");
		mailContent.append("					<span>Follow-Up-Action</span>");
		mailContent.append("					<table class=\"base\">");
		mailContent.append("						<colgroup>");
		mailContent.append("							<col width=\"180px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"30px\"/>");
		mailContent.append("						</colgroup>");
		mailContent.append("");
		mailContent.append("						<thead>");
		mailContent.append("							<tr>");
		mailContent.append("								<th>내용</th>");
		mailContent.append("								<th>책임자</th>");
		mailContent.append("								<th>해결목표일</th>");
		mailContent.append("								<th>실제완료일</th>");
		mailContent.append("								<th class=\"endcell\">Status</th>");
		mailContent.append("							</tr>");
		mailContent.append("						</thead>");
		mailContent.append("");
		mailContent.append("						<tbody>");
		
		mailContent.append("						</tbody>");
		mailContent.append("					</table>");
		mailContent.append("				</div>");
		*/
		mailContent.append("			</div>");
		mailContent.append("");
		mailContent.append("		</div>");
		mailContent.append("		<!--// 콘텍정보 메일공유 -->");
		mailContent.append("	</div>");
		mailContent.append("	<!--// 콘텐츠 -->");


		//sendMailSMTP(String mailSubject, String bodyText, String fromMail, String fromName, ArrayList<Object> toAddr){
		sendMailSMTP(mailSubject, mailHtml(mailContent.toString(), returnURL), fromMail, fromName, toAddr);
	}
	
	/**
	 * @author 	: 장성훈
	 * @Date	: 2016. 9. 29.
	 * @explain : smtp 로 메일보내기
	 */
	public void sendMailSMTP(String mailSubject, String bodyText, String fromMail, String fromName, ArrayList<Object> toAddr){

		Properties properties;
		// String hostname = "umail.unipoint.co.kr"; // the host to send email from

		// String hostname = "192.168.1.165"; // the host to send email from
		String hostname ="";

		// Set Properties for Sendmail
		properties = new Properties();
		properties.put("mail.transport.protocol", "smtp");
		//        properties.put("mail.smtp.host", getMXRecordsForEmailAddress(to)); // SMTP Server
		properties.put("mail.smtp.port","25");
		properties.put("mail.smtp.host", MAIL_HOST); 		// HELO host
		properties.put("mail.smtp.from",fromMail);			// SMTP MAIL FROM
		properties.put("mail.smtp.allow8bitmime","true");

		properties.put("mail.smtp.connectiontimeout", 3000);
		properties.put("mail.smtp.timeout", 60000);

		try{

			Session session = Session.getInstance(properties);
			MimeMessage mimeMsg = new MimeMessage(session);

			mimeMsg.setFrom(new InternetAddress(fromMail, fromName, "utf-8"));

			InternetAddress[] toAddrList = new InternetAddress[toAddr.size()];
			for(int i =0; i<toAddr.size(); i++){
				toAddrList[i] = new InternetAddress(toAddr.get(i).toString());
			}
			//            mimeMsg.addRecipient(Message.RecipientType.TO, new InternetAddress(toMail));
			mimeMsg.setRecipients(Message.RecipientType.TO, toAddrList);
			mimeMsg.setSubject(mailSubject);
			mimeMsg.setContent(bodyText,"text/html; charset=utf-8");

			Transport.send(mimeMsg);

			log.info("======================================");
			log.info("Message sent OK");
			log.info("======================================");

		}catch (AddressException e){
			log.error("Bad address format: "+e.getRef());
		}
		/*
        catch (SMTPSenderFailedException e){
            System.out.println(e.getReturnCode() + ": We can't send emails from this address: " + e.getAddress());
        }
		 */
		catch (NoSuchProviderException e){
			log.error(e.getMessage()+": No such provider");
			//        }
			//        catch(MessagingException e){
			//        	log.error("Unknown exception"+e);
		}catch (Exception e){
			log.error("Unknown exception", e);
		}

	}

	public int sendMailCalendarInviteSMTP(String mailSubject, String bodyText, String fromMail, String fromName, String toMail){
		int cnt = 0;
		Properties properties;
		// String hostname = "umail.unipoint.co.kr"; // the host to send email from

		// String hostname = "192.168.1.165"; // the host to send email from
		/*
        String hostname ="";
        try {
        	//host IP 가져오기.
			hostname = getPropertyInfo.propertyInfo("hostIP");
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		 */

		// Set Properties for Sendmail
		properties = new Properties();
		properties.put("mail.transport.protocol", "smtp");
		//        properties.put("mail.smtp.host", getMXRecordsForEmailAddress(to)); // SMTP Server
		properties.put("mail.smtp.port","25");
		properties.put("mail.smtp.host", MAIL_HOST); 		// HELO host
		properties.put("mail.smtp.from",fromMail);			// SMTP MAIL FROM
		properties.put("mail.smtp.allow8bitmime","true");

		properties.put("mail.smtp.connectiontimeout", 3000);
		properties.put("mail.smtp.timeout", 60000);

		try{

			Session session = Session.getInstance(properties);
			MimeMessage mimeMsg = new MimeMessage(session);

			mimeMsg.setFrom(new InternetAddress(fromMail, fromName, "utf-8"));
			/*
            InternetAddress[] toAddrList = new InternetAddress[toAddr.size()];
            for(int i =0; i<toAddr.size(); i++){
            	toAddrList[i] = new InternetAddress(toAddr.get(i).toString());
            }
			 */
			mimeMsg.addRecipient(Message.RecipientType.TO, new InternetAddress(toMail));
			//다수 한번에
			//mimeMsg.setRecipients(Message.RecipientType.TO, toAddrList);
			mimeMsg.setSubject(mailSubject);
			mimeMsg.setContent(bodyText,"text/html; charset=utf-8");

			Transport.send(mimeMsg);

			log.info("======================================");
			log.info("Message sent OK");
			log.info("======================================");

		}catch (AddressException e){
			log.error("Bad address format: "+e.getRef());
			cnt = -1;
		}
		/*
        catch (SMTPSenderFailedException e){
            System.out.println(e.getReturnCode() + ": We can't send emails from this address: " + e.getAddress());
        }
		 */
		catch (NoSuchProviderException e){
			log.error(e.getMessage()+": No such provider");
			cnt = -1;
			//        }
			//        catch(MessagingException e){
			//        	log.error("Unknown exception"+e);
		}catch (Exception e){
			log.error("Unknown exception", e);
			cnt = -1;
		}

		return cnt;
	}

	public String mailHtml(String mailContent, URL returnURL){
		StringBuilder bodyText = new StringBuilder();

		bodyText.append("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">");
		bodyText.append("<html xmlns=\"http://www.w3.org/1999/xhtml\" lang=\"ko\">");
		bodyText.append("<head>");
		bodyText.append("<meta http-equiv=\"X-UA-Compatible\" content=\"IE=EmulateIE9\">");
		bodyText.append("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />");
		bodyText.append("<title>메일링</title>");
		bodyText.append("<link href=\""+IMAGE_HOST+"/other/mailform/css/style.css\" rel=\"stylesheet\" type=\"text/css\" />");
		bodyText.append("</head>");

		bodyText.append("<body>");
		bodyText.append("<div class=\"wrap\">");
		bodyText.append("	<!-- 헤더 -->");
		bodyText.append("	<div class=\"header\">");
		bodyText.append("		<span>"+CommonUtils.currentDate("yyyy-MM-dd")+"</span>");
		bodyText.append("		<img src=\""+IMAGE_HOST+"/other/mailform/images/header.jpg\" alt=\"\"/>");
		bodyText.append("	</div>");
		bodyText.append("	<!--// 헤더 -->");

		bodyText.append("	<!-- 콘텐츠 -->");
		bodyText.append("	<div class=\"content\">");
		bodyText.append("		<!-- 콘텍정보 메일공유 -->");
		bodyText.append("		<div class=\"contact_mag\">");
		bodyText.append("			<p class=\"mg_b10\">");
		if(CommonUtils.isEmpty(returnURL)){
			bodyText.append("				<strong class=\"fc_sellers\">셀러스</strong>에서 메일을 보냈습니다.");
		}else{
			bodyText.append("				<strong class=\"fc_sellers\">셀러스</strong>에서 메일을 보냈습니다. <a href=\""+returnURL+"\"><strong>[관련내용 바로가기]</strong></a>");
		}
		bodyText.append("			</p>");

		//메일 내용
		bodyText.append(mailContent);

		bodyText.append("	<!-- 푸터 -->");
		bodyText.append("	<div class=\"footer\">");
		bodyText.append("		Copyright Seller’s Company © 2016. ALL RIGHTS RESERVED .");
		bodyText.append("	</div>");
		bodyText.append("	<!--// 푸터 -->");
		bodyText.append("</div>");
		bodyText.append("");
		bodyText.append("</body>");
		bodyText.append("</html>");

		return bodyText.toString();
	}

	//    public  String getMXRecordsForEmailAddress(String eMailAddress) {
	//        String returnValue = new String();
	//
	//        try {
	//            String parts[] = eMailAddress.split("@");
	//            String hostName = parts[1];
	//
	//            Record[] records = new Lookup(hostName, Type.MX).run();
	//            if (records == null) { throw new RuntimeException("No MX records found for domain " + hostName + "."); }
	//
	//            if (records.length > 0){
	//                MXRecord mxr = (MXRecord) records[0];
	//                for (int i = 0; i< records.length; i++){
	//                    MXRecord tocompare = (MXRecord)records[i];
	//                    if (mxr.getPriority() > tocompare.getPriority())
	//                        mxr = tocompare;
	//                }
	//                returnValue = mxr.getTarget().toString();
	//            }
	//
	//        } catch (TextParseException e) {
	//            return new String("NULL");
	//
	//        }
	//
	//        return returnValue;
	//    }
	
	/**
	 * 고도리 메일 보내기 (황팀장-> 담당자 검색)
	 * @param map
	 * @param toAddr
	 * @throws Exception
	 */
	public void shareClientGodorySendMailDetail(Map<String, Object> map, ArrayList<Object> toAddr) throws Exception {
		String mailSubject = null;

		String selectModalIssueCategory = "";
		
		if("1".equals(map.get("selectGodoryTerritory1"))){
			selectModalIssueCategory = "고쳐주세요";
		}else if("2".equals(map.get("selectGodoryTerritory1"))){
			selectModalIssueCategory = "도와주세요";
		}else if("3".equals(map.get("selectGodoryTerritory1"))){
			selectModalIssueCategory = "이런건어때요";
		}
		
		String textModalSubject = (String) map.get("textModalSubject1"); 					// 제목
		String textareaModalIssueDetail = (String) map.get("textareaModalIssueDetail1").toString().replaceAll("\r\n", "\n").replaceAll("\n", "<br>"); 	// 내용
//		String textModalSolveOwner = (String) map.get("textModalSolveOwner"); 				// 이슈제기자
		String textModalSolveOwner = "홍길동"; 				// 이슈제기자
		String fromMail	= "yysim@unipoint.co.kr"; 							// 공유자 이메일
		String fromName	= "홍길동"; 							// 공유자 이름
		selectModalIssueCategory = selectModalIssueCategory; 	// 카테고리
		String textModalIssueDate = (String) map.get("textModalIssueDate1"); 				// 제안일자
		String textModalIssueDueDate = (String) map.get("textModalDueDate1"); 				// 제안일자
		int pkNo =  Integer.parseInt(map.get("hiddenModalPK1").toString()); // PK

		URL returnURL = null;

		try {
			returnURL	=	new URL(IP_ADDR+"/kyungnong/viewGodoryList.do?issueId="+pkNo);
		} catch (MalformedURLException e1) {
			e1.printStackTrace();
		}

		//제목
		mailSubject = "[THE Seller's] 고도리 제안("+fromName+")";


		StringBuilder mailContent = new StringBuilder();

		mailContent.append("			<div class=\"contact_info mg_b30\">");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">고도리 제목 : "+ textModalSubject +"</label>");
		mailContent.append("				</div>");

		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">고도리 영역 : " +selectModalIssueCategory+ "</label>");
		mailContent.append("				</div>");

		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">제안자 : " + fromName +"</label>");
		mailContent.append("				</div>");

		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">제안 일자 : " + textModalIssueDate + "</label>");
		mailContent.append("				</div>");
		
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">목표 일자 : " + textModalIssueDueDate + "</label>");
		mailContent.append("				</div>");

		mailContent.append("				<div class=\"pd_25\">");
		mailContent.append("					<span>이슈해결계획</span>");
		mailContent.append("					<table class=\"base\">");
		mailContent.append("						<colgroup>");
		mailContent.append("							<col width=\"180px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"60px\"/>");
		mailContent.append("							<col width=\"30px\"/>");
		mailContent.append("						</colgroup>");
		mailContent.append("");
		mailContent.append("						<thead>");
		mailContent.append("							<tr>");
		mailContent.append("								<th>해결계획</th>");
		mailContent.append("								<th>책임자</th>");
		mailContent.append("								<th>등록일</th>");
		mailContent.append("								<th>해결목표일</th>");
		mailContent.append("								<th>실제완료일</th>");
		mailContent.append("								<th class=\"endcell\">Status</th>");
		mailContent.append("							</tr>");
		mailContent.append("						</thead>");
		mailContent.append("");
		mailContent.append("						<tbody>");

		
		map.put("pkNo",pkNo);
		
		List<Map<String,Object>> actionGridList = etcDAO.selectSolvePlanIssue(map);
		for(Map<String,Object> getMap : actionGridList){
			String closeDate = "";
			if(getMap.get("CLOSE_DATE") != null){
				closeDate = getMap.get("CLOSE_DATE").toString();
			}
			String statusColor = compareToDateColor(getMap.get("DUE_DATE").toString(), closeDate);// 날짜 비교 색상 
			
			mailContent.append("							<tr>");
			mailContent.append("								<td class='ag_l'>"+ getMap.get("SOLVE_PLAN") +"</td>");
			mailContent.append("								<td>"+ getMap.get("SOLVE_OWNER") +"</td>");
			mailContent.append("								<td>"+ getMap.get("SYS_REGISTER_DATE") +"</td>");
			mailContent.append("								<td>"+ getMap.get("DUE_DATE") +"</td>");
			if(CommonUtils.isEmpty(getMap.get("CLOSE_DATE"))){
				mailContent.append("								<td></td>");
			}else{
				mailContent.append("								<td>"+ getMap.get("CLOSE_DATE") +"</td>");
			}
			if("G".equals(getMap.get("STATUS"))){
				mailContent.append("								<td class=\"endcell status_green\"><img src=\"http://thesellers.unipoint.co.kr:30100/other/mailform/images/green.png\" alt=\"\"/></td>");
			}else if("Y".equals(getMap.get("STATUS"))){
				mailContent.append("								<td class=\"endcell status_yellow\"><img src=\"http://thesellers.unipoint.co.kr:30100/other/mailform/images/yellow.png\" alt=\"\"/></td>");
			}else if("R".equals(getMap.get("STATUS"))){
				mailContent.append("								<td class=\"endcell status_red\"><img src=\"http://thesellers.unipoint.co.kr:30100/other/mailform/images/red.png\" alt=\"\"/></td>");
			}else{
				mailContent.append("								<td>-</td>");
			}
			mailContent.append("							</tr>");
		}

		mailContent.append("						</tbody>");
		mailContent.append("					</table>");
		mailContent.append("				</div>");
		mailContent.append("			</div>");
		mailContent.append("");
		mailContent.append("		</div>");
		mailContent.append("		<!--// 콘텍정보 메일공유 -->");
		mailContent.append("	</div>");
		mailContent.append("	<!--// 콘텐츠 -->");

		sendMailSMTP(mailSubject, mailHtml(mailContent.toString(), returnURL), fromMail, fromName, toAddr);
	}
	
	/**
	 * 고도리 메일 보내기 (제기자->대표담당자 황팀장)
	 * @param map
	 * @param toAddr
	 * @throws Exception
	 */
	public void shareClientGodorySendMail(Map<String, Object> map, ArrayList<Object> toAddr) throws Exception {
		String mailSubject = null;

		String selectModalIssueCategory = "";
		
		if("1".equals(map.get("selectModalIssueCategory"))){
			selectModalIssueCategory = "고쳐주세요";
		}else if("2".equals(map.get("selectModalIssueCategory"))){
			selectModalIssueCategory = "도와주세요";
		}else if("3".equals(map.get("selectModalIssueCategory"))){
			selectModalIssueCategory = "이런건어때요";
		}
		
		String textModalSubject = (String) map.get("textModalSubject"); 					// 제목
		String textareaModalIssueDetail = (String) map.get("textareaModalIssueDetail").toString().replaceAll("\r\n", "\n").replaceAll("\n", "<br>");	// 내용
//		String textModalSolveOwner = (String) map.get("textModalSolveOwner"); 				// 이슈제기자
		String textModalSolveOwner = "홍길동"; 				// 이슈제기자
		String fromMail	= "yysim@unipoint.co.kr"; 							// 공유자 이메일
		String fromName	= "홍길동"; 							// 공유자 이름
		selectModalIssueCategory = selectModalIssueCategory; 	// 카테고리
		String textModalIssueDate = (String) map.get("textModalIssueDate"); 				// 제안일자
		
		int pkNo = (int) map.get("filePK"); // PK

		URL returnURL = null;

		try {
			returnURL	=	new URL(IP_ADDR+"/kyungnong/viewGodoryList.do?issueId="+pkNo);
		} catch (MalformedURLException e1) {
			e1.printStackTrace();
		}

		//제목
		mailSubject = "[THE Seller's] 고도리 제안("+fromName+")";


		StringBuilder mailContent = new StringBuilder();

		mailContent.append("			<div class=\"contact_info mg_b30\">");
		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">고도리 제목 : "+ textModalSubject +"</label>");
		mailContent.append("				</div>");

		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">고도리 영역 : " +selectModalIssueCategory+ "</label>");
		mailContent.append("				</div>");

		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">제안자 : " + fromName +"</label>");
		mailContent.append("				</div>");

		mailContent.append("				<div class=\"row\">");
		mailContent.append("					<label class=\"bar\">제안 일자 : " + textModalIssueDate + "</label>");
		mailContent.append("				</div>");

		map.put("pkNo",pkNo);
		/*
		List<Map<String,Object>> actionGridList = clientSatisfactionDAO.selectSolvePlanIssue(map);
		for(Map<String,Object> getMap : actionGridList){
			mailContent.append("							<tr>");
			mailContent.append("								<td class='ag_l'>"+ getMap.get("SOLVE_PLAN") +"</td>");
			mailContent.append("								<td>"+ getMap.get("SOLVE_OWNER") +"</td>");
			mailContent.append("								<td>"+ getMap.get("SYS_REGISTER_DATE") +"</td>");
			mailContent.append("								<td>"+ getMap.get("DUE_DATE") +"</td>");
			if(CommonUtils.isEmpty(getMap.get("CLOSE_DATE"))){
				mailContent.append("								<td></td>");
			}else{
				mailContent.append("								<td>"+ getMap.get("CLOSE_DATE") +"</td>");
			}
			if("G".equals(getMap.get("HIDDEN_STATUS"))){
				mailContent.append("								<td class=\"endcell status_green\"><img src=\"http://thesellers.unipoint.co.kr:30100/other/mailform/images/green.png\" alt=\"\"/></td>");
			}else if("Y".equals(getMap.get("HIDDEN_STATUS"))){
				mailContent.append("								<td class=\"endcell status_yellow\"><img src=\"http://thesellers.unipoint.co.kr:30100/other/mailform/images/yellow.png\" alt=\"\"/></td>");
			}else if("R".equals(getMap.get("HIDDEN_STATUS"))){
				mailContent.append("								<td class=\"endcell status_red\"><img src=\"http://thesellers.unipoint.co.kr:30100/other/mailform/images/red.png\" alt=\"\"/></td>");
			}else{
				mailContent.append("								<td>-</td>");
			}
			mailContent.append("							</tr>");
		}
*/
		mailContent.append("						</tbody>");
		mailContent.append("					</table>");
		mailContent.append("				</div>");
		mailContent.append("			</div>");
		mailContent.append("");
		mailContent.append("		</div>");
		mailContent.append("		<!--// 콘텍정보 메일공유 -->");
		mailContent.append("	</div>");
		mailContent.append("	<!--// 콘텐츠 -->");

		sendMailSMTP(mailSubject, mailHtml(mailContent.toString(), returnURL), fromMail, fromName, toAddr);
	}
	
	
	public String compareToDateColor(String dueDateString, String closeDateString) throws Exception {
		String color = "";
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		Date dueDate = df.parse(dueDateString);
		String nowDateString = df.format(new Date());
		Date nowDate = df.parse(nowDateString);
		
		if(closeDateString != null && !"".equals(closeDateString)){
			color = "G";
		}else{
			if(nowDate.compareTo(dueDate) <= 0){
				color = "Y";
			}else{
				color = "R";
			}
		}
		
		return color;
	}
	
}
