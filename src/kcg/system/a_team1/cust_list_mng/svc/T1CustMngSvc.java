package kcg.system.a_team1.cust_list_mng.svc;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import common.dao.CmmnDao;
import common.utils.common.CmmnMap;
import common.utils.common.PagingConfig;
import common.utils.mybatis_paginator.domain.PageList;

@Service

public class T1CustMngSvc {
	
	@Autowired
	CmmnDao cmmnDao;
	
	public PageList<CmmnMap> getT1CustListAll(CmmnMap params, PagingConfig pagingConfig) {
		
		return cmmnDao.selectListPage("system.a_1team_cust_mng.getT1CustListAll", params, pagingConfig);
	}

	public PageList<CmmnMap> getT1SearchList(CmmnMap params, PagingConfig pagingConfig) {
		
		return cmmnDao.selectListPage("system.a_1team_cust_mng.getT1SearchList", params, pagingConfig);
	}

	public PageList<CmmnMap> getT1DrtSearchList(CmmnMap params, PagingConfig pagingConfig) {
		return cmmnDao.selectListPage("system.a_1team_cust_mng.getT1DrtSearchList", params, pagingConfig);
	}

	public CmmnMap getT1CustInfo(CmmnMap params) {
		CmmnMap rslt = cmmnDao.selectOne("system.a_1team_cust_mng.getT1CustInfo", params);
		return rslt;
	}


	public PageList<CmmnMap> getT1CustCardList(CmmnMap params, PagingConfig pagingConfig) {
		return cmmnDao.selectListPage("system.a_1team_cust_mng.getT1CustCardList", params, pagingConfig);
	}

	public CmmnMap getT1CustCardDetail(CmmnMap params) {
		CmmnMap rslt = cmmnDao.selectOne("system.a_1team_cust_mng.getT1CustCardDetail", params);
		return rslt;
	}

	public List<CmmnMap> getT1DrtInfo(CmmnMap params) {
		List<CmmnMap> dataList = cmmnDao.selectList("system.a_1team_cust_mng.getT1DrtInfo", params);
		return dataList;
	}

	public CmmnMap getT1InitInfo(CmmnMap params) {
		CmmnMap rslt = cmmnDao.selectOne("system.a_1team_cust_mng.getT1InitInfo", params);
		return rslt;
	}

	public List<CmmnMap> getT1CustList(CmmnMap params) {
		return cmmnDao.selectList("system.a_1team_cust_mng.getT1CustList", params);

	}

	public CmmnMap getT1CustInfoProd(CmmnMap params) {
		CmmnMap rslt = cmmnDao.selectOne("system.a_1team_cust_mng.getT1CustInfoProd",params);
		return rslt;
	}
}