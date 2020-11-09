package com.uni.sellers.duzon;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.uni.sellers.datasource.AbstractMsDAO;

@Repository("duzonDAO")
public class DuzonDAO extends AbstractMsDAO{ 
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectOurMemberInfo(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList_mssql("duzon.selectOurMemberInfo", map);
	}
	
	@SuppressWarnings("unchecked")
	public synchronized  int insertOurMemberInfo(List<Map<String, Object>> list) throws Exception{
		return (int)insertBatch("duzon.insertOurMemberInfo", list);
	}
	
	@SuppressWarnings("unchecked")
	public synchronized int updateOurMemberInfoTeam(Map<String, Object> map) throws Exception{
		return (int)update("duzon.updateOurMemberInfoTeam", map);
	}
	
	@SuppressWarnings("unchecked")
	public int insertOurMemberInfoLogin(Map<String, Object> map) throws Exception{
		return (int)insert("duzon.insertOurMemberInfoLogin", map);
	}
	
	@SuppressWarnings("unchecked")
	public int insertOurMemberInfoAuth(Map<String, Object> map) throws Exception{
		return (int)insert("duzon.insertOurMemberInfoAuth", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectOurDivisionInfo(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList_mssql("duzon.selectOurDivisionInfo", map);
	}
	
	@SuppressWarnings("unchecked")
	public int updateOurDivisionInfo(List<Map<String, Object>> list) throws Exception{
		return (int)update("duzon.updateOurDivisionInfo", list);
	}
	
	@SuppressWarnings("unchecked")
	public int insertOurDivisionInfo(List<Map<String, Object>> list) throws Exception{
		return (int)insertBatch("duzon.insertOurDivisionInfo", list);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectOurTeamInfo(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList_mssql("duzon.selectOurTeamInfo", map);
	}
	
	@SuppressWarnings("unchecked")
	public int updateOurTeamInfo(List<Map<String, Object>> list) throws Exception{
		return (int)update("duzon.updateOurTeamInfo", list);
	}
	
	@SuppressWarnings("unchecked")
	public int insertOurTeamInfo(List<Map<String, Object>> list) throws Exception{
		return (int)insertBatch("duzon.insertOurTeamInfo", list);
	}
	
	@SuppressWarnings("unchecked")
	public int updateOurTeamInfoToDivision(List<Map<String, Object>> list) throws Exception{
		return (int)update("duzon.updateOurTeamInfoToDivision", list);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectSalesGoalInfo(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList_mssql("duzon.selectSalesGoalInfo", map);
	}
	
	@SuppressWarnings("unchecked")
	public int insertSalesGoalInfo(List<Map<String, Object>> list) throws Exception{
		return (int)insertBatch("duzon.insertSalesGoalInfo", list);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCreditRatingStatusInfo(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList_mssql("duzon.selectCreditRatingStatusInfo", map);
	}
	
	@SuppressWarnings("unchecked")
	public int insertCreditRatingStatusInfo(List<Map<String, Object>> list) throws Exception{
		return (int)insertBatch("duzon.insertCreditRatingStatusInfo", list);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectClientCompanyInfo(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList_mssql("duzon.selectClientCompanyInfo", map);
	}
	
	@SuppressWarnings("unchecked")
	public int insertClientCompanyInfo(List<Map<String, Object>> list) throws Exception{
		return (int)insertBatch("duzon.insertClientCompanyInfo", list);
	}
	
	@SuppressWarnings("unchecked")
	public int updateCloseClientIndividualinfo(Map<String, Object> map) throws Exception{
		return (int)update("duzon.updateCloseClientIndividualinfo", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectClientSalesmanInfo(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList_mssql("duzon.selectClientSalesmanInfo", map);
	}
	
	@SuppressWarnings("unchecked")
	public int insertClientSalesmanInfo(List<Map<String, Object>> list) throws Exception{
		return (int)insertBatch("duzon.insertClientSalesmanInfo", list);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectOurProductInfo(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList_mssql("duzon.selectOurProductInfo", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectErpSfaSoptyH(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList_mssql("duzon.selectErpSfaSoptyH", map);
	}
	
	@SuppressWarnings("unchecked")
	public int insertOurProductInfo(List<Map<String, Object>> list) throws Exception{
		return (int)insertBatch("duzon.insertOurProductInfo", list);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectProjectComCode(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList_mssql("duzon.selectProjectComCode", map);
	}
	
	@SuppressWarnings("unchecked")
	public int insertProjectComCode(List<Map<String, Object>> list) throws Exception{
		return (int)insertBatch("duzon.insertProjectComCode", list);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectTPSOComCode(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList_mssql("duzon.selectTPSOComCode", map);
	}
	
	@SuppressWarnings("unchecked")
	public int insertTPSOComCode(List<Map<String, Object>> list) throws Exception{
		return (int)insertBatch("duzon.insertTPSOComCode", list);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectSfaPflsMaster(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList_mssql("duzon.selectSfaPflsMaster", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectSfaPflsItem1(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList_mssql("duzon.selectSfaPflsItem1", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectSfaPflsItem2(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList_mssql("duzon.selectSfaPflsItem2", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectSfaPflsBill(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList_mssql("duzon.selectSfaPflsBill", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectSfaPflsPay(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList_mssql("duzon.selectSfaPflsPay", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectDashBoardCheckList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList_mssql("duzon.selectDashBoardCheckList", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectErpSalesActual(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList_mssql("duzon.selectErpSalesActual", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectErpSalesActualTcv(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList_mssql("duzon.selectErpSalesActualTcv", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectErpSalesPgp(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList_mssql("duzon.selectErpSalesPgp", map);
	}
	
	@SuppressWarnings("unchecked")
	public String selectErpOppCode(Map<String, Object> map) throws Exception{
		return (String)selectOne_mssql("duzon.selectErpOppCode", map);
	}
	
	@SuppressWarnings("unchecked")
	public String selectErpOppActiveCode(Map<String, Object> map) throws Exception{
		return (String)selectOne_mssql("duzon.selectErpOppActiveCode", map);
	}
	
	@SuppressWarnings("unchecked")
	public String callErpOppMaster(Map<String, Object> map) throws Exception{
		return selectList_mssql("duzon.callErpOppMaster", map).toString();
	}
	
	@SuppressWarnings("unchecked")
	public String callErpOppProductSales(Map<String, Object> map) throws Exception{
		return selectList_mssql("duzon.callErpOppProductSales", map).toString();
	}
	
	@SuppressWarnings("unchecked")
	public String callErpOppProductPs(Map<String, Object> map) throws Exception{
		return selectList_mssql("duzon.callErpOppProductPs", map).toString();
	}
	
	@SuppressWarnings("unchecked")
	public int deletefaPflsAll(List<Map<String, Object>> list) throws Exception{
		return (int)delete("duzon.deletefaPflsAll", list);
	}
	
	@SuppressWarnings("unchecked")
	public int insertSfaPflsMaster(List<Map<String, Object>> list) throws Exception{
		return (int)insertBatch("duzon.insertSfaPflsMaster", list);
	}
	
	@SuppressWarnings("unchecked")
	public int insertSfaPflsItem1(List<Map<String, Object>> list) throws Exception{
		return (int)insertBatch("duzon.insertSfaPflsItem1", list);
	}
	
	@SuppressWarnings("unchecked")
	public int insertSfaPflsItem2(List<Map<String, Object>> list) throws Exception{
		return (int)insertBatch("duzon.insertSfaPflsItem2", list);
	}
	
	@SuppressWarnings("unchecked")
	public int insertSfaPflsBill(List<Map<String, Object>> list) throws Exception{
		return (int)insertBatch("duzon.insertSfaPflsBill", list);
	}
	
	@SuppressWarnings("unchecked")
	public int insertSfaPflsPay(List<Map<String, Object>> list) throws Exception{
		return (int)insertBatch("duzon.insertSfaPflsPay", list);
	}
	
	@SuppressWarnings("unchecked")
	public int insertDashBoardCheckList(List<Map<String, Object>> list) throws Exception{
		return (int)insertBatch("duzon.insertDashBoardCheckList", list);
	}
	
	@SuppressWarnings("unchecked")
	public int insertErpSalesActual(List<Map<String, Object>> list) throws Exception{
		return (int)insertBatch("duzon.insertErpSalesActual", list);
	}
	
	@SuppressWarnings("unchecked")
	public int updateErpSalesActualTcv(List<Map<String, Object>> list) throws Exception{
		return (int)updateBatch("duzon.updateErpSalesActualTcv", list);
	}
	
	@SuppressWarnings("unchecked")
	public int updateErpSalesPgp(List<Map<String, Object>> list) throws Exception{
		return (int)updateBatch("duzon.updateErpSalesPgp", list);
	}
	
	@SuppressWarnings("unchecked")
	public int updateOppToInst(Map<String, Object> map) throws Exception{
		return (int)update("duzon.updateOppToInst", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectOppToSalesProduct(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("duzon.selectOppToSalesProduct", map);
	}
	
	@SuppressWarnings("unchecked")
	public int updateOppToSalesProduct(List<Map<String, Object>> list) throws Exception{
		return (int)update("duzon.updateOppToSalesProduct", list);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectOppToPsProduct(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("duzon.selectOppToPsProduct", map);
	}	
	
	@SuppressWarnings("unchecked")
	public int updateOppToPsProduct(List<Map<String, Object>> list) throws Exception{
		return (int)update("duzon.updateOppToPsProduct", list);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectOppToBill(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("duzon.selectOppToBill", map);
	}	
	
	@SuppressWarnings("unchecked")
	public int updateOppToBill(List<Map<String, Object>> list) throws Exception{
		return (int)update("duzon.updateOppToBill", list);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectOppToPay(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("duzon.selectOppToPay", map);
	}	
	
	@SuppressWarnings("unchecked")
	public int updateOppToPay(List<Map<String, Object>> list) throws Exception{
		return (int)update("duzon.updateOppToPay", list);
	}
	
	@SuppressWarnings("unchecked")
	public void beginTran() throws Exception{
		selectList_mssql("duzon.beginTran", null);
	}
	
	@SuppressWarnings("unchecked")
	public void commitTran() throws Exception{
		selectList_mssql("duzon.commitTran", null);
	}
	
	@SuppressWarnings("unchecked")
	public int updateOppNo(Map<String, Object> map) throws Exception{
		return (int)update("duzon.updateOppNo", map);
	}
	
	@SuppressWarnings("unchecked")
	public int insertErpSfaSoptyH(List<Map<String, Object>> list) throws Exception{
		return (int)insertBatch("duzon.insertErpSfaSoptyH", list);
	}
	
	//거래처대표테이블 검색
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> searchSalesManInfo(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("duzon.searchSalesManInfo", map);
	}
}
