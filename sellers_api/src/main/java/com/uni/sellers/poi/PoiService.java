package com.uni.sellers.poi;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFFormulaEvaluator;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.uni.sellers.admin.AdminDAO;
import com.uni.sellers.clientmanagement.ClientManagementDAO;
import com.uni.sellers.common.CommonDAO;
import com.uni.sellers.datasource.CommandMap;
import com.uni.sellers.logger.LoggerAspect;
import com.uni.sellers.salesmanagement.SalesManagementDAO;
import com.uni.sellers.salesmanagement.SalesManagementService;
import com.uni.sellers.util.CommonDateUtils;
import com.uni.sellers.util.CommonUtils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

@Service("poiService")
public class PoiService{
	protected Log log = LogFactory.getLog(LoggerAspect.class);

	@Resource(name="poiDAO")
	private PoiDAO poiDAO;

	@Resource(name="clientManagementDAO")
	private ClientManagementDAO clientManagementDAO;
		
	@Resource(name="salesManagementService")
	private SalesManagementService salesManagementService;
	
	@Resource(name="salesManagementDAO")
	private SalesManagementDAO salesManagementDAO;

	@Resource(name="adminDAO")
	private AdminDAO adminDAO;

	@Resource(name="commonDAO")
	private CommonDAO commonDAO;

	@Value("#{config['path.sampleFile']}")
	private String sampleFilePath;

	@Value("#{config['path.uploadFile']}")
	private String uploadFilePath;

	@Value("#{config['path.resultFile']}")
	private String resultFilePath;
	
	@Value("#{config['tmp.Data']}")
	private String TMP_DATA;

	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;

	private int CUSTOMER_ID;
	private int COMPANY_ID;
	private int PARTNER_INDIVIDUAL_ID;
	private int KEY_ID;

	//null 값 문자열 처리
	public String nullCheck(String text){
		if(null == text){
			text = "";
		}else {
			return text;
		}

		return  text;
	}
	
