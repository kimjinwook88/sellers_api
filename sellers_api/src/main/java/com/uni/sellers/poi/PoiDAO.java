package com.uni.sellers.poi;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.uni.sellers.datasource.AbstractDAO;

@Repository("poiDAO")
public class PoiDAO extends AbstractDAO{
	Logger log = LoggerFactory.getLogger(this.getClass());

	@SuppressWarnings("unchecked")
	public void insertClientIndividualInfo(Map<String, Object> map) throws Exception{
		insert("poi.insertClientIndividualInfo", map);
	}

	@SuppressWarnings("unchecked")
	public void insertErpSalesPlan(Map<String, Object> map) throws Exception{
		insert("poi.insertErpSalesPlan", map);
	}
	
	@SuppressWarnings("unchecked")
	public void insertErpSalesActual(Map<String, Object> map) throws Exception{
		insert("poi.insertErpSalesActual", map);
	}

	@SuppressWarnings("unchecked")
	public int updateErpSalesActual(Map<String, Object> map) throws Exception{
		return (int)update("poi.updateErpSalesActual", map);
	}
	
	@SuppressWarnings("unchecked")
	public int updateShareMemberErpSalesActual(Map<String, Object> map) throws Exception{
		return (int)update("poi.updateShareMemberErpSalesActual", map);
	}
	/*
	@SuppressWarnings("unchecked")
	public int updateResetShareMemberErpSalesActual(Map<String, Object> map) throws Exception{
		return (int)update("poi.updateResetShareMemberErpSalesActual", map);
	}
	*/
	@SuppressWarnings("unchecked")
	public int updateClientIndividualInfo(Map<String, Object> map) throws Exception{
		return (int)update("poi.updateClientIndividualInfo", map);
	}

	@SuppressWarnings("unchecked")
	public int updateErpSalesPlan(Map<String, Object> map) throws Exception{
		return (int)update("poi.updateErpSalesPlan", map);
	}

	@SuppressWarnings("unchecked")
	public int updateClientCompanyInfo(Map<String, Object> map) throws Exception{
		return (int)update("poi.updateClientCompanyInfo", map);
	}
	@SuppressWarnings("unchecked")
	public int updatePartnerIndividualInfo(Map<String, Object> map) throws Exception{
		return (int)update("poi.updatePartnerIndividualInfo", map);
	}

	@SuppressWarnings("unchecked")
	public int updateClientIndividualInfo2(Map<String, Object> map) throws Exception{
		return (int)update("poi.updateClientIndividualInfo2", map);
	}

	@SuppressWarnings("unchecked")
	public int updatePartnerCompanyInfo(Map<String, Object> map) throws Exception{
		return (int)update("poi.updatePartnerCompanyInfo", map);
	}

	@SuppressWarnings("unchecked")
	public int updateTeamInfo(Map<String, Object> map) throws Exception{
		return (int)update("poi.updateTeamInfo", map);
	}

	@SuppressWarnings("unchecked")
	public int updateOurDivisionInfo(Map<String, Object> map) throws Exception{
		return (int)update("poi.updateOurDivisionInfo", map);
	}

