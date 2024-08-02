package kcg.system.a_team1.prod_calculator_mng.svc;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import common.dao.CmmnDao;
import common.utils.common.CmmnMap;
import common.utils.common.PagingConfig;
import common.utils.mybatis_paginator.domain.PageList;
import kcg.common.svc.CommonSvc;

@Service
public class T1ProdCalcSvc {

	@SuppressWarnings("unused")
	private final Logger log = LoggerFactory.getLogger(getClass());

	@Autowired
	HttpServletRequest request;
	
	@Autowired
	CommonSvc commonSvc;

	@Autowired
	CmmnDao cmmnDao;
	
	public List<CmmnMap> getProdOne(CmmnMap params) {
		List<CmmnMap> result = new ArrayList<CmmnMap>();
		result = cmmnDao.selectList("system.t1_promion_mng.getProdOne" , params);
		System.out.println(result);
		return result;
	} //시험용

//	public void putProdOne(CmmnMap params) {
//		cmmnDao.insert("system.t1_promion_mng.putProdOne", params);
//	} //시험용

	public List<CmmnMap> getProdList(CmmnMap params) {
		List<CmmnMap> resultList = new ArrayList<CmmnMap>();
		resultList = cmmnDao.selectList("system.t1_promion_mng.getProdList" , params);
		return resultList;
	}

	public CmmnMap putProdInfo(CmmnMap param) {
		CmmnMap result = cmmnDao.selectOne("system.t1_promion_mng.putProdInfo" , param);
		return result;
	}

	public void putProdDpst(CmmnMap params) {
//		System.out.println("====================================" + params.get("dsgn_dpst_wrt_dt"));
		
		if (params.get("dsgn_dpst_wrt_dt") != null) {
            try {
            	String dateString = params.get("dsgn_dpst_wrt_dt").toString();
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                LocalDate localDate = LocalDate.parse(dateString, formatter);
                java.sql.Date sqlDate = java.sql.Date.valueOf(localDate);
                params.put("dsgn_dpst_wrt_dt", sqlDate);
            } catch (DateTimeParseException e) {
                System.out.println("Error: Invalid date format for dsgn_dpst_wrt_dt");
            }
        }
		
		int dsgn_dpst_prod_sn = params.getInt("dsgn_dpst_prod_sn");
		String dsgn_dpst_name = params.getString("dsgn_dpst_name");
		int dsgn_dpst_pay_ty_cd = params.getInt("dsgn_dpst_pay_ty_cd");
		int dsgn_dpst_int_tax_ty_cd = params.getInt("dsgn_dpst_int_tax_ty_cd");
		int dsgn_dpst_aply_rate = params.getInt("dsgn_dpst_aply_rate");
		java.sql.Date dsgn_dpst_wrt_dt = (java.sql.Date) params.get("dsgn_dpst_wrt_dt");
		int dsgn_dpst_amt = params.getInt("dsgn_dpst_amt");
		int dsgn_dpst_prd = params.getInt("dsgn_dpst_prd");
		int dsgn_dpst_tot_amt = params.getInt("dsgn_dpst_tot_amt");
		int dsgn_dpst_tot_int = params.getInt("dsgn_dpst_tot_int");
		int dsgn_dpst_int_tax_amt = params.getInt("dsgn_dpst_int_tax_amt");
		int dsgn_dpst_atx_rcve_amt = params.getInt("dsgn_dpst_atx_rcve_amt");
		String dsgn_sav_sim_com = params.getString("dsgn_sav_sim_com");
		String dsgn_dpst_cust_sn = params.getString("dsgn_dpst_cust_sn");
		
		
		params.put("dsgn_dpst_prod_sn", dsgn_dpst_prod_sn);
		params.put("dsgn_dpst_name", dsgn_dpst_name);
		params.put("dsgn_dpst_int_tax_ty_cd", dsgn_dpst_int_tax_ty_cd);
		params.put("dsgn_dpst_aply_rate", dsgn_dpst_aply_rate);
		params.put("dsgn_dpst_wrt_dt", dsgn_dpst_wrt_dt);
		params.put("dsgn_dpst_tot_amt", dsgn_dpst_tot_amt);
		params.put("dsgn_dpst_prd", dsgn_dpst_prd);
		params.put("dsgn_dpst_tot_int", dsgn_dpst_tot_int);
		params.put("dsgn_dpst_int_tax_amt", dsgn_dpst_int_tax_amt);
		params.put("dsgn_dpst_atx_rcve_amt", dsgn_dpst_atx_rcve_amt);
		params.put("dsgn_dpst_cust_sn", dsgn_dpst_cust_sn);
		params.put("dsgn_sav_sim_com", Integer.parseInt(dsgn_sav_sim_com));
		
		
		cmmnDao.insert("system.t1_promion_mng.putProdDpst" , params);
 	} //적금저장