	/**
	 * 주간보고 엑셀 다운로드
	 */
	@SuppressWarnings("unchecked")
	public void weeklyReportXlsxDownload(Map<String, Object> map1, HttpServletRequest request, HttpServletResponse response) throws FileNotFoundException {
		
		try {
			
			// 주간보고서 데이터
			// 년도
			Map<String, Object> weeklyReportYear = salesManagementService.selectWeeklyReportYear(map1);
			List<Map<String, Object>> yearList = (List<Map<String, Object>>) weeklyReportYear.get("weeklyReportYear");
			Map<String, Object> yearTotal = (Map<String, Object>) weeklyReportYear.get("weeklyReportTotalYear");

			// 분기
			List<Map<String, Object>> quarterList = salesManagementDAO.selectWeeklyReportQuarter(map1);
			
			
			InputStream inp = null;
			inp = new FileInputStream(request.getSession().getServletContext().getRealPath("/WEB-INF/Weekly Report.xlsx"));
		
			Workbook wb = WorkbookFactory.create(inp);
			
			Sheet sheet = wb.getSheetAt(0);
			
			// 제목
			String title = (String) map1.get("selectDivisionName");
			title = title + " Forecast";
			
			Row titleRow = sheet.getRow(0);
			Cell titleCell = titleRow.getCell(0);
			titleCell.setCellType(Cell.CELL_TYPE_STRING);
			titleCell.setCellValue(title);
										
			int size = yearList.size();
			
			for(int j=0; j<size; j++) {
				
				Map<String, Object> list = yearList.get(j);
				
				Row siRow = sheet.getRow(j+(3*(j+1)));
				
				Cell tcvCell = siRow.getCell(3);
				tcvCell.setCellType(Cell.CELL_TYPE_NUMERIC);
				tcvCell.setCellValue(Double.parseDouble(list.get("TCV_SI").toString()));
				Cell revCell = siRow.getCell(5);
				revCell.setCellType(Cell.CELL_TYPE_NUMERIC);
				revCell.setCellValue(Double.parseDouble(list.get("REV_SI").toString()));
				Cell gpCell = siRow.getCell(6);
				gpCell.setCellType(Cell.CELL_TYPE_NUMERIC);
				gpCell.setCellValue(Double.parseDouble(list.get("GP_SI").toString()));
				
				Cell yearRev = siRow.getCell(7);
				yearRev.setCellType(Cell.CELL_TYPE_NUMERIC);
				yearRev.setCellValue(Double.parseDouble(list.get("ACHIEVE_REV_Y").toString()));
				Cell yearGp = siRow.getCell(8);
				yearGp.setCellType(Cell.CELL_TYPE_NUMERIC);
				yearGp.setCellValue(Double.parseDouble(list.get("ACHIEVE_GP_Y").toString()));
				
				Cell targetRev = siRow.getCell(9);
				targetRev.setCellType(Cell.CELL_TYPE_NUMERIC);
				targetRev.setCellValue(Double.parseDouble(list.get("TARGET_REV_Q").toString()));
				Cell targetGp = siRow.getCell(10);
				targetGp.setCellType(Cell.CELL_TYPE_NUMERIC);
				targetGp.setCellValue(Double.parseDouble(list.get("TARGET_GP_Q").toString()));
				
				Cell quarterRev = siRow.getCell(11);
				quarterRev.setCellType(Cell.CELL_TYPE_NUMERIC);
				quarterRev.setCellValue(Double.parseDouble(list.get("ACHIEVE_REV_Q").toString()));
				Cell quarterGp = siRow.getCell(12);
				quarterGp.setCellType(Cell.CELL_TYPE_NUMERIC);
				quarterGp.setCellValue(Double.parseDouble(list.get("ACHIEVE_GP_Q").toString()));
				
				Row maRow = sheet.getRow(j+(3*(j+1))+1);
				
				tcvCell = maRow.getCell(3);
				tcvCell.setCellType(Cell.CELL_TYPE_NUMERIC);
				tcvCell.setCellValue(Double.parseDouble(list.get("TCV_MA").toString()));
				revCell = maRow.getCell(5);
				revCell.setCellType(Cell.CELL_TYPE_NUMERIC);
				revCell.setCellValue(Double.parseDouble(list.get("REV_MA").toString()));
				gpCell = maRow.getCell(6);
				gpCell.setCellType(Cell.CELL_TYPE_NUMERIC);
				gpCell.setCellValue(Double.parseDouble(list.get("GP_MA").toString()));
				
				Row etcRow = sheet.getRow(j+(3*(j+1))+2);
				
				tcvCell = etcRow.getCell(3);
				tcvCell.setCellType(Cell.CELL_TYPE_NUMERIC);
				tcvCell.setCellValue(Double.parseDouble(list.get("TCV_ETC").toString()));
				revCell = etcRow.getCell(5);
				revCell.setCellType(Cell.CELL_TYPE_NUMERIC);
				revCell.setCellValue(Double.parseDouble(list.get("REV_ETC").toString()));
				gpCell = etcRow.getCell(6);
				gpCell.setCellType(Cell.CELL_TYPE_NUMERIC);
				gpCell.setCellValue(Double.parseDouble(list.get("GP_ETC").toString()));
				
				Row sumRow = sheet.getRow(j+(3*(j+1))+3);
				
				tcvCell = sumRow.getCell(3);
				tcvCell.setCellType(Cell.CELL_TYPE_NUMERIC);
				tcvCell.setCellValue(Double.parseDouble(list.get("SUM_TCV").toString()));
				revCell = sumRow.getCell(5);
				revCell.setCellType(Cell.CELL_TYPE_NUMERIC);
				revCell.setCellValue(Double.parseDouble(list.get("SUM_REV").toString()));
				gpCell = sumRow.getCell(6);
				gpCell.setCellType(Cell.CELL_TYPE_NUMERIC);
				gpCell.setCellValue(Double.parseDouble(list.get("SUM_GP").toString()));
				
				Cell sumQuarterRev = siRow.getCell(9);
				sumQuarterRev.setCellType(Cell.CELL_TYPE_NUMERIC);
				sumQuarterRev.setCellValue(Double.parseDouble(list.get("TARGET_REV_Q").toString()));
				Cell sumQuarterGp = siRow.getCell(10);
				sumQuarterGp.setCellType(Cell.CELL_TYPE_NUMERIC);
				sumQuarterGp.setCellValue(Double.parseDouble(list.get("TARGET_GP_Q").toString()));
			}
			
			// total row
			Row totalRow = sheet.getRow(19);
			Cell revTotalCell = totalRow.getCell(11);
			revTotalCell.setCellType(Cell.CELL_TYPE_NUMERIC);
			revTotalCell.setCellValue(Double.parseDouble(yearTotal.get("TOTAL_ACHIEVE_REV_Q").toString()));
			Cell gpTotalCell = totalRow.getCell(12);
			gpTotalCell.setCellType(Cell.CELL_TYPE_NUMERIC);
			gpTotalCell.setCellValue(Double.parseDouble(yearTotal.get("TOTAL_ACHIEVE_GP_Q").toString()));
			
			
			//////////////////////////////////////////////년도 그리드 end//////////////////////////////////////////////////////
			//////////////////////////////////////////////분기 그리드 start//////////////////////////////////////////////////////
						
			Font cellFont = wb.createFont();
			cellFont.setFontName("맑은 고딕");
			cellFont.setFontHeightInPoints((short) 10);
			// 기본 셀 스타일
			CellStyle cellStyle = wb.createCellStyle();
			
			// 숫자 표시하는 셀 스타일
			CellStyle numStyle = wb.createCellStyle();
			numStyle.setBorderTop(CellStyle.BORDER_THIN);
			numStyle.setBorderRight(CellStyle.BORDER_THIN);
			numStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0"));
			numStyle.setAlignment(CellStyle.ALIGN_RIGHT);
			numStyle.setFont(cellFont);
			
			// 오른쪽 끝 셀 스타일
			CellStyle rightStyle = wb.createCellStyle();
			rightStyle.setBorderTop(CellStyle.BORDER_THIN);
			rightStyle.setAlignment(CellStyle.ALIGN_CENTER);
			rightStyle.setBorderRight(CellStyle.BORDER_MEDIUM); 
			rightStyle.setFont(cellFont);
			
			//======================================================= 
			// 마지막 라인의 셀 스타일
			CellStyle lastCellStyle = wb.createCellStyle();
			lastCellStyle.setBorderBottom(CellStyle.BORDER_MEDIUM);
			lastCellStyle.setBorderTop(CellStyle.BORDER_THIN);
			lastCellStyle.setBorderRight(CellStyle.BORDER_THIN);
			lastCellStyle.setAlignment(CellStyle.ALIGN_CENTER);
			lastCellStyle.setFont(cellFont);
			
			CellStyle lastNumStyle = wb.createCellStyle();
			lastNumStyle.setBorderBottom(CellStyle.BORDER_MEDIUM);
			lastNumStyle.setBorderTop(CellStyle.BORDER_THIN);
			lastNumStyle.setBorderRight(CellStyle.BORDER_THIN);
			lastNumStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0"));
			lastNumStyle.setAlignment(CellStyle.ALIGN_RIGHT);
			lastNumStyle.setFont(cellFont);
			
			CellStyle lastRightStyle = wb.createCellStyle();
			lastRightStyle.setBorderBottom(CellStyle.BORDER_MEDIUM);
			lastRightStyle.setBorderTop(CellStyle.BORDER_THIN);
			lastRightStyle.setAlignment(CellStyle.ALIGN_CENTER);
			lastRightStyle.setBorderRight(CellStyle.BORDER_MEDIUM); 
			lastRightStyle.setFont(cellFont);
			//======================================================= 
			
			size = quarterList.size();
			
			for(int j=0; j<size; j++){				
				
				Map<String, Object> list = quarterList.get(j);
				
				// 23행부터 시작
				Row row = sheet.getRow(j+22);
				if(row == null){
					row = sheet.createRow(j+22);
				}
				
				// 구분
				Cell cell0 = row.getCell(0);
				if(cell0 == null){
					cell0 = row.createCell(0);
				}
				
				// cell 스타일 가져오기
				if(j==0){
					cellStyle = cell0.getCellStyle();
					cellStyle.setBorderTop(CellStyle.BORDER_THIN);
				}
				
				cell0.setCellType(Cell.CELL_TYPE_STRING);
				cell0.setCellValue(list.get("OBTAIN_ORDER_TYPE").toString());
				if(j == (size-1)){
					cell0.setCellStyle(lastCellStyle);
				}else{
					cell0.setCellStyle(cellStyle);
				}
				
				// 영업대표
				Cell cell1 = row.getCell(1);
				if(cell1 == null){
					cell1 = row.createCell(1);
				}
				cell1.setCellType(Cell.CELL_TYPE_STRING);
				cell1.setCellValue(list.get("HAN_NAME").toString());
				if(j == (size-1)){
					cell1.setCellStyle(lastCellStyle);
				}else{
					cell1.setCellStyle(cellStyle);
				}
				
				// 고객명
				Cell cell2 = row.getCell(2);
				if(cell2 == null){
					cell2 = row.createCell(2);
				}
				cell2.setCellType(Cell.CELL_TYPE_STRING);
				cell2.setCellValue(list.get("COMPANY_NAME").toString());
				if(j == (size-1)){
					cell2.setCellStyle(lastCellStyle);
				}else{
					cell2.setCellStyle(cellStyle);
				}
				
//				 프로젝트명
				Cell cell3 = row.getCell(3);
				Cell cell3_2 = row.getCell(4);
				if(cell3 == null){
					cell3 = row.createCell(3);
				}
				if(cell3_2 == null){
					cell3_2 = row.createCell(4);
				}
				cell3.setCellType(Cell.CELL_TYPE_STRING);
				cell3.setCellValue(list.get("PROJECT_NAME").toString());
				
				if(j == (size-1)){
					cell3.setCellStyle(lastCellStyle);
					cell3_2.setCellStyle(lastCellStyle);
				}else{
					cell3.setCellStyle(cellStyle);
					cell3_2.setCellStyle(cellStyle);
				}
				
				if(j != 0){
					//셀 병합
					sheet.addMergedRegion(new CellRangeAddress((j+22), (j+22), 3, 4));
				}

				// TCV
				Cell cell4 = row.getCell(5);
				if(cell4 == null){
					cell4 = row.createCell(5);
				}
				
				cell4.setCellType(Cell.CELL_TYPE_NUMERIC);
				cell4.setCellValue(Double.parseDouble(list.get("TCV").toString()));
				if(j == (size-1)){
					cell4.setCellStyle(lastNumStyle);
				}else{
					cell4.setCellStyle(numStyle);
				}
				
				// Revenue
				Cell cell5 = row.getCell(6);
				if(cell5 == null){
					cell5 = row.createCell(6);
				}
				cell5.setCellType(Cell.CELL_TYPE_NUMERIC);
				cell5.setCellValue(Double.parseDouble(list.get("ACCRUE_REV").toString()));
				if(j == (size-1)){
					cell5.setCellStyle(lastNumStyle);
				}else{
					cell5.setCellStyle(numStyle);
				}
				
				// GP
				Cell cell6 = row.getCell(7);
				if(cell6 == null){
					cell6 = row.createCell(7);
				}
				cell6.setCellType(Cell.CELL_TYPE_NUMERIC);
				cell6.setCellValue(Double.parseDouble(list.get("ACCRUE_GP").toString()));
				if(j == (size-1)){
					cell6.setCellStyle(lastNumStyle);
				}else{
					cell6.setCellStyle(numStyle);
				}
				
				// 계약일
				Cell cell7 = row.getCell(8);
				if(cell7 == null){
					cell7 = row.createCell(8);
				}
				cell7.setCellType(Cell.CELL_TYPE_STRING);
				cell7.setCellValue(list.get("DT_SO").toString());
				if(j == (size-1)){
					cell7.setCellStyle(lastCellStyle);
				}else{
					cell7.setCellStyle(cellStyle);
				}
				
				// 계산서발행일
				Cell cell8 = row.getCell(9);
				if(cell8 == null){
					cell8 = row.createCell(9);
				}
				cell8.setCellType(Cell.CELL_TYPE_STRING);
				cell8.setCellValue(list.get("DT_IVL").toString());
				if(j == (size-1)){
					cell8.setCellStyle(lastCellStyle);
				}else{
					cell8.setCellStyle(cellStyle);
				}
				
				// 수금예정일
				Cell cell9 = row.getCell(10);
				if(cell9 == null){
					cell9 = row.createCell(10);
				}
				cell9.setCellType(Cell.CELL_TYPE_STRING);
				cell9.setCellValue(" ");
				if(j == (size-1)){
					cell9.setCellStyle(lastCellStyle);
				}else{
					cell9.setCellStyle(cellStyle);
				}
				
				
				// 수금일
				Cell cell10 = row.getCell(11);
				if(cell10 == null){
					cell10 = row.createCell(11);
				}
				cell10.setCellType(Cell.CELL_TYPE_STRING);
				cell10.setCellValue(" ");
				if(j == (size-1)){
					cell10.setCellStyle(lastCellStyle);
				}else{
					cell10.setCellStyle(cellStyle);
				}
				
				// 비고
				Cell cell11 = row.getCell(12);
				if(cell11 == null){
					cell11 = row.createCell(12);
				}
				cell11.setCellType(Cell.CELL_TYPE_STRING);
				cell11.setCellValue(" ");
				if(j == (size-1)){
					cell11.setCellStyle(lastRightStyle);
				}else{
					cell11.setCellStyle(rightStyle);
				}
			}
			
			//////////////////////////////////////////////분기 그리드 end//////////////////////////////////////////////////////
			
			HSSFFormulaEvaluator.evaluateAllFormulaCells(wb);

//			FileOutputStream fileOut = null;
//			fileOut = new FileOutputStream("C:/download/Weekly Report 다운로드.xlsx");
//			wb.write(fileOut);
//			fileOut.close();

			// 현재 날짜
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat ( "yyyyMMdd", Locale.KOREA );
			Date date = new Date();
			String currentDate = simpleDateFormat.format(date);
			
			response.reset();
			response.setContentType("application/vnd.ms-excel");
		    response.setHeader("Content-Disposition", "attachment; filename=Weekly Report_" + currentDate + ".xlsx;");
			
//			out.clear();
//			out = pageContext.pushBody();
			OutputStream fileOut = response.getOutputStream();
			wb.write(fileOut);
			wb.close();
			fileOut.close();
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
	}

	public int xlsxDownloadExcelFile(Map<String, Object> map1, HttpServletRequest request) throws Exception {
		int cnt = 0;

		InputStream inp = null;

		try
		{
			if(!map1.get("flag").equals("Target"))
			{
				inp = new FileInputStream(sampleFilePath+"셀러스_필요데이터_양식_유니.xlsx");
			}else {
				inp = new FileInputStream(sampleFilePath+"셀러스_직원_Target데이터_양식.xlsx");
			}

			Workbook wb = WorkbookFactory.create(inp);
//			XSSFWorkbook wb = new XSSFWorkbook(inp);

			if(!map1.get("flag").equals("Target"))
			{
				//레이아웃 ( sheet )
				for(int i=0; i<10; i++)
				{
					//첫번째 sheet 
					if(i==0)
					{
						Sheet sheet = wb.getSheetAt(i);
						//				Row row = sheet.getRow(3);
						//				Cell cell = row.getCell(3);

						List<Map<String, Object>> list = poiDAO.selectClientIndividualDBtoExcel();

						for(int j=0; j<list.size(); j++)
						{
							Row row = sheet.getRow(j+3);
							for(int k=0; k<39; k++)
							{
								Cell cell = row.getCell(k);
								if(cell == null){
									cell = row.createCell(k);
								}
								cell.setCellType(Cell.CELL_TYPE_STRING);
								if(k==0){
									cell.setCellValue(list.get(j).get("CUSTOMER_ID").toString());
								}else if(k==1){
									cell.setCellValue(list.get(j).get("COMPANY_ID").toString());
								}else if(k==2){
									cell.setCellValue(list.get(j).get("CUSTOMER_NAME").toString());
								}else if(k==3){
									cell.setCellValue(list.get(j).get("DIVISION").toString());
								}else if(k==4){
									cell.setCellValue(list.get(j).get("POST").toString());
								}else if(k==5){
									cell.setCellValue(list.get(j).get("TEAM").toString());
								}else if(k==6){
									cell.setCellValue(list.get(j).get("POSITION").toString());
								}else if(k==7){
									cell.setCellValue(list.get(j).get("DUTY").toString());
								}else if(k==8){
									cell.setCellValue(list.get(j).get("CELL_PHONE").toString());
								}else if(k==9){
									cell.setCellValue(list.get(j).get("PHONE").toString());
								}else if(k==10){
									cell.setCellValue(list.get(j).get("EMAIL").toString());
								}else if(k==11){
									cell.setCellValue(list.get(j).get("ADDRESS").toString());
								}else if(k==12){
									cell.setCellValue(list.get(j).get("FRIENDSHIP_INFO").toString());
								}else if(k==13){
									cell.setCellValue(list.get(j).get("INFO_SOURCE").toString());
								}else if(k==14){
									cell.setCellValue(list.get(j).get("PINFO_CAREER").toString());
								}else if(k==15){
									cell.setCellValue(list.get(j).get("PINFO_SOCIAL_ACTS").toString());
								}else if(k==16){
									cell.setCellValue(list.get(j).get("PINFO_FAMILY").toString());
								}else if(k==17){
									cell.setCellValue(list.get(j).get("PINFO_INCLINATION").toString());
								}else if(k==18){
									cell.setCellValue(list.get(j).get("PINFO_FAMILIARS").toString());
								}else if(k==19){
									cell.setCellValue(list.get(j).get("PINFO_SNS").toString());
								}else if(k==20){
									cell.setCellValue(list.get(j).get("PINFO_ETC").toString());
								}else if(k==21){
									cell.setCellValue(list.get(j).get("CREATOR_ID").toString());
								}else if(k==22){
									cell.setCellValue(list.get(j).get("CREATE_DATE").toString());
								}else if(k==23){
									cell.setCellValue(list.get(j).get("SYS_REGISTER_DATE").toString());
								}else if(k==24){
									cell.setCellValue(list.get(j).get("SYS_UPDATE_DATE").toString());
								}else if(k==25){
									cell.setCellValue(list.get(j).get("REPORTING_LINE_DIVISION_ID").toString());
								}else if(k==26){
									cell.setCellValue(list.get(j).get("REPORTING_LINE_POST_ID").toString());
								}else if(k==27){
									cell.setCellValue(list.get(j).get("REPORTING_LINE_TEAM_ID").toString());
								}else if(k==28){
									cell.setCellValue(list.get(j).get("PINFO_EDUCATION_PERSON").toString());
								}else if(k==29){
									cell.setCellValue(list.get(j).get("PINFO_CAREER_PERSON").toString());
								}else if(k==30){
									cell.setCellValue(list.get(j).get("PINFO_EDUCATION").toString());
								}else if(k==31){
									cell.setCellValue(list.get(j).get("PREV_SALES_MEMBER_ID").toString());
								}else if(k==32){
									cell.setCellValue(list.get(j).get("POSITION_DUTY").toString());
								}else if(k==33){
									cell.setCellValue(list.get(j).get("PINFO_RELATIONSHIP").toString());
								}else if(k==34){
									cell.setCellValue(list.get(j).get("LIKEABILITY").toString());
								}else if(k==35){
									cell.setCellValue(list.get(j).get("RELATION").toString());
								}else if(k==36){
									cell.setCellValue(list.get(j).get("DIRECTOR_ID").toString());
								}else if(k==37){
									cell.setCellValue(list.get(j).get("USE_YN").toString());
								}
								else if(k==38){
									//기본으로 "N"
									cell.setCellValue("N");
								}
							}
						}
						

					}//if i==0
					else if(i==1){
						Sheet sheet = wb.getSheetAt(i);
						//				Row row = sheet.getRow(3);
						//				Cell cell = row.getCell(3);

						List<Map<String, Object>> list = poiDAO.selectClientCompanyDBtoExcel();

						for(int j=0; j<list.size(); j++)
						{
							Row row = sheet.getRow(j+3);
							for(int k=0; k<20; k++)
							{
								Cell cell = row.getCell(k);
								if(cell == null){
									cell = row.createCell(k);
								}
								cell.setCellType(Cell.CELL_TYPE_STRING);
								if(k==0){
									cell.setCellValue(list.get(j).get("COMPANY_ID").toString());
								}else if(k==1){
									cell.setCellValue(list.get(j).get("SEGMENT_CODE").toString());
								}else if(k==2){
									cell.setCellValue(list.get(j).get("ERP_REG_CODE").toString());
								}else if(k==3){
									cell.setCellValue(list.get(j).get("COMPANY_NAME").toString());
								}else if(k==4){
									cell.setCellValue(list.get(j).get("CEO_NAME").toString());
								}else if(k==5){
									cell.setCellValue(list.get(j).get("COMPANY_TELNO").toString());
								}else if(k==6){
									cell.setCellValue(list.get(j).get("POSTAL_CODE").toString());
								}else if(k==7){
									cell.setCellValue(list.get(j).get("POSTAL_ADDRESS").toString());
								}else if(k==8){
									cell.setCellValue(list.get(j).get("BUSINESS_NUMBER").toString());
								}else if(k==9){
									cell.setCellValue(list.get(j).get("BUSINESS_TYPE").toString());
								}else if(k==10){
									cell.setCellValue(list.get(j).get("BUSINESS_SECTOR").toString());
								}else if(k==11){
									cell.setCellValue(list.get(j).get("COMPANY_STATUS").toString());
								}else if(k==12){
									cell.setCellValue(list.get(j).get("SYS_REGISTER_DATE").toString());
								}else if(k==13){
									cell.setCellValue(list.get(j).get("SYS_UPDATE_DATE").toString());
								}else if(k==14){
									cell.setCellValue(list.get(j).get("CIO_NAME").toString());
								}else if(k==15){
									cell.setCellValue(list.get(j).get("CTO_NAME").toString());
								}else if(k==16){
									cell.setCellValue(list.get(j).get("CEO_ID").toString());
								}else if(k==17){
									cell.setCellValue(list.get(j).get("CIO_ID").toString());
								}else if(k==18){
									cell.setCellValue(list.get(j).get("CTO_ID").toString());
								}else if(k==19){
									if(list.get(j).get("CLIENT_CATEGORY").toString().equals("1")){
										cell.setCellValue("EPC");
									}else if(list.get(j).get("CLIENT_CATEGORY").toString().equals("2")){
										cell.setCellValue("Owner");
									}else if(list.get(j).get("CLIENT_CATEGORY").toString().equals("3")){
										cell.setCellValue("Sales");
									}else if(list.get(j).get("CLIENT_CATEGORY").toString().equals("4")){
										cell.setCellValue("공기업");
									}else if(list.get(j).get("CLIENT_CATEGORY").toString().equals("5")){
										cell.setCellValue("제조");
									}else if(list.get(j).get("CLIENT_CATEGORY").toString().equals("6")){
										cell.setCellValue("해외");
									}
									//cell.setCellValue(list.get(j).get("CLIENT_CATEGORY").toString());
								}
							}
						}
					}
					else if(i==2){
						Sheet sheet = wb.getSheetAt(i);
						//				Row row = sheet.getRow(3);
						//				Cell cell = row.getCell(3);

						List<Map<String, Object>> list = poiDAO.selectOurMembersInfoDBtoExcel();

						for(int j=0; j<list.size(); j++)
						{
							Row row = sheet.getRow(j+3);
							for(int k=0; k<23; k++)
							{
								Cell cell = row.getCell(k);
								if(cell == null){
									cell = row.createCell(k);
								}
								cell.setCellType(Cell.CELL_TYPE_STRING);
								if(k==0){
									cell.setCellValue(list.get(j).get("MEMBER_ID").toString());
								}else if(k==1){
									cell.setCellValue(list.get(j).get("MEMBER_DIVISION").toString());
								}else if(k==2){
									cell.setCellValue(list.get(j).get("MEMBER_POST").toString());
								}else if(k==3){
									cell.setCellValue(list.get(j).get("MEMBER_TEAM").toString());
								}else if(k==4){
									cell.setCellValue(list.get(j).get("MEMBER_ID_NUM").toString());
								}else if(k==5){
									cell.setCellValue(list.get(j).get("HAN_NAME").toString());
								}else if(k==6){
									cell.setCellValue(list.get(j).get("POSITION_STATUS").toString());
								}else if(k==7){
									cell.setCellValue(list.get(j).get("POSITION_RANK").toString());
								}else if(k==8){
									cell.setCellValue(list.get(j).get("POSITION_DUTY").toString());
								}else if(k==9){
									cell.setCellValue(list.get(j).get("POSITION_TYPE").toString());
								}else if(k==10){
									cell.setCellValue(list.get(j).get("BUSINESS_DUTY").toString());
								}else if(k==11){
									cell.setCellValue(list.get(j).get("JOIN_DATE").toString());
								}else if(k==12){
									cell.setCellValue(list.get(j).get("STOP_DATE").toString());
								}else if(k==13){
									cell.setCellValue(list.get(j).get("CELL_PHONE").toString());
								}else if(k==14){
									cell.setCellValue(list.get(j).get("PHONE").toString());
								}else if(k==15){
									cell.setCellValue(list.get(j).get("EMAIL").toString());
								}else if(k==16){
									cell.setCellValue(list.get(j).get("FRIENDSHIP_COMPANY").toString());
								}else if(k==17){
									cell.setCellValue(list.get(j).get("FRIENDSHIP_CUSTOMER").toString());
								}else if(k==18){
									cell.setCellValue(list.get(j).get("PERSONAL_PHOTO").toString());
								}else if(k==19){
									cell.setCellValue(list.get(j).get("PHOTO_TYPE").toString());
								}else if(k==20){
									cell.setCellValue(list.get(j).get("SYS_REGISTER_DATE").toString());
								}else if(k==21){
									cell.setCellValue(list.get(j).get("SYS_UPDATE_DATE").toString());
								}else if(k==22){
									cell.setCellValue(list.get(j).get("USE_YN").toString());
								}
							}
						}
					}
					else if(i==3){
						Sheet sheet = wb.getSheetAt(i);
						//				Row row = sheet.getRow(3);
						//				Cell cell = row.getCell(3);

						List<Map<String, Object>> list = poiDAO.selectOurDivisionInfoDBtoExcel();

						for(int j=0; j<list.size(); j++)
						{
							Row row = sheet.getRow(j+3);
							for(int k=0; k<7; k++)
							{
								Cell cell = row.getCell(k);
								if(cell == null){
									cell = row.createCell(k);
								}
								cell.setCellType(Cell.CELL_TYPE_STRING);
								if(k==0){
									cell.setCellValue(list.get(j).get("DIVISION_NO").toString());
								}else if(k==1){
									cell.setCellValue(list.get(j).get("DIVISION_NAME").toString());
								}else if(k==2){
									cell.setCellValue(list.get(j).get("SYS_REGISTER_DATE").toString());
								}else if(k==3){
									cell.setCellValue(list.get(j).get("SYS_UPDATE_DATE").toString());
								}else if(k==4){
									cell.setCellValue(list.get(j).get("DIVISION_TYPE").toString());
								}else if(k==5){
									cell.setCellValue(list.get(j).get("USE_YN").toString());
								}else if(k==6){
									cell.setCellValue(list.get(j).get("DIVISION_LEADER").toString());
								}
							}
						}
					}
					else if(i==4){
						Sheet sheet = wb.getSheetAt(i);
						//				Row row = sheet.getRow(3);
						//				Cell cell = row.getCell(3);

						List<Map<String, Object>> list = poiDAO.selectOurTeamInfoDBtoExcel();

						for(int j=0; j<list.size(); j++)
						{
							Row row = sheet.getRow(j+3);
							for(int k=0; k<8; k++)
							{
								Cell cell = row.getCell(k);
								if(cell == null){
									cell = row.createCell(k);
								}
								cell.setCellType(Cell.CELL_TYPE_STRING);
								if(k==0){
									cell.setCellValue(list.get(j).get("TEAM_NO").toString());
								}else if(k==1){
									cell.setCellValue(list.get(j).get("TEAM_NAME").toString());
								}else if(k==2){
									cell.setCellValue(list.get(j).get("TEAM_LEADER").toString());
								}else if(k==3){
									cell.setCellValue(list.get(j).get("USE_YN").toString());
								}else if(k==4){
									cell.setCellValue(list.get(j).get("SYS_REGISTER_DATE").toString());
								}else if(k==5){
									cell.setCellValue(list.get(j).get("SYS_UPDATE_DATE").toString());
								}else if(k==6){
									cell.setCellValue(list.get(j).get("DIVISION_NO").toString());
								}else if(k==7){
									cell.setCellValue(list.get(j).get("TEAM_TYPE").toString());
								}
							}
						}
					}
					else if(i==5){
						Sheet sheet = wb.getSheetAt(i);
						//				Row row = sheet.getRow(3);
						//				Cell cell = row.getCell(3);

						List<Map<String, Object>> list = poiDAO.selectPartnerCompanyDBtoExcel();

						for(int j=0; j<list.size(); j++)
						{
							Row row = sheet.getRow(j+3);
							for(int k=0; k<19; k++)
							{
								Cell cell = row.getCell(k);
								if(cell == null){
									cell = row.createCell(k);
								}
								cell.setCellType(Cell.CELL_TYPE_STRING);
								if(k==0){
									cell.setCellValue(list.get(j).get("PARTNER_ID").toString());
								}else if(k==1){
									cell.setCellValue(list.get(j).get("PARTNER_CODE").toString());
								}else if(k==2){
									cell.setCellValue(list.get(j).get("COMPANY_NAME").toString());
								}else if(k==3){
									cell.setCellValue(list.get(j).get("CEO_NAME").toString());
								}else if(k==4){
									cell.setCellValue(list.get(j).get("COMPANY_TELNO").toString());
								}else if(k==5){
									cell.setCellValue(list.get(j).get("POSTAL_CODE").toString());
								}else if(k==6){
									cell.setCellValue(list.get(j).get("POSTAL_ADDRESS").toString());
								}else if(k==7){
									cell.setCellValue(list.get(j).get("BUSINESS_NUMBER").toString());
								}else if(k==8){
									cell.setCellValue(list.get(j).get("BUSINESS_TYPE").toString());
								}else if(k==9){
									cell.setCellValue(list.get(j).get("BUSINESS_SECTOR").toString());
								}else if(k==10){
									cell.setCellValue(list.get(j).get("COMPANY_STATUS").toString());
								}else if(k==11){
									cell.setCellValue(list.get(j).get("SYS_REGISTER_DATE").toString());
								}else if(k==12){
									cell.setCellValue(list.get(j).get("SYS_UPDATE_DATE").toString());
								}else if(k==13){
									cell.setCellValue(list.get(j).get("COMPANY_ENNAME").toString());
								}else if(k==14){
									cell.setCellValue(list.get(j).get("CEO_ID").toString());
								}else if(k==15){
									cell.setCellValue(list.get(j).get("PARTNER_CATEGORY").toString());
								}else if(k==16){
									cell.setCellValue(list.get(j).get("COMPANY_ITEM").toString());
								}else if(k==17){
									cell.setCellValue(list.get(j).get("COMPANY_HOMEPAGE").toString());
								}else if(k==18){
									cell.setCellValue(list.get(j).get("COMPANY_FAXNO").toString());
								}
							}
						}
					}
					else if(i==6){
						Sheet sheet = wb.getSheetAt(i);
						//				Row row = sheet.getRow(3);
						//				Cell cell = row.getCell(3);

						List<Map<String, Object>> list = poiDAO.selectPartnerIndividualDBtoExcel();

						for(int j=0; j<list.size(); j++)
						{
							Row row = sheet.getRow(j+3);
							for(int k=0; k<24; k++)
							{
								Cell cell = row.getCell(k);
								if(cell == null){
									cell = row.createCell(k);
								}
								cell.setCellType(Cell.CELL_TYPE_STRING);
								if(k==0){
									cell.setCellValue(list.get(j).get("PARTNER_INDIVIDUAL_ID").toString());
								}else if(k==1){
									cell.setCellValue(list.get(j).get("PARTNER_ID").toString());
								}else if(k==2){
									cell.setCellValue(list.get(j).get("PARTNER_PERSONAL_NAME").toString());
								}else if(k==3){
									cell.setCellValue(list.get(j).get("DIVISION").toString());
								}else if(k==4){
									cell.setCellValue(list.get(j).get("POST").toString());
								}else if(k==5){
									cell.setCellValue(list.get(j).get("TEAM").toString());
								}else if(k==6){
									cell.setCellValue(list.get(j).get("POSITION").toString());
								}else if(k==7){
									cell.setCellValue(list.get(j).get("SKILL_TYPE").toString());
								}else if(k==8){
									cell.setCellValue(list.get(j).get("DUTY").toString());
								}else if(k==9){
									cell.setCellValue(list.get(j).get("CELL_PHONE").toString());
								}else if(k==10){
									cell.setCellValue(list.get(j).get("PHONE").toString());
								}else if(k==11){
									cell.setCellValue(list.get(j).get("EMAIL").toString());
								}else if(k==12){
									cell.setCellValue(list.get(j).get("FRIENDSHIP_COMPANY").toString());
								}else if(k==13){
									cell.setCellValue(list.get(j).get("FRIENDSHIP_CUSTOMER").toString());
								}else if(k==14){
									cell.setCellValue(list.get(j).get("PERSONAL_INFO").toString());
								}else if(k==15){
									cell.setCellValue(list.get(j).get("PERSONAL_PHOTO").toString());
								}else if(k==16){
									cell.setCellValue(list.get(j).get("PHOTO_TYPE").toString());
								}else if(k==17){
									cell.setCellValue(list.get(j).get("FRIENDSHIP_INFO").toString());
								}else if(k==18){
									cell.setCellValue(list.get(j).get("SYS_REGISTER_DATE").toString());
								}else if(k==19){
									cell.setCellValue(list.get(j).get("SYS_UPDATE_DATE").toString());
								}else if(k==20){
									cell.setCellValue(list.get(j).get("CREATOR_ID").toString());
								}else if(k==21){
									cell.setCellValue(list.get(j).get("USE_YN").toString());
								}else if(k==22){
									cell.setCellValue(list.get(j).get("POSITION_DUTY").toString());
								}
								else if(k==23){
									//기본으로 "N"
									cell.setCellValue("N");
								}
							}
						}
					}
					else if(i==7){
						Sheet sheet = wb.getSheetAt(i);
						//				Row row = sheet.getRow(3);
						//				Cell cell = row.getCell(3);

						List<Map<String, Object>> list = poiDAO.selectCodePartnerSegmentDBtoExcel();

						for(int j=0; j<list.size(); j++)
						{
							Row row = sheet.getRow(j+3);
							for(int k=0; k<6; k++)
							{
								Cell cell = row.getCell(k);
								if(cell == null){
									cell = row.createCell(k);
								}
								cell.setCellType(Cell.CELL_TYPE_STRING);
								if(k==0){
									cell.setCellValue(list.get(j).get("PARTNER_CODE").toString());
								}else if(k==1){
									cell.setCellValue(list.get(j).get("PARTNER_LEVEL").toString());
								}else if(k==2){
									cell.setCellValue(list.get(j).get("PARTNER_DETAIL").toString());
								}else if(k==3){
									cell.setCellValue(list.get(j).get("SYS_REGISTER_DATE").toString());
								}else if(k==4){
									cell.setCellValue(list.get(j).get("SYS_UPDATE_DATE").toString());
								}else if(k==5){
									cell.setCellValue(list.get(j).get("USE_YN").toString());
								}
							}
						}
					}
					else if(i==8){
						Sheet sheet = wb.getSheetAt(i);
						//				Row row = sheet.getRow(3);
						//				Cell cell = row.getCell(3);

						List<Map<String, Object>> list = poiDAO.selectErpSalesPlanDBtoExcel();

						for(int j=0; j<list.size(); j++)
						{
							Row row = sheet.getRow(j+3);
							for(int k=0; k<9; k++)
							{
								Cell cell = row.getCell(k);
								if(cell == null){
									cell = row.createCell(k);
								}
								cell.setCellType(Cell.CELL_TYPE_STRING);
								if(k==0){
									cell.setCellValue(list.get(j).get("PERF_TARGET_ID").toString());
								}else if(k==1){
									cell.setCellValue(list.get(j).get("MEMBER_ID_NUM").toString());
								}else if(k==2){
									cell.setCellValue(list.get(j).get("BASIS_MONTH").toString());
								}else if(k==3){
									cell.setCellValue(list.get(j).get("BOOKING_TYPE").toString());
								}else if(k==4){
									cell.setCellValue(list.get(j).get("TARGET_REV_AMOUNT").toString());
								}else if(k==5){
									cell.setCellValue(list.get(j).get("TARGET_GP_AMOUNT").toString());
								}else if(k==6){
									cell.setCellValue(list.get(j).get("SYS_REGISTER_DATE").toString());
								}else if(k==7){
									cell.setCellValue(list.get(j).get("SYS_REGISTER_DATE").toString());
								}
							}
						}
					}
				}//레이아웃 for문
			}//if
			else {
				int i =0;
				Sheet sheet = wb.getSheetAt(i);
				//					Row row = sheet.getRow(3);
				//					Cell cell = row.getCell(3);

				List<Map<String, Object>> list = poiDAO.selectErpSalesPlanDBtoExcel();

				for(int j=0; j<list.size(); j++)
				{
					Row row = sheet.getRow(j+3);
					for(int k=0; k<9; k++)
					{
						Cell cell = row.getCell(k);
						if(cell == null){
							cell = row.createCell(k);
						}
						cell.setCellType(Cell.CELL_TYPE_STRING);
						if(k==0){
							cell.setCellValue(list.get(j).get("PERF_TARGET_ID").toString());
						}else if(k==1){
							cell.setCellValue(list.get(j).get("MEMBER_ID_NUM").toString());
						}else if(k==2){
							cell.setCellValue(list.get(j).get("BASIS_DATE").toString());
						}else if(k==3){
							cell.setCellValue(list.get(j).get("BOOKING_TYPE").toString());
						}else if(k==4){
							cell.setCellValue(list.get(j).get("TARGET_TCV_AMOUNT").toString());
						}else if(k==5){
							cell.setCellValue(list.get(j).get("TARGET_REV_AMOUNT").toString());
						}else if(k==6){
							cell.setCellValue(list.get(j).get("TARGET_GP_AMOUNT").toString());
						}else if(k==7){
							cell.setCellValue(list.get(j).get("SYS_REGISTER_DATE").toString());
						}else if(k==8){
							cell.setCellValue(list.get(j).get("SYS_REGISTER_DATE").toString());
						}
					}
				}
			}//else if

			FileOutputStream fileOut = null;
			if(!map1.get("flag").equals("Target")){
				fileOut = new FileOutputStream(sampleFilePath+"셀러스_필요데이터_양식_v1.41.xlsx");
			}else {
				fileOut = new FileOutputStream(sampleFilePath+"셀러스_직원_Target데이터_양식_v1.41.xlsx");
			}

			wb.write(fileOut);
			fileOut.close();
		}catch(FileNotFoundException f){
			cnt = -1;
			return cnt;
		}

		return cnt;
	}

	public int xlsxReadClientIndividualInfo(Map<String, Object> map, HttpServletRequest request) throws Exception {
		int cnt = 0;
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> poiMap = new HashMap<String, Object>();
		int excelForm = Integer.parseInt((String) map.get("form"));

		FileInputStream fis = null;
		XSSFWorkbook workbook = null;

		MultipartHttpServletRequest multi = (MultipartHttpServletRequest) request;
		MultipartFile file = multi.getFile("filePOI");

		String fileName = file.getOriginalFilename();
		//	    String fileName = uploadFilePath;
		//	    File temp_file = new File(fileName);
		File temp_file = new File(resultFilePath + fileName);

		if (temp_file.exists() == false) {
			// 없으면 생성
			temp_file.mkdirs();
		}
		file.transferTo(temp_file);

		fis = new FileInputStream(temp_file.getAbsolutePath());

		log.info("업로드 경로 : " + temp_file.getAbsolutePath().toString());

		workbook = new XSSFWorkbook(fis);

		XSSFSheet curSheet;
		XSSFRow	curRow;
		XSSFCell curCell;

		//for(int sheetIndex = 0; sheetIndex < workbook.getNumberOfSheets(); sheetIndex++){
		//curSheet = workbook.getSheetAt(sheetIndex);
		curSheet = workbook.getSheetAt(excelForm);
		for(int rowIndex = 2; rowIndex < curSheet.getPhysicalNumberOfRows(); rowIndex++){
			if(rowIndex != 2){
				curRow = curSheet.getRow(rowIndex);
				String value;
				if(!"".equals(curRow.getCell(1).getRawValue()) && curRow.getCell(1).getRawValue() != null){
					poiMap = new HashMap<String, Object>();
					for(int cellIndex = 0; cellIndex < curRow.getPhysicalNumberOfCells(); cellIndex++){
						curCell = curRow.getCell(cellIndex);
						if(true){
							value = "";
							switch(curCell.getCellType()){
							case HSSFCell.CELL_TYPE_NUMERIC :
								value = curCell.getRawValue();
								//value = curCell.getNumericCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_STRING :
								value = curCell.getStringCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_FORMULA :
								value = curCell.getCellFormula();
								break;
							case HSSFCell.CELL_TYPE_BLANK :
								value = curCell.getBooleanCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_ERROR :
								value = curCell.getErrorCellValue()+"";
								break;
							default :
								value = "";
								break;
							}

							if(!value.equals("false")){
								switch(cellIndex) {
								case 0 :
									poiMap.put("CUSTOMER_ID", value);
									break;
								case 1 :
									poiMap.put("COMPANY_ID", value);
									break;
								case 2 :
									poiMap.put("CUSTOMER_NAME", value);
									break;
								case 3 :
									poiMap.put("DIVISION", value);
									break;
								case 4 :
									poiMap.put("POST", value);
									break;
								case 5 :
									poiMap.put("TEAM", value);
									break;
								case 6 :
									poiMap.put("POSITION", value);
									break;
								case 7 :
									poiMap.put("DUTY", value);
									break;
								case 8 :
									poiMap.put("CELL_PHONE", value);
									break;
								case 9 :
									poiMap.put("PHONE", value);
									break;
								case 10 :
									poiMap.put("EMAIL", value);
									break;
								case 11 :
									poiMap.put("ADDRESS", value);
									break;
								case 12 :
									poiMap.put("FRIENDSHIP_INFO", value);
									break;
								case 13 :
									poiMap.put("INFO_SOURCE", value);
									break;
								case 14 :
									poiMap.put("PINFO_CAREER", value);
									break;
								case 15 :
									poiMap.put("PINFO_SOCIAL_ACTS", value);
									break;
								case 16 :
									poiMap.put("PINFO_FAMILY", value);
									break;
								case 17 :
									poiMap.put("PINFO_INCLINATION", value);
									break;
								case 18 :
									poiMap.put("PINFO_FAMILIARS", value);
									break;
								case 19 :
									poiMap.put("PINFO_SNS", value);
									break;
								case 20 :
									poiMap.put("PINFO_ETC", value);
									break;
								case 21 :
									poiMap.put("CREATOR_ID", value);
									break;
								case 22 :
									poiMap.put("CREATE_DATE", value);
									break;
								case 23 :
									poiMap.put("SYS_REGISTER_DATE", value);
									break;
								case 24 :
									poiMap.put("SYS_UPDATE_DATE", value);
									break;
								case 25 :
									poiMap.put("REPORTING_LINE_DIVISION_ID", value);
									break;
								case 26 :
									poiMap.put("REPORTING_LINE_POST_ID", value);
									break;
								case 27 :
									poiMap.put("REPORTING_LINE_TEAM_ID", value);
									break;
								case 28 :
									poiMap.put("PINFO_EDUCATION_PERSON", value);
									break;
								case 29 :
									poiMap.put("PINFO_CAREER_PERSON", value);
									break;
								case 30 :
									poiMap.put("PINFO_EDUCATION", value);
									break;
								case 31 :
									poiMap.put("PREV_SALES_MEMBER_ID", value);
									break;
								case 32 :
									poiMap.put("POSITION_DUTY", value);
									break;
								case 33 :
									poiMap.put("PINFO_RELATIONSHIP", value);
									break;
								case 34 :
									poiMap.put("LIKEABILITY", value);
									break;
								case 35 :
									poiMap.put("RELATION", value);
									break;
								case 36 :
									poiMap.put("DIRECTOR_ID", value);
									break;
								case 37 : 
									poiMap.put("USE_YN", value);
								case 38:
									poiMap.put("INSERT_FLAG", value);
								default : 
									break;
								}
							}
						}
					}// cell for  ( 열 )
					poiMap.put("creatorId", map.get("creatorId"));
					//int insertExcel = insertClientIndividualInfo(list);
					int insertExcel = insertClientIndividualInfo(poiMap);

					String customerId = Integer.toString(CUSTOMER_ID);

					int maxCellIndex = 39;
					String sheetFlag = "clientIndividual";
					outFileProcess(rowIndex, curSheet, maxCellIndex, workbook, temp_file, insertExcel, customerId, sheetFlag);

					list.add(poiMap);
				}
			}
		} // row for ( 행 )
		//}
		// 아래꺼 보류
		fis.close();
		//deleteExel(temp_file.getAbsolutePath());

		return cnt;
	}
	
	public List<Map<String, Object>> xlsxReadErpSalesActual(Map<String, Object> map, HttpServletRequest request) throws Exception {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> poiMap = new HashMap<String, Object>();
		
		int excelForm = Integer.parseInt((String) map.get("form"));

		if(excelForm == 9){
			excelForm = 0;
		}
		
		FileInputStream fis = null;
		XSSFWorkbook workbook = null;

		MultipartHttpServletRequest multi = (MultipartHttpServletRequest) request;
		MultipartFile file = multi.getFile("filePOI");

		String fileName = file.getOriginalFilename();
		//	    String fileName = uploadFilePath;
		//		File temp_file = new File(fileName);
		File temp_file = new File(resultFilePath + fileName);

		if (temp_file.exists() == false) {
			// 없으면 생성
			temp_file.mkdirs();
		}

		file.transferTo(temp_file);

		fis = new FileInputStream(temp_file.getAbsolutePath());

		log.info("업로드 경로 : " + temp_file.getAbsolutePath().toString());

		workbook = new XSSFWorkbook(fis);

		XSSFSheet curSheet;
		XSSFRow	curRow;
		XSSFCell curCell;
		//for(int sheetIndex = 0; sheetIndex < workbook.getNumberOfSheets(); sheetIndex++){
		//curSheet = workbook.getSheetAt(sheetIndex);
		curSheet = workbook.getSheetAt(excelForm);
		for(int rowIndex = 1; rowIndex < curSheet.getPhysicalNumberOfRows(); rowIndex++){
			if(rowIndex != 1){
				curRow = curSheet.getRow(rowIndex);
				String value;
				if(!"".equals(curRow.getCell(1).getRawValue()) && curRow.getCell(1).getRawValue() != null){
					poiMap = new HashMap<String, Object>();
					for(int cellIndex = 0; cellIndex < curRow.getPhysicalNumberOfCells(); cellIndex++){
						curCell = curRow.getCell(cellIndex);
						if(true){
							value = "";
							switch(curCell.getCellType()){
							case HSSFCell.CELL_TYPE_NUMERIC :
								value = curCell.getRawValue();
								//value = curCell.getNumericCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_STRING :
								value = curCell.getStringCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_FORMULA :
								value = curCell.getCellFormula();
								break;
							case HSSFCell.CELL_TYPE_BLANK :
								value = curCell.getBooleanCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_ERROR :
								value = curCell.getErrorCellValue()+"";
								break;
							default :
								value = "";
								break;
							}

							if(!value.equals("false")){
								switch(cellIndex) {
								case 0 :
									poiMap.put("DIVISION_NAME", value);
									break;
								case 1 :
									poiMap.put("HAN_NAME", value);
									break;
								case 2 :
									poiMap.put("TARGET_REV_YEAR", value);
									break;
								case 3 :
									poiMap.put("TARGET_GP_YEAR", value);
									break;
								case 4 :
									poiMap.put("ACHIEVE_REV", value);
									break;
								case 5 :
									poiMap.put("ACHIEVE_REV_PER", value);
									break;
								case 6 :
									poiMap.put("ACHIEVE_GP", value);
									break;
								case 7 :
									poiMap.put("ACHIEVE_GP_PER", value);
									break;
								case 8 :
									poiMap.put("TARGET_REV_1Q", value);
									break;
								case 9 :
									poiMap.put("TARGET_GP_1Q", value);
									break;
								case 10:
									poiMap.put("ACHIEVE_REV_1Q", value);
									break;
								case 11:
									poiMap.put("ACHIEVE_REV_PER_1Q", value);
									break;
								case 12:
									poiMap.put("ACHIEVE_GP_1Q", value);
									break;
								case 13:
									poiMap.put("ACHIEVE_GP_PER_1Q", value);
									break;
								case 14:
									poiMap.put("TARGET_REV_2Q", value);
									break;
								case 15:
									poiMap.put("TARGET_GP_2Q", value);
									break;
								case 16:
									poiMap.put("ACHIEVE_REV_2Q", value);
									break;
								case 17:
									poiMap.put("ACHIEVE_REV_PER_2Q", value);
									break;
								case 18:
									poiMap.put("ACHIEVE_GP_2Q", value);
									break;
								case 19:
									poiMap.put("ACHIEVE_GP_PER_2Q", value);
									break;
								case 20:
									poiMap.put("TARGET_REV_3Q", value);
									break;
								case 21:
									poiMap.put("TARGET_GP_3Q", value);
									break;
								case 22:
									poiMap.put("ACHIEVE_REV_3Q", value);
									break;
								case 23:
									poiMap.put("ACHIEVE_REV_PER_3Q", value);
									break;
								case 24:
									poiMap.put("ACHIEVE_GP_3Q", value);
									break;
								case 25:
									poiMap.put("ACHIEVE_GP_PER_3Q", value);
									break;
								case 26:
									poiMap.put("TARGET_REV_4Q", value);
									break;
								case 27:
									poiMap.put("TARGET_GP_4Q", value);
									break;
								case 28:
									poiMap.put("ACHIEVE_REV_4Q", value);
									break;
								case 29:
									poiMap.put("ACHIEVE_REV_PER_4Q", value);
									break;
								case 30:
									poiMap.put("ACHIEVE_GP_4Q", value);
									break;
								case 31:
									poiMap.put("ACHIEVE_GP_PER_4Q", value);
									break;
								default : 
									break;
								}
							}
						}
					}// cell for  ( 열 )
					poiMap.put("creatorId", map.get("creatorId"));
					//int insertExcel = insertClientIndividualInfo(list);
					//int insertExcel = insertClientIndividualInfo(poiMap);

//					int insertExcel = insertErpSalesActual(excelDataList);


//					String customerId = Integer.toString(KEY_ID);
//					int maxCellIndex = 32;
//					String sheetFlag = "erpSalesActual";
//					outFileProcess(rowIndex, curSheet, maxCellIndex, workbook, temp_file, insertExcel, customerId, sheetFlag);

					list.add(poiMap);
				}
			}
		} // row for ( 행 )
		
		int insertExcel = insertErpSalesActual2(list);
		
		//}
		// 아래꺼 보류
		fis.close();
		//deleteExel(temp_file.getAbsolutePath());

		return list;
	}
	
	//ERP 대시보드
	public List<Map<String, Object>> xlsxReadErpDashBoard(Map<String, Object> map, HttpServletRequest request) throws Exception {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> poiMap = new HashMap<String, Object>();
		
		int excelForm = Integer.parseInt((String) map.get("form"));
		
		if(excelForm == 10){
			excelForm = 0;
		}
		
		FileInputStream fis = null;
		XSSFWorkbook workbook = null;
		
		MultipartHttpServletRequest multi = (MultipartHttpServletRequest) request;
		MultipartFile file = multi.getFile("filePOI");
		
		String fileName = file.getOriginalFilename();
		//	    String fileName = uploadFilePath;
		//		File temp_file = new File(fileName);
		File temp_file = new File(resultFilePath + fileName);
		
		if (temp_file.exists() == false) {
			// 없으면 생성
			temp_file.mkdirs();
		}
		
		file.transferTo(temp_file);
		
		fis = new FileInputStream(temp_file.getAbsolutePath());
		
		log.info("업로드 경로 : " + temp_file.getAbsolutePath().toString());
		
		workbook = new XSSFWorkbook(fis);
		
		XSSFSheet curSheet;
		XSSFRow	curRow;
		XSSFCell curCell;
		//for(int sheetIndex = 0; sheetIndex < workbook.getNumberOfSheets(); sheetIndex++){
		//curSheet = workbook.getSheetAt(sheetIndex);
		curSheet = workbook.getSheetAt(excelForm);
		for(int rowIndex = 1; rowIndex < curSheet.getPhysicalNumberOfRows(); rowIndex++){
			if(rowIndex != 1){
				curRow = curSheet.getRow(rowIndex);
				String value;
				if(!"".equals(curRow.getCell(1).getRawValue()) && curRow.getCell(1).getRawValue() != null){
					poiMap = new HashMap<String, Object>();
					for(int cellIndex = 0; cellIndex < curRow.getPhysicalNumberOfCells(); cellIndex++){
						curCell = curRow.getCell(cellIndex);
						if(true){
							value = "";
							switch(curCell.getCellType()){
							case HSSFCell.CELL_TYPE_NUMERIC :
								value = curCell.getRawValue();
								//value = curCell.getNumericCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_STRING :
								value = curCell.getStringCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_FORMULA :
								value = curCell.getCellFormula();
								break;
							case HSSFCell.CELL_TYPE_BLANK :
								value = curCell.getBooleanCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_ERROR :
								value = curCell.getErrorCellValue()+"";
								break;
							default :
								value = "";
								break;
							}
							
							if(!value.equals("false")){
								switch(cellIndex) {
								case 0 :
									poiMap.put("DIVISION_NAME", value);
									break;
								case 1 :
									poiMap.put("TEAM_NAME", value);
									break;
								case 2 :
									poiMap.put("OBTAIN_ORDER_TYPE", value);
									break;
								case 3 :
									poiMap.put("PROJECT_ID", value);
									break;
								case 4 :
									poiMap.put("PROJECT_NAME", value);
									break;
									/*
								case 5 :
									poiMap.put("GARBAGE_DATA_1", value);
									break;
								case 6 :
									poiMap.put("GARBAGE_DATA_2", value);
									break;
								case 7 :
									poiMap.put("GARBAGE_DATA_3", value);
									break;
								case 8 :
									poiMap.put("GARBAGE_DATA_4", value);
									break;
								case 9 :
									poiMap.put("GARBAGE_DATA_5", value);
									break;
								case 10:
									poiMap.put("GARBAGE_DATA_6", value);
									break;
									*/
								case 11:
									poiMap.put("ACCRUE_REV", value);
									break;
									/*
								case 12:
									poiMap.put("GARBAGE_DATA_7", value);
									break;
								case 13:
									poiMap.put("GARBAGE_DATA_8", value);
									break;
									*/
								case 14:
									poiMap.put("ACCRUE_GP", value);
									break;
									/*
								case 15:
									poiMap.put("GARBAGE_DATA_9", value);
									break;
								case 16:
									poiMap.put("GARBAGE_DATA_10", value);
									break;
								case 17:
									poiMap.put("GARBAGE_DATA_11", value);
									break;
								case 18:
									poiMap.put("GARBAGE_DATA_12", value);
									break;
									*/
								case 19:
									poiMap.put("TCV", value);
									break;
									/*
								case 20:
									poiMap.put("GARBAGE_DATA_13", value);
									break;
								case 21:
									poiMap.put("GARBAGE_DATA_14", value);
									break;
								case 22:
									poiMap.put("GARBAGE_DATA_15", value);
									break;
								case 23:
									poiMap.put("GARBAGE_DATA_16", value);
									break;
								case 24:
									poiMap.put("GARBAGE_DATA_17", value);
									break;
									*/
								default : 
									break;
								}
							}
						}
					}// cell for  ( 열 )
					poiMap.put("creatorId", map.get("creatorId"));
					
					//int insertExcel = insertClientIndividualInfo(list);
					//int insertExcel = insertClientIndividualInfo(poiMap);
					
//					int insertExcel = insertErpSalesActual(excelDataList);
					
					
//					String customerId = Integer.toString(KEY_ID);
//					int maxCellIndex = 32;
//					String sheetFlag = "erpSalesActual";
//					outFileProcess(rowIndex, curSheet, maxCellIndex, workbook, temp_file, insertExcel, customerId, sheetFlag);
					
					list.add(poiMap);
				}
			}
		} // row for ( 행 )
		
		
		int insertExcel = insertErpDashBoard(list);
		
		//}
		// 아래꺼 보류
		fis.close();
		//deleteExel(temp_file.getAbsolutePath());
		
		return list;
	}
	
	/**
	 * 확장다 .xsl 엑셀 파일 사용 안함.
	 * 공백처리를 못함. 안읽고 지나가는 현상
	 * jsp에서 처리
	 * @param map
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> xlsReadErpDashBoard(Map<String, Object> map, HttpServletRequest request) throws Exception {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> poiMap = new HashMap<String, Object>();
		
		int excelForm = Integer.parseInt((String) map.get("form"));

		if(excelForm == 10){
			excelForm = 0;
		}
		
		FileInputStream fis = null;
		HSSFWorkbook workbook = null;

		MultipartHttpServletRequest multi = (MultipartHttpServletRequest) request;
		MultipartFile file = multi.getFile("filePOI");

		String fileName = file.getOriginalFilename();
		//	    String fileName = uploadFilePath;
		//		File temp_file = new File(fileName);
		File temp_file = new File(resultFilePath + fileName);

		if (temp_file.exists() == false) {
			// 없으면 생성
			temp_file.mkdirs();
		}

		file.transferTo(temp_file);

		fis = new FileInputStream(temp_file.getAbsolutePath());

		log.info("업로드 경로 : " + temp_file.getAbsolutePath().toString());

		workbook = new HSSFWorkbook(fis);

		HSSFSheet curSheet;
		HSSFRow	curRow;
		HSSFCell curCell;

		//for(int sheetIndex = 0; sheetIndex < workbook.getNumberOfSheets(); sheetIndex++){
		//curSheet = workbook.getSheetAt(sheetIndex);
		curSheet = workbook.getSheetAt(excelForm);
		for(int rowIndex = 1; rowIndex < curSheet.getPhysicalNumberOfRows(); rowIndex++){
			if(rowIndex != 1){
				curRow = curSheet.getRow(rowIndex);
				String value;
				if(!"".equals(curRow.getCell(1).getStringCellValue())){
					poiMap = new HashMap<String, Object>();
					for(int cellIndex = 0; cellIndex < curRow.getPhysicalNumberOfCells(); cellIndex++){
						curCell = curRow.getCell(cellIndex);
						if(true){
							value = "";
							switch(curCell.getCellType()){
							case HSSFCell.CELL_TYPE_NUMERIC :
								value = curCell.getNumericCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_STRING :
								value = curCell.getStringCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_FORMULA :
								value = curCell.getCellFormula();
								break;
							case HSSFCell.CELL_TYPE_BLANK :
								value = curCell.getBooleanCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_ERROR :
								value = curCell.getErrorCellValue()+"";
								break;
							default :
								value = "";
								break;
							}

							if(!value.equals("false")){
								switch(cellIndex) {
								case 0 :
									poiMap.put("DIVISION_NAME", value);
									break;
								case 1 :
									poiMap.put("TEAM_NAME", value);
									break;
								case 2 :
									poiMap.put("OBTAIN_ORDER_TYPE", value);
									break;
								case 3 :
									poiMap.put("PROJECT_ID", value);
									break;
								case 4 :
									poiMap.put("PROJECT_NAME", value);
									break;
									/*
								case 5 :
									poiMap.put("GARBAGE_DATA_1", value);
									break;
								case 6 :
									poiMap.put("GARBAGE_DATA_2", value);
									break;
								case 7 :
									poiMap.put("GARBAGE_DATA_3", value);
									break;
								case 8 :
									poiMap.put("GARBAGE_DATA_4", value);
									break;
								case 9 :
									poiMap.put("GARBAGE_DATA_5", value);
									break;
								case 10:
									poiMap.put("GARBAGE_DATA_6", value);
									break;
									*/
								case 11:
									poiMap.put("ACCRUE_REV", value);
									break;
									/*
								case 12:
									poiMap.put("GARBAGE_DATA_7", value);
									break;
								case 13:
									poiMap.put("GARBAGE_DATA_8", value);
									break;
									*/
								case 14:
									poiMap.put("ACCRUE_GP", value);
									break;
									/*
								case 15:
									poiMap.put("GARBAGE_DATA_9", value);
									break;
								case 16:
									poiMap.put("GARBAGE_DATA_10", value);
									break;
								case 17:
									poiMap.put("GARBAGE_DATA_11", value);
									break;
								case 18:
									poiMap.put("GARBAGE_DATA_12", value);
									break;
									*/
								case 19:
									poiMap.put("TCV", value);
									break;
									/*
								case 20:
									poiMap.put("GARBAGE_DATA_13", value);
									break;
								case 21:
									poiMap.put("GARBAGE_DATA_14", value);
									break;
								case 22:
									poiMap.put("GARBAGE_DATA_15", value);
									break;
								case 23:
									poiMap.put("GARBAGE_DATA_16", value);
									break;
								case 24:
									poiMap.put("GARBAGE_DATA_17", value);
									break;
									*/
								default : 
									break;
								}
							}
						}
					}// cell for  ( 열 )
					poiMap.put("creatorId", map.get("creatorId"));
					//int insertExcel = insertClientIndividualInfo(list);
					//int insertExcel = insertClientIndividualInfo(poiMap);

					
					//int insertExcel = insertErpSalesActual(poiMap, excelDataList);
					
					
