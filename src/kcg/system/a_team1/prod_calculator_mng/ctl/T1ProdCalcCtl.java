package kcg.system.a_team1.prod_calculator_mng.ctl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import common.utils.common.CmmnMap;
import common.utils.common.PagingConfig;
import common.utils.mybatis_paginator.domain.PageList;
import kcg.common.svc.CommonSvc;
import kcg.system.a_team1.prod_calculator_mng.svc.T1ProdCalcSvc;

@Controller
@RequestMapping("/t1_prod_mng")
public class T1ProdCalcCtl {

	@Autowired
	T1ProdCalcSvc t1PromionMngSvc;
	@Autowired
	CommonSvc commonSvc;
	
	@RequestMapping("/dtlA")
	public String dtl(CmmnMap params , Model model) {
		
		String i = params.getString("prod_ty_cd");
	    System.out.println(i); 

//	    model.addAttribute("prod_ty_cd", i);

	    String rslt = "/kcg/system/a_team1/promion_dpst_dtl";

	    if ("2".equals(i)) {
	        rslt = "/kcg/system/a_team1/promion_acml_dtl";
	    } else if ("3".equals(i)) {
	        rslt = "/kcg/system/a_team1/promion_sav_dtl";
	    } else if ("4".equals(i)) {
	        rslt = "/kcg/system/a_team1/promion_loan_dtl";
	    }

	    return rslt;
	}
	
	@RequestMapping("/getProdOne")
	public List<CmmnMap> getProdOne(CmmnMap params) {
		System.out.println(params.getString(params));
		return t1PromionMngSvc.getProdOne(params);
	} // 상품팝업창 상품조건검색
	
	@RequestMapping("/getProdListA")
	public List<CmmnMap> getProdList(CmmnMap params){
		
		return t1PromionMngSvc.getProdList(params);
	} // 상품팝업창 상품목록
	
	@RequestMapping("/putProdInfo")
	public CmmnMap putProdInfo(CmmnMap param) {
		return t1PromionMngSvc.putProdInfo(param);
	} // 상품팝업창에서 상품 클릭 시 상품정보 출력
	
	@RequestMapping("/putProdDpst")
	public void putProdOne(CmmnMap params) {
		
		t1PromionMngSvc.putProdDpst(params);
	} //적금저장
	
	@RequestMapping("/putProdSav")
	public void putProdSav (CmmnMap params) {
		t1PromionMngSvc.putProdSav(params);
	} //예금저장
	
	@RequestMapping("/putProdAcml")
	public void putProdAcml (CmmnMap params) {
		t1PromionMngSvc.putProdAcml(params);
	} //목돈저장
	
	@RequestMapping("/putProdLoan")
	public void putProdLoan (CmmnMap params) {
		t1PromionMngSvc.putProdLoan(params);
	} //대출저장
	@RequestMapping("/getRecommendPd")
	public List<CmmnMap> getRecommendPd(CmmnMap params) {
		return t1PromionMngSvc.getRecommendPd(params);
	} //대출상품추천
	@RequestMapping("/getT1ListPaging") 
	public PageList<CmmnMap> getListPaging(CmmnMap params, PagingConfig pagingConfig) {
		return t1PromionMngSvc.getListPaging(params, pagingConfig);
	} // 설계 목록 리스트
	
	@RequestMapping("/selectOneT1Paging")
	public PageList<CmmnMap> selectOnePaging(CmmnMap params, PagingConfig pagingConfig) {
		return t1PromionMngSvc.selectOnePaging(params, pagingConfig);
	} // 설계 목록 조건 검색
	
	@RequestMapping("/stateT1Paging")
	public PageList<CmmnMap> statePaging(CmmnMap params, PagingConfig pagingConfig) {
		return t1PromionMngSvc.statePaging(params, pagingConfig);
	} // 진행 중인 설계 리스트

	@RequestMapping("/promionList")
	public String openPageCalc(Model model, CmmnMap params) {
		return "kcg/system/a_team1/promion_list";
	} // 설계목록 페이지 
}
