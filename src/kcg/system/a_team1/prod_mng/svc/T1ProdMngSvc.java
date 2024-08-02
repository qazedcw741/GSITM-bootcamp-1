package kcg.system.a_team1.prod_mng.svc;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import common.dao.CmmnDao;
import common.utils.common.CmmnMap;
import common.utils.common.PagingConfig;
import common.utils.mybatis_paginator.domain.PageList;

@Service
public class T1ProdMngSvc {
	
	@Autowired
	CmmnDao cmmnDao;


	public PageList<CmmnMap> getProdListA(CmmnMap params, PagingConfig pagingConfig) {
		return cmmnDao.selectListPage("system.a_team1_prod_mng.getList", params, pagingConfig);
	}


	public PageList<CmmnMap> getProdSearch(CmmnMap params, PagingConfig pagingConfig) {		
		
		if(!(params.get("prod_payment_cycle").equals("") || params.get("prod_payment_cycle") == "")) {
			String prod_name = params.getString("prod_name");
			params.put("prod_name", prod_name);			
			String prod_type = params.getString("prod_type");
			params.put("prod_type", prod_type);			
			String prod_start_sale = params.getString("prod_start_sale");
			params.put("prod_start_sale", prod_start_sale);			
			int prod_payment_cycle = params.getInt("prod_payment_cycle");
			params.put("prod_payment_cycle", prod_payment_cycle);
		}		
		
		return cmmnDao.selectListPage("system.a_team1_prod_mng.getSearch", params, pagingConfig);
	}


	public CmmnMap getInfo(CmmnMap params) {
		
		int prod_sn = params.getInt("prod_sn");
		params.put("prod_sn", prod_sn);

		CmmnMap getInfo = cmmnDao.selectOne("system.a_team1_prod_mng.getInfo", params);
		List<CmmnMap> getHist = cmmnDao.selectList("system.a_team1_prod_mng.getHist", params);
		
		
		//현재 날짜 currentDate에 넣어줌
		LocalDate date = LocalDate.now();
		String currentDate = date.toString();
		
		
		String strHist = "";
		//리스트에 있는 이율 테이블의 날짜와 이율을 문장+줄바꿈을 넣어서 String 하나에 쑤셔박음
		for(CmmnMap map : getHist) {
			strHist = strHist + map.getString("pr_stdt") + " ~ " + map.getString("pr_eddt") + "   (최저)" + map.get("pr_min_ir") + "% (최고)" + map.get("pr_max_ir") + "%\n";
			//현재 날짜가 이율 시작 이상/마감 날짜 이하 이면 getInfo에 두 날짜를 넣는다
			
			//테스트용 출력
//			System.out.println("pr_stdt: " + map.getString("pr_stdt") + ", currentDate: " + currentDate + ", pr_stdt, compare: " + map.getString("pr_stdt").compareTo(currentDate));
//			System.out.println("pr_eddt" + map.getString("pr_eddt") + ", currentDate: " + currentDate + ", pr_eddt, compare: " + map.getString("pr_eddt").compareTo(currentDate));			
			
			if(map.getString("pr_stdt").compareTo(currentDate) <= 0 && map.getString("pr_eddt").compareTo(currentDate) >= 0) {
				getInfo.put("pr_min_ir", map.getString("pr_min_ir"));
				getInfo.put("pr_max_ir", map.getString("pr_max_ir"));
			}
		}
		getInfo.put("str_hist", strHist);				
		return getInfo;		
	}


	public void delete(CmmnMap params) {
		int prod_sn = params.getInt("prod_sn");
		params.put("prod_sn", prod_sn);
		cmmnDao.delete("system.a_team1_prod_mng.delete", params);		
	}


	public CmmnMap save(CmmnMap params) {		
		
		String prod_name = params.getString("prod_name");
		params.put("prod_name", prod_name);	
		String prod_type = params.getString("prod_type");
		params.put("prod_type", prod_type);
		int prod_min_amount = params.getInt("prod_min_amount");
		params.put("prod_min_amount", prod_min_amount);
		int prod_max_amount = params.getInt("prod_max_amount");
		params.put("prod_max_amount", prod_max_amount);
		int prod_payment_cycle = params.getInt("prod_payment_cycle");
		params.put("prod_payment_cycle", prod_payment_cycle);
		
		//input[type=date]값을 string에 담아서 Date로 변환하기 위한 포맷
		SimpleDateFormat formatter = new SimpleDateFormat("YYYY-MM-DD");				
		
		String prod_start_period = params.getString("prod_start_period");		
		params.put("prod_start_period", LocalDate.parse(prod_start_period));		
		String prod_deadline_period = params.getString("prod_deadline_period");
		params.put("prod_deadline_period", LocalDate.parse(prod_deadline_period));
		
		int prod_interest_taxation = params.getInt("prod_interest_taxation");
		params.put("prod_interest_taxation", prod_interest_taxation);
		int prod_sales_status = params.getInt("prod_sales_status");
		params.put("prod_sales_status", prod_sales_status);
		
		String prod_start_sale = params.getString("prod_start_sale");
		params.put("prod_start_sale", LocalDate.parse(prod_start_sale));
		String prod_end_sale = params.getString("prod_end_sale");
		params.put("prod_end_sale", LocalDate.parse(prod_end_sale));
		
		int pr_max_ir = params.getInt("pr_max_ir");
		params.put("pr_max_ir", pr_max_ir);
		int pr_min_ir = params.getInt("pr_min_ir");
		params.put("pr_min_ir", pr_min_ir);
		
		//params.save_mode에 저장되어 있는 것에 따라 상품테이블은 update/insert
		//str_hist는 무조건 insert
		if("update".equals(params.getString("save_mode"))) {			
			int prod_sn = params.getInt("prod_sn");
			params.put("prod_sn", prod_sn);			
			cmmnDao.update("system.a_team1_prod_mng.update", params);			
		} else {			
			cmmnDao.insert("system.a_team1_prod_mng.insert", params);
			//insertHist.pr_code에 넣을 prod_sn값을 받아와서 넣어 줌  
			CmmnMap sn = cmmnDao.selectOne("system.a_team1_prod_mng.selectOne", params);
			params.put("prod_sn", sn.getInt("prod_sn"));
		}
		
			cmmnDao.insert("system.a_team1_prod_mng.insertHist", params);
		
			
		return new CmmnMap().put("prod_sn", params.getInt("prod_sn"));
	}

}
