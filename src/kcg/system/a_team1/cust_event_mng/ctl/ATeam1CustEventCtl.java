package kcg.system.a_team1.cust_event_mng.ctl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import common.utils.common.CmmnMap;
import common.utils.common.PagingConfig;
import common.utils.mybatis_paginator.domain.PageList;
import kcg.system.a_team1.cust_event_mng.svc.ATeam1CustEventSvc;

@Controller
@RequestMapping("/aTeam1/custEventMng")
public class ATeam1CustEventCtl {
	
	private final Logger log = LoggerFactory.getLogger(getClass());

	@Autowired
	ATeam1CustEventSvc aTeam1CustEventSvc;

	@RequestMapping("/custEvent")
	public String custEventList() {
		return "kcg/system/a_team1/ATeam1CustEventList";
	}
	
	@RequestMapping("/getT1List")
	public PageList<CmmnMap> getList(CmmnMap params, PagingConfig pagingConfig) {
		PageList<CmmnMap> pageList = aTeam1CustEventSvc.getList(params, pagingConfig); 
		log.debug("{}",pageList);
		return pageList;
	}
	
	@RequestMapping("/getT1ListAll")
	public PageList<CmmnMap> getListAll(CmmnMap params, PagingConfig pagingConfig) {
		PageList<CmmnMap> pageList = aTeam1CustEventSvc.getListAll(params, pagingConfig); 
		log.debug("{}",pageList);
		return pageList;
	}
	
	@RequestMapping("/getT1Info")
	public CmmnMap getInfo(CmmnMap params) {
		return aTeam1CustEventSvc.getInfo(params);
	}
	
	@RequestMapping("/getT1ListEvent")
	public PageList<CmmnMap> getListEvent(CmmnMap params, PagingConfig pagingConfig) {
		PageList<CmmnMap> pageList = aTeam1CustEventSvc.getListEvent(params, pagingConfig); 
		log.debug("{}",pageList);
		return pageList;
	}
		
}
