package kcg.system.a_team1.exchange_mng.ctl;

import org.json.simple.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kcg.system.a_team1.exchange_mng.svc.GetExchangeData;


@Controller
@RequestMapping("/t1_exchange_mng")
public class T1ExchangeMngCtl {
		

	GetExchangeData getExchangeData;
	
	@RequestMapping("/main")
	public String exchangeMain() {
		String url = "kcg/system/a_team1/main";
		return url;	
	}
	
	@RequestMapping("/getListMap")
	public JSONArray getListMap() {
		// 시연 하기 전에
		// postman 용 url: https://www.koreaexim.go.kr/site/program/financial/exchangeJSON?authkey=qJ9Ix3brcEAtwLnwxub2gZWSuUuNKu0p&searchdate=20240621&data=AP01		
		
		JSONArray gatheringArray = GetExchangeData.getExchangeRate();
		System.out.println(gatheringArray.toString());	
		
		return gatheringArray;		
	}
	
	
	
	
}