	public void putProdSav(CmmnMap params) {
		
		//if (params.get("dsgn_sav_date") != null) {
         //   try {
          //  	String dateString = params.get("dsgn_sav_date").toString();
         //       DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
         //       LocalDate localDate = LocalDate.parse(dateString, formatter);
         //       java.sql.Date sqlDate = java.sql.Date.valueOf(localDate);
         //       params.put("dsgn_sav_date", sqlDate);
          //  } catch (DateTimeParseException e) {
         //       System.out.println("Error: Invalid date format for dsgn_sav_date");
         //   }
        //}
		
		int dsgn_sav_prod_sn = params.getInt("dsgn_sav_prod_sn");
		String dsgn_sav_name = params.getString("dsgn_sav_name");
		//int dsgn_dpst_pay_ty_cd = params.getInt("dsgn_dpst_pay_ty_cd");
		int dsgn_sav_tax = params.getInt("dsgn_sav_tax");
		int dsgn_sav_aply_rate = params.getInt("dsgn_sav_aply_rate");
		//java.sql.Date dsgn_sav_date = (java.sql.Date) params.get("dsgn_sav_date");
		int dsgn_sav_paid = params.getInt("dsgn_sav_paid");
		int dsgn_sav_target = params.getInt("dsgn_sav_target");
		int dsgn_sav_tot_amt = params.getInt("dsgn_sav_tot_amt");
		int dsgn_sav_tot_int = params.getInt("dsgn_sav_tot_int");
		int dsgn_sav_int_tax_amt = params.getInt("dsgn_sav_int_tax_amt");
		int dsgn_sav_atx_rcve_amt = params.getInt("dsgn_sav_atx_rcve_amt");
		String dsgn_sav_cust_sn = params.getString("dsgn_sav_cust_sn");
		String dsgn_sav_sim_com = params.getString("dsgn_sav_sim_com");
		
		
		params.put("dsgn_sav_prod_sn", dsgn_sav_prod_sn);
		params.put("dsgn_sav_name", dsgn_sav_name);
		params.put("dsgn_sav_atx_rcve_amt", dsgn_sav_atx_rcve_amt);
		params.put("dsgn_sav_tax", dsgn_sav_tax);
		params.put("dsgn_sav_aply_rate", dsgn_sav_aply_rate);
		// params.put("dsgn_sav_date", dsgn_sav_date);
		params.put("dsgn_sav_paid", dsgn_sav_paid);
		params.put("dsgn_sav_target", dsgn_sav_target);
		params.put("dsgn_sav_tot_amt", dsgn_sav_tot_amt);
		params.put("dsgn_sav_tot_int", dsgn_sav_tot_int);
		params.put("dsgn_sav_int_tax_amt", dsgn_sav_int_tax_amt);
		params.put("dsgn_sav_cust_sn", dsgn_sav_cust_sn);
		params.put("dsgn_sav_sim_com", Integer.parseInt(dsgn_sav_sim_com));
		
		
		cmmnDao.insert("system.t1_promion_mng.putProdSav" , params);
	} //예금저장

	public void putProdAcml(CmmnMap params) {
		
		int dsgn_acml_prod_sn = params.getInt("dsgn_acml_prod_sn");
		String dsgn_acml_prod_name = params.getString("dsgn_acml_prod_name");
		int dsgn_acml_pay_ty_cd = params.getInt("dsgn_acml_pay_ty_cd");
		int dsgn_acml_int_tax_ty_cd = params.getInt("dsgn_acml_int_tax_ty_cd");
		int dsgn_acml_aply_rate = params.getInt("dsgn_acml_aply_rate");
		//java.sql.Date dsgn_sav_date = (java.sql.Date) params.get("dsgn_sav_date");
		int dsgn_acml_amt = params.getInt("dsgn_acml_amt");
		int dsgn_acml_goal_amt = params.getInt("dsgn_acml_goal_amt");
		int dsgn_acml_goal_prd = params.getInt("dsgn_acml_goal_prd");
		int dsgn_acml_tot_amt = params.getInt("dsgn_acml_tot_amt");
		int dsgn_acml_tot_int = params.getInt("dsgn_acml_tot_int");
		int dsgn_acml_int_tax_amt = params.getInt("dsgn_acml_int_tax_amt");
		int dsgn_acml_atx_rcve_amt = params.getInt("dsgn_acml_atx_rcve_amt");
		String dsgn_acml_cust_sn = params.getString("dsgn_acml_cust_sn");
		
		
		params.put("dsgn_acml_prod_sn", dsgn_acml_prod_sn);
		params.put("dsgn_acml_prod_name", dsgn_acml_prod_name);
		params.put("dsgn_acml_pay_ty_cd", dsgn_acml_pay_ty_cd);
		params.put("dsgn_acml_int_tax_ty_cd", dsgn_acml_int_tax_ty_cd);
		params.put("dsgn_acml_aply_rate", dsgn_acml_aply_rate);
		// params.put("dsgn_sav_date", dsgn_sav_date);
		params.put("dsgn_acml_amt", dsgn_acml_amt);
		params.put("dsgn_acml_goal_amt", dsgn_acml_goal_amt);
		params.put("dsgn_acml_goal_prd", dsgn_acml_goal_prd);
		params.put("dsgn_acml_tot_amt", dsgn_acml_tot_amt);
		params.put("dsgn_acml_tot_int", dsgn_acml_tot_int);
		params.put("dsgn_acml_int_tax_amt", dsgn_acml_int_tax_amt);
		params.put("dsgn_acml_atx_rcve_amt",dsgn_acml_atx_rcve_amt);
		params.put("dsgn_acml_cust_sn",dsgn_acml_cust_sn);
		
		
		cmmnDao.insert("system.t1_promion_mng.putProdAcml" , params);
	}//목돈저장

