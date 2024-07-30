package kcg.system.a_team1.cust_mng.ctl;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import common.utils.common.CmmnMap;
import kcg.common.svc.CommonSvc;
import kcg.system.a_team1.cust_mng.svc.a_team1_CustMngSvc;
import kcg.system.cust_mng.svc.CustMngSvc;

@RequestMapping("/a_team1_custMng")
@Controller
public class a_team1_CustMngCtl {

	private final Logger log = LoggerFactory.getLogger(getClass());

	@Autowired
	a_team1_CustMngSvc custMngSvc;

	@Autowired
	CommonSvc commonSvc;

	/**
	 * 관리 페이지를 호출한다.
	 * 
	 * @param model
	 * @return
	 */

	/* 고객정보 관리 페이지 이동 */
	@RequestMapping("/a_team1_custInfoMng")
	public String openCustInfoMng(ModelMap model) {
		log.debug(">>> open new page list");

		return "kcg/system/a_team1/a_team1_custInfoMng";
	}

	/* 전체 검색 */
	@RequestMapping("/searchAllAjax")
	public List<CmmnMap> getCustAllList() {
		/* 전채 검색 선택 시 params 없이 List return */
		log.debug("SearchAll-전체 검색");

		/* a_team1_CustMngSvc - getCustAllList */
		return custMngSvc.getCustAllList();
	}

	/* 조건 검색 */
	@RequestMapping("/searchOneAjax")
	public List<CmmnMap> getCustOneList(CmmnMap params) {

		log.debug("SearchOne-조건 검색" + params);

		/* a_team1_CustMngSvc - getCustOneList - params data 전달 */
		return custMngSvc.getCustOneList(params);
	}

	/* radio 선택 : Cust */
	@RequestMapping("/radioCustOneAjax")
	public List<CmmnMap> getRadioCustOne(CmmnMap params) {

		log.debug("RadioOne-라디오 버튼 선택" + params);

		/* a_team1_CustMngSvc - getRadioCustOne - params data 전달 */
		return custMngSvc.getRadioCustOne(params);
	}
	
	/* 등록 버튼 - 고객 정보 */
	@RequestMapping("/insertCustInfo")
	public CmmnMap insertCustInfo(CmmnMap params) {

		log.debug("insertCustInfo - 등록 버튼" + params);

		/* a_team1_CustMngSvc - insertCustInfo - params data 전달 */
		return custMngSvc.insertCustInfo(params);
	}

	/* 수정 버튼 - 고객 정보 */
	@RequestMapping("/updateCustInfo")
	public CmmnMap updateCustInfo(CmmnMap params) {

		log.debug("updateCustInfo - 수정 버튼" + params);

		/* a_team1_CustMngSvc - updateCustInfo - params data 전달 */
		return custMngSvc.updateCustInfo(params);
	}

	/* 삭제 버튼 - 고객 정보 */
	@RequestMapping("/deleteCustInfo")
	public CmmnMap deleteCustInfo(CmmnMap params) {

		log.debug("deleteCustInfo - 삭제 버튼" + params);

		/* a_team1_CustMngSvc - deleteCustInfo - params data 전달 */
		return custMngSvc.deleteCustInfo(params);
	}

	/* 담당자 설정 */
	@RequestMapping("/getPicInfo")
	public List<CmmnMap> getPicInfo(CmmnMap params){
		return custMngSvc.getPicInfo(params); 
	}
	
	@RequestMapping("/getInitInfo")
	public CmmnMap getInitInfo(CmmnMap params) {
		return custMngSvc.getInitInfo(params);
	}
}
