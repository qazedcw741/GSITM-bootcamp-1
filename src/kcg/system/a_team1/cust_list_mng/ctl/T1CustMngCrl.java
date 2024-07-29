package kcg.system.a_team1.cust_list_mng.ctl;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import common.utils.common.CmmnMap;
import common.utils.common.PagingConfig;
import common.utils.mybatis_paginator.domain.PageList;
import kcg.common.svc.CommonSvc;
import kcg.system.a_team1.cust_list_mng.svc.T1CustMngSvc;

@Controller
@RequestMapping("/t1custMng")
public class T1CustMngCrl {
	
	private final Logger log = LoggerFactory.getLogger(getClass());
	
	@Autowired
	T1CustMngSvc t1CustMngSvc;
	@Autowired
	CommonSvc commonSvc;
	
	
	@GetMapping("/T1CustMng")
	public String T1CustListMng(ModelMap model) {
		log.debug(">>> open page list");
		return "kcg/system/a_team1/t1CustInfoList";
	}
	//전체조회리스트
	@RequestMapping("/getT1CustListAll")
	public PageList<CmmnMap> getT1CustListAll(CmmnMap params, PagingConfig pagingConfig) {
		PageList<CmmnMap> pageList = t1CustMngSvc.getT1CustListAll(params, pagingConfig); 
		log.debug("{}",pageList);
		return pageList;
	}
	//조건검색
	@RequestMapping("/getT1SearchList")
	public PageList<CmmnMap> getT1SearchList(CmmnMap params, PagingConfig pagingConfig) {
		PageList<CmmnMap> pageList = t1CustMngSvc.getT1SearchList(params, pagingConfig); 
		log.debug("{}",pageList);
		return pageList;
	}
	//조건검색-담당자 리스트 불러오기용 매소드
	@RequestMapping("/getT1DrtSearchList")
	public PageList<CmmnMap> getT1DrtSearchList(CmmnMap params, PagingConfig pagingConfig) {
		PageList<CmmnMap> pageList = t1CustMngSvc.getT1DrtSearchList(params, pagingConfig); 
		log.debug("{}",pageList);
		return pageList;
	}
	//고객상세정보(팝업)
	@RequestMapping("/getT1CustInfo")
	public CmmnMap getT1CustInfo(CmmnMap params){
		return t1CustMngSvc.getT1CustInfo(params); 
	}
	@RequestMapping("getT1CustInfoProd")
	public CmmnMap getT1CustInfoProd (CmmnMap params) {
		return t1CustMngSvc.getT1CustInfoProd(params);
	}
	//고객관리카드(팝업)
	@RequestMapping("/getT1CustCardDetail")
	public CmmnMap getCustCardDetail(CmmnMap params) {
		return t1CustMngSvc.getT1CustCardDetail(params);
	}
	//관리대장(팝업)
	@RequestMapping("/getT1CustCardList")
	public PageList<CmmnMap> getT1CustCardList(CmmnMap params, PagingConfig pagingConfig) {
		PageList<CmmnMap> pageList = t1CustMngSvc.getT1CustCardList(params, pagingConfig); 
		log.debug("{}",pageList);
		return pageList;
	}
	//담당자 정보(용도 불명)
	@RequestMapping("/getT1DrtInfo")
	public List<CmmnMap> getT1DrtInfo(CmmnMap params){
		return t1CustMngSvc.getT1DrtInfo(params); 
	}
	//용도불명
	@RequestMapping("/getT1InitInfo")
	public CmmnMap getT1InitInfo(CmmnMap params) {
		return t1CustMngSvc.getT1InitInfo(params);
	}
	 //이벤트 페이지 고객 리스트
	  @RequestMapping("/getT1CustList")
	  public List<CmmnMap> getList(CmmnMap params) {
			return t1CustMngSvc.getT1CustList(params);
	  }
}