//					String customerId = Integer.toString(KEY_ID);
//					int maxCellIndex = 32;
//					String sheetFlag = "erpSalesActual";
//					outFileProcess(rowIndex, curSheet, maxCellIndex, workbook, temp_file, insertExcel, customerId, sheetFlag);

					list.add(poiMap);
				}
			}
		} // row for ( 행 )
		
		int insertExcel = insertErpDashBoard(list);
		
		
		//}
		// 아래꺼 보류
		fis.close();
		//deleteExel(temp_file.getAbsolutePath());

		return list;
	}
	
	/**
	 * ERP 대시보드 엑셀
	 * @param excelDataList
	 * @return
	 * @throws Exception
	 */
	public int insertErpDashBoard(List<Map<String, Object>> excelDataList) throws Exception {
		int cnt = 0;

		for(int k=0; k<excelDataList.size(); k++)
		{
			Map<String, Object> map = new HashMap<String, Object>();
			
			//엑셀 파일에서 PROJECT_ID가 존재하지 않으면 remove
			if(null == excelDataList.get(k).get("PROJECT_ID") || excelDataList.get(k).get("PROJECT_ID").equals(""))
			{
				excelDataList.remove(k);
				k++;
			}
			else
			{
				//PROJECT_ID가 존재하면 map에 담는다

				if(null == excelDataList.get(k).get("DIVISION_NAME") || excelDataList.get(k).get("DIVISION_NAME").equals(""))
				{
					map.put("DIVISION_NAME", "");
				}
				else
				{
					map.put("DIVISION_NAME", excelDataList.get(k).get("DIVISION_NAME"));
				}
				
				if(null == excelDataList.get(k).get("TEAM_NAME") || excelDataList.get(k).get("TEAM_NAME").equals(""))
				{
					map.put("TEAM_NAME", "");
				}
				else
				{
					map.put("TEAM_NAME", excelDataList.get(k).get("TEAM_NAME"));
				}
				
				map.put("OBTAIN_ORDER_TYPE", excelDataList.get(k).get("OBTAIN_ORDER_TYPE"));
				map.put("PROJECT_ID", excelDataList.get(k).get("PROJECT_ID"));
				map.put("ACCRUE_REV", excelDataList.get(k).get("ACCRUE_REV"));
				map.put("ACCRUE_GP", excelDataList.get(k).get("ACCRUE_GP"));
				map.put("TCV", excelDataList.get(k).get("TCV"));
				map.put("PROJECT_NAME", excelDataList.get(k).get("PROJECT_NAME"));
				
				List<Map<String, Object>> upCnt = poiDAO.selectErpDashBoard(map);
				if(upCnt.size() > 0)
				{
					//ERP_DASHBOARD_CHECKLIST 테이블에 해당 PROJECT_ID에 대한 데이터가 있으면 update
					poiDAO.updateErpDashBoard(map);
				}
				else
				{
					//없으면 insert
					poiDAO.insertErpDashBoard(map);	
				}
			}//else
		}//for
		return cnt;
	}
	
	public List<Map<String, Object>> xlsReadErpSalesActual(Map<String, Object> map, HttpServletRequest request) throws Exception {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> poiMap = new HashMap<String, Object>();
		
		int excelForm = Integer.parseInt((String) map.get("form"));

		if(excelForm == 9){
			excelForm = 0;
		}
		
		FileInputStream fis = null;
		HSSFWorkbook workbook = null;

		MultipartHttpServletRequest multi = (MultipartHttpServletRequest) request;
		MultipartFile file = multi.getFile("filePOI");

		String fileName = file.getOriginalFilename();
		//	    String fileName = uploadFilePath;
		//		File temp_file = new File(fileName);
		File temp_file = new File(resultFilePath + fileName);

		if (temp_file.exists() == false) {
			// 없으면 생성
			temp_file.mkdirs();
		}

		file.transferTo(temp_file);

		fis = new FileInputStream(temp_file.getAbsolutePath());

		log.info("업로드 경로 : " + temp_file.getAbsolutePath().toString());

		workbook = new HSSFWorkbook(fis);

		HSSFSheet curSheet;
		HSSFRow	curRow;
		HSSFCell curCell;

		//for(int sheetIndex = 0; sheetIndex < workbook.getNumberOfSheets(); sheetIndex++){
		//curSheet = workbook.getSheetAt(sheetIndex);
		curSheet = workbook.getSheetAt(excelForm);
		for(int rowIndex = 1; rowIndex < curSheet.getPhysicalNumberOfRows(); rowIndex++){
			if(rowIndex != 1){
				curRow = curSheet.getRow(rowIndex);
				String value;
				if(!"".equals(curRow.getCell(1).getStringCellValue())){
					poiMap = new HashMap<String, Object>();
					for(int cellIndex = 0; cellIndex < curRow.getPhysicalNumberOfCells(); cellIndex++){
						curCell = curRow.getCell(cellIndex);
						if(true){
							value = "";
							switch(curCell.getCellType()){
							case HSSFCell.CELL_TYPE_NUMERIC :
								value = curCell.getNumericCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_STRING :
								value = curCell.getStringCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_FORMULA :
								value = curCell.getCellFormula();
								break;
							case HSSFCell.CELL_TYPE_BLANK :
								value = curCell.getBooleanCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_ERROR :
								value = curCell.getErrorCellValue()+"";
								break;
							default :
								value = "";
								break;
							}

							if(!value.equals("false")){
								switch(cellIndex) {
								case 0 :
									poiMap.put("DIVISION_NAME", value);
									break;
								case 1 :
									poiMap.put("HAN_NAME", value);
									break;
								case 2 :
									poiMap.put("TARGET_REV_YEAR", value);
									break;
								case 3 :
									poiMap.put("TARGET_GP_YEAR", value);
									break;
								case 4 :
									poiMap.put("ACHIEVE_REV", value);
									break;
								case 5 :
									poiMap.put("ACHIEVE_REV_PER", value);
									break;
								case 6 :
									poiMap.put("ACHIEVE_GP", value);
									break;
								case 7 :
									poiMap.put("ACHIEVE_GP_PER", value);
									break;
								case 8 :
									poiMap.put("TARGET_REV_1Q", value);
									break;
								case 9 :
									poiMap.put("TARGET_GP_1Q", value);
									break;
								case 10:
									poiMap.put("ACHIEVE_REV_1Q", value);
									break;
								case 11:
									poiMap.put("ACHIEVE_REV_PER_1Q", value);
									break;
								case 12:
									poiMap.put("ACHIEVE_GP_1Q", value);
									break;
								case 13:
									poiMap.put("ACHIEVE_GP_PER_1Q", value);
									break;
								case 14:
									poiMap.put("TARGET_REV_2Q", value);
									break;
								case 15:
									poiMap.put("TARGET_GP_2Q", value);
									break;
								case 16:
									poiMap.put("ACHIEVE_REV_2Q", value);
									break;
								case 17:
									poiMap.put("ACHIEVE_REV_PER_2Q", value);
									break;
								case 18:
									poiMap.put("ACHIEVE_GP_2Q", value);
									break;
								case 19:
									poiMap.put("ACHIEVE_GP_PER_2Q", value);
									break;
								case 20:
									poiMap.put("TARGET_REV_3Q", value);
									break;
								case 21:
									poiMap.put("TARGET_GP_3Q", value);
									break;
								case 22:
									poiMap.put("ACHIEVE_REV_3Q", value);
									break;
								case 23:
									poiMap.put("ACHIEVE_REV_PER_3Q", value);
									break;
								case 24:
									poiMap.put("ACHIEVE_GP_3Q", value);
									break;
								case 25:
									poiMap.put("ACHIEVE_GP_PER_3Q", value);
									break;
								case 26:
									poiMap.put("TARGET_REV_4Q", value);
									break;
								case 27:
									poiMap.put("TARGET_GP_4Q", value);
									break;
								case 28:
									poiMap.put("ACHIEVE_REV_4Q", value);
									break;
								case 29:
									poiMap.put("ACHIEVE_REV_PER_4Q", value);
									break;
								case 30:
									poiMap.put("ACHIEVE_GP_4Q", value);
									break;
								case 31:
									poiMap.put("ACHIEVE_GP_PER_4Q", value);
									break;
								default : 
									break;
								}
							}
						}
					}// cell for  ( 열 )
					poiMap.put("creatorId", map.get("creatorId"));
					//int insertExcel = insertClientIndividualInfo(list);
					//int insertExcel = insertClientIndividualInfo(poiMap);

					
					//int insertExcel = insertErpSalesActual(poiMap, excelDataList);
					
					
//					String customerId = Integer.toString(KEY_ID);
//					int maxCellIndex = 32;
//					String sheetFlag = "erpSalesActual";
//					outFileProcess(rowIndex, curSheet, maxCellIndex, workbook, temp_file, insertExcel, customerId, sheetFlag);

					list.add(poiMap);
				}
			}
		} // row for ( 행 )
		
		int insertExcel = insertErpSalesActual2(list);
		
		
		//}
		// 아래꺼 보류
		fis.close();
		//deleteExel(temp_file.getAbsolutePath());

		return list;
	}
	
	/**
	 * 사용안함 _ insertErpSalesActual2 로 properties 이용해서 사용
	 * @param excelDataList
	 * @return
	 * @throws Exception
	 */
	public int insertErpSalesActual(List<Map<String, Object>> excelDataList) throws Exception {
		int cnt = 0;
		Map<String, Object> map = new HashMap<String, Object>();
		
		for(int i=0; i< excelDataList.size(); i++)
		{
			
			map.put("DIVISION_NAME", excelDataList.get(i).get("DIVISION_NAME"));
			map.put("HAN_NAME", excelDataList.get(i).get("HAN_NAME"));
			map.put("TARGET_REV_YEAR", excelDataList.get(i).get("TARGET_REV_YEAR"));
			map.put("TARGET_GP_YEAR", excelDataList.get(i).get("TARGET_GP_YEAR"));
			map.put("ACHIEVE_REV", excelDataList.get(i).get("ACHIEVE_REV"));
			map.put("ACHIEVE_REV_PER", excelDataList.get(i).get("ACHIEVE_REV_PER"));
			map.put("ACHIEVE_GP", excelDataList.get(i).get("ACHIEVE_GP"));
			map.put("ACHIEVE_GP_PER", excelDataList.get(i).get("ACHIEVE_GP_PER"));
			map.put("TARGET_REV_1Q", excelDataList.get(i).get("TARGET_REV_1Q"));			
			map.put("TARGET_GP_1Q", excelDataList.get(i).get("TARGET_GP_1Q"));
			map.put("ACHIEVE_REV_1Q", excelDataList.get(i).get("ACHIEVE_REV_1Q"));				//1Q REV
			map.put("ACHIEVE_REV_PER_1Q", excelDataList.get(i).get("ACHIEVE_REV_PER_1Q"));
			map.put("ACHIEVE_GP_1Q", excelDataList.get(i).get("ACHIEVE_GP_1Q"));				//1Q GP
			map.put("ACHIEVE_GP_PER_1Q", excelDataList.get(i).get("ACHIEVE_GP_PER_1Q"));
			map.put("TARGET_REV_2Q", excelDataList.get(i).get("TARGET_REV_2Q"));
			map.put("TARGET_GP_2Q", excelDataList.get(i).get("TARGET_GP_2Q"));
			map.put("ACHIEVE_REV_2Q", excelDataList.get(i).get("ACHIEVE_REV_2Q"));				//2Q REV
			map.put("ACHIEVE_REV_PER_2Q", excelDataList.get(i).get("ACHIEVE_REV_PER_2Q"));
			map.put("ACHIEVE_GP_2Q", excelDataList.get(i).get("ACHIEVE_GP_2Q"));				//2Q GP
			map.put("ACHIEVE_GP_PER_2Q", excelDataList.get(i).get("ACHIEVE_GP_PER_2Q"));
			map.put("TARGET_REV_3Q", excelDataList.get(i).get("TARGET_REV_3Q"));
			map.put("TARGET_GP_3Q", excelDataList.get(i).get("TARGET_GP_3Q"));
			map.put("ACHIEVE_REV_3Q", excelDataList.get(i).get("ACHIEVE_REV_3Q"));				//3Q REV
			map.put("ACHIEVE_REV_PER_3Q", excelDataList.get(i).get("ACHIEVE_REV_PER_3Q"));
			map.put("ACHIEVE_GP_3Q", excelDataList.get(i).get("ACHIEVE_GP_3Q"));				//3Q GP
			map.put("ACHIEVE_GP_PER_3Q", excelDataList.get(i).get("ACHIEVE_GP_PER_3Q"));
			map.put("TARGET_REV_4Q", excelDataList.get(i).get("TARGET_REV_4Q"));
			map.put("TARGET_GP_4Q", excelDataList.get(i).get("TARGET_GP_4Q"));
			map.put("ACHIEVE_REV_4Q", excelDataList.get(i).get("ACHIEVE_REV_4Q"));				//4Q REV
			map.put("ACHIEVE_REV_PER_4Q", excelDataList.get(i).get("ACHIEVE_REV_PER_4Q"));
			map.put("ACHIEVE_GP_4Q", excelDataList.get(i).get("ACHIEVE_GP_4Q"));				//4Q GP
			map.put("ACHIEVE_GP_PER_4Q", excelDataList.get(i).get("ACHIEVE_GP_PER_4Q"));
			
			
			//이름 가지고 DB에 있는 MEMBER 정보 가져오기
			List<Map<String, Object>> list = poiDAO.selectMembersInfo(map);
			
			String MEMBER_HAN_NAME = (String) list.get(0).get("HAN_NAME");
			String MEMBER_ID_NUM = (String) list.get(0).get("MEMBER_ID_NUM");
			String MEMBER_TEAM_NAME = (String) list.get(0).get("TEAM_NAME");
			String MEMBER_DIVISION_NAME = (String) list.get(0).get("DIVISION_NAME");
			
			map.put("MEMBER_ID_NUM", MEMBER_ID_NUM);
			map.put("FISCAL_YEAR", CommonDateUtils.getToday().substring(0, 4));
			map.put("ACTUAL_DATE", CommonDateUtils.getToday());
			
			
			/**
			 * 이름 & 본부이름 또는 이름 & 팀 이름이 같을경우 그냥 업설트
			 * 다를경우 ( 한 본부에 같은 이름이 존재할 경우_팀을 바꾸었다고 가정하고 처리 )
			 */
			if((MEMBER_HAN_NAME.equals(excelDataList.get(i).get("HAN_NAME")) && MEMBER_DIVISION_NAME.replaceAll(" ", "").equals(excelDataList.get(i).get("DIVISION_NAME").toString().replaceAll(" ", "")))
					|| (MEMBER_HAN_NAME.equals(excelDataList.get(i).get("HAN_NAME")) && MEMBER_TEAM_NAME.replaceAll(" ", "").equals(excelDataList.get(i).get("DIVISION_NAME").toString().replaceAll(" ", "")))
					)
			{
				
				int upCnt = poiDAO.updateErpSalesActual(map);
				if(upCnt <= 0)
				{
					poiDAO.insertErpSalesActual(map);
				}
				
			}
			else
			{
				System.out.println("엑셀 이름 : "+ excelDataList.get(i).get("HAN_NAME") +", DB이름 : " + MEMBER_HAN_NAME);
				System.out.println("엑셀 본부1 : "+ excelDataList.get(i).get("DIVISION_NAME") +", DB본부1 : " + MEMBER_DIVISION_NAME);
				System.out.println("엑셀 본부1 : "+ excelDataList.get(i).get("DIVISION_NAME") +", DB본부1 : " + MEMBER_TEAM_NAME);
				
				
				if(excelDataList.get(i).get("HAN_NAME").equals("이형준") && excelDataList.get(i).get("DIVISION_NAME").toString().replaceAll(" ", "").equals("Software사업본부"))
				{
					Map<String, Object> shareUserMap = new HashMap<String, Object>();
					shareUserMap.put("HAN_NAME", "김재준");
					
					List<Map<String, Object>> shareMemberInfo = poiDAO.selectMembersInfo(shareUserMap);
					shareUserMap.put("MEMBER_ID_NUM", shareMemberInfo.get(0).get("MEMBER_ID_NUM"));
					
					List<Map<String, Object>> shareActualUserInfo = poiDAO.selectShareMemberErpSalesActualData(shareUserMap);
					
					map.put("MEMBER_ID_NUM", shareUserMap.get("MEMBER_ID_NUM"));
					map.put("1Q_ACTUAL_TCV_AMOUNT", shareActualUserInfo.get(0).get("1Q_ACTUAL_TCV_AMOUNT"));
					map.put("1Q_ACTUAL_REV_AMOUNT", shareActualUserInfo.get(0).get("1Q_ACTUAL_REV_AMOUNT"));
					map.put("1Q_ACTUAL_GP_AMOUNT", shareActualUserInfo.get(0).get("1Q_ACTUAL_GP_AMOUNT"));
					
					map.put("2Q_ACTUAL_TCV_AMOUNT", shareActualUserInfo.get(0).get("2Q_ACTUAL_TCV_AMOUNT"));
					map.put("2Q_ACTUAL_REV_AMOUNT", shareActualUserInfo.get(0).get("2Q_ACTUAL_REV_AMOUNT"));
					map.put("2Q_ACTUAL_GP_AMOUNT", shareActualUserInfo.get(0).get("2Q_ACTUAL_GP_AMOUNT"));
					
					map.put("3Q_ACTUAL_TCV_AMOUNT", shareActualUserInfo.get(0).get("3Q_ACTUAL_TCV_AMOUNT"));
					map.put("3Q_ACTUAL_REV_AMOUNT", shareActualUserInfo.get(0).get("3Q_ACTUAL_REV_AMOUNT"));
					map.put("3Q_ACTUAL_GP_AMOUNT", shareActualUserInfo.get(0).get("3Q_ACTUAL_GP_AMOUNT"));
					
					map.put("4Q_ACTUAL_TCV_AMOUNT", shareActualUserInfo.get(0).get("4Q_ACTUAL_TCV_AMOUNT"));
					map.put("4Q_ACTUAL_REV_AMOUNT", shareActualUserInfo.get(0).get("4Q_ACTUAL_REV_AMOUNT"));
					map.put("4Q_ACTUAL_GP_AMOUNT", shareActualUserInfo.get(0).get("4Q_ACTUAL_GP_AMOUNT"));
					
					map.put("1q_actual_pgp_amount", shareActualUserInfo.get(0).get("1q_actual_pgp_amount"));
					map.put("2q_actual_pgp_amount", shareActualUserInfo.get(0).get("2q_actual_pgp_amount"));
					map.put("3q_actual_pgp_amount", shareActualUserInfo.get(0).get("3q_actual_pgp_amount"));
					map.put("4q_actual_pgp_amount", shareActualUserInfo.get(0).get("4q_actual_pgp_amount"));
					
					if(shareActualUserInfo.size() > 0)
					{
						poiDAO.updateShareMemberErpSalesActual(map);
					}
					else
					{//전 본부장 데이터 미존재 ( 데이터 insert )
						
						//poiDAO.insertShareMemberErpSalesActual(map);
					}
				}
			} // else
		}//for excelDataList size
		
		
		
		/*
		if(!map.get("DIVISION_NAME").equals("소계") && !map.get("DIVISION_NAME").equals("총계"))
		{
			List<Map<String, Object>> list = poiDAO.selectMembersInfo(map);
			
			map.put("MEMBER_ID_NUM", list.get(0).get("MEMBER_ID_NUM"));
			map.put("FISCAL_YEAR", CommonDateUtils.getToday().substring(0, 4));
			map.put("ACTUAL_DATE", CommonDateUtils.getToday());
			
			poiDAO.insertErpSalesActual(map);
		}
		*/
		
		return cnt;
	}
	
	/**
	 * DB 본부명과, 더존 ERP 본부명 싱크가 맞지 않아, 일단 properties로 관리
	 * @param excelDataList
	 * @return
	 * @throws Exception
	 */
	public int insertErpSalesActual2(List<Map<String, Object>> excelDataList) throws Exception {
		int cnt = 0;
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		String nowDateTime = CommonDateUtils.getTodayDateTime().substring(11, 16);
		if(nowDateTime.compareTo("00:00")>0 && nowDateTime.compareTo("18:00")<0)
		{
			Calendar day = Calendar.getInstance();
			day.add(Calendar.DATE , -1);
			String beforeDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(day.getTime());

			//ACTUAL_DATE를 하루전 날짜로 설정
			map.put("ACTUAL_DATE", beforeDate);
		}else{
			map.put("ACTUAL_DATE", CommonDateUtils.getToday());
		}
		
		//기존데이터 삭제 ( 같은 데이터를 다시 업로드 할 경우 )
		poiDAO.deleteSalesActualData(map);
			
		
		for(int i=0; i< excelDataList.size(); i++)
		{
			//Map<String, Object> map = new HashMap<String, Object>();
			//엑셀에서 읽은 데이터를 map에 담는다.
			map.put("DIVISION_NAME", excelDataList.get(i).get("DIVISION_NAME"));
			map.put("HAN_NAME", excelDataList.get(i).get("HAN_NAME"));
			map.put("TARGET_REV_YEAR", excelDataList.get(i).get("TARGET_REV_YEAR"));
			map.put("TARGET_GP_YEAR", excelDataList.get(i).get("TARGET_GP_YEAR"));
			map.put("ACHIEVE_REV", excelDataList.get(i).get("ACHIEVE_REV"));
			map.put("ACHIEVE_REV_PER", excelDataList.get(i).get("ACHIEVE_REV_PER"));
			map.put("ACHIEVE_GP", excelDataList.get(i).get("ACHIEVE_GP"));
			map.put("ACHIEVE_GP_PER", excelDataList.get(i).get("ACHIEVE_GP_PER"));
			map.put("TARGET_REV_1Q", excelDataList.get(i).get("TARGET_REV_1Q"));			
			map.put("TARGET_GP_1Q", excelDataList.get(i).get("TARGET_GP_1Q"));
			map.put("ACHIEVE_REV_1Q", excelDataList.get(i).get("ACHIEVE_REV_1Q"));				//1Q REV
			map.put("ACHIEVE_REV_PER_1Q", excelDataList.get(i).get("ACHIEVE_REV_PER_1Q"));
			map.put("ACHIEVE_GP_1Q", excelDataList.get(i).get("ACHIEVE_GP_1Q"));				//1Q GP
			map.put("ACHIEVE_GP_PER_1Q", excelDataList.get(i).get("ACHIEVE_GP_PER_1Q"));
			map.put("TARGET_REV_2Q", excelDataList.get(i).get("TARGET_REV_2Q"));
			map.put("TARGET_GP_2Q", excelDataList.get(i).get("TARGET_GP_2Q"));
			map.put("ACHIEVE_REV_2Q", excelDataList.get(i).get("ACHIEVE_REV_2Q"));				//2Q REV
			map.put("ACHIEVE_REV_PER_2Q", excelDataList.get(i).get("ACHIEVE_REV_PER_2Q"));
			map.put("ACHIEVE_GP_2Q", excelDataList.get(i).get("ACHIEVE_GP_2Q"));				//2Q GP
			map.put("ACHIEVE_GP_PER_2Q", excelDataList.get(i).get("ACHIEVE_GP_PER_2Q"));
			map.put("TARGET_REV_3Q", excelDataList.get(i).get("TARGET_REV_3Q"));
			map.put("TARGET_GP_3Q", excelDataList.get(i).get("TARGET_GP_3Q"));
			map.put("ACHIEVE_REV_3Q", excelDataList.get(i).get("ACHIEVE_REV_3Q"));				//3Q REV
			map.put("ACHIEVE_REV_PER_3Q", excelDataList.get(i).get("ACHIEVE_REV_PER_3Q"));
			map.put("ACHIEVE_GP_3Q", excelDataList.get(i).get("ACHIEVE_GP_3Q"));				//3Q GP
			map.put("ACHIEVE_GP_PER_3Q", excelDataList.get(i).get("ACHIEVE_GP_PER_3Q"));
			map.put("TARGET_REV_4Q", excelDataList.get(i).get("TARGET_REV_4Q"));
			map.put("TARGET_GP_4Q", excelDataList.get(i).get("TARGET_GP_4Q"));
			map.put("ACHIEVE_REV_4Q", excelDataList.get(i).get("ACHIEVE_REV_4Q"));				//4Q REV
			map.put("ACHIEVE_REV_PER_4Q", excelDataList.get(i).get("ACHIEVE_REV_PER_4Q"));
			map.put("ACHIEVE_GP_4Q", excelDataList.get(i).get("ACHIEVE_GP_4Q"));				//4Q GP
			map.put("ACHIEVE_GP_PER_4Q", excelDataList.get(i).get("ACHIEVE_GP_PER_4Q"));
			
			//엑셀에 있는 이름 가지고 DB에 있는 MEMBER 아이디등 가져오기
			List<Map<String, Object>> list = poiDAO.selectMembersInfo(map);
			if(list.size() <= 0)
			{
				//직원 사번 ID가 DB에 존재 ㄴㄴ
				continue;
			}
			
			String MEMBER_ID_NUM = (String) list.get(0).get("MEMBER_ID_NUM");
			/*
			String MEMBER_HAN_NAME = (String) list.get(0).get("HAN_NAME");
			String MEMBER_TEAM_NAME = (String) list.get(0).get("TEAM_NAME");
			String MEMBER_DIVISION_NAME = (String) list.get(0).get("DIVISION_NAME");
			*/
			map.put("MEMBER_ID_NUM", MEMBER_ID_NUM);
			map.put("FISCAL_YEAR", CommonDateUtils.getToday().substring(0, 4));
			//map.put("ACTUAL_DATE", CommonDateUtils.getToday());

			
			/**
			 * 임시로 properties에서 관리
			 */
			String[] tmpData = TMP_DATA.split("/");
			int countFlag = 1;
			for(int k=0; k < tmpData.length; k++)
			{
				
				String[] tmpExcelExcepData = tmpData[k].split(",");
				
				String excelDivisionHanNmData = excelDataList.get(i).get("DIVISION_NAME") +"."+excelDataList.get(i).get("HAN_NAME");
				
				//IBM HW 사업본부.임주윤    equals  엑셀에 있는 DIVISION.HAN이름
				//프로퍼티에 등록된 예외 목록에 있는 명단이 엑셀과 동일할 때,
				if(tmpExcelExcepData[0].equals(excelDivisionHanNmData))
				{
					Map<String, Object> shareUserMap = new HashMap<String, Object>();
					shareUserMap.put("HAN_NAME", tmpExcelExcepData[1]); // 변경할 본부장 이름
					
					
					List<Map<String, Object>> shareMemberInfo = poiDAO.selectMembersInfo(shareUserMap);
					shareUserMap.put("MEMBER_ID_NUM", shareMemberInfo.get(0).get("MEMBER_ID_NUM"));
					shareUserMap.put("FISCAL_YEAR", map.get("FISCAL_YEAR"));
					shareUserMap.put("ACTUAL_DATE", map.get("ACTUAL_DATE"));
					
					
					/**
					 * 기존 본부장 데이터가 있을 시에는, 그 기존 데이터를 가지고와 합하여 업데이트
					 */
					List<Map<String, Object>> shareActualUserInfo = poiDAO.selectShareMemberErpSalesActualData(shareUserMap);
					if(shareActualUserInfo.size() > 0)
					{
						
						map.put("HAN_NAME", shareUserMap.get("HAN_NAME"));
						map.put("MEMBER_ID_NUM", shareUserMap.get("MEMBER_ID_NUM"));
						map.put("1Q_ACTUAL_TCV_AMOUNT", shareActualUserInfo.get(0).get("1Q_ACTUAL_TCV_AMOUNT"));
						map.put("1Q_ACTUAL_REV_AMOUNT", shareActualUserInfo.get(0).get("1Q_ACTUAL_REV_AMOUNT"));
						map.put("1Q_ACTUAL_GP_AMOUNT", shareActualUserInfo.get(0).get("1Q_ACTUAL_GP_AMOUNT"));
						
						map.put("2Q_ACTUAL_TCV_AMOUNT", shareActualUserInfo.get(0).get("2Q_ACTUAL_TCV_AMOUNT"));
						map.put("2Q_ACTUAL_REV_AMOUNT", shareActualUserInfo.get(0).get("2Q_ACTUAL_REV_AMOUNT"));
						map.put("2Q_ACTUAL_GP_AMOUNT", shareActualUserInfo.get(0).get("2Q_ACTUAL_GP_AMOUNT"));
						
						map.put("3Q_ACTUAL_TCV_AMOUNT", shareActualUserInfo.get(0).get("3Q_ACTUAL_TCV_AMOUNT"));
						map.put("3Q_ACTUAL_REV_AMOUNT", shareActualUserInfo.get(0).get("3Q_ACTUAL_REV_AMOUNT"));
						map.put("3Q_ACTUAL_GP_AMOUNT", shareActualUserInfo.get(0).get("3Q_ACTUAL_GP_AMOUNT"));
						
						map.put("4Q_ACTUAL_TCV_AMOUNT", shareActualUserInfo.get(0).get("4Q_ACTUAL_TCV_AMOUNT"));
						map.put("4Q_ACTUAL_REV_AMOUNT", shareActualUserInfo.get(0).get("4Q_ACTUAL_REV_AMOUNT"));
						map.put("4Q_ACTUAL_GP_AMOUNT", shareActualUserInfo.get(0).get("4Q_ACTUAL_GP_AMOUNT"));
						
						map.put("1q_actual_pgp_amount", shareActualUserInfo.get(0).get("1q_actual_pgp_amount"));
						map.put("2q_actual_pgp_amount", shareActualUserInfo.get(0).get("2q_actual_pgp_amount"));
						map.put("3q_actual_pgp_amount", shareActualUserInfo.get(0).get("3q_actual_pgp_amount"));
						map.put("4q_actual_pgp_amount", shareActualUserInfo.get(0).get("4q_actual_pgp_amount"));

						//중복으로 업로드할 경우, 본부장 데이터 계산 합산됨
						//그래서 처음 데이터로 업데이트
						//poiDAO.updateResetShareMemberErpSalesActual(map);

						poiDAO.updateShareMemberErpSalesActual(map);
						//map.clear();
					}
					else
					{
						/**
						 * 전 본부장 데이터 미존재 ( 데이터 insert )
						 */
//						poiDAO.insertShareMemberErpSalesActual(map);
						
						map.put("HAN_NAME", shareUserMap.get("HAN_NAME"));
						map.put("MEMBER_ID_NUM", shareUserMap.get("MEMBER_ID_NUM"));
						
						poiDAO.insertErpSalesActual(map);
					}
					break;
				}
				else
				{
					/**
					 * properties에 있는 예외처리 갯수만큼 비교를 다하였는데도 예외 대상이 아닐 시에 insert 
					 */
					
					int propertiesLength = tmpData.length;
					
					if(countFlag == propertiesLength)
					{
						
						List<Map<String, Object>> shareActualUserInfo = poiDAO.selectShareMemberErpSalesActualData(map);
						
						if(shareActualUserInfo.size() > 0)
						{
							map.put("1Q_ACTUAL_TCV_AMOUNT", shareActualUserInfo.get(0).get("1Q_ACTUAL_TCV_AMOUNT"));
							map.put("1Q_ACTUAL_REV_AMOUNT", shareActualUserInfo.get(0).get("1Q_ACTUAL_REV_AMOUNT"));
							map.put("1Q_ACTUAL_GP_AMOUNT", shareActualUserInfo.get(0).get("1Q_ACTUAL_GP_AMOUNT"));
							
							map.put("2Q_ACTUAL_TCV_AMOUNT", shareActualUserInfo.get(0).get("2Q_ACTUAL_TCV_AMOUNT"));
							map.put("2Q_ACTUAL_REV_AMOUNT", shareActualUserInfo.get(0).get("2Q_ACTUAL_REV_AMOUNT"));
							map.put("2Q_ACTUAL_GP_AMOUNT", shareActualUserInfo.get(0).get("2Q_ACTUAL_GP_AMOUNT"));
							
							map.put("3Q_ACTUAL_TCV_AMOUNT", shareActualUserInfo.get(0).get("3Q_ACTUAL_TCV_AMOUNT"));
							map.put("3Q_ACTUAL_REV_AMOUNT", shareActualUserInfo.get(0).get("3Q_ACTUAL_REV_AMOUNT"));
							map.put("3Q_ACTUAL_GP_AMOUNT", shareActualUserInfo.get(0).get("3Q_ACTUAL_GP_AMOUNT"));
							
							map.put("4Q_ACTUAL_TCV_AMOUNT", shareActualUserInfo.get(0).get("4Q_ACTUAL_TCV_AMOUNT"));
							map.put("4Q_ACTUAL_REV_AMOUNT", shareActualUserInfo.get(0).get("4Q_ACTUAL_REV_AMOUNT"));
							map.put("4Q_ACTUAL_GP_AMOUNT", shareActualUserInfo.get(0).get("4Q_ACTUAL_GP_AMOUNT"));
							
							map.put("1q_actual_pgp_amount", shareActualUserInfo.get(0).get("1q_actual_pgp_amount"));
							map.put("2q_actual_pgp_amount", shareActualUserInfo.get(0).get("2q_actual_pgp_amount"));
							map.put("3q_actual_pgp_amount", shareActualUserInfo.get(0).get("3q_actual_pgp_amount"));
							map.put("4q_actual_pgp_amount", shareActualUserInfo.get(0).get("4q_actual_pgp_amount"));
							
							poiDAO.updateShareMemberErpSalesActual(map);
						}
						else 
						{
							poiDAO.insertErpSalesActual(map);
						}
						
						break;
					}
					else
					{
						countFlag++;
					}
				}
			}// for(int k=0; k < tmpData.length; k++) end
			
			//map.clear();
		}//for excelDataList size
		
		return cnt;
	}

	public List<Map<String, Object>> xlsxReadErpSalesPlan(Map<String, Object> map, HttpServletRequest request) throws Exception {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> poiMap = new HashMap<String, Object>();
		int excelForm = Integer.parseInt((String) map.get("form"));

		FileInputStream fis = null;
		XSSFWorkbook workbook = null;

		MultipartHttpServletRequest multi = (MultipartHttpServletRequest) request;
		MultipartFile file = multi.getFile("filePOI");

		String fileName = file.getOriginalFilename();
		//	    String fileName = uploadFilePath;
		//		File temp_file = new File(fileName);
		File temp_file = new File(resultFilePath + fileName);

		if (temp_file.exists() == false) {
			// 없으면 생성
			temp_file.mkdirs();
		}

		file.transferTo(temp_file);

		fis = new FileInputStream(temp_file.getAbsolutePath());

		log.info("업로드 경로 : " + temp_file.getAbsolutePath().toString());

		workbook = new XSSFWorkbook(fis);

		XSSFSheet curSheet;
		XSSFRow	curRow;
		XSSFCell curCell;

		//for(int sheetIndex = 0; sheetIndex < workbook.getNumberOfSheets(); sheetIndex++){
		//curSheet = workbook.getSheetAt(sheetIndex);
		curSheet = workbook.getSheetAt(excelForm);
		for(int rowIndex = 2; rowIndex < curSheet.getPhysicalNumberOfRows(); rowIndex++){
			if(rowIndex != 2){
				curRow = curSheet.getRow(rowIndex);
				String value;
				if(!"".equals(curRow.getCell(1).getRawValue()) && curRow.getCell(1).getRawValue() != null){
					poiMap = new HashMap<String, Object>();
					for(int cellIndex = 0; cellIndex < curRow.getPhysicalNumberOfCells(); cellIndex++){
						curCell = curRow.getCell(cellIndex);
						if(true){
							value = "";
							switch(curCell.getCellType()){
							case HSSFCell.CELL_TYPE_NUMERIC :
								value = curCell.getRawValue();
								//value = curCell.getNumericCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_STRING :
								value = curCell.getStringCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_FORMULA :
								value = curCell.getCellFormula();
								break;
							case HSSFCell.CELL_TYPE_BLANK :
								value = curCell.getBooleanCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_ERROR :
								value = curCell.getErrorCellValue()+"";
								break;
							default :
								value = "";
								break;
							}

							if(!value.equals("false")){
								switch(cellIndex) {
								case 0 :
									poiMap.put("PERF_TARGET_ID", value);
									break;
								case 1 :
									poiMap.put("MEMBER_ID_NUM", value);
									break;
								case 2 :
									poiMap.put("BASIS_DATE", value);
									break;
								case 3 :
									poiMap.put("BOOKING_TYPE", value);
									break;
								case 4 :
									poiMap.put("TARGET_TCV_AMOUNT", value);
									break;
								case 5 :
									poiMap.put("TARGET_REV_AMOUNT", value);
									break;
								case 6 :
									poiMap.put("TARGET_GP_AMOUNT", value);
									break;
								case 7 :
									poiMap.put("SYS_REGISTER_DATE", value);
									break;
								case 8 :
									poiMap.put("SYS_UPDATE_DATE", value);
									break;
								default : 
									break;
								}
							}
						}
					}// cell for  ( 열 )
					poiMap.put("creatorId", map.get("creatorId"));
					//int insertExcel = insertClientIndividualInfo(list);
					//int insertExcel = insertClientIndividualInfo(poiMap);

					int insertExcel = insertErpSalesPlan(poiMap);

					String customerId = Integer.toString(KEY_ID);

					int maxCellIndex = 9;
					String sheetFlag = "erpSalesPlan";
					outFileProcess(rowIndex, curSheet, maxCellIndex, workbook, temp_file, insertExcel, customerId, sheetFlag);

					list.add(poiMap);
				}
			}
		} // row for ( 행 )
		//}
		// 아래꺼 보류
		fis.close();
		//deleteExel(temp_file.getAbsolutePath());

		return list;
	}

	/**
	 * 파일 저장
	 * @param rowIndex
	 * @param curSheet
	 * @param maxCellIndex
	 * @param workbook
	 * @param temp_file
	 * @throws Exception
	 */
	public void outFileProcess(int rowIndex, XSSFSheet curSheet, int maxCellIndex, XSSFWorkbook workbook, File temp_file, int insertExcel, String keyID, String sheetFlag)throws Exception{
		Row row =null;
		curSheet.getRow(rowIndex);
		row =curSheet.getRow(rowIndex);

		Cell cell = null;

		CellStyle cellStyle = workbook.createCellStyle();
		cellStyle.setFillForegroundColor(HSSFColor.LIME.index);
		cellStyle.setFillPattern(CellStyle.BIG_SPOTS);

		cell = row.createCell(maxCellIndex);

		if(sheetFlag.equals("clientIndividual"))
		{//고객개인
			if(insertExcel == -1)
			{
				cell.setCellValue("실패 - 고객사 존재하지 않습니다. 고객사를 먼저 등록하여 주십시오.");
				cell.setCellStyle(cellStyle);
			}
			else if (insertExcel==-2)
			{
				cell.setCellValue("실패 - 고객사 동명이인이 존재. 고객사 동명이인이라도 등록을 원한다면 엑셀 INSERT_FLAG 값을 'Y'로 변경하시오.");
				cell.setCellStyle(cellStyle);
			}
			else 
			{
				//insertExcel == 0;
				cell.setCellValue("성공");
				cell = row.createCell(0);
				cell.setCellValue(keyID);
			}
		}
		else if(sheetFlag.equals("clientCompany"))
		{//고객사
			if(insertExcel == -1)
			{
				cell.setCellValue("실패 - 이미 고객사가 등록되어 있습니다.");
				cell.setCellStyle(cellStyle);
			}
			else
			{
				//insertExcel == 0;
				cell.setCellValue("성공");
				cell = row.createCell(0);
				cell.setCellValue(keyID);
			}
		}
		else if(sheetFlag.equals("partnerIndividual"))
		{//파트너사 개인
			if(insertExcel == -2)
			{
				//파트너사 동명이인
				cell.setCellValue("실패 - 벤더사 동명이인이 존재. 같은회사 동명이인이라도 등록을 원한다면 엑셀 INSERT_FLAG 값을 'Y'로 변경하시오.");
				cell.setCellStyle(cellStyle);
			}
			else if(insertExcel == -3)
			{
				cell.setCellValue("실패 - 입력한 벤더사ID에 해당하는 벤더사가 존재하지 않거나, 필수입력 데이터가 비어있습니다.");
				cell.setCellStyle(cellStyle);
			}
			else if(insertExcel == 1)
			{
				cell.setCellValue("추가 성공");
				cell = row.createCell(0);
				cell.setCellValue(keyID);
			}
			else
			{
				cell.setCellValue("업데이트 성공");
				//cell = row.createCell(0);
				//cell.setCellValue(keyID);
			}
		}
		else if(sheetFlag.equals("partnerCompany"))
		{//파트너사
			if(insertExcel == -2)
			{
				cell.setCellValue("실패 - 벤더사 동일 벤더코드가 존재합니다.");
				cell.setCellStyle(cellStyle);
			}
			else if(insertExcel == 1)
			{
				cell.setCellValue("추가 성공");
				cell = row.createCell(0);
				cell.setCellValue(keyID);
			}
			else if(insertExcel == -5){
				cell.setCellValue("실패 - 협력사코드가 잘못되었습니다.");
				cell.setCellStyle(cellStyle);
			}
			else
			{
				cell.setCellValue("업데이트 성공");
			}
		}
		else if(sheetFlag.equals("partnerSegment"))
		{//협력사 코드
			if(insertExcel == -2)
			{
				cell.setCellValue("실패 - 협력사분류코드 중복");
				cell.setCellStyle(cellStyle);
			}
			else 
			{
				cell.setCellValue("추가 성공");
			}
		}
		else if(sheetFlag.equals("ourMember"))
		{
			if(insertExcel == -2)
			{
				cell.setCellValue("실패 - 회사내 동일 사번이 존재합니다.");
				cell.setCellStyle(cellStyle);
			}
			else if (insertExcel == 1)
			{
				cell.setCellValue("추가 성공");
				cell = row.createCell(0);
				cell.setCellValue(keyID);
			}
			else 
			{
				cell.setCellValue("업데이트 성공");
			}
		}else if(sheetFlag.equals("ourMemberTeam"))
		{
			if(insertExcel == -2)
			{
				cell.setCellValue("실패 - 팀이 존재합니다.");
				cell.setCellStyle(cellStyle);
			}
			else if(insertExcel == 1)
			{
				cell.setCellValue("추가 성공");
				cell = row.createCell(0);
				cell.setCellValue(keyID);
			}
			else
			{
				cell.setCellValue("업데이트 성공");
			}
		}
		else if(sheetFlag.equals("ourMemberDivision"))
		{
			if(insertExcel == -2)
			{
				cell.setCellValue("실패 - 본부가 존재합니다.");
				cell.setCellStyle(cellStyle);
			}
			else if(insertExcel == 1)
			{
				cell.setCellValue("추가 성공");
				cell = row.createCell(0);
				cell.setCellValue(keyID);
			}
			else 
			{
				cell.setCellValue("업데이트 성공");
			}
		}else if(sheetFlag.equals("erpSalesPlan"))
		{
			if(insertExcel == 0)
			{
				cell.setCellValue("성공");
			}
		}

		/*
		if(insertExcel == -1){
			cell.setCellValue("고객사 존재하지 않음");
			cell.setCellStyle(cellStyle);
		}else if (insertExcel==-2){
			cell.setCellValue("같은회사 동명이인이 존재하여 등록하지 않았습니다. 같은회사 동명이인이라도 등록을 원한다면 엑셀 INSERT_FLAG 값을 'Y'로 변경하시오.");
			cell.setCellStyle(cellStyle);
		}else {
			cell = row.createCell(0);
			cell.setCellValue(CUSTOMER_ID);
		}
		 */
		//		cell.setCellStyle(cellStyle);

		FileOutputStream fileOutput = new FileOutputStream(temp_file);
		workbook.write(fileOutput);
		fileOutput.close();
	}

	public Map<String,Object> xlsDownload(CommandMap map) throws Exception {
		Map<String,Object> map2 = null;


		return map2;
	}

	@SuppressWarnings({ "resource" })
	public List<Map<String, Object>> xlsReadClientIndividualInfo(Map<String, Object> map, HttpServletRequest request) throws Exception {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> poiMap = new HashMap<String, Object>();

		int excelForm = Integer.parseInt((String) map.get("form"));

		FileInputStream fis = null;
		HSSFWorkbook workbook = null;

		MultipartHttpServletRequest multi = (MultipartHttpServletRequest) request;
		MultipartFile file = multi.getFile("filePOI");

		String fileName = file.getOriginalFilename();
		//	    File temp_file = new File(fileName);
		File temp_file = new File(resultFilePath + fileName);

		if (temp_file.exists() == false) {
			// 없으면 생성
			temp_file.mkdirs();
		}

		file.transferTo(temp_file);

		fis = new FileInputStream(temp_file.getAbsolutePath());

		workbook = new HSSFWorkbook(fis);

		HSSFSheet curSheet;
		HSSFRow	curRow;
		HSSFCell curCell;

		//for(int sheetIndex = 0; sheetIndex < workbook.getNumberOfSheets(); sheetIndex++){
		//curSheet = workbook.getSheetAt(sheetIndex);
		curSheet = workbook.getSheetAt(excelForm);
		for(int rowIndex = 2; rowIndex < curSheet.getPhysicalNumberOfRows(); rowIndex++){
			if(rowIndex != 2){
				curRow = curSheet.getRow(rowIndex);
				String value;
				if(!"".equals(curRow.getCell(1).getStringCellValue())){
					poiMap = new HashMap<String, Object>();
					for(int cellIndex = 0; cellIndex < curRow.getPhysicalNumberOfCells(); cellIndex++){
						curCell = curRow.getCell(cellIndex);
						if(true){
							value = "";
							switch(curCell.getCellType()){
							case HSSFCell.CELL_TYPE_NUMERIC :
								value = curCell.getNumericCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_STRING :
								value = curCell.getStringCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_FORMULA :
								value = curCell.getCellFormula();
								break;
							case HSSFCell.CELL_TYPE_BLANK :
								value = curCell.getBooleanCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_ERROR :
								value = curCell.getErrorCellValue()+"";
								break;
							default :
								value = new String();
								break;
							}

							if(!value.equals("false")){
								switch(cellIndex) {
								case 0 :
									poiMap.put("CUSTOMER_ID", value);
									break;
								case 1 :
									poiMap.put("COMPANY_NAME", value);
									break;
								case 2 :
									poiMap.put("CUSTOMER_NAME", value);
									break;
								case 3 :
									poiMap.put("DIVISION", value);
									break;
								case 4 :
									poiMap.put("POST", value);
									break;
								case 5 :
									poiMap.put("TEAM", value);
									break;
								case 6 :
									poiMap.put("POSITION", value);
									break;
								case 7 :
									poiMap.put("DUTY", value);
									break;
								case 8 :
									poiMap.put("CELL_PHONE", value);
									break;
								case 9 :
									poiMap.put("PHONE", value);
									break;
								case 10 :
									poiMap.put("EMAIL", value);
									break;
								case 11 :
									poiMap.put("ADDRESS", value);
									break;
								case 12 :
									poiMap.put("FRIENDSHIP_INFO", value);
									break;
								case 13 :
									poiMap.put("INFO_SOURCE", value);
									break;
								case 14 :
									poiMap.put("PINFO_CAREER", value);
									break;
								case 15 :
									poiMap.put("PINFO_SOCIAL_ACTS", value);
									break;
								case 16 :
									poiMap.put("PINFO_FAMILY", value);
									break;
								case 17 :
									poiMap.put("PINFO_INCLINATION", value);
									break;
								case 18 :
									poiMap.put("PINFO_FAMILIARS", value);
									break;
								case 19 :
									poiMap.put("PINFO_SNS", value);
									break;
								case 20 :
									poiMap.put("PINFO_ETC", value);
									break;
								case 21 :
									poiMap.put("CREATOR_ID", value);
									break;
								case 22 :
									poiMap.put("CREATE_DATE", value);
									break;
								case 23 :
									poiMap.put("SYS_REGISTER_DATE", value);
									break;
								case 24 :
									poiMap.put("SYS_UPDATE_DATE", value);
									break;
								case 25 :
									poiMap.put("REPORTING_LINE_DIVISION_ID", value);
									break;
								case 26 :
									poiMap.put("REPORTING_LINE_POST_ID", value);
									break;
								case 27 :
									poiMap.put("REPORTING_LINE_TEAM_ID", value);
									break;
								case 28 :
									poiMap.put("PINFO_EDUCATION_PERSON", value);
									break;
								case 29 :
									poiMap.put("PINFO_CAREER_PERSON", value);
									break;
								case 30 :
									poiMap.put("PINFO_EDUCATION", value);
									break;
								case 31 :
									poiMap.put("PREV_SALES_MEMBER_ID", value);
									break;
								case 32 :
									poiMap.put("POSITION_DUTY", value);
									break;
								case 33 :
									poiMap.put("PINFO_RELATIONSHIP", value);
									break;
								case 34 :
									poiMap.put("LIKEABILITY", value);
									break;
								case 35 :
									poiMap.put("RELATION", value);
									break;
								case 36 :
									poiMap.put("DIRECTOR_ID", value);
									break;
								default : 
									break;
								}
							}
						}
					}
					poiMap.put("creatorId", map.get("creatorId"));
					list.add(poiMap);
				}
			}
		}
		//}
		fis.close();
		deleteExel(temp_file.getAbsolutePath());
		insertClientIndividualInfo(list);

		return list;
	}

	public List<Map<String, Object>> xlsxReadClientCompanyInfo(Map<String, Object> map, HttpServletRequest request) throws Exception {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> poiMap = new HashMap<String, Object>();

		int excelForm = Integer.parseInt((String) map.get("form"));

		FileInputStream fis = null;
		XSSFWorkbook workbook = null;

		MultipartHttpServletRequest multi = (MultipartHttpServletRequest) request;
		MultipartFile file = multi.getFile("filePOI");

		String fileName = file.getOriginalFilename();
		File temp_file = new File(resultFilePath + fileName);

		if (temp_file.exists() == false) {
			// 없으면 생성
			temp_file.mkdirs();
		}


		file.transferTo(temp_file);

		fis = new FileInputStream(temp_file.getAbsolutePath());

		workbook = new XSSFWorkbook(fis);

		XSSFSheet curSheet;
		XSSFRow	curRow;
		XSSFCell curCell;

		//for(int sheetIndex = 0; sheetIndex < workbook.getNumberOfSheets(); sheetIndex++){
		//curSheet = workbook.getSheetAt(sheetIndex);
		curSheet = workbook.getSheetAt(excelForm);
		for(int rowIndex = 2; rowIndex < curSheet.getPhysicalNumberOfRows(); rowIndex++){
			if(rowIndex != 2){
				curRow = curSheet.getRow(rowIndex);
				String value;
				if(!"".equals(curRow.getCell(1).getRawValue()) && curRow.getCell(1).getRawValue() != null){
					poiMap = new HashMap<String, Object>();
					for(int cellIndex = 0; cellIndex < curRow.getPhysicalNumberOfCells(); cellIndex++){
						curCell = curRow.getCell(cellIndex);
						if(true){
							value = "";
							switch(curCell.getCellType()){
							case HSSFCell.CELL_TYPE_NUMERIC :
								value = curCell.getRawValue();
								//value = curCell.getNumericCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_STRING :
								value = curCell.getStringCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_FORMULA :
								value = curCell.getCellFormula();
								break;
							case HSSFCell.CELL_TYPE_BLANK :
								value = curCell.getBooleanCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_ERROR :
								value = curCell.getErrorCellValue()+"";
								break;
							default :
								value = "";
								break;
							}

							if(!value.equals("false")){
								switch(cellIndex) {
								case 0 :
									poiMap.put("COMPANY_ID", value);
									break;
								case 1 :
									poiMap.put("SEGMENT_CODE", value);
									break;
								case 2 :
									poiMap.put("ERP_REG_CODE", value);
									break;
								case 3 :
									poiMap.put("COMPANY_NAME", value);
									break;
								case 4 :
									poiMap.put("CEO_NAME", value);
									break;
								case 5 :
									poiMap.put("COMPANY_TELNO", value);
									break;
								case 6 :
									poiMap.put("POSTAL_CODE", value);
									break;
								case 7 :
									poiMap.put("POSTAL_ADDRESS", value);
									break;
								case 8 :
									poiMap.put("BUSINESS_NUMBER", value);
									break;
								case 9 :
									poiMap.put("BUSINESS_TYPE", value);
									break;
								case 10 :
									poiMap.put("BUSINESS_SECTOR", value);
									break;
								case 11 :
									poiMap.put("COMPANY_STATUS", value);
									break;
								case 12 :
									poiMap.put("SYS_REGISTER_DATE", value);
									break;
								case 13 :
									poiMap.put("SYS_UPDATE_DATE", value);
									break;
								case 14 :
									poiMap.put("CIO_NAME", value);
									break;
								case 15 :
									poiMap.put("CTO_NAME", value);
									break;
								case 16 :
									poiMap.put("CEO_ID", value);
									break;
								case 17 :
									poiMap.put("CIO_ID", value);
									break;
								case 18 :
									poiMap.put("CTO_ID", value);
									break;
								case 19 :
									switch (value) {
									case "EPC":
										poiMap.put("CLIENT_CATEGORY", "1");
										break;
									case "Owner":
										poiMap.put("CLIENT_CATEGORY", "2");
										break;
									case "Sales":
										poiMap.put("CLIENT_CATEGORY", "3");
										break;
									case "공기업":
										poiMap.put("CLIENT_CATEGORY", "4");
										break;
									case "제조":
										poiMap.put("CLIENT_CATEGORY", "5");
										break;
									case "해외":
										poiMap.put("CLIENT_CATEGORY", "6");
										break;
									default:
										break;
									}
									break;
								default : 
									break;
								}
							}
						}
					}//cell for문
					poiMap.put("creatorId", map.get("creatorId"));

					int insertExcel = insertClientCompanyInfo(poiMap);
					int maxCellIndex = 20;
					String companyId = Integer.toString(COMPANY_ID); 
					String sheetFlag = "clientCompany";

					//결과엑셀 상태 입력하기.
					outFileProcess(rowIndex, curSheet, maxCellIndex, workbook, temp_file, insertExcel, companyId, sheetFlag);
					//list.add(poiMap);
				}
			}
		}//for
		//}
		fis.close();
		//deleteExel(temp_file.getAbsolutePath());

		//insertClientCompanyInfo(list);

		return list;
	}

	@SuppressWarnings({ "resource" })
	public List<Map<String, Object>> xlsReadClientCompanyInfo(Map<String, Object> map, HttpServletRequest request) throws Exception {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> poiMap = new HashMap<String, Object>();

		int excelForm = Integer.parseInt((String) map.get("form"));

		FileInputStream fis = null;
		HSSFWorkbook workbook = null;

		MultipartHttpServletRequest multi = (MultipartHttpServletRequest) request;
		MultipartFile file = multi.getFile("filePOI");

		String fileName = file.getOriginalFilename();
		//	    File temp_file = new File(fileName);
		File temp_file = new File(resultFilePath + fileName);

		if (temp_file.exists() == false) {
			// 없으면 생성
			temp_file.mkdirs();
		}

		file.transferTo(temp_file);

		fis = new FileInputStream(temp_file.getAbsolutePath());

		workbook = new HSSFWorkbook(fis);

		HSSFSheet curSheet;
		HSSFRow	curRow;
		HSSFCell curCell;

		//for(int sheetIndex = 0; sheetIndex < workbook.getNumberOfSheets(); sheetIndex++){
		//curSheet = workbook.getSheetAt(sheetIndex);
		curSheet = workbook.getSheetAt(excelForm);
		for(int rowIndex = 2; rowIndex < curSheet.getPhysicalNumberOfRows(); rowIndex++){
			if(rowIndex != 2){
				curRow = curSheet.getRow(rowIndex);
				String value;
				if(!"".equals(curRow.getCell(1).getStringCellValue())){
					poiMap = new HashMap<String, Object>();
					for(int cellIndex = 0; cellIndex < curRow.getPhysicalNumberOfCells(); cellIndex++){
						curCell = curRow.getCell(cellIndex);
						if(true){
							value = "";
							switch(curCell.getCellType()){
							case HSSFCell.CELL_TYPE_NUMERIC :
								value = curCell.getNumericCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_STRING :
								value = curCell.getStringCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_FORMULA :
								value = curCell.getCellFormula();
								break;
							case HSSFCell.CELL_TYPE_BLANK :
								value = curCell.getBooleanCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_ERROR :
								value = curCell.getErrorCellValue()+"";
								break;
							default :
								value = new String();
								break;
							}

							if(!value.equals("false")){
								switch(cellIndex) {
								case 0 :
									poiMap.put("COMPANY_ID", value);
									break;
								case 1 :
									poiMap.put("SEGMENT_CODE", value);
									break;
								case 2 :
									poiMap.put("ERP_REG_CODE", value);
									break;
								case 3 :
									poiMap.put("COMPANY_NAME", value);
									break;
								case 4 :
									poiMap.put("CEO_NAME", value);
									break;
								case 5 :
									poiMap.put("COMPANY_TELNO", value);
									break;
								case 6 :
									poiMap.put("POSTAL_CODE", value);
									break;
								case 7 :
									poiMap.put("POSTAL_ADDRESS", value);
									break;
								case 8 :
									poiMap.put("BUSINESS_NUMBER", value);
									break;
								case 9 :
									poiMap.put("BUSINESS_TYPE", value);
									break;
								case 10 :
									poiMap.put("BUSINESS_SECTOR", value);
									break;
								case 11 :
									poiMap.put("COMPANY_STATUS", value);
									break;
								case 12 :
									poiMap.put("SYS_REGISTER_DATE", value);
									break;
								case 13 :
									poiMap.put("SYS_UPDATE_DATE", value);
									break;
								case 14 :
									poiMap.put("CIO_NAME", value);
									break;
								case 15 :
									poiMap.put("CTO_NAME", value);
									break;
								case 16 :
									poiMap.put("CEO_ID", value);
									break;
								case 17 :
									poiMap.put("CIO_ID", value);
									break;
								case 18 :
									poiMap.put("CTO_ID", value);
									break;
								case 19 :
									switch (value) {
									case "EPC":
										poiMap.put("CLIENT_CATEGORY", "1");
										break;
									case "Owner":
										poiMap.put("CLIENT_CATEGORY", "2");
										break;
									case "Sales":
										poiMap.put("CLIENT_CATEGORY", "3");
										break;
									case "공기업":
										poiMap.put("CLIENT_CATEGORY", "4");
										break;
									case "제조":
										poiMap.put("CLIENT_CATEGORY", "5");
										break;
									case "해외":
										poiMap.put("CLIENT_CATEGORY", "6");
										break;
									default:
										break;
									}
									break;
								default : 
									break;
								}
							}
						}
					}
					poiMap.put("creatorId", map.get("creatorId"));
					list.add(poiMap);
				}
			}
		}
		//}
		fis.close();
		deleteExel(temp_file.getAbsolutePath());
		insertClientCompanyInfo(list);

		return list;
	}

	public List<Map<String, Object>> xlsxReadOurMembersInfo(Map<String, Object> map, HttpServletRequest request) throws Exception {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> poiMap = new HashMap<String, Object>();

		int excelForm = Integer.parseInt((String) map.get("form"));

		FileInputStream fis = null;
		XSSFWorkbook workbook = null;

		MultipartHttpServletRequest multi = (MultipartHttpServletRequest) request;
		MultipartFile file = multi.getFile("filePOI");

		String fileName = file.getOriginalFilename();
		//	    File temp_file = new File(fileName);
		File temp_file = new File(resultFilePath + fileName);

		if (temp_file.exists() == false) {
			// 없으면 생성
			temp_file.mkdirs();
		}

		file.transferTo(temp_file);

		fis = new FileInputStream(temp_file.getAbsolutePath());

		workbook = new XSSFWorkbook(fis);

		XSSFSheet curSheet;
		XSSFRow	curRow;
		XSSFCell curCell;

		//for(int sheetIndex = 0; sheetIndex < workbook.getNumberOfSheets(); sheetIndex++){
		//curSheet = workbook.getSheetAt(sheetIndex);
		curSheet = workbook.getSheetAt(excelForm);
		for(int rowIndex = 2; rowIndex < curSheet.getPhysicalNumberOfRows(); rowIndex++){
			if(rowIndex != 2){
				curRow = curSheet.getRow(rowIndex);
				String value;
				if(!"".equals(curRow.getCell(4).getRawValue()) && curRow.getCell(4).getRawValue() != null){
					poiMap = new HashMap<String, Object>();
					for(int cellIndex = 0; cellIndex < curRow.getPhysicalNumberOfCells(); cellIndex++){
						curCell = curRow.getCell(cellIndex);
						if(true){
							value = "";
							switch(curCell.getCellType()){
							case HSSFCell.CELL_TYPE_NUMERIC :
								value = curCell.getRawValue();
								//value = curCell.getNumericCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_STRING :
								value = curCell.getStringCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_FORMULA :
								value = curCell.getCellFormula();
								break;
							case HSSFCell.CELL_TYPE_BLANK :
								value = curCell.getBooleanCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_ERROR :
								value = curCell.getErrorCellValue()+"";
								break;
							default :
								value = "";
								break;
							}

							if(!value.equals("false")){
								switch(cellIndex) {
								case 0 :
									poiMap.put("MEMBER_ID", value);
									break;
								case 1 :
									poiMap.put("MEMBER_DIVISION", value);
									break;
								case 2 :
									poiMap.put("MEMBER_POST", value);
									break;
								case 3 :
									poiMap.put("MEMBER_TEAM", value);
									break;
								case 4 :
									poiMap.put("MEMBER_ID_NUM", value);
									break;
								case 5 :
									poiMap.put("HAN_NAME", value);
									break;
								case 6 :
									poiMap.put("POSITION_STATUS", value);
									break;
								case 7 :
									poiMap.put("POSITION_RANK", value);
									break;
								case 8 :
									poiMap.put("POSITION_DUTY", value);
									break;
								case 9 :
									poiMap.put("POSITION_TYPE", value);
									break;
								case 10 :
									poiMap.put("BUSINESS_DUTY", value);
									break;
								case 11 :
									poiMap.put("JOIN_DATE", value);
									break;
								case 12 :
									poiMap.put("STOP_DATE", value);
									break;
								case 13 :
									poiMap.put("CELL_PHONE", value);
									break;
								case 14 :
									poiMap.put("PHONE", value);
									break;
								case 15 :
									poiMap.put("EMAIL", value);
									break;
								case 16 :
									poiMap.put("FRIENDSHIP_COMPANY", value);
									break;
								case 17 :
									poiMap.put("FRIENDSHIP_CUSTOMER", value);
									break;
								case 18 :
									poiMap.put("PERSONAL_PHOTO", value);
									break;
								case 19 :
									poiMap.put("PHOTO_TYPE", value);
									break;
								case 20 :
									poiMap.put("SYS_REGISTER_DATE", value);
									break;
								case 21 :
									poiMap.put("SYS_UPDATE_DATE", value);
									break;
								case 22 :
									poiMap.put("USE_YN", value);
									break;
								default : 
									break;
								}
							}
						}
					}//cell for

					poiMap.put("creatorId", map.get("creatorId"));

					//insertOurMembersInfo(list);

					int insertExcel = insertOurMembersInfo(poiMap, map);
					int maxCellIndex = 23;
					String companyId = Integer.toString(KEY_ID); 
					String sheetFlag = "ourMember";

					//결과엑셀 상태 입력하기.
					outFileProcess(rowIndex, curSheet, maxCellIndex, workbook, temp_file, insertExcel, companyId, sheetFlag);
					//list.add(poiMap);
				}
			}
		}
		//}
		fis.close();
		//deleteExel(temp_file.getAbsolutePath());
		//insertOurMembersInfo(list);

		return list;
	}

	@SuppressWarnings({ "resource" })
	public List<Map<String, Object>> xlsReadOurMembersInfo(Map<String, Object> map, HttpServletRequest request) throws Exception {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> poiMap = new HashMap<String, Object>();

		int excelForm = Integer.parseInt((String) map.get("form"));

		FileInputStream fis = null;
		HSSFWorkbook workbook = null;

		MultipartHttpServletRequest multi = (MultipartHttpServletRequest) request;
		MultipartFile file = multi.getFile("filePOI");

		String fileName = file.getOriginalFilename();
		//	    File temp_file = new File(fileName);
		File temp_file = new File(resultFilePath + fileName);

		if (temp_file.exists() == false) {
			// 없으면 생성
			temp_file.mkdirs();
		}

		file.transferTo(temp_file);

		fis = new FileInputStream(temp_file.getAbsolutePath());

		workbook = new HSSFWorkbook(fis);

		HSSFSheet curSheet;
		HSSFRow	curRow;
		HSSFCell curCell;

		//for(int sheetIndex = 0; sheetIndex < workbook.getNumberOfSheets(); sheetIndex++){
		//curSheet = workbook.getSheetAt(sheetIndex);
		curSheet = workbook.getSheetAt(excelForm);
		for(int rowIndex = 2; rowIndex < curSheet.getPhysicalNumberOfRows(); rowIndex++){
			if(rowIndex != 2){
				curRow = curSheet.getRow(rowIndex);
				String value;
				if(!"".equals(curRow.getCell(4).getStringCellValue())){
					poiMap = new HashMap<String, Object>();
					for(int cellIndex = 0; cellIndex < curRow.getPhysicalNumberOfCells(); cellIndex++){
						curCell = curRow.getCell(cellIndex);
						if(true){
							value = "";
							switch(curCell.getCellType()){
							case HSSFCell.CELL_TYPE_NUMERIC :
								value = curCell.getNumericCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_STRING :
								value = curCell.getStringCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_FORMULA :
								value = curCell.getCellFormula();
								break;
							case HSSFCell.CELL_TYPE_BLANK :
								value = curCell.getBooleanCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_ERROR :
								value = curCell.getErrorCellValue()+"";
								break;
							default :
								value = new String();
								break;
							}

							if(!value.equals("false")){
								switch(cellIndex) {
								case 0 :
									poiMap.put("MEMBER_ID", value);
									break;
								case 1 :
									poiMap.put("MEMBER_DIVISION", value);
									break;
								case 2 :
									poiMap.put("MEMBER_POST", value);
									break;
								case 3 :
									poiMap.put("MEMBER_TEAM", value);
									break;
								case 4 :
									poiMap.put("MEMBER_ID_NUM", value);
									break;
								case 5 :
									poiMap.put("HAN_NAME", value);
									break;
								case 6 :
									poiMap.put("POSITION_STATUS", value);
									break;
								case 7 :
									poiMap.put("POSITION_RANK", value);
									break;
								case 8 :
									poiMap.put("POSITION_DUTY", value);
									break;
								case 9 :
									poiMap.put("POSITION_TYPE", value);
									break;
								case 10 :
									poiMap.put("BUSINESS_DUTY", value);
									break;
								case 11 :
									poiMap.put("JOIN_DATE", value);
									break;
								case 12 :
									poiMap.put("STOP_DATE", value);
									break;
								case 13 :
									poiMap.put("CELL_PHONE", value);
									break;
								case 14 :
									poiMap.put("PHONE", value);
									break;
								case 15 :
									poiMap.put("EMAIL", value);
									break;
								case 16 :
									poiMap.put("FRIENDSHIP_COMPANY", value);
									break;
								case 17 :
									poiMap.put("FRIENDSHIP_CUSTOMER", value);
									break;
								case 18 :
									poiMap.put("PERSONAL_PHOTO", value);
									break;
								case 19 :
									poiMap.put("PHOTO_TYPE", value);
									break;
								case 20 :
									poiMap.put("SYS_REGISTER_DATE", value);
									break;
								case 21 :
									poiMap.put("SYS_UPDATE_DATE", value);
									break;
								default : 
									break;
								}
							}
						}
					}
					list.add(poiMap);
				}
			}
		}
		//}
		fis.close();
		deleteExel(temp_file.getAbsolutePath());
		insertOurMembersInfo(list);

		return list;
	}

	public List<Map<String, Object>> xlsxReadOurDivisionInfo(Map<String, Object> map, HttpServletRequest request) throws Exception {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> poiMap = new HashMap<String, Object>();

		int excelForm = Integer.parseInt((String) map.get("form"));

		FileInputStream fis = null;
		XSSFWorkbook workbook = null;

		MultipartHttpServletRequest multi = (MultipartHttpServletRequest) request;
		MultipartFile file = multi.getFile("filePOI");

		String fileName = file.getOriginalFilename();
		//	    File temp_file = new File(fileName);
		File temp_file = new File(resultFilePath + fileName);

		if (temp_file.exists() == false) {
			// 없으면 생성
			temp_file.mkdirs();
		}

		file.transferTo(temp_file);

		fis = new FileInputStream(temp_file.getAbsolutePath());

		workbook = new XSSFWorkbook(fis);

		XSSFSheet curSheet;
		XSSFRow	curRow;
		XSSFCell curCell;

		curSheet = workbook.getSheetAt(excelForm);
		
		/*
		Connection con = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		
		String insertSql = "INSERT INTO OUR_DIVISION_INFO(DIVISION_NAME, SYS_REGISTER_DATE, SYS_UPDATE_DATE, DIVISION_TYPE, USE_YN, DIVISION_LEADER) values(?,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,?,?,?)";
		String updateSql = "UPDATE OUR_DIVISION_INFO SET DIVISION_NAME=?, SYS_REGISTER_DATE = CURRENT_TIMESTAMP, SYS_UPDATE_DATE = CURRENT_TIMESTAMP, DIVISION_TYPE=?, USE_YN=?, DIVISION_LEADER=? WHERE DIVISION_NO =?";
		*/
		
		int cnt = 0;
		
//		try{
//			Class.forName("com.mysql.jdbc.Driver");
//			con = DriverManager.getConnection("jdbc:mysql://192.168.1.165/sellers_standard","sellers", "Sellers123!@#");
//			con = DriverManager.getConnection("jdbc:mysql://127.0.0.1/sellers_local_db","root", "root");
//			
//			pstmt = con.prepareStatement(insertSql);
//			pstmt2 = con.prepareStatement(updateSql);
			
			for(int rowIndex = 2; rowIndex < curSheet.getPhysicalNumberOfRows(); rowIndex++)
			{
				if(rowIndex != 2)
				{
					curRow = curSheet.getRow(rowIndex);
					String value;
					if(!"".equals(curRow.getCell(1).getRawValue()) && curRow.getCell(1).getRawValue() != null)
					{
						poiMap = new HashMap<String, Object>();
						for(int cellIndex = 0; cellIndex < curRow.getPhysicalNumberOfCells(); cellIndex++)
						{
							curCell = curRow.getCell(cellIndex);
							if(true)
							{
								value = "";
								switch(curCell.getCellType()){
								case HSSFCell.CELL_TYPE_NUMERIC :
									value = curCell.getRawValue();
									//value = curCell.getNumericCellValue()+"";
									break;
								case HSSFCell.CELL_TYPE_STRING :
									value = curCell.getStringCellValue()+"";
									break;
								case HSSFCell.CELL_TYPE_FORMULA :
									value = curCell.getCellFormula();
									break;
								case HSSFCell.CELL_TYPE_BLANK :
									value = curCell.getBooleanCellValue()+"";
									break;
								case HSSFCell.CELL_TYPE_ERROR :
									value = curCell.getErrorCellValue()+"";
									break;
								default :
									value = "";
									break;
								}
	
								if(!value.equals("false"))
								{
									switch(cellIndex) {
									case 0 :
										poiMap.put("DIVISION_NO", value);
										break;
									case 1 :
										poiMap.put("DIVISION_NAME", value);
										break;
									case 2 :
										poiMap.put("SYS_REGISTER_DATE", value);
										break;
									case 3 :
										poiMap.put("SYS_UPDATE_DATE", value);
										break;
									case 4 :
										poiMap.put("DIVISION_TYPE", value);
										break;
									case 5 :
										poiMap.put("USE_YN", value);
										break;
									case 6 :
										poiMap.put("DIVISION_LEADER", value);
										break;
									default : 
										break;
									}
								}
							}
						}//cell for
						
						//poiMap.put("creatorId", map.get("creatorId"));
	
						int insertExcel = insertOurDivisionInfo(poiMap);
						int maxCellIndex = 7;
						String companyId = Integer.toString(KEY_ID); 
						String sheetFlag = "ourMemberDivision";
	
						//결과엑셀 상태 입력하기.
						outFileProcess(rowIndex, curSheet, maxCellIndex, workbook, temp_file, insertExcel, companyId, sheetFlag);
						//list.add(poiMap);
					}
				}// if(rowIndex != 2) end
			
				/*
				//TODO: ///////////////////////////////////////////엑셀 업로드 속도 개선 작업중///////////////////////////////////////
				if(null != poiMap.get("DIVISION_NO"))
				{
					//엑셀에 DIVISION_NO가 존재하면 update
					//poiDAO.updateOurDivisionInfo(poiMap);
					
					String DIVISION_NAME = (String) poiMap.get("DIVISION_NAME");
					String DIVISION_TYPE = (String) poiMap.get("DIVISION_TYPE");
					String USE_YN = (String) poiMap.get("USE_YN");
					String DIVISION_LEADER = (String) poiMap.get("DIVISION_LEADER");
					String DIVISION_NO = (String) poiMap.get("DIVISION_NO");
					
					pstmt2.setString(1, DIVISION_NAME);
					pstmt2.setString(2, DIVISION_TYPE);
					pstmt2.setString(3, USE_YN);
					pstmt2.setString(4, DIVISION_LEADER);
					pstmt2.setString(5, DIVISION_NO);
					
					//add Batch에 담기
					pstmt2.addBatch();
					
					//파라미터 Clear
					pstmt2.clearParameters();
				}
				else
				{
					Map<String, Object> selectMap = poiDAO.selectOurDivisionInfo(poiMap);
					
					//DIVISION_NO가 존재하지 않는데 DIVISION_NAME으로 검색했을 때, DB 데이터가 존재할 경우
					if(null != selectMap)
					{
						cnt = -2;
					}
					else 
					{
						cnt = 1;
						
						poiDAO.insertOurDivisionInfo(poiMap);
						KEY_ID = Integer.parseInt(poiMap.get("filePK").toString());
						
						
						String DIVISION_NAME = (String) poiMap.get("DIVISION_NAME");
						String DIVISION_TYPE = (String) poiMap.get("DIVISION_TYPE");
						String USE_YN = (String) poiMap.get("USE_YN");
						String DIVISION_LEADER = (String) poiMap.get("DIVISION_LEADER");
						
						pstmt.setString(1, DIVISION_NAME);
						pstmt.setString(2, DIVISION_TYPE);
						pstmt.setString(3, USE_YN);
						pstmt.setString(4, DIVISION_LEADER);
						
						//add Batch에 담기
						pstmt.addBatch();
						
						//파라미터 Clear
						pstmt.clearParameters();
						
					}
				}//else end
				*/
				/*
				//엑셀 상태 처리(비고란)
				int maxCellIndex = 7;
				String companyId = Integer.toString(KEY_ID); 
				String sheetFlag = "ourMemberDivision";
				outFileProcess(rowIndex, curSheet, maxCellIndex, workbook, temp_file, cnt, companyId, sheetFlag);
				
				//엑셀 로우 index 끝 다달 했을 때, 쿼리문 한빵에 실행
				if(rowIndex+1 == curSheet.getPhysicalNumberOfRows())
				{
					//배치 실행
					pstmt.executeBatch();	//insert
					pstmt2.executeBatch();	//update
					
					// Batch 초기화
					pstmt.clearBatch();
					pstmt2.clearBatch();
					
					//커밋
					con.commit();
				}
				*/
				
				
			}//for end
			
			
			/*	
		}catch(Exception e){
			e.printStackTrace();
             
            try {
                con.rollback() ;
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
		}finally{
			if (pstmt != null) try {pstmt.close();pstmt = null;} catch(SQLException ex){}
            if (con != null) try {con.close();con = null;} catch(SQLException ex){}
		}
*/
		//}//row for문 end
		
		
		//}
		fis.close();
		//deleteExel(temp_file.getAbsolutePath());
		//insertOurDivisionInfo(list);

		return list;
	}

	@SuppressWarnings({ "resource" })
	public List<Map<String, Object>> xlsReadOurDivisionInfo(Map<String, Object> map, HttpServletRequest request) throws Exception {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> poiMap = new HashMap<String, Object>();

		int excelForm = Integer.parseInt((String) map.get("form"));

		FileInputStream fis = null;
		HSSFWorkbook workbook = null;

		MultipartHttpServletRequest multi = (MultipartHttpServletRequest) request;
		MultipartFile file = multi.getFile("filePOI");

		String fileName = file.getOriginalFilename();
		//	    File temp_file = new File(fileName);
		File temp_file = new File(resultFilePath + fileName);

		if (temp_file.exists() == false) {
			// 없으면 생성
			temp_file.mkdirs();
		}

		file.transferTo(temp_file);

		fis = new FileInputStream(temp_file.getAbsolutePath());

		workbook = new HSSFWorkbook(fis);

		HSSFSheet curSheet;
		HSSFRow	curRow;
		HSSFCell curCell;

		//for(int sheetIndex = 0; sheetIndex < workbook.getNumberOfSheets(); sheetIndex++){
		//curSheet = workbook.getSheetAt(sheetIndex);
		curSheet = workbook.getSheetAt(excelForm);
		for(int rowIndex = 2; rowIndex < curSheet.getPhysicalNumberOfRows(); rowIndex++){
			if(rowIndex != 2){
				curRow = curSheet.getRow(rowIndex);
				String value;
				if(!"".equals(curRow.getCell(1).getStringCellValue())){
					poiMap = new HashMap<String, Object>();
					for(int cellIndex = 0; cellIndex < curRow.getPhysicalNumberOfCells(); cellIndex++){
						curCell = curRow.getCell(cellIndex);
						if(true){
							value = "";
							switch(curCell.getCellType()){
							case HSSFCell.CELL_TYPE_NUMERIC :
								value = curCell.getNumericCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_STRING :
								value = curCell.getStringCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_FORMULA :
								value = curCell.getCellFormula();
								break;
							case HSSFCell.CELL_TYPE_BLANK :
								value = curCell.getBooleanCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_ERROR :
								value = curCell.getErrorCellValue()+"";
								break;
							default :
								value = new String();
								break;
							}

							if(!value.equals("false")){
								switch(cellIndex) {
								case 0 :
									poiMap.put("DIVISION_NO", value);
									break;
								case 1 :
									poiMap.put("DIVISION_NAME", value);
									break;
								case 2 :
									poiMap.put("SYS_REGISTER_DATE", value);
									break;
								case 3 :
									poiMap.put("SYS_UPDATE_DATE", value);
									break;
								case 4 :
									poiMap.put("DIVISION_TYPE", value);
									break;
								case 5 :
									poiMap.put("USE_YN", value);
									break;
								case 6 :
									poiMap.put("DIVISION_LEADER", value);
									break;
								default : 
									break;
								}
							}
						}
					}
					list.add(poiMap);
				}
			}
		}
		//}
		fis.close();
		deleteExel(temp_file.getAbsolutePath());
		insertOurDivisionInfo(list);

		return list;
	}

	public List<Map<String, Object>> xlsxReadOurTeamInfo(Map<String, Object> map, HttpServletRequest request) throws Exception {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> poiMap = new HashMap<String, Object>();

		int excelForm = Integer.parseInt((String) map.get("form"));

		FileInputStream fis = null;
		XSSFWorkbook workbook = null;

		MultipartHttpServletRequest multi = (MultipartHttpServletRequest) request;
		MultipartFile file = multi.getFile("filePOI");

		String fileName = file.getOriginalFilename();
		//	    File temp_file = new File(fileName);
		File temp_file = new File(resultFilePath + fileName);

		if (temp_file.exists() == false) {
			// 없으면 생성
			temp_file.mkdirs();
		}

		file.transferTo(temp_file);

		fis = new FileInputStream(temp_file.getAbsolutePath());

		workbook = new XSSFWorkbook(fis);

		XSSFSheet curSheet;
		XSSFRow	curRow;
		XSSFCell curCell;

		//for(int sheetIndex = 0; sheetIndex < workbook.getNumberOfSheets(); sheetIndex++){
		//curSheet = workbook.getSheetAt(sheetIndex);
		curSheet = workbook.getSheetAt(excelForm);
		for(int rowIndex = 2; rowIndex < curSheet.getPhysicalNumberOfRows(); rowIndex++){
			if(rowIndex != 2){
				curRow = curSheet.getRow(rowIndex);
				String value;
				if(!"".equals(curRow.getCell(1).getRawValue()) && curRow.getCell(1).getRawValue() != null){
					poiMap = new HashMap<String, Object>();
					for(int cellIndex = 0; cellIndex < curRow.getPhysicalNumberOfCells(); cellIndex++){
						curCell = curRow.getCell(cellIndex);
						if(true){
							value = "";
							switch(curCell.getCellType()){
							case HSSFCell.CELL_TYPE_NUMERIC :
								value = curCell.getRawValue();
								//value = curCell.getNumericCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_STRING :
								value = curCell.getStringCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_FORMULA :
								value = curCell.getCellFormula();
								break;
							case HSSFCell.CELL_TYPE_BLANK :
								value = curCell.getBooleanCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_ERROR :
								value = curCell.getErrorCellValue()+"";
								break;
							default :
								value = "";
								break;
							}

							if(!value.equals("false")){
								switch(cellIndex) {
								case 0 :
									poiMap.put("TEAM_NO", value);
									break;
								case 1 :
									poiMap.put("TEAM_NAME", value);
									break;
								case 2 :
									poiMap.put("TEAM_LEADER", value);
									break;
								case 3 :
									poiMap.put("USE_YN", value);
									break;
								case 4 :
									poiMap.put("SYS_REGISTER_DATE", value);
									break;
								case 5 :
									poiMap.put("SYS_UPDATE_DATE", value);
									break;
								case 6 :
									poiMap.put("DIVISION_NO", value);
									break;
								case 7 :
									poiMap.put("TEAM_TYPE", value);
									break;
								default : 
									break;
								}
							}
						}
					}//cell for
					poiMap.put("creatorId", map.get("creatorId"));

					//insertOurMembersInfo(list);

					int insertExcel = insertOurTeamInfo(poiMap);
					int maxCellIndex = 8;
					String companyId = Integer.toString(KEY_ID); 
					String sheetFlag = "ourMemberTeam";

					//결과엑셀 상태 입력하기.
					outFileProcess(rowIndex, curSheet, maxCellIndex, workbook, temp_file, insertExcel, companyId, sheetFlag);
					//list.add(poiMap);
				}
			}
		}
		//}
		fis.close();
		//deleteExel(temp_file.getAbsolutePath());
		//insertOurTeamInfo(list);

		return list;
	}

	@SuppressWarnings({ "resource" })
	public List<Map<String, Object>> xlsReadOurTeamInfo(Map<String, Object> map, HttpServletRequest request) throws Exception {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> poiMap = new HashMap<String, Object>();

		int excelForm = Integer.parseInt((String) map.get("form"));

		FileInputStream fis = null;
		HSSFWorkbook workbook = null;

		MultipartHttpServletRequest multi = (MultipartHttpServletRequest) request;
		MultipartFile file = multi.getFile("filePOI");

		String fileName = file.getOriginalFilename();
		//	    File temp_file = new File(fileName);
		File temp_file = new File(resultFilePath + fileName);

		if (temp_file.exists() == false) {
			// 없으면 생성
			temp_file.mkdirs();
		}

		file.transferTo(temp_file);

		fis = new FileInputStream(temp_file.getAbsolutePath());

		workbook = new HSSFWorkbook(fis);

		HSSFSheet curSheet;
		HSSFRow	curRow;
		HSSFCell curCell;

		//for(int sheetIndex = 0; sheetIndex < workbook.getNumberOfSheets(); sheetIndex++){
		//curSheet = workbook.getSheetAt(sheetIndex);
		curSheet = workbook.getSheetAt(excelForm);
		for(int rowIndex = 2; rowIndex < curSheet.getPhysicalNumberOfRows(); rowIndex++){
			if(rowIndex != 2){
				curRow = curSheet.getRow(rowIndex);
				String value;
				if(!"".equals(curRow.getCell(1).getStringCellValue())){
					poiMap = new HashMap<String, Object>();
					for(int cellIndex = 0; cellIndex < curRow.getPhysicalNumberOfCells(); cellIndex++){
						curCell = curRow.getCell(cellIndex);
						if(true){
							value = "";
							switch(curCell.getCellType()){
							case HSSFCell.CELL_TYPE_NUMERIC :
								value = curCell.getNumericCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_STRING :
								value = curCell.getStringCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_FORMULA :
								value = curCell.getCellFormula();
								break;
							case HSSFCell.CELL_TYPE_BLANK :
								value = curCell.getBooleanCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_ERROR :
								value = curCell.getErrorCellValue()+"";
								break;
							default :
								value = new String();
								break;
							}

							if(!value.equals("false")){
								switch(cellIndex) {
								case 0 :
									poiMap.put("TEAM_NO", value);
									break;
								case 1 :
									poiMap.put("TEAM_NAME", value);
									break;
								case 2 :
									poiMap.put("TEAM_LEADER", value);
									break;
								case 3 :
									poiMap.put("USE_YN", value);
									break;
								case 4 :
									poiMap.put("SYS_REGISTER_DATE", value);
									break;
								case 5 :
									poiMap.put("SYS_UPDATE_DATE", value);
									break;
								case 6 :
									poiMap.put("DIVISION_NO", value);
									break;
								case 7 :
									poiMap.put("TEAM_TYPE", value);
									break;
								default : 
									break;
								}
							}
						}
					}
					list.add(poiMap);
				}
			}
		}
		//}
		fis.close();
		deleteExel(temp_file.getAbsolutePath());
		insertOurTeamInfo(list);

		return list;
	}

	public int xlsxReadPartnerCompanyInfo(Map<String, Object> map, HttpServletRequest request) throws Exception {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		int cnt = 0;
		Map<String, Object> poiMap = new HashMap<String, Object>();

		int excelForm = Integer.parseInt((String) map.get("form"));

		FileInputStream fis = null;
		XSSFWorkbook workbook = null;

		MultipartHttpServletRequest multi = (MultipartHttpServletRequest) request;
		MultipartFile file = multi.getFile("filePOI");

		String fileName = file.getOriginalFilename();
		//	    File temp_file = new File(fileName);
		File temp_file = new File(resultFilePath + fileName);

		if (temp_file.exists() == false) {
			// 없으면 생성
			temp_file.mkdirs();
		}

		file.transferTo(temp_file);

		fis = new FileInputStream(temp_file.getAbsolutePath());

		workbook = new XSSFWorkbook(fis);

		XSSFSheet curSheet;
		XSSFRow	curRow;
		XSSFCell curCell;

		//for(int sheetIndex = 0; sheetIndex < workbook.getNumberOfSheets(); sheetIndex++){
		//curSheet = workbook.getSheetAt(sheetIndex);
		curSheet = workbook.getSheetAt(excelForm);
		for(int rowIndex = 2; rowIndex < curSheet.getPhysicalNumberOfRows(); rowIndex++){
			if(rowIndex != 2){
				curRow = curSheet.getRow(rowIndex);
				String value;
				if(!"".equals(curRow.getCell(1).getRawValue()) && curRow.getCell(1).getRawValue() != null){
					poiMap = new HashMap<String, Object>();
					for(int cellIndex = 0; cellIndex < curRow.getPhysicalNumberOfCells(); cellIndex++){
						curCell = curRow.getCell(cellIndex);
						if(true){
							value = "";
							switch(curCell.getCellType()){
							case HSSFCell.CELL_TYPE_NUMERIC :
								value = curCell.getRawValue();
								//value = curCell.getNumericCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_STRING :
								value = curCell.getStringCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_FORMULA :
								value = curCell.getCellFormula();
								break;
							case HSSFCell.CELL_TYPE_BLANK :
								value = curCell.getBooleanCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_ERROR :
								value = curCell.getErrorCellValue()+"";
								break;
							default :
								value = "";
								break;
							}

							if(!value.equals("false")){
								switch(cellIndex) {
								case 0 :
									poiMap.put("PARTNER_ID", value);
									break;
								case 1 :
									poiMap.put("PARTNER_CODE", value);
									break;
								case 2 :
									poiMap.put("COMPANY_NAME", value);
									break;
								case 3 :
									poiMap.put("CEO_NAME", value);
									break;
								case 4 :
									poiMap.put("COMPANY_TELNO", value);
									break;
								case 5 :
									poiMap.put("POSTAL_CODE", value);
									break;
								case 6 :
									poiMap.put("POSTAL_ADDRESS", value);
									break;
								case 7 :
									poiMap.put("BUSINESS_NUMBER", value);
									break;
								case 8 :
									poiMap.put("BUSINESS_TYPE", value);
									break;
								case 9 :
									poiMap.put("BUSINESS_SECTOR", value);
									break;
								case 10 :
									poiMap.put("COMPANY_STATUS", value);
									break;
								case 11 :
									poiMap.put("SYS_REGISTER_DATE", value);
									break;
								case 12 :
									poiMap.put("SYS_UPDATE_DATE", value);
									break;
								case 13 :
									poiMap.put("COMPANY_ENNAME", value);
									break;
								case 14 :
									poiMap.put("CEO_ID", value);
									break;
								case 15:
									poiMap.put("PARTNER_CATEGORY", value);
									break;
								case 16:
									poiMap.put("COMPANY_ITEM", value);
									break;
								case 17:
									poiMap.put("COMPANY_HOMEPAGE", value);
									break;
								case 18:
									poiMap.put("COMPANY_FAXNO", value);
									break;
								default : 
									break;
								}
							}
						}
					}//cell for

					//int insertExcel = insertPartnerIndividualInfo(poiMap);
					int insertExcel = insertPartnerCompanyInfo(poiMap);
					cnt = insertExcel;

					int maxCellIndex = 19;
					String companyId = Integer.toString(KEY_ID); 
					String sheetFlag = "partnerCompany";

					//결과엑셀 상태 입력하기.
					outFileProcess(rowIndex, curSheet, maxCellIndex, workbook, temp_file, insertExcel, companyId, sheetFlag);
					//list.add(poiMap);
				}
			}
		}
		//}
		fis.close();
		//deleteExel(temp_file.getAbsolutePath());
		//insertPartnerCompanyInfo(list);

		return cnt;
	}

	@SuppressWarnings({ "resource" })
	public List<Map<String, Object>> xlsReadPartnerCompanyInfo(Map<String, Object> map, HttpServletRequest request) throws Exception {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> poiMap = new HashMap<String, Object>();

		int excelForm = Integer.parseInt((String) map.get("form"));

		FileInputStream fis = null;
		HSSFWorkbook workbook = null;

		MultipartHttpServletRequest multi = (MultipartHttpServletRequest) request;
		MultipartFile file = multi.getFile("filePOI");

		String fileName = file.getOriginalFilename();
		//	    File temp_file = new File(fileName);

		File temp_file = new File(resultFilePath + fileName);

		if (temp_file.exists() == false) {
			// 없으면 생성
			temp_file.mkdirs();
		}

		file.transferTo(temp_file);

		fis = new FileInputStream(temp_file.getAbsolutePath());

		workbook = new HSSFWorkbook(fis);

		HSSFSheet curSheet;
		HSSFRow	curRow;
		HSSFCell curCell;

		//for(int sheetIndex = 0; sheetIndex < workbook.getNumberOfSheets(); sheetIndex++){
		//curSheet = workbook.getSheetAt(sheetIndex);
		curSheet = workbook.getSheetAt(excelForm);
		for(int rowIndex = 2; rowIndex < curSheet.getPhysicalNumberOfRows(); rowIndex++){
			if(rowIndex != 2){
				curRow = curSheet.getRow(rowIndex);
				String value;
				if(!"".equals(curRow.getCell(1).getStringCellValue())){
					poiMap = new HashMap<String, Object>();
					for(int cellIndex = 0; cellIndex < curRow.getPhysicalNumberOfCells(); cellIndex++){
						curCell = curRow.getCell(cellIndex);
						if(true){
							value = "";
							switch(curCell.getCellType()){
							case HSSFCell.CELL_TYPE_NUMERIC :
								value = curCell.getNumericCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_STRING :
								value = curCell.getStringCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_FORMULA :
								value = curCell.getCellFormula();
								break;
							case HSSFCell.CELL_TYPE_BLANK :
								value = curCell.getBooleanCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_ERROR :
								value = curCell.getErrorCellValue()+"";
								break;
							default :
								value = new String();
								break;
							}

							if(!value.equals("false")){
								switch(cellIndex) {
								case 0 :
									poiMap.put("PARTNER_ID", value);
									break;
								case 1 :
									poiMap.put("PARTNER_CODE", value);
									break;
								case 2 :
									poiMap.put("COMPANY_NAME", value);
									break;
								case 3 :
									poiMap.put("CEO_NAME", value);
									break;
								case 4 :
									poiMap.put("COMPANY_TELNO", value);
									break;
								case 5 :
									poiMap.put("POSTAL_CODE", value);
									break;
								case 6 :
									poiMap.put("POSTAL_ADDRESS", value);
									break;
								case 7 :
									poiMap.put("BUSINESS_NUMBER", value);
									break;
								case 8 :
									poiMap.put("BUSINESS_TYPE", value);
									break;
								case 9 :
									poiMap.put("BUSINESS_SECTOR", value);
									break;
								case 10 :
									poiMap.put("COMPANY_STATUS", value);
									break;
								case 11 :
									poiMap.put("SYS_REGISTER_DATE", value);
									break;
								case 12 :
									poiMap.put("SYS_UPDATE_DATE", value);
									break;
								case 13 :
									poiMap.put("company_enname", value);
									break;
								case 14 :
									poiMap.put("CEO_ID", value);
									break;
								default : 
									break;
								}
							}
						}
					}
					list.add(poiMap);
				}
			}
		}
		//}
		fis.close();
		deleteExel(temp_file.getAbsolutePath());
		insertPartnerCompanyInfo(list);

		return list;
	}

	public int xlsxReadPartnerIndividualInfo(Map<String, Object> map, HttpServletRequest request) throws Exception {
		int cnt =0;
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> poiMap = new HashMap<String, Object>();

		int excelForm = Integer.parseInt((String) map.get("form"));

		FileInputStream fis = null;
		XSSFWorkbook workbook = null;

		MultipartHttpServletRequest multi = (MultipartHttpServletRequest) request;
		MultipartFile file = multi.getFile("filePOI");

		String fileName = file.getOriginalFilename();
		//	    File temp_file = new File(fileName);
		File temp_file = new File(resultFilePath + fileName);

		if (temp_file.exists() == false) {
			// 없으면 생성
			temp_file.mkdirs();
		}

		file.transferTo(temp_file);

		fis = new FileInputStream(temp_file.getAbsolutePath());

		workbook = new XSSFWorkbook(fis);

		XSSFSheet curSheet;
		XSSFRow	curRow;
		XSSFCell curCell;

		//for(int sheetIndex = 0; sheetIndex < workbook.getNumberOfSheets(); sheetIndex++){
		//curSheet = workbook.getSheetAt(sheetIndex);
		curSheet = workbook.getSheetAt(excelForm);
		for(int rowIndex = 2; rowIndex < curSheet.getPhysicalNumberOfRows(); rowIndex++){
			if(rowIndex != 2){
				curRow = curSheet.getRow(rowIndex);
				String value;
				if(!"".equals(curRow.getCell(1).getRawValue()) && curRow.getCell(1).getRawValue() != null){
					poiMap = new HashMap<String, Object>();
					for(int cellIndex = 0; cellIndex < curRow.getPhysicalNumberOfCells(); cellIndex++){
						curCell = curRow.getCell(cellIndex);
						if(true){
							value = "";
							switch(curCell.getCellType()){
							case HSSFCell.CELL_TYPE_NUMERIC :
								value = curCell.getRawValue();
								//value = curCell.getNumericCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_STRING :
								value = curCell.getStringCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_FORMULA :
								value = curCell.getCellFormula();
								break;
							case HSSFCell.CELL_TYPE_BLANK :
								value = curCell.getBooleanCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_ERROR :
								value = curCell.getErrorCellValue()+"";
								break;
							default :
								value = "";
								break;
							}

							if(!value.equals("false")){
								switch(cellIndex) {
								case 0 :
									poiMap.put("PARTNER_INDIVIDUAL_ID", value);
									break;
								case 1 :
									poiMap.put("PARTNER_ID", value);
									break;
								case 2 :
									poiMap.put("PARTNER_PERSONAL_NAME", value);
									break;
								case 3 :
									poiMap.put("DIVISION", value);
									break;
								case 4 :
									poiMap.put("POST", value);
									break;
								case 5 :
									poiMap.put("TEAM", value);
									break;
								case 6 :
									poiMap.put("POSITION", value);
									break;
								case 7 :
									poiMap.put("SKILL_TYPE", value);
									break;
								case 8 :
									poiMap.put("DUTY", value);
									break;
								case 9 :
									poiMap.put("CELL_PHONE", value);
									break;
								case 10 :
									poiMap.put("PHONE", value);
									break;
								case 11 :
									poiMap.put("EMAIL", value);
									break;
								case 12 :
									poiMap.put("FRIENDSHIP_COMPANY", value);
									break;
								case 13 :
									poiMap.put("FRIENDSHIP_CUSTOMER", value);
									break;
								case 14 :
									poiMap.put("PERSONAL_INFO", value);
									break;
								case 15 :
									poiMap.put("PERSONAL_PHOTO", value);
									break;
								case 16 :
									poiMap.put("PHOTO_TYPE", value);
									break;
								case 17 :
									poiMap.put("FRIENDSHIP_INFO", value);
									break;
								case 18 :
									poiMap.put("SYS_REGISTER_DATE", value);
									break;
								case 19 :
									poiMap.put("SYS_UPDATE_DATE", value);
									break;
								case 20 :
									poiMap.put("CREATOR_ID", value);
									break;
								case 21 :
									poiMap.put("USE_YN", value);
									break;
								case 22 :
									poiMap.put("POSITION_DUTY", value);
									break;
								case 23 :
									poiMap.put("INSERT_FLAG", value);
									break;
								default : 
									break;
								}
							}
						}
					}//cell for

					//int insertExcel = insertClientCompanyInfo(poiMap);
					int insertExcel = insertPartnerIndividualInfo(poiMap);
					cnt = insertExcel;

					int maxCellIndex = 24;
					String companyId = Integer.toString(KEY_ID); 
					String sheetFlag = "partnerIndividual";

					//결과엑셀 상태 입력하기.
					outFileProcess(rowIndex, curSheet, maxCellIndex, workbook, temp_file, insertExcel, companyId, sheetFlag);

					//list.add(poiMap);
				}
			}
		}
		//}
		fis.close();
		//deleteExel(temp_file.getAbsolutePath());
		//insertPartnerIndividualInfo(list);

		return cnt;
	}

	@SuppressWarnings({ "resource" })
	public List<Map<String, Object>> xlsReadPartnerIndividualInfo(Map<String, Object> map, HttpServletRequest request) throws Exception {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> poiMap = new HashMap<String, Object>();

		int excelForm = Integer.parseInt((String) map.get("form"));

		FileInputStream fis = null;
		HSSFWorkbook workbook = null;

		MultipartHttpServletRequest multi = (MultipartHttpServletRequest) request;
		MultipartFile file = multi.getFile("filePOI");

		String fileName = file.getOriginalFilename();
		//	    File temp_file = new File(fileName);

		File temp_file = new File(resultFilePath + fileName);

		if (temp_file.exists() == false) {
			// 없으면 생성
			temp_file.mkdirs();
		}

		file.transferTo(temp_file);

		fis = new FileInputStream(temp_file.getAbsolutePath());

		workbook = new HSSFWorkbook(fis);

		HSSFSheet curSheet;
		HSSFRow	curRow;
		HSSFCell curCell;

		//for(int sheetIndex = 0; sheetIndex < workbook.getNumberOfSheets(); sheetIndex++){
		//curSheet = workbook.getSheetAt(sheetIndex);
		curSheet = workbook.getSheetAt(excelForm);
		for(int rowIndex = 2; rowIndex < curSheet.getPhysicalNumberOfRows(); rowIndex++){
			if(rowIndex != 2){
				curRow = curSheet.getRow(rowIndex);
				String value;
				if(!"".equals(curRow.getCell(1).getStringCellValue())){
					poiMap = new HashMap<String, Object>();
					for(int cellIndex = 0; cellIndex < curRow.getPhysicalNumberOfCells(); cellIndex++){
						curCell = curRow.getCell(cellIndex);
						if(true){
							value = "";
							switch(curCell.getCellType()){
							case HSSFCell.CELL_TYPE_NUMERIC :
								value = curCell.getNumericCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_STRING :
								value = curCell.getStringCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_FORMULA :
								value = curCell.getCellFormula();
								break;
							case HSSFCell.CELL_TYPE_BLANK :
								value = curCell.getBooleanCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_ERROR :
								value = curCell.getErrorCellValue()+"";
								break;
							default :
								value = new String();
								break;
							}

							if(!value.equals("false")){
								switch(cellIndex) {
								case 0 :
									poiMap.put("PARTNER_INDIVIDUAL_ID", value);
									break;
								case 1 :
									poiMap.put("COMPANY_NAME", value);
									break;
								case 2 :
									poiMap.put("PARTNER_PERSONAL_NAME", value);
									break;
								case 3 :
									poiMap.put("DIVISION", value);
									break;
								case 4 :
									poiMap.put("POST", value);
									break;
								case 5 :
									poiMap.put("TEAM", value);
									break;
								case 6 :
									poiMap.put("POSITION", value);
									break;
								case 7 :
									poiMap.put("SKILL_TYPE", value);
									break;
								case 8 :
									poiMap.put("DUTY", value);
									break;
								case 9 :
									poiMap.put("CELL_PHONE", value);
									break;
								case 10 :
									poiMap.put("PHONE", value);
									break;
								case 11 :
									poiMap.put("EMAIL", value);
									break;
								case 12 :
									poiMap.put("FRIENDSHIP_COMPANY", value);
									break;
								case 13 :
									poiMap.put("FRIENDSHIP_CUSTOMER", value);
									break;
								case 14 :
									poiMap.put("PERSONAL_INFO", value);
									break;
								case 15 :
									poiMap.put("PERSONAL_PHOTO", value);
									break;
								case 16 :
									poiMap.put("PHOTO_TYPE", value);
									break;
								case 17 :
									poiMap.put("FRIENDSHIP_INFO", value);
									break;
								case 18 :
									poiMap.put("SYS_REGISTER_DATE", value);
									break;
								case 19 :
									poiMap.put("SYS_UPDATE_DATE", value);
									break;
								case 20 :
									poiMap.put("CREATOR_ID", value);
									break;
								default : 
									break;
								}
							}
						}
					}
					list.add(poiMap);
				}
			}
		}
		//}
		fis.close();
		deleteExel(temp_file.getAbsolutePath());
		insertPartnerIndividualInfo(list);

		return list;
	}

	@SuppressWarnings({ "resource" })
	public List<Map<String, Object>> xlsxReadCodeIndustrySegment(Map<String, Object> map, HttpServletRequest request) throws Exception {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> poiMap = new HashMap<String, Object>();

		int excelForm = Integer.parseInt((String) map.get("form"));

		FileInputStream fis = null;
		XSSFWorkbook workbook = null;

		MultipartHttpServletRequest multi = (MultipartHttpServletRequest) request;
		MultipartFile file = multi.getFile("filePOI");

		String fileName = file.getOriginalFilename();
		//	    File temp_file = new File(fileName);

		//	    File temp_file = new File(resultFilePath + fileName);

		File temp_file = new File(resultFilePath + fileName);

		if (temp_file.exists() == false) {
			// 없으면 생성
			temp_file.mkdirs();
		}

		if (temp_file.exists() == false) {
			// 없으면 생성
			temp_file.mkdirs();
		}

		file.transferTo(temp_file);

		fis = new FileInputStream(temp_file.getAbsolutePath());

		workbook = new XSSFWorkbook(fis);

		XSSFSheet curSheet;
		XSSFRow	curRow;
		XSSFCell curCell;

		//for(int sheetIndex = 0; sheetIndex < workbook.getNumberOfSheets(); sheetIndex++){
		//curSheet = workbook.getSheetAt(sheetIndex);
		curSheet = workbook.getSheetAt(excelForm);
		for(int rowIndex = 2; rowIndex < curSheet.getPhysicalNumberOfRows(); rowIndex++){
			if(rowIndex != 2){
				curRow = curSheet.getRow(rowIndex);
				String value;
				if(!"".equals(curRow.getCell(1).getRawValue()) && curRow.getCell(1).getRawValue() != null){
					poiMap = new HashMap<String, Object>();
					for(int cellIndex = 0; cellIndex < curRow.getPhysicalNumberOfCells(); cellIndex++){
						curCell = curRow.getCell(cellIndex);
						if(true){
							value = "";
							switch(curCell.getCellType()){
							case HSSFCell.CELL_TYPE_NUMERIC :
								value = curCell.getRawValue();
								//value = curCell.getNumericCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_STRING :
								value = curCell.getStringCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_FORMULA :
								value = curCell.getCellFormula();
								break;
							case HSSFCell.CELL_TYPE_BLANK :
								value = curCell.getBooleanCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_ERROR :
								value = curCell.getErrorCellValue()+"";
								break;
							default :
								value = "";
								break;
							}

							if(!value.equals("false")){
								switch(cellIndex) {
								case 0 :
									poiMap.put("SEGMENT_CODE", value);
									break;
								case 1 :
									poiMap.put("SEGMENT_HAN_NAME", value);
									break;
								case 2 :
									poiMap.put("SEGMENT_ENG_NAME", value);
									break;
								default : 
									break;
								}
							}
						}
					}
					list.add(poiMap);
				}
			}
		}
		//}
		fis.close();
		deleteExel(temp_file.getAbsolutePath());
		insertCodeIndustrySegment(list);

		return list;
	}

	@SuppressWarnings({ "resource" })
	public List<Map<String, Object>> xlsReadCodeIndustrySegment(Map<String, Object> map, HttpServletRequest request) throws Exception {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> poiMap = new HashMap<String, Object>();

		int excelForm = Integer.parseInt((String) map.get("form"));

		FileInputStream fis = null;
		HSSFWorkbook workbook = null;

		MultipartHttpServletRequest multi = (MultipartHttpServletRequest) request;
		MultipartFile file = multi.getFile("filePOI");

		String fileName = file.getOriginalFilename();
		//	    File temp_file = new File(fileName);

		File temp_file = new File(resultFilePath + fileName);

		if (temp_file.exists() == false) {
			// 없으면 생성
			temp_file.mkdirs();
		}

		file.transferTo(temp_file);

		fis = new FileInputStream(temp_file.getAbsolutePath());

		workbook = new HSSFWorkbook(fis);

		HSSFSheet curSheet;
		HSSFRow	curRow;
		HSSFCell curCell;

		//for(int sheetIndex = 0; sheetIndex < workbook.getNumberOfSheets(); sheetIndex++){
		//curSheet = workbook.getSheetAt(sheetIndex);
		curSheet = workbook.getSheetAt(excelForm);
		for(int rowIndex = 2; rowIndex < curSheet.getPhysicalNumberOfRows(); rowIndex++){
			if(rowIndex != 2){
				curRow = curSheet.getRow(rowIndex);
				String value;
				if(!"".equals(curRow.getCell(1).getStringCellValue())){
					poiMap = new HashMap<String, Object>();
					for(int cellIndex = 0; cellIndex < curRow.getPhysicalNumberOfCells(); cellIndex++){
						curCell = curRow.getCell(cellIndex);
						if(true){
							value = "";
							switch(curCell.getCellType()){
							case HSSFCell.CELL_TYPE_NUMERIC :
								value = curCell.getNumericCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_STRING :
								value = curCell.getStringCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_FORMULA :
								value = curCell.getCellFormula();
								break;
							case HSSFCell.CELL_TYPE_BLANK :
								value = curCell.getBooleanCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_ERROR :
								value = curCell.getErrorCellValue()+"";
								break;
							default :
								value = new String();
								break;
							}

							if(!value.equals("false")){
								switch(cellIndex) {
								case 0 :
									poiMap.put("SEGMENT_CODE", value);
									break;
								case 1 :
									poiMap.put("SEGMENT_HAN_NAME", value);
									break;
								case 2 :
									poiMap.put("SEGMENT_ENG_NAME", value);
									break;
								default : 
									break;
								}
							}
						}
					}
					list.add(poiMap);
				}
			}
		}
		//}
		fis.close();
		deleteExel(temp_file.getAbsolutePath());
		insertCodeIndustrySegment(list);

		return list;
	}

	public List<Map<String, Object>> xlsxReadCodePartnerSegment(Map<String, Object> map, HttpServletRequest request) throws Exception {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> poiMap = new HashMap<String, Object>();

		int excelForm = Integer.parseInt((String) map.get("form"));

		FileInputStream fis = null;
		XSSFWorkbook workbook = null;

		MultipartHttpServletRequest multi = (MultipartHttpServletRequest) request;
		MultipartFile file = multi.getFile("filePOI");

		String fileName = file.getOriginalFilename();
		//	    File temp_file = new File(fileName);

		File temp_file = new File(resultFilePath + fileName);

		if (temp_file.exists() == false) {
			// 없으면 생성
			temp_file.mkdirs();
		}

		file.transferTo(temp_file);

		fis = new FileInputStream(temp_file.getAbsolutePath());

		workbook = new XSSFWorkbook(fis);

		XSSFSheet curSheet;
		XSSFRow	curRow;
		XSSFCell curCell;

		//for(int sheetIndex = 0; sheetIndex < workbook.getNumberOfSheets(); sheetIndex++){
		//curSheet = workbook.getSheetAt(sheetIndex);
		curSheet = workbook.getSheetAt(excelForm);
		for(int rowIndex = 2; rowIndex < curSheet.getPhysicalNumberOfRows(); rowIndex++){
			if(rowIndex != 2){
				curRow = curSheet.getRow(rowIndex);
				String value;
				if(!"".equals(curRow.getCell(1).getRawValue()) && curRow.getCell(1).getRawValue() != null){
					poiMap = new HashMap<String, Object>();
					for(int cellIndex = 0; cellIndex < curRow.getPhysicalNumberOfCells(); cellIndex++){
						curCell = curRow.getCell(cellIndex);
						if(true){
							value = "";
							switch(curCell.getCellType()){
							case HSSFCell.CELL_TYPE_NUMERIC :
								value = curCell.getRawValue();
								//value = curCell.getNumericCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_STRING :
								value = curCell.getStringCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_FORMULA :
								value = curCell.getCellFormula();
								break;
							case HSSFCell.CELL_TYPE_BLANK :
								value = curCell.getBooleanCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_ERROR :
								value = curCell.getErrorCellValue()+"";
								break;
							default :
								value = "";
								break;
							}

							if(!value.equals("false")){
								switch(cellIndex) {
								case 0 :
									poiMap.put("PARTNER_CODE", value);
									break;
								case 1 :
									poiMap.put("PARTNER_LEVEL", value);
									break;
								case 2 :
									poiMap.put("PARTNER_DETAIL", value);
									break;
								case 3 :
									poiMap.put("SYS_REGISTER_DATE", value);
									break;
								case 4 :
									poiMap.put("SYS_UPDATE_DATE", value);
									break;
								case 5 :
									poiMap.put("USE_YN", value);
								default : 
									break;
								}
							}
						}
					}//cell for

					//Map<String, Object> selectMap = poiDAO.selectCodePartnerSegment(poiMap);
					int insertExcel = 0;
					try{
						poiDAO.insertCodePartnerSegment(poiMap);
						int maxCellIndex = 6;
						String companyId = Integer.toString(KEY_ID); 
						String sheetFlag = "partnerSegment";

						//결과엑셀 상태 입력하기.
						outFileProcess(rowIndex, curSheet, maxCellIndex, workbook, temp_file, insertExcel, companyId, sheetFlag);

					}catch(Exception t){
						insertExcel = -2;
						int maxCellIndex = 6;
						String companyId = Integer.toString(KEY_ID); 
						String sheetFlag = "partnerSegment";

						//결과엑셀 상태 입력하기.
						outFileProcess(rowIndex, curSheet, maxCellIndex, workbook, temp_file, insertExcel, companyId, sheetFlag);
						continue;
					}

					//list.add(poiMap);
				}
			}
		}
		//}
		fis.close();
		//deleteExel(temp_file.getAbsolutePath());
		//insertCodePartnerSegment(list);

		return list;
	}

	@SuppressWarnings({ "resource" })
	public List<Map<String, Object>> xlsReadCodePartnerSegment(Map<String, Object> map, HttpServletRequest request) throws Exception {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> poiMap = new HashMap<String, Object>();

		int excelForm = Integer.parseInt((String) map.get("form"));

		FileInputStream fis = null;
		HSSFWorkbook workbook = null;

		MultipartHttpServletRequest multi = (MultipartHttpServletRequest) request;
		MultipartFile file = multi.getFile("filePOI");

		String fileName = file.getOriginalFilename();
		//	    File temp_file = new File(fileName);

		File temp_file = new File(resultFilePath + fileName);

		if (temp_file.exists() == false) {
			// 없으면 생성
			temp_file.mkdirs();
		}

		file.transferTo(temp_file);

		fis = new FileInputStream(temp_file.getAbsolutePath());

		workbook = new HSSFWorkbook(fis);

		HSSFSheet curSheet;
		HSSFRow	curRow;
		HSSFCell curCell;

		//for(int sheetIndex = 0; sheetIndex < workbook.getNumberOfSheets(); sheetIndex++){
		//curSheet = workbook.getSheetAt(sheetIndex);
		curSheet = workbook.getSheetAt(excelForm);
		for(int rowIndex = 2; rowIndex < curSheet.getPhysicalNumberOfRows(); rowIndex++){
			if(rowIndex != 2){
				curRow = curSheet.getRow(rowIndex);
				String value;
				if(!"".equals(curRow.getCell(1).getStringCellValue())){
					poiMap = new HashMap<String, Object>();
					for(int cellIndex = 0; cellIndex < curRow.getPhysicalNumberOfCells(); cellIndex++){
						curCell = curRow.getCell(cellIndex);
						if(true){
							value = "";
							switch(curCell.getCellType()){
							case HSSFCell.CELL_TYPE_NUMERIC :
								value = curCell.getNumericCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_STRING :
								value = curCell.getStringCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_FORMULA :
								value = curCell.getCellFormula();
								break;
							case HSSFCell.CELL_TYPE_BLANK :
								value = curCell.getBooleanCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_ERROR :
								value = curCell.getErrorCellValue()+"";
								break;
							default :
								value = new String();
								break;
							}

							if(!value.equals("false")){
								switch(cellIndex) {
								case 0 :
									poiMap.put("PARTNER_CODE", value);
									break;
								case 1 :
									poiMap.put("PARTNER_LEVEL", value);
									break;
								case 2 :
									poiMap.put("PARTNER_DETAIL", value);
									break;
								default : 
									break;
								}
							}
						}
					}
					list.add(poiMap);
				}
			}
		}
		//}
		fis.close();
		deleteExel(temp_file.getAbsolutePath());
		insertCodePartnerSegment(list);

		return list;
	}

	@SuppressWarnings({ "resource" })
	public List<Map<String, Object>> xlsxReadVendorSolutionArea(Map<String, Object> map, HttpServletRequest request) throws Exception {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> poiMap = new HashMap<String, Object>();

		int excelForm = Integer.parseInt((String) map.get("form"));

		FileInputStream fis = null;
		XSSFWorkbook workbook = null;

		MultipartHttpServletRequest multi = (MultipartHttpServletRequest) request;
		MultipartFile file = multi.getFile("filePOI");

		String fileName = file.getOriginalFilename();
		//	    File temp_file = new File(fileName);
		File temp_file = new File(resultFilePath + fileName);

		if (temp_file.exists() == false) {
			// 없으면 생성
			temp_file.mkdirs();
		}

		file.transferTo(temp_file);

		fis = new FileInputStream(temp_file.getAbsolutePath());

		workbook = new XSSFWorkbook(fis);

		XSSFSheet curSheet;
		XSSFRow	curRow;
		XSSFCell curCell;

		//for(int sheetIndex = 0; sheetIndex < workbook.getNumberOfSheets(); sheetIndex++){
		//curSheet = workbook.getSheetAt(sheetIndex);
		curSheet = workbook.getSheetAt(excelForm);
		for(int rowIndex = 2; rowIndex < curSheet.getPhysicalNumberOfRows(); rowIndex++){
			if(rowIndex != 2){
				curRow = curSheet.getRow(rowIndex);
				String value;
				if(!"".equals(curRow.getCell(1).getRawValue()) && curRow.getCell(1).getRawValue() != null){
					poiMap = new HashMap<String, Object>();
					for(int cellIndex = 0; cellIndex < curRow.getPhysicalNumberOfCells(); cellIndex++){
						curCell = curRow.getCell(cellIndex);
						if(true){
							value = "";
							switch(curCell.getCellType()){
							case HSSFCell.CELL_TYPE_NUMERIC :
								value = curCell.getRawValue();
								//value = curCell.getNumericCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_STRING :
								value = curCell.getStringCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_FORMULA :
								value = curCell.getCellFormula();
								break;
							case HSSFCell.CELL_TYPE_BLANK :
								value = curCell.getBooleanCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_ERROR :
								value = curCell.getErrorCellValue()+"";
								break;
							default :
								value = "";
								break;
							}

							if(!value.equals("false")){
								switch(cellIndex) {
								case 0 :
									poiMap.put("SOLUTION_ID", value);
									break;
								case 1 :
									poiMap.put("PRODUCT_VENDOR", value);
									break;
								case 2 :
									poiMap.put("PRODUCT_GROUP", value);
									break;
								case 3 :
									poiMap.put("SOLUTION_AREA", value);
									break;
								default : 
									break;
								}
							}
						}
					}
					list.add(poiMap);
				}
			}
		}
		//}
		fis.close();
		deleteExel(temp_file.getAbsolutePath());
		insertVendorSolutionArea(list);

		return list;
	}

	@SuppressWarnings({ "resource" })
	public List<Map<String, Object>> xlsReadVendorSolutionArea(Map<String, Object> map, HttpServletRequest request) throws Exception {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> poiMap = new HashMap<String, Object>();

		int excelForm = Integer.parseInt((String) map.get("form"));

		FileInputStream fis = null;
		HSSFWorkbook workbook = null;

		MultipartHttpServletRequest multi = (MultipartHttpServletRequest) request;
		MultipartFile file = multi.getFile("filePOI");

		String fileName = file.getOriginalFilename();
		//	    File temp_file = new File(fileName);
		File temp_file = new File(resultFilePath + fileName);

		if (temp_file.exists() == false) {
			// 없으면 생성
			temp_file.mkdirs();
		}

		file.transferTo(temp_file);

		fis = new FileInputStream(temp_file.getAbsolutePath());

		workbook = new HSSFWorkbook(fis);

		HSSFSheet curSheet;
		HSSFRow	curRow;
		HSSFCell curCell;

		//for(int sheetIndex = 0; sheetIndex < workbook.getNumberOfSheets(); sheetIndex++){
		//curSheet = workbook.getSheetAt(sheetIndex);
		curSheet = workbook.getSheetAt(excelForm);
		for(int rowIndex = 2; rowIndex < curSheet.getPhysicalNumberOfRows(); rowIndex++){
			if(rowIndex != 2){
				curRow = curSheet.getRow(rowIndex);
				String value;
				if(!"".equals(curRow.getCell(1).getStringCellValue())){
					poiMap = new HashMap<String, Object>();
					for(int cellIndex = 0; cellIndex < curRow.getPhysicalNumberOfCells(); cellIndex++){
						curCell = curRow.getCell(cellIndex);
						if(true){
							value = "";
							switch(curCell.getCellType()){
							case HSSFCell.CELL_TYPE_NUMERIC :
								value = curCell.getNumericCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_STRING :
								value = curCell.getStringCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_FORMULA :
								value = curCell.getCellFormula();
								break;
							case HSSFCell.CELL_TYPE_BLANK :
								value = curCell.getBooleanCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_ERROR :
								value = curCell.getErrorCellValue()+"";
								break;
							default :
								value = new String();
								break;
							}

							if(!value.equals("false")){
								switch(cellIndex) {
								case 0 :
									poiMap.put("SOLUTION_ID", value);
									break;
								case 1 :
									poiMap.put("PRODUCT_VENDOR", value);
									break;
								case 2 :
									poiMap.put("PRODUCT_GROUP", value);
									break;
								case 3 :
									poiMap.put("SOLUTION_AREA", value);
									break;
								default : 
									break;
								}
							}
						}
					}
					list.add(poiMap);
				}
			}
		}
		//}
		fis.close();
		deleteExel(temp_file.getAbsolutePath());
		insertVendorSolutionArea(list);

		return list;
	}

	@SuppressWarnings({ "resource" })
	public List<Map<String, Object>> xlsxReadErpCompanyCredit(Map<String, Object> map, HttpServletRequest request) throws Exception {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> poiMap = new HashMap<String, Object>();

		int excelForm = Integer.parseInt((String) map.get("form"));

		FileInputStream fis = null;
		XSSFWorkbook workbook = null;

		MultipartHttpServletRequest multi = (MultipartHttpServletRequest) request;
		MultipartFile file = multi.getFile("filePOI");

		String fileName = file.getOriginalFilename();
		//	    File temp_file = new File(fileName);
		File temp_file = new File(resultFilePath + fileName);

		if (temp_file.exists() == false) {
			// 없으면 생성
			temp_file.mkdirs();
		}

		file.transferTo(temp_file);

		fis = new FileInputStream(temp_file.getAbsolutePath());

		workbook = new XSSFWorkbook(fis);

		XSSFSheet curSheet;
		XSSFRow	curRow;
		XSSFCell curCell;

		//for(int sheetIndex = 0; sheetIndex < workbook.getNumberOfSheets(); sheetIndex++){
		//curSheet = workbook.getSheetAt(sheetIndex);
		curSheet = workbook.getSheetAt(excelForm);
		for(int rowIndex = 2; rowIndex < curSheet.getPhysicalNumberOfRows(); rowIndex++){
			if(rowIndex != 2){
				curRow = curSheet.getRow(rowIndex);
				String value;
				if(!"".equals(curRow.getCell(1).getRawValue()) && curRow.getCell(1).getRawValue() != null){
					poiMap = new HashMap<String, Object>();
					for(int cellIndex = 0; cellIndex < curRow.getPhysicalNumberOfCells(); cellIndex++){
						curCell = curRow.getCell(cellIndex);
						if(true){
							value = "";
							switch(curCell.getCellType()){
							case HSSFCell.CELL_TYPE_NUMERIC :
								value = curCell.getRawValue();
								//value = curCell.getNumericCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_STRING :
								value = curCell.getStringCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_FORMULA :
								value = curCell.getCellFormula();
								break;
							case HSSFCell.CELL_TYPE_BLANK :
								value = curCell.getBooleanCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_ERROR :
								value = curCell.getErrorCellValue()+"";
								break;
							default :
								value = "";
								break;
							}

							if(!value.equals("false")){
								switch(cellIndex) {
								case 0 :
									poiMap.put("COMPANY_CODE", value);
									break;
								case 1 :
									poiMap.put("COMPANY_NAME", value);
									break;
								case 2 :
									poiMap.put("BUSINESS_NUMBER", value);
									break;
								case 3 :
									poiMap.put("LOAN_GRADE", value);
									break;
								case 4 :
									poiMap.put("CREDIT_AMOUNT", value);
									break;
								case 5 :
									poiMap.put("BUSINESS_STATUS", value);
									break;
								case 6 :
									poiMap.put("AUDIT_OPINION", value);
									break;
								case 7 :
									poiMap.put("CREDIT_GRADE", value);
									break;
								case 8 :
									poiMap.put("CASH_FLOW", value);
									break;
								default : 
									break;
								}
							}
						}
					}
					list.add(poiMap);
				}
			}
		}
		//}
		fis.close();
		deleteExel(temp_file.getAbsolutePath());
		insertErpCompanyCredit(list);

		return list;
	}

	@SuppressWarnings({ "resource" })
	public List<Map<String, Object>> xlsReadErpCompanyCredit(Map<String, Object> map, HttpServletRequest request) throws Exception {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> poiMap = new HashMap<String, Object>();

		int excelForm = Integer.parseInt((String) map.get("form"));

		FileInputStream fis = null;
		HSSFWorkbook workbook = null;

		MultipartHttpServletRequest multi = (MultipartHttpServletRequest) request;
		MultipartFile file = multi.getFile("filePOI");

		String fileName = file.getOriginalFilename();
		//	    File temp_file = new File(fileName);
		File temp_file = new File(resultFilePath + fileName);

		if (temp_file.exists() == false) {
			// 없으면 생성
			temp_file.mkdirs();
		}

		file.transferTo(temp_file);

		fis = new FileInputStream(temp_file.getAbsolutePath());

		workbook = new HSSFWorkbook(fis);

		HSSFSheet curSheet;
		HSSFRow	curRow;
		HSSFCell curCell;

		//for(int sheetIndex = 0; sheetIndex < workbook.getNumberOfSheets(); sheetIndex++){
		//curSheet = workbook.getSheetAt(sheetIndex);
		curSheet = workbook.getSheetAt(excelForm);
		for(int rowIndex = 2; rowIndex < curSheet.getPhysicalNumberOfRows(); rowIndex++){
			if(rowIndex != 2){
				curRow = curSheet.getRow(rowIndex);
				String value;
				if(!"".equals(curRow.getCell(1).getStringCellValue())){
					poiMap = new HashMap<String, Object>();
					for(int cellIndex = 0; cellIndex < curRow.getPhysicalNumberOfCells(); cellIndex++){
						curCell = curRow.getCell(cellIndex);
						if(true){
							value = "";
							switch(curCell.getCellType()){
							case HSSFCell.CELL_TYPE_NUMERIC :
								value = curCell.getNumericCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_STRING :
								value = curCell.getStringCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_FORMULA :
								value = curCell.getCellFormula();
								break;
							case HSSFCell.CELL_TYPE_BLANK :
								value = curCell.getBooleanCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_ERROR :
								value = curCell.getErrorCellValue()+"";
								break;
							default :
								value = new String();
								break;
							}

							if(!value.equals("false")){
								switch(cellIndex) {
								case 0 :
									poiMap.put("COMPANY_CODE", value);
									break;
								case 1 :
									poiMap.put("COMPANY_NAME", value);
									break;
								case 2 :
									poiMap.put("BUSINESS_NUMBER", value);
									break;
								case 3 :
									poiMap.put("LOAN_GRADE", value);
									break;
								case 4 :
									poiMap.put("CREDIT_AMOUNT", value);
									break;
								case 5 :
									poiMap.put("BUSINESS_STATUS", value);
									break;
								case 6 :
									poiMap.put("AUDIT_OPINION", value);
									break;
								case 7 :
									poiMap.put("CREDIT_GRADE", value);
									break;
								case 8 :
									poiMap.put("CASH_FLOW", value);
									break;
								default : 
									break;
								}
							}
						}
					}
					list.add(poiMap);
				}
			}
		}
		//}
		fis.close();
		deleteExel(temp_file.getAbsolutePath());
		insertErpCompanyCredit(list);

		return list;
	}

	@SuppressWarnings({ "resource" })
	public List<Map<String, Object>> xlsxReadErpSalesProject(Map<String, Object> map, HttpServletRequest request) throws Exception {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> poiMap = new HashMap<String, Object>();

		int excelForm = Integer.parseInt((String) map.get("form"));

		FileInputStream fis = null;
		XSSFWorkbook workbook = null;

		MultipartHttpServletRequest multi = (MultipartHttpServletRequest) request;
		MultipartFile file = multi.getFile("filePOI");

		String fileName = file.getOriginalFilename();
		//	    File temp_file = new File(fileName);
		File temp_file = new File(resultFilePath + fileName);

		if (temp_file.exists() == false) {
			// 없으면 생성
			temp_file.mkdirs();
		}

		file.transferTo(temp_file);

		fis = new FileInputStream(temp_file.getAbsolutePath());

		workbook = new XSSFWorkbook(fis);

		XSSFSheet curSheet;
		XSSFRow	curRow;
		XSSFCell curCell;

		//for(int sheetIndex = 0; sheetIndex < workbook.getNumberOfSheets(); sheetIndex++){
		//curSheet = workbook.getSheetAt(sheetIndex);
		curSheet = workbook.getSheetAt(excelForm);
		for(int rowIndex = 2; rowIndex < curSheet.getPhysicalNumberOfRows(); rowIndex++){
			if(rowIndex != 2){
				curRow = curSheet.getRow(rowIndex);
				String value;
				if(!"".equals(curRow.getCell(1).getRawValue()) && curRow.getCell(1).getRawValue() != null){
					poiMap = new HashMap<String, Object>();
					for(int cellIndex = 0; cellIndex < curRow.getPhysicalNumberOfCells(); cellIndex++){
						curCell = curRow.getCell(cellIndex);
						if(true){
							value = "";
							switch(curCell.getCellType()){
							case HSSFCell.CELL_TYPE_NUMERIC :
								value = curCell.getRawValue();
								//value = curCell.getNumericCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_STRING :
								value = curCell.getStringCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_FORMULA :
								value = curCell.getCellFormula();
								break;
							case HSSFCell.CELL_TYPE_BLANK :
								value = curCell.getBooleanCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_ERROR :
								value = curCell.getErrorCellValue()+"";
								break;
							default :
								value = "";
								break;
							}

							if(!value.equals("false")){
								switch(cellIndex) {
								case 0 :
									poiMap.put("PROJECT_CODE", value);
									break;
								case 1 :
									poiMap.put("PROJECT_NAME", value);
									break;
								case 2 :
									poiMap.put("BOOKING_TYPE_NAME", value);
									break;
								case 3 :
									poiMap.put("REVISON", value);
									break;
								case 4 :
									poiMap.put("CONTRACT_COMPANY", value);
									break;
								case 5 :
									poiMap.put("CLIENT_COMPANY", value);
									break;
								case 6 :
									poiMap.put("STATE", value);
									break;
								case 7 :
									poiMap.put("SALES_REP_NAME", value);
									break;
								case 8 :
									poiMap.put("CONTRACT_DATE", value);
									break;
								case 9 :
									poiMap.put("TCV_NET_AMOUNT", value);
									break;
								case 10 :
									poiMap.put("TCV_VAT_AMOUNT", value);
									break;
								case 11 :
									poiMap.put("TCV_TOTAL_AMOUNT", value);
									break;
								case 12 :
									poiMap.put("SALES_DIVISION", value);
									break;
								case 13 :
									poiMap.put("MEMBER_ID_NUM", value);
									break;
								case 14 :
									poiMap.put("BOOKING_TYPE", value);
									break;
								default : 
									break;
								}
							}
						}
					}
					list.add(poiMap);
				}
			}
		}
		//}
		fis.close();
		deleteExel(temp_file.getAbsolutePath());
		insertErpSalesProject(list);

		return list;
	}

	@SuppressWarnings({ "resource" })
	public List<Map<String, Object>> xlsReadErpSalesProject(Map<String, Object> map, HttpServletRequest request) throws Exception {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> poiMap = new HashMap<String, Object>();

		int excelForm = Integer.parseInt((String) map.get("form"));

		FileInputStream fis = null;
		HSSFWorkbook workbook = null;

		MultipartHttpServletRequest multi = (MultipartHttpServletRequest) request;
		MultipartFile file = multi.getFile("filePOI");

		String fileName = file.getOriginalFilename();
		//	    File temp_file = new File(fileName);
		File temp_file = new File(resultFilePath + fileName);

		if (temp_file.exists() == false) {
			// 없으면 생성
			temp_file.mkdirs();
		}

		file.transferTo(temp_file);

		fis = new FileInputStream(temp_file.getAbsolutePath());

		workbook = new HSSFWorkbook(fis);

		HSSFSheet curSheet;
		HSSFRow	curRow;
		HSSFCell curCell;

		//for(int sheetIndex = 0; sheetIndex < workbook.getNumberOfSheets(); sheetIndex++){
		//curSheet = workbook.getSheetAt(sheetIndex);
		curSheet = workbook.getSheetAt(excelForm);
		for(int rowIndex = 2; rowIndex < curSheet.getPhysicalNumberOfRows(); rowIndex++){
			if(rowIndex != 2){
				curRow = curSheet.getRow(rowIndex);
				String value;
				if(!"".equals(curRow.getCell(1).getStringCellValue())){
					poiMap = new HashMap<String, Object>();
					for(int cellIndex = 0; cellIndex < curRow.getPhysicalNumberOfCells(); cellIndex++){
						curCell = curRow.getCell(cellIndex);
						if(true){
							value = "";
							switch(curCell.getCellType()){
							case HSSFCell.CELL_TYPE_NUMERIC :
								value = curCell.getNumericCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_STRING :
								value = curCell.getStringCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_FORMULA :
								value = curCell.getCellFormula();
								break;
							case HSSFCell.CELL_TYPE_BLANK :
								value = curCell.getBooleanCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_ERROR :
								value = curCell.getErrorCellValue()+"";
								break;
							default :
								value = new String();
								break;
							}

							if(!value.equals("false")){
								switch(cellIndex) {
								case 0 :
									poiMap.put("PROJECT_CODE", value);
									break;
								case 1 :
									poiMap.put("PROJECT_NAME", value);
									break;
								case 2 :
									poiMap.put("BOOKING_TYPE_NAME", value);
									break;
								case 3 :
									poiMap.put("REVISON", value);
									break;
								case 4 :
									poiMap.put("CONTRACT_COMPANY", value);
									break;
								case 5 :
									poiMap.put("CLIENT_COMPANY", value);
									break;
								case 6 :
									poiMap.put("STATE", value);
									break;
								case 7 :
									poiMap.put("SALES_REP_NAME", value);
									break;
								case 8 :
									poiMap.put("CONTRACT_DATE", value);
									break;
								case 9 :
									poiMap.put("TCV_NET_AMOUNT", value);
									break;
								case 10 :
									poiMap.put("TCV_VAT_AMOUNT", value);
									break;
								case 11 :
									poiMap.put("TCV_TOTAL_AMOUNT", value);
									break;
								case 12 :
									poiMap.put("SALES_DIVISION", value);
									break;
								case 13 :
									poiMap.put("MEMBER_ID_NUM", value);
									break;
								case 14 :
									poiMap.put("BOOKING_TYPE", value);
									break;
								default : 
									break;
								}
							}
						}
					}
					list.add(poiMap);
				}
			}
		}
		//}
		fis.close();
		deleteExel(temp_file.getAbsolutePath());
		insertErpSalesProject(list);

		return list;
	}

	@SuppressWarnings({ "resource" })
	public List<Map<String, Object>> xlsxReadErpCompanyAr(Map<String, Object> map, HttpServletRequest request) throws Exception {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> poiMap = new HashMap<String, Object>();

		int excelForm = Integer.parseInt((String) map.get("form"));

		FileInputStream fis = null;
		XSSFWorkbook workbook = null;

		MultipartHttpServletRequest multi = (MultipartHttpServletRequest) request;
		MultipartFile file = multi.getFile("filePOI");

		String fileName = file.getOriginalFilename();
		//	    File temp_file = new File(fileName);
		File temp_file = new File(resultFilePath + fileName);

		if (temp_file.exists() == false) {
			// 없으면 생성
			temp_file.mkdirs();
		}

		file.transferTo(temp_file);

		fis = new FileInputStream(temp_file.getAbsolutePath());

		workbook = new XSSFWorkbook(fis);

		XSSFSheet curSheet;
		XSSFRow	curRow;
		XSSFCell curCell;

		//for(int sheetIndex = 0; sheetIndex < workbook.getNumberOfSheets(); sheetIndex++){
		//curSheet = workbook.getSheetAt(sheetIndex);
		curSheet = workbook.getSheetAt(excelForm);
		for(int rowIndex = 2; rowIndex < curSheet.getPhysicalNumberOfRows(); rowIndex++){
			if(rowIndex != 2){
				curRow = curSheet.getRow(rowIndex);
				String value;
				if(!"".equals(curRow.getCell(1).getRawValue()) && curRow.getCell(1).getRawValue() != null){
					poiMap = new HashMap<String, Object>();
					for(int cellIndex = 0; cellIndex < curRow.getPhysicalNumberOfCells(); cellIndex++){
						curCell = curRow.getCell(cellIndex);
						if(true){
							value = "";
							switch(curCell.getCellType()){
							case HSSFCell.CELL_TYPE_NUMERIC :
								value = curCell.getRawValue();
								//value = curCell.getNumericCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_STRING :
								value = curCell.getStringCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_FORMULA :
								value = curCell.getCellFormula();
								break;
							case HSSFCell.CELL_TYPE_BLANK :
								value = curCell.getBooleanCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_ERROR :
								value = curCell.getErrorCellValue()+"";
								break;
							default :
								value = "";
								break;
							}

							if(!value.equals("false")){
								switch(cellIndex) {
								case 0 :
									poiMap.put("PROJECT_CODE", value);
									break;
								case 1 :
									poiMap.put("CONTRACT_DATE", value);
									break;
								case 2 :
									poiMap.put("COMPANY_NAME", value);
									break;
								case 3 :
									poiMap.put("PROJECT_NAME", value);
									break;
								case 4 :
									poiMap.put("PROJECT_TYPE", value);
									break;
								case 5 :
									poiMap.put("AR_AMOUNT", value);
									break;
								case 6 :
									poiMap.put("COLLECT_DATE", value);
									break;
								case 7 :
									poiMap.put("SALES_REP_NAME", value);
									break;
								case 8 :
									poiMap.put("MEMBER_DIVISION", value);
									break;
								case 9 :
									poiMap.put("TCV_AMOUNT", value);
									break;
								default : 
									break;
								}
							}
						}
					}
					list.add(poiMap);
				}
			}
		}
		//}
		fis.close();
		deleteExel(temp_file.getAbsolutePath());
		insertErpCompanyAr(list);

		return list;
	}

	@SuppressWarnings({ "resource" })
	public List<Map<String, Object>> xlsReadErpCompanyAr(Map<String, Object> map, HttpServletRequest request) throws Exception {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> poiMap = new HashMap<String, Object>();

		int excelForm = Integer.parseInt((String) map.get("form"));

		FileInputStream fis = null;
		HSSFWorkbook workbook = null;

		MultipartHttpServletRequest multi = (MultipartHttpServletRequest) request;
		MultipartFile file = multi.getFile("filePOI");

		String fileName = file.getOriginalFilename();
		//	    File temp_file = new File(fileName);
		File temp_file = new File(resultFilePath + fileName);

		if (temp_file.exists() == false) {
			// 없으면 생성
			temp_file.mkdirs();
		}

		file.transferTo(temp_file);

		fis = new FileInputStream(temp_file.getAbsolutePath());

		workbook = new HSSFWorkbook(fis);

		HSSFSheet curSheet;
		HSSFRow	curRow;
		HSSFCell curCell;

		//for(int sheetIndex = 0; sheetIndex < workbook.getNumberOfSheets(); sheetIndex++){
		//curSheet = workbook.getSheetAt(sheetIndex);
		curSheet = workbook.getSheetAt(excelForm);
		for(int rowIndex = 2; rowIndex < curSheet.getPhysicalNumberOfRows(); rowIndex++){
			if(rowIndex != 2){
				curRow = curSheet.getRow(rowIndex);
				String value;
				if(!"".equals(curRow.getCell(1).getStringCellValue())){
					poiMap = new HashMap<String, Object>();
					for(int cellIndex = 0; cellIndex < curRow.getPhysicalNumberOfCells(); cellIndex++){
						curCell = curRow.getCell(cellIndex);
						if(true){
							value = "";
							switch(curCell.getCellType()){
							case HSSFCell.CELL_TYPE_NUMERIC :
								value = curCell.getNumericCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_STRING :
								value = curCell.getStringCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_FORMULA :
								value = curCell.getCellFormula();
								break;
							case HSSFCell.CELL_TYPE_BLANK :
								value = curCell.getBooleanCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_ERROR :
								value = curCell.getErrorCellValue()+"";
								break;
							default :
								value = new String();
								break;
							}

							if(!value.equals("false")){
								switch(cellIndex) {
								case 0 :
									poiMap.put("PROJECT_CODE", value);
									break;
								case 1 :
									poiMap.put("CONTRACT_DATE", value);
									break;
								case 2 :
									poiMap.put("COMPANY_NAME", value);
									break;
								case 3 :
									poiMap.put("PROJECT_NAME", value);
									break;
								case 4 :
									poiMap.put("PROJECT_TYPE", value);
									break;
								case 5 :
									poiMap.put("AR_AMOUNT", value);
									break;
								case 6 :
									poiMap.put("COLLECT_DATE", value);
									break;
								case 7 :
									poiMap.put("SALES_REP_NAME", value);
									break;
								case 8 :
									poiMap.put("MEMBER_DIVISION", value);
									break;
								case 9 :
									poiMap.put("TCV_AMOUNT", value);
									break;
								default : 
									break;
								}
							}
						}
					}
					list.add(poiMap);
				}
			}
		}
		//}
		fis.close();
		deleteExel(temp_file.getAbsolutePath());
		insertErpCompanyAr(list);

		return list;
	}

	/**
	 * cnt = -1 : 고객사 정보 없음
	 * cnt = -2 : 같은회사 동명이인
	 * cnt = 1  : 기존 데이터 update 성공
	 * cnt = 0  : 신규 성공
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int insertClientIndividualInfo(Map<String, Object> map) throws Exception {
		int cnt = 0;

		Map<String, Object> clientCompanyInfo = null;
		Map<String, Object> excelMap = new HashMap<>();
		//엑셀에 입력된 데이터 그대로 담아놓기.
		excelMap.putAll(map);

		//고객개인 회사명으로 고객사 정보 가져오기.
		clientCompanyInfo = poiDAO.selectClientCompanyInfo(map);

		//고객사가 없으면
		if(clientCompanyInfo == null)
		{
			cnt = -1;
			return cnt;
		}
		else //고객사 존재
		{
			//카테고리별 고객개인 ID MAX 값 : ex) GS건설 : COMPANY_ID - 10,000,000
			int nextClientIndividualId = Integer.parseInt(poiDAO.selectClientIndividualMaxId(clientCompanyInfo).get("CUSTOMER_ID").toString());
			if(nextClientIndividualId != 0)
			{
				nextClientIndividualId = nextClientIndividualId + 1;
			}
			else
			{
				//고객사 카테고리 : ex) 1, 2, 3
				int clientCategory = Integer.parseInt(clientCompanyInfo.get("CLIENT_CATEGORY").toString());
				nextClientIndividualId = clientCategory * 10000000;
			}

			map.put("CUSTOMER_ID", nextClientIndividualId);
			//map.put("COMPANY_ID", clientCompanyInfo.get("COMPANY_ID").toString());

			//엑셀에 CUSTOMER_ID 가 null이 아니면 기존에 DB에 있는 데이터 이니 update
			if(null != excelMap.get("CUSTOMER_ID") || "".equals(excelMap.get("CUSTOMER_ID")))
			{
				poiDAO.updateClientIndividualInfo(excelMap);
				CUSTOMER_ID = Integer.parseInt(excelMap.get("CUSTOMER_ID").toString());
				return 1;
			}
			else
			{	//엑셀에 CUSTOMER_ID가 없으면 신규등록을 위한 것
				//신규 고객을 insert 하려는데 DB에 기존 데이터가 있는지 확인 후, 있으면 동명이인 체크(Y,N) 수행
				int upCnt = poiDAO.updateClientIndividualInfo2(map);
				if(upCnt > 0)
				{
					if(map.get("INSERT_FLAG").equals("Y"))
					{
						//같은회사 동명이인 insert 허용
						poiDAO.insertClientIndividualInfo(map);
						CUSTOMER_ID = Integer.parseInt(map.get("CUSTOMER_ID").toString());

					}else if (map.get("INSERT_FLAG").equals("N")){ 
						//같은회사 동명이인 insert 불가
						cnt = -2;
						return cnt;
					}
				}
				else
				{
					//신규고객 insert
					poiDAO.insertClientIndividualInfo(map);
					CUSTOMER_ID = Integer.parseInt(map.get("CUSTOMER_ID").toString());
				}
			}
		}

		return cnt;
	}

	public int insertErpSalesPlan(Map<String, Object> map) throws Exception {
		int cnt = 0;
		Map<String, Object> erpSalesPlanMap = null;

		if(null != map.get("PERF_TARGET_ID"))
		{
			poiDAO.updateErpSalesPlan(map);
			KEY_ID = Integer.parseInt(map.get("PERF_TARGET_ID").toString());
		}else{
			erpSalesPlanMap = poiDAO.selectErpSalesPlan(map);
			if(null != erpSalesPlanMap){
				poiDAO.updateErpSalesPlan(map);
			}else{
				poiDAO.insertErpSalesPlan(map);
				KEY_ID = Integer.parseInt(map.get("filePK").toString());
			}
		}
		return cnt;
	}


	public int insertClientIndividualInfo(List<Map<String, Object>> list) throws Exception {
		int cnt =0;

		Map<String, Object> clientCompanyInfo = null;
		for(int i=0; i<list.size(); i++){
			if(i==0 || (i>0 && !list.get(i).get("COMPANY_NAME").equals(list.get(i-1).get("COMPANY_NAME"))))
			{
				//고객개인 회사명으로 고객사 정보 가져오기.
				clientCompanyInfo = poiDAO.selectClientCompanyInfo(list.get(i));
				//고객사가 없으면?
				if(clientCompanyInfo == null)
				{
					cnt = -1;
					return cnt;
				}
				else //고객사 존재
				{
					//카테고리별 고객개인 ID MAX 값 : ex) GS건설 : COMPANY_ID - 10,000,000
					int nextClientIndividualId = Integer.parseInt(poiDAO.selectClientIndividualMaxId(clientCompanyInfo).get("CUSTOMER_ID").toString());
					if(nextClientIndividualId != 0)
					{
						nextClientIndividualId = nextClientIndividualId + 1;
					}
					else
					{
						//고객사 카테고리 : ex) 1, 2, 3
						int clientCategory = Integer.parseInt(clientCompanyInfo.get("CLIENT_CATEGORY").toString());
						nextClientIndividualId = clientCategory * 10000000;
					}

					list.get(i).put("CUSTOMER_ID", nextClientIndividualId);
					list.get(i).put("COMPANY_ID", clientCompanyInfo.get("COMPANY_ID").toString());


					int upCnt = poiDAO.updateClientIndividualInfo(list.get(i));
					if(upCnt > 0){

					}

					poiDAO.insertClientIndividualInfo(list.get(i));
				}
			}
			else
			{
				list.get(i).put("CUSTOMER_ID", Integer.parseInt(list.get(i-1).get("filePK").toString()) + 1);
				list.get(i).put("COMPANY_ID", list.get(i-1).get("COMPANY_ID").toString());
			}

			//고객개인 DB insert
			//poiDAO.insertClientIndividualInfo(list.get(i));
			//안쓰지 않나?
			//poiDAO.updateSequenceInfo(list.get(i));
		}

		return cnt;
	}

	public int insertClientCompanyInfo(Map<String, Object> poiMap) throws Exception 
	{
		int cnt = 0;

		if(null != poiMap.get("COMPANY_ID"))
		{
			//기존에 company_id가 존재하면 update 처리
			poiDAO.updateClientCompanyInfo(poiMap);
			COMPANY_ID = Integer.parseInt(poiMap.get("COMPANY_ID").toString());
		}
		else
		{
			Map<String, Object> selectMap = poiDAO.selectClientCompanyInfo2(poiMap);
			if(null != selectMap)
			{
				//고객사가 존재
				cnt = -1;
				return cnt;
			}
			else
			{
				int clientCategory = Integer.parseInt(poiMap.get("CLIENT_CATEGORY").toString());
				int nextCompanyId = Integer.parseInt(poiDAO.selectCompanyCategoryMaxId(poiMap).get("COMPANY_ID").toString());
				if(nextCompanyId != 0){
					nextCompanyId = nextCompanyId + 1;
				}else{
					nextCompanyId = clientCategory * 10000000;
				}
				poiMap.put("COMPANY_ID", nextCompanyId);
				COMPANY_ID = Integer.parseInt(poiMap.get("COMPANY_ID").toString());

				poiDAO.insertClientCompanyInfo(poiMap);


				//전체 자사직원 테리토리 : 태원 소스
				/*List<Map<String, Object>> memberList = clientManagementDAO.selectAllMemberIdNum();
				if(memberList.size() > 0) 
				{
					poiMap.put("memberList", memberList);
					poiMap.put("filePK", poiMap.get("COMPANY_ID"));
					clientManagementDAO.insertSalesTerritoryAlignAllMap(poiMap);
				}*/
			}
		}

		return cnt;

		//poiDAO.insertClientCompanyInfo(list.get(i));
		//List<Map<String, Object>> memberList = poiDAO.selectAllMemberIdNum();
		//list.get(i).put("memberList", memberList);

		//뭔데 이거?
		//poiDAO.insertSalesTerritoryAlignNewCompanyAllMap(list.get(i));
	}

	public void insertClientCompanyInfo(List<Map<String, Object>> list) throws Exception {
		for(int i=0; i<list.size(); i++){
			if(i==0 || (i>0 && !list.get(i).get("CLIENT_CATEGORY").equals(list.get(i-1).get("CLIENT_CATEGORY")))){
				int clientCategory = Integer.parseInt(list.get(i).get("CLIENT_CATEGORY").toString());
				int nextCompanyId = Integer.parseInt(poiDAO.selectCompanyCategoryMaxId(list.get(i)).get("COMPANY_ID").toString());
				if(nextCompanyId != 0){
					nextCompanyId = nextCompanyId + 1;
				}else{
					nextCompanyId = clientCategory * 10000000;
				}
				list.get(i).put("COMPANY_ID", nextCompanyId);
			}else{
				list.get(i).put("COMPANY_ID", Integer.parseInt(list.get(i-1).get("filePK").toString()) + 1);
			}

			poiDAO.insertClientCompanyInfo(list.get(i));

			//insert 고객사를 자사 전 직원 테리토리 권한에 추가 : 테원 소스
			/*List<Map<String, Object>> memberList = poiDAO.selectAllMemberIdNum();
			list.get(i).put("memberList", memberList);
			poiDAO.insertSalesTerritoryAlignNewCompanyAllMap(list.get(i));*/

			//시퀀스 테이블 값 최신화
			poiDAO.updateSequenceInfo(list.get(i));
		}
	}

	public void insertOurMembersInfo(List<Map<String, Object>> list) throws Exception {
		for(int i=0; i<list.size(); i++){
			poiDAO.insertOurMembersInfo(list.get(i));

			//직원 계정 생성
			String user_pw = "uni123";
			list.get(i).put("user_pw", bcryptPasswordEncoder.encode(user_pw));
			adminDAO.insertInfoUser(list.get(i));

			//insert 직원의 고객사 전체  테리토리 권한 추가 : 태원 소스
			/*List<Map<String, Object>> clientCompanyList = poiDAO.selectAllClientCompanyId();
			list.get(i).put("clientCompanyList", clientCompanyList);
			poiDAO.insertSalesTerritoryAlignNewOurMemberAllMap(list.get(i));*/
		}
	}

	public int insertOurMembersInfo(Map<String, Object> poiMap, Map<String, Object> map) throws Exception {

		int cnt = 0;

		if(null == poiMap.get("STOP_DATE") || "".equals(poiMap.get("STOP_DATE"))){
			poiMap.put("STOP_DATE", null);
		}
		if(null == poiMap.get("JOIN_DATE") || "".equals(poiMap.get("JOIN_DATE"))){
			poiMap.put("JOIN_DATE", null);
		}


		if(null != poiMap.get("MEMBER_ID"))
		{
			poiDAO.updateOurMembersInfo(poiMap);
		}
		else{
			Map<String, Object> selectMap = poiDAO.selectOurMembersInfo(poiMap);

			if(null != selectMap)
			{//직원이 존재하는데, 같은 이름 직원을 또 등록하려할 때.

				cnt = -2;
				return cnt;
			}else {
				poiDAO.insertOurMembersInfo(poiMap);
				KEY_ID = Integer.parseInt(poiMap.get("filePK").toString()); 

				String user_pw = "uni123";
				poiMap.put("user_pw", bcryptPasswordEncoder.encode(user_pw));
				adminDAO.insertInfoUser(poiMap);


				//자사직원 추가시 전체 고객사 테리토리 : 태원 소스
				/*List<Map<String, Object>> clientCompanyList = poiDAO.selectAllClientCompanyId();
				if(clientCompanyList.size() > 0 )
				{
					poiMap.put("clientCompanyList", clientCompanyList);
					poiMap.put("creatorId", map.get("global_member_id"));
					poiMap.put("MEMBER_ID_NUM", poiMap.get("MEMBER_ID_NUM"));
					poiDAO.insertSalesTerritoryAlignNewOurMemberAllMap(poiMap);
				}*/

				cnt = 1;

			}
		}


		/*
		poiDAO.insertOurMembersInfo(poiMap);

		String user_pw = "uni123";
		poiMap.put("user_pw", bcryptPasswordEncoder.encode(user_pw));
		adminDAO.insertInfoUser(poiMap);

		List<Map<String, Object>> clientCompanyList = poiDAO.selectAllClientCompanyId();
		poiMap.put("clientCompanyList", clientCompanyList);
		poiDAO.insertSalesTerritoryAlignNewOurMemberAllMap(poiMap);
		 */

		return cnt;
	}

	public void insertOurDivisionInfo(List<Map<String, Object>> list) throws Exception {
		for(int i=0; i<list.size(); i++){
			poiDAO.insertOurDivisionInfo(list.get(i));
		}
	}


	public int insertOurDivisionInfo(Map<String, Object> poiMap) throws Exception {
		int cnt =0;

		if(null != poiMap.get("DIVISION_NO"))
		{
			poiDAO.updateOurDivisionInfo(poiMap);
		}
		else {
			Map<String, Object> selectMap = poiDAO.selectOurDivisionInfo(poiMap);
			if(null != selectMap)
			{
				cnt = -2;
				return cnt;
			}
			else 
			{
				poiDAO.insertOurDivisionInfo(poiMap);
				KEY_ID = Integer.parseInt(poiMap.get("filePK").toString());
				cnt = 1;
			}
		}

		return cnt;
	}

	public void insertOurTeamInfo(List<Map<String, Object>> list) throws Exception {
		for(int i=0; i<list.size(); i++){
			poiDAO.insertOurTeamInfo(list.get(i));
		}
	}

	public int insertOurTeamInfo(Map<String, Object> poiMap) throws Exception {
		int cnt =0;

		if(null != poiMap.get("TEAM_NO"))
		{
			poiDAO.updateTeamInfo(poiMap);
		}else{
			Map<String, Object> selectMap = poiDAO.selectTeamInfo(poiMap);
			if(null != selectMap)
			{
				cnt = -2;
				return cnt;
			}
			else 
			{
				poiDAO.insertOurTeamInfo(poiMap);
				KEY_ID = Integer.parseInt(poiMap.get("filePK").toString());
				cnt = 1;
			}
		}
		return cnt;
	}

	public void insertPartnerCompanyInfo(List<Map<String, Object>> list) throws Exception {
		for(int i=0; i<list.size(); i++){
			poiDAO.insertPartnerCompanyInfo(list.get(i));
		}
	}

	public static String rtrim(String str)
	{
		int len = str.length();
		while ((0 < len) && (str.charAt(len-1) <= ' '))
		{
			len--;
		}
		return str.substring(0, len);
	}

	public int insertPartnerCompanyInfo(Map<String, Object> poiMap) throws Exception {
		int cnt = 0;
		if(null != poiMap.get("PARTNER_ID"))
		{
			poiDAO.updatePartnerCompanyInfo(poiMap);
		}
		else 
		{
			Map<String, Object> selectMap = poiDAO.selectPartnerCompanyInfo(poiMap);

			if(null != selectMap)
			{
				//기존에 등록되어있는 파트너사 ID
				int PARTNER_ID = Integer.parseInt(selectMap.get("PARTNER_ID").toString());
				//기존에 등록되어있는 파트너사의 파트너 코드
				String PARTNER_CODE = (String) selectMap.get("PARTNER_CODE");

				PARTNER_CODE = rtrim(PARTNER_CODE);
				PARTNER_CODE += ";"+poiMap.get("PARTNER_CODE");

				poiMap.put("PARTNER_ID", PARTNER_ID);
				poiMap.put("PARTNER_CODE", PARTNER_CODE);

				poiDAO.updatePartnerCompanyInfo(poiMap);

				//cnt = -2;
				//return cnt;
			}
			else 
			{
				poiDAO.insertPartnerCompanyInfo(poiMap);
				KEY_ID = Integer.parseInt(poiMap.get("filePK").toString());
				cnt = 1;
				return cnt;
			}
		}

		return cnt;
	}

	public void insertPartnerIndividualInfo(List<Map<String, Object>> list) throws Exception {
		Map<String, Object> partnerCompanyInfo = null;
		for(int i=0; i<list.size(); i++){
			if(i==0 || (i>0 && !list.get(i).get("COMPANY_NAME").equals(list.get(i-1).get("COMPANY_NAME")))){
				partnerCompanyInfo = poiDAO.selectPartnerCompanyInfo(list.get(i));
				list.get(i).put("PARTNER_ID", partnerCompanyInfo.get("PARTNER_ID").toString());
			}else{
				list.get(i).put("PARTNER_ID", list.get(i-1).get("PARTNER_ID").toString());
			}
			poiDAO.insertPartnerIndividualInfo(list.get(i));
		}
	}


	public int insertPartnerIndividualInfo(Map<String, Object> poiMap) throws Exception {
		int cnt =0;

		if(null != poiMap.get("PARTNER_INDIVIDUAL_ID"))
		{
			poiDAO.updatePartnerIndividualInfo(poiMap);
			//KEY_ID = Integer.parseInt(poiMap.get("PARTNER_INDIVIDUAL_ID").toString());
		}else{
			Map<String, Object> selectMap = poiDAO.selectPartnerIdfividualInfo(poiMap);
			if( null != selectMap)
			{//같은 파트너사 & 같은 이름이 존재할 경우

				if(poiMap.get("INSERT_FLAG").equals("Y"))
				{//동명이인 insert 허가
					poiDAO.insertPartnerIndividualInfo(poiMap);
					KEY_ID = Integer.parseInt(poiMap.get("filePK").toString());
				}
				else 
				{//동명이인 unsert 불가
					cnt = -2;
					return cnt;
				}
			}
			else
			{//파트너사 개인 insert

				try{
					poiDAO.insertPartnerIndividualInfo(poiMap);
					KEY_ID = Integer.parseInt(poiMap.get("filePK").toString());
				}catch(Exception e){
					cnt = -3;
					return cnt;
				}

				cnt = 1;
				return cnt;
			}
		}

		return cnt;
	}

	public void insertCodeIndustrySegment(List<Map<String, Object>> list) throws Exception {
		for(int i=0; i<list.size(); i++){
			poiDAO.insertCodeIndustrySegment(list.get(i));
		}
	}

	public void insertCodePartnerSegment(List<Map<String, Object>> list) throws Exception {
		for(int i=0; i<list.size(); i++){
			poiDAO.insertCodePartnerSegment(list.get(i));
		}
	}

	public void insertVendorSolutionArea(List<Map<String, Object>> list) throws Exception {
		for(int i=0; i<list.size(); i++){
			poiDAO.insertVendorSolutionArea(list.get(i));
		}
	}

	public void insertErpCompanyCredit(List<Map<String, Object>> list) throws Exception {
		for(int i=0; i<list.size(); i++){
			poiDAO.insertErpCompanyCredit(list.get(i));
		}
	}

	public void insertErpSalesProject(List<Map<String, Object>> list) throws Exception {
		for(int i=0; i<list.size(); i++){
			poiDAO.insertErpSalesProject(list.get(i));
		}
	}

	public void insertErpCompanyAr(List<Map<String, Object>> list) throws Exception {
		for(int i=0; i<list.size(); i++){
			poiDAO.insertErpCompanyAr(list.get(i));
		}
	}



	public void deleteExel(String filePath) {
		File delFile = new File(filePath);
		log.debug("====delete====");
		if(delFile.exists()){
			boolean deleteFlag = delFile.delete();
			if(deleteFlag){
				log.debug("파일삭제 성공.");
			}else{
				log.debug("파일 삭제 실패.");
			}
		}else{
			log.debug("파일이 존재하지 않습니다.");
		}
	}

	public int insert(Map<String, Object> map) throws Exception {
		int cnt = 0;
		//메뉴 리스트
		ArrayList<HashMap<String, Object>> list = CommonUtils.jsonList((map.get("list")).toString());
		for(Map<String,Object> listMap : list){
			if(CommonUtils.isEmpty(adminDAO.selectPartnerSegmentAll(listMap))){
				cnt = adminDAO.insertPartnerSegment(listMap);
			}
		}
		return cnt;
	}

}
