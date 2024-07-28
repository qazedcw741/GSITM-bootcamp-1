package kcg.system.a_team1.cust_event_mng.svc;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import common.dao.CmmnDao;
import common.utils.common.CmmnMap;
import common.utils.common.PagingConfig;
import common.utils.mybatis_paginator.domain.PageList;

@Service
public class ATeam1CustEventSvc {
	
	@Autowired
	CmmnDao cmmnDao;
	
	public PageList<CmmnMap> getList(CmmnMap params, PagingConfig pagingConfig) {
		return cmmnDao.selectListPage("system.a_team1.getList", params, pagingConfig);
	} 
	
	public PageList<CmmnMap> getListAll(CmmnMap params, PagingConfig pagingConfig) {
		return cmmnDao.selectListPage("system.a_team1.getListAll", params, pagingConfig);
	}

	public CmmnMap getInfo(CmmnMap params) {
		CmmnMap t1 = cmmnDao.selectOne("system.a_team1.getInfo", params);
		return t1;
	}
	
	public PageList<CmmnMap> getListEvent(CmmnMap params, PagingConfig pagingConfig) {
		return cmmnDao.selectListPage("system.a_team1.getListEvent", params, pagingConfig);
	}
}