	public void putProdLoan(CmmnMap params) {
		
		int dsgn_loan_prod_sn = params.getInt("dsgn_loan_prod_sn");
		String dsgn_loan_name = params.getString("dsgn_loan_name");
		int dsgn_loan_rpty_cd = params.getInt("dsgn_loan_rpty_cd");
		int dsgn_loan_aply_rate = params.getInt("dsgn_loan_aply_rate");
		int dsgn_loan_amt = params.getInt("dsgn_loan_amt");
		//java.sql.Date dsgn_sav_date = (java.sql.Date) params.get("dsgn_sav_date");
		int dsgn_loan_repy_prd = params.getInt("dsgn_loan_repy_prd");
		int dsgn_loan_pay_amt = params.getInt("dsgn_loan_pay_amt");
		int dsgn_loan_circle_pay_amt = params.getInt("dsgn_loan_circle_pay_amt");
		int dsgn_loan_int_tax_amt = params.getInt("dsgn_loan_int_tax_amt");
		int dsgn_loan_tot_pay_amt = params.getInt("dsgn_loan_tot_pay_amt");
		String dsgn_loan_cust_sn = params.getString("dsgn_loan_cust_sn");
		
		
		params.put("dsgn_loan_prod_sn", dsgn_loan_prod_sn);
		params.put("dsgn_loan_name", dsgn_loan_name);
		params.put("dsgn_loan_rpty_cd", dsgn_loan_rpty_cd);
		params.put("dsgn_loan_aply_rate", dsgn_loan_aply_rate);
		params.put("dsgn_loan_amt", dsgn_loan_amt);
		// params.put("dsgn_sav_date", dsgn_sav_date);
		params.put("dsgn_loan_repy_prd", dsgn_loan_repy_prd);
		params.put("dsgn_loan_pay_amt", dsgn_loan_pay_amt);
		params.put("dsgn_loan_circle_pay_amt", dsgn_loan_circle_pay_amt);
		params.put("dsgn_loan_int_tax_amt", dsgn_loan_int_tax_amt);
		params.put("dsgn_loan_tot_pay_amt", dsgn_loan_tot_pay_amt);
		params.put("dsgn_loan_cust_sn", dsgn_loan_cust_sn);
		
		
		cmmnDao.insert("system.t1_promion_mng.putProdLoan" , params);
	} //대출저장
	
	public List<CmmnMap> getRecommendPd(CmmnMap params) {
		List<CmmnMap> resultList = new ArrayList<CmmnMap>();
		resultList = cmmnDao.selectList("system.t1_promion_mng.getRecommendPd" , params);
		return resultList;
	} //상품추천
	
	public PageList<CmmnMap> getListPaging(CmmnMap params, PagingConfig pagingConfig) {
		PageList<CmmnMap> pageList = cmmnDao.selectListPage("system.t1_promion_mng.getListPaging", params, pagingConfig);
		return pageList;
	} // 설계목록 전체리스트
	
	public PageList<CmmnMap> selectOnePaging(CmmnMap params, PagingConfig pagingConfig) {
		PageList<CmmnMap> pageList = cmmnDao.selectListPage("system.t1_promion_mng.selectOnePaging", params, pagingConfig);
		return pageList;
	} // 설계목록 조건검색
	
	public PageList<CmmnMap> statePaging(CmmnMap params, PagingConfig pagingConfig) {
		PageList<CmmnMap> pageList = cmmnDao.selectListPage("system.t1_promion_mng.statePaging", params, pagingConfig);
		return pageList;
	} // 진행 중인 설계목록 

}
