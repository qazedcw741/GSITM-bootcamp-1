package kcg.system.a_team1.prod_mng.ctl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import common.utils.common.CmmnMap;
import common.utils.common.PagingConfig;
import common.utils.mybatis_paginator.domain.PageList;
import kcg.system.a_team1.prod_mng.svc.T1ProdMngSvc;



@Controller
@RequestMapping("/t1_prod_mng")
public class T1ProdMngCtl {
	
	private final Logger log = LoggerFactory.getLogger(getClass());
	
	@Autowired
	T1ProdMngSvc t1ProdMngSvc;	
	
	
	//상품 리스트 빈페이지
	@RequestMapping("/ProdList")
	public String ProdList(ModelMap model) {
		log.debug(">>> open page list");
		
		return "kcg/system/a_team1/ProdList";
	}
	
	//상품 리스트 전체 리스트
	@RequestMapping("/getProdList")
	public PageList<CmmnMap> getProdListA(CmmnMap params, PagingConfig pagingConfig){
		PageList<CmmnMap> pageList = t1ProdMngSvc.getProdListA(params, pagingConfig);
		log.debug("{}",pageList);
		return pageList;
	}
	
	//상품 리스트 검색 리스트
	@RequestMapping("/getProdSearch")
	public PageList<CmmnMap> getProdSearch(CmmnMap params, PagingConfig pagingConfig){
		PageList<CmmnMap> pageList = t1ProdMngSvc.getProdSearch(params, pagingConfig);
		log.debug("{}",pageList);
		return pageList;
	}		
	
	//상품 상세/수정페이지용 단건 정보
	@RequestMapping("/getInfo")
	public CmmnMap getInfo(CmmnMap params){
		CmmnMap pageList = t1ProdMngSvc.getInfo(params);
		log.debug("{}",pageList);
		System.out.println("params.toString: " + params.toString());
		return pageList;
	}
	
	//상품 상세/수정 빈페이지 + 파람으로 가져온 시리얼 넘버 전송
	@RequestMapping("/dtl")
	public String dtlA(Model model, CmmnMap params) {
		log.debug(">>> open page list");
		model.addAttribute("prod_sn", params.getInt("prod_sn"));
		return "kcg/system/a_team1/ProdDetail";
	}
	
	//상품 상세/수정 페이지 정보 
	@RequestMapping("/detail")
	public CmmnMap detail(CmmnMap params) {
		CmmnMap map = t1ProdMngSvc.getInfo(params);
		log.debug("{}",map);
		return map;
	}
	
	//상품 상세/수정 페이지 삭제
	@RequestMapping("/delete")
	public void delete(CmmnMap params) {
		t1ProdMngSvc.delete(params);
	}
	
	//상품 상세/수정 페이지 저장 및 수정(서비스 단에서 save_mode 비교해서 다른 query문 적용)
	@RequestMapping("/save")
	public CmmnMap save(CmmnMap params) {
		System.out.println("savesavesavesavesave: " + params.toString());
		return t1ProdMngSvc.save(params);
	}
	
	
}