	@SuppressWarnings("unchecked")
	public int updateCodePartnerSegment(Map<String, Object> map) throws Exception{
		return (int)update("poi.updateCodePartnerSegment", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectClientIndividualInfo(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("poi.selectClientIndividualInfo", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectClientIndividualDBtoExcel() throws Exception{
		return (List<Map<String, Object>>)selectList("poi.selectClientIndividualDBtoExcel");
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectClientCompanyDBtoExcel() throws Exception{
		return (List<Map<String, Object>>)selectList("poi.selectClientCompanyDBtoExcel");
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectPartnerCompanyDBtoExcel() throws Exception{
		return (List<Map<String, Object>>)selectList("poi.selectPartnerCompanyDBtoExcel");
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectMembersInfo(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("poi.selectMembersInfo", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectShareMemberErpSalesActualData(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("poi.selectShareMemberErpSalesActualData", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectPartnerIndividualDBtoExcel() throws Exception{
		return (List<Map<String, Object>>)selectList("poi.selectPartnerIndividualDBtoExcel");
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCodePartnerSegmentDBtoExcel() throws Exception{
		return (List<Map<String, Object>>)selectList("poi.selectCodePartnerSegmentDBtoExcel");
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectErpSalesPlanDBtoExcel() throws Exception{
		return (List<Map<String, Object>>)selectList("poi.selectErpSalesPlanDBtoExcel");
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectOurMembersInfoDBtoExcel() throws Exception{
		return (List<Map<String, Object>>)selectList("poi.selectOurMembersInfoDBtoExcel");
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectOurTeamInfoDBtoExcel() throws Exception{
		return (List<Map<String, Object>>)selectList("poi.selectOurTeamInfoDBtoExcel");
	}
	
	@SuppressWarnings("unchecked")
	public int deleteActualData(Map<String, Object> map) throws Exception{
		return (int)delete("poi.deleteActualData", map);
	}
	
	@SuppressWarnings("unchecked")
	public int deleteSalesActualData(Map<String, Object> map) throws Exception{
		return (int)delete("poi.deleteSalesActualData", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectOurDivisionInfoDBtoExcel() throws Exception{
		return (List<Map<String, Object>>)selectList("poi.selectOurDivisionInfoDBtoExcel");
	}
	
	
	
	//ERP 대시보드
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectErpDashBoard(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("poi.selectErpDashBoard", map);
	}
	
	@SuppressWarnings("unchecked")
	public void insertErpDashBoard(Map<String, Object> map) throws Exception{
		insert("poi.insertErpDashBoard", map);
	}

	@SuppressWarnings("unchecked")
	public int updateErpDashBoard(Map<String, Object> map) throws Exception{
		return (int)insert("poi.updateErpDashBoard", map);
	}
	////ERP대시보드 end
	
	
	
	@SuppressWarnings("unchecked")
	public void insertClientCompanyInfo(Map<String, Object> map) throws Exception{
		insert("poi.insertClientCompanyInfo", map);
	}
	

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectAllMemberIdNum() throws Exception{
		return (List<Map<String, Object>>)selectList("poi.selectAllMemberIdNum");
	}

	@SuppressWarnings("unchecked")
	public int insertSalesTerritoryAlignNewCompanyAllMap(Map<String, Object> map) throws Exception{
		return (int)insert("poi.insertSalesTerritoryAlignNewCompanyAllMap", map);
	}

	@SuppressWarnings("unchecked")
	public void insertOurMembersInfo(Map<String, Object> map) throws Exception{
		insert("poi.insertOurMembersInfo", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectAllClientCompanyId() throws Exception{
		return (List<Map<String, Object>>)selectList("poi.selectAllClientCompanyId");
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectOurMembersInfo(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("poi.selectOurMembersInfo", map);
	}

	@SuppressWarnings("unchecked")
	public int insertSalesTerritoryAlignNewOurMemberAllMap(Map<String, Object> map) throws Exception{
		return (int)insert("poi.insertSalesTerritoryAlignNewOurMemberAllMap", map);
	}

	@SuppressWarnings("unchecked")
	public void insertSalesTerritoryAlignMap(Map<String, Object> map) throws Exception{
		insert("poi.insertSalesTerritoryAlignMap", map);
	}

	@SuppressWarnings("unchecked")
	public void insertOurDivisionInfo(Map<String, Object> map) throws Exception{
		insert("poi.insertOurDivisionInfo", map);
	}

	@SuppressWarnings("unchecked")
	public void insertOurTeamInfo(Map<String, Object> map) throws Exception{
		insert("poi.insertOurTeamInfo", map);
	}

	@SuppressWarnings("unchecked")
	public void insertPartnerCompanyInfo(Map<String, Object> map) throws Exception{
		insert("poi.insertPartnerCompanyInfo", map);
	}

	@SuppressWarnings("unchecked")
	public void insertPartnerIndividualInfo(Map<String, Object> map) throws Exception{
		insert("poi.insertPartnerIndividualInfo", map);
	}

	@SuppressWarnings("unchecked")
	public void insertCodeIndustrySegment(Map<String, Object> map) throws Exception{
		insert("poi.insertCodeIndustrySegment", map);
	}

	@SuppressWarnings("unchecked")
	public void insertCodePartnerSegment(Map<String, Object> map) throws Exception{
		insert("poi.insertCodePartnerSegment", map);
	}

	@SuppressWarnings("unchecked")
	public void insertVendorSolutionArea(Map<String, Object> map) throws Exception{
		insert("poi.insertVendorSolutionArea", map);
	}

	@SuppressWarnings("unchecked")
	public void insertErpCompanyCredit(Map<String, Object> map) throws Exception{
		insert("poi.insertErpCompanyCredit", map);
	}

	@SuppressWarnings("unchecked")
	public void insertErpSalesProject(Map<String, Object> map) throws Exception{
		insert("poi.insertErpSalesProject", map);
	}

	@SuppressWarnings("unchecked")
	public void insertErpCompanyAr(Map<String, Object> map) throws Exception{
		insert("poi.insertErpCompanyAr", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectCompanyCategoryMaxId(Map<String, Object> map) throws Exception{
		return (Map<String, Object>) selectOne("poi.selectCompanyCategoryMaxId", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectCodePartnerSegment(Map<String, Object> map) throws Exception{
		return (Map<String, Object>) selectOne("poi.selectCodePartnerSegment", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectClientCompanyInfo(Map<String, Object> map) throws Exception{
		return (Map<String, Object>) selectOne("poi.selectClientCompanyInfo", map);
	}


	@SuppressWarnings("unchecked")
	public Map<String, Object> selectErpSalesPlan(Map<String, Object> map) throws Exception{
		return (Map<String, Object>) selectOne("poi.selectErpSalesPlan", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectTeamInfo(Map<String, Object> map) throws Exception{
		return (Map<String, Object>) selectOne("poi.selectTeamInfo", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectOurDivisionInfo(Map<String, Object> map) throws Exception{
		return (Map<String, Object>) selectOne("poi.selectOurDivisionInfo", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectClientCompanyInfo2(Map<String, Object> map) throws Exception{
		return (Map<String, Object>) selectOne("poi.selectClientCompanyInfo2", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectPartnerIdfividualInfo(Map<String, Object> map) throws Exception{
		return (Map<String, Object>) selectOne("poi.selectPartnerIdfividualInfo", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectClientIndividualMaxId(Map<String, Object> map) throws Exception{
		return (Map<String, Object>) selectOne("poi.selectClientIndividualMaxId", map);
	}

	@SuppressWarnings("unchecked")
	public int updateSequenceInfo(Map<String, Object> map) throws Exception{
		return (int)insert("poi.updateSequenceInfo", map);
	}

	@SuppressWarnings("unchecked")
	public int updateOurMembersInfo(Map<String, Object> map) throws Exception{
		return (int)insert("poi.updateOurMembersInfo", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectPartnerCompanyInfo(Map<String, Object> map) throws Exception{
		return (Map<String, Object>) selectOne("poi.selectPartnerCompanyInfo", map);
	}

}
