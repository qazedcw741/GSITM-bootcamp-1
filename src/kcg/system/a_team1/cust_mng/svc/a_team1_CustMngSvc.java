package kcg.system.a_team1.cust_mng.svc;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.sound.midi.Soundbank;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import common.dao.CmmnDao;
import common.dao.IamDao;
import common.utils.common.CmmnMap;
import kcg.common.svc.CommonSvc;
import kcg.login.vo.UserInfoVO;

@Service
public class a_team1_CustMngSvc {

	@Autowired
	HttpServletRequest request;

	@Autowired
	CommonSvc commonSvc;

	/* 프로젝트 Dao : mapper */
	@Autowired
	CmmnDao cmmnDao;

	@Autowired
	IamDao iamDao;

	/* CmmnMap : 프로젝트 data 정의 */

	/* <mapper namespace='system.a_team1_cust_mng'> */

	/* 모든 고객 검색 */
	public List<CmmnMap> getCustAllList() {

		/* List 형식의 CmmnMap data를 custAllList(변수명)으로 정의 */
		/*
		 * = cmmnDao에서 selectList를 활용 xml : namespace='system.a_team1_cust_mng' select
		 * id = 'getCustAllList'인 부분
		 */
		List<CmmnMap> custAllList = cmmnDao.selectList("system.a_team1_cust_mng.getCustAllList");

		return custAllList;
	}

	/* 조건 검색 */
	public List<CmmnMap> getCustOneList(CmmnMap params) {

		/* List 형식의 CmmnMap data를 custOneList(변수명)으로 정의 */
		/*
		 * = cmmnDao에서 selectList를 활용 xml : namespace='system.a_team1_cust_mng' select
		 * id = 'getCustOneList'인 부분
		 */
		List<CmmnMap> custOneList = cmmnDao.selectList("system.a_team1_cust_mng.getCustOneList", params);

		return custOneList;
	}

	/* Radio 버튼 선택 : Cust */
	public List<CmmnMap> getRadioCustOne(CmmnMap params) {

		/* List 형식의 CmmnMap data를 radioCustOne(변수명)으로 정의 */
		/*
		 * = cmmnDao에서 selectOne를 활용 xml : namespace='system.a_team1_cust_mng' select id
		 * = 'getRadioCustOne'인 부분
		 */
		List<CmmnMap> radioCustOne = cmmnDao.selectList("system.a_team1_cust_mng.getRadioCustOne", params);

		return radioCustOne;
	}

	
	/* 등록 버튼 */
	public CmmnMap insertCustInfo(CmmnMap params) {

		/* string타입 : params 객체로부터 받은 값을 모두 문자열로 처리 */
		String wrt_dt = params.getString("wrt_dt");
		String cust_name = params.getString("cust_name");
		String cust_home_telno = params.getString("cust_home_telno");
		String cust_mbl_telno = params.getString("cust_mbl_telno");
		String cust_pridtf_no = params.getString("cust_pridtf_no");
		String cust_email = params.getString("cust_email");
		String occp_ty_cd = params.getString("occp_ty_cd");
		String cust_addr = params.getString("cust_addr");
		String cust_cr = params.getString("cust_cr");
		String cust_yn = params.getString("cust_yn");
		String cnsl_date = params.getString("cnsl_date");
		String cnsl_details = params.getString("cnsl_details");
		int drt_sn = params.getInt("drt_sn");
	
		if(cnsl_date != null && cnsl_details != null && !cnsl_date.equals("") && !cnsl_details.equals("")) {
			
			/* 다시 params 객체에 문자열로 설정하여 저장하는 과정 */
			params.put("wrt_dt", wrt_dt);
			params.put("cust_name", cust_name);
			params.put("cust_home_telno", cust_home_telno);
			params.put("cust_mbl_telno", cust_mbl_telno);
			params.put("cust_pridtf_no", cust_pridtf_no);
			params.put("cust_email", cust_email);
			params.put("occp_ty_cd", occp_ty_cd);
			params.put("cust_addr", cust_addr);
			params.put("cust_cr", cust_cr);
			params.put("cust_yn", cust_yn);
			params.put("cnsl_date", cnsl_date);
			params.put("cnsl_details", cnsl_details);
			params.put("drt_sn", drt_sn);

			/*
			 * = cmmnDao에서 insert를 활용 xml : namespace='system.a_team1_cust_mng' select id =
			 * 'insertCustInfo'인 부분
			 */
			cmmnDao.insert("system.a_team1_cust_mng.insertAllInfo", params);
			return new CmmnMap().put("status", "OK");
			
		}else {
			params.put("wrt_dt", wrt_dt);
			params.put("cust_name", cust_name);
			params.put("cust_home_telno", cust_home_telno);
			params.put("cust_mbl_telno", cust_mbl_telno);
			params.put("cust_pridtf_no", cust_pridtf_no);
			params.put("cust_email", cust_email);
			params.put("occp_ty_cd", occp_ty_cd);
			params.put("cust_addr", cust_addr);
			params.put("cust_cr", cust_cr);
			params.put("cust_yn", cust_yn);
			params.put("drt_sn", drt_sn);
			
			cmmnDao.insert("system.a_team1_cust_mng.insertCustInfo", params);
			return new CmmnMap().put("status", "OK");
		}
		
	}

	/* 수정 버튼 */
	public CmmnMap updateCustInfo(CmmnMap params) {

		/* string타입 : params 객체로부터 받은 값을 모두 문자열로 처리 */
		String wrt_dt = params.getString("wrt_dt");
		int cust_sn = params.getInt("cust_sn");
		String cust_name = params.getString("cust_name");
		String cust_home_telno = params.getString("cust_home_telno");
		String cust_mbl_telno = params.getString("cust_mbl_telno");
		String cust_pridtf_no = params.getString("cust_pridtf_no");
		String cust_email = params.getString("cust_email");
		String occp_ty_cd = params.getString("occp_ty_cd");
		String cust_addr = params.getString("cust_addr");
		String cust_cr = params.getString("cust_cr");
		String cnsl_date = params.getString("cnsl_date");
		String cnsl_details = params.getString("cnsl_details");
		int drt_sn = params.getInt("drt_sn");
		
		if (cnsl_date != null && cnsl_details != null && !cnsl_date.equals("") && !cnsl_details.equals("")) {
		    // cnsl_date와 cnsl_details가 모두 null이 아닌 경우 실행할 코드
		    params.put("wrt_dt", wrt_dt);
		    params.put("cust_sn", cust_sn);
		    params.put("cust_name", cust_name);
		    params.put("cust_home_telno", cust_home_telno);
		    params.put("cust_mbl_telno", cust_mbl_telno);
		    params.put("cust_pridtf_no", cust_pridtf_no);
		    params.put("cust_email", cust_email);
		    params.put("occp_ty_cd", occp_ty_cd);
		    params.put("cust_addr", cust_addr);
		    params.put("cust_cr", cust_cr);
		    params.put("cnsl_date", cnsl_date);
		    params.put("cnsl_details", cnsl_details);
		    params.put("drt_sn", drt_sn);

		    cmmnDao.update("system.a_team1_cust_mng.updateCustInfo", params);
		    cmmnDao.update("system.a_team1_cust_mng.insertCnslInfo", params);
		    
		    return new CmmnMap().put("status", "OK");
		} else {
		    // cnsl_date 또는 cnsl_details 중 하나라도 null인 경우 실행할 코드
		    params.put("wrt_dt", wrt_dt);
		    params.put("cust_sn", cust_sn);
		    params.put("cust_name", cust_name);
		    params.put("cust_home_telno", cust_home_telno);
		    params.put("cust_mbl_telno", cust_mbl_telno);
		    params.put("cust_pridtf_no", cust_pridtf_no);
		    params.put("cust_email", cust_email);
		    params.put("occp_ty_cd", occp_ty_cd);
		    params.put("cust_addr", cust_addr);
		    params.put("cust_cr", cust_cr);
		    params.put("drt_sn", drt_sn);
		    
		    cmmnDao.update("system.a_team1_cust_mng.updateCustInfo", params);
		    return new CmmnMap().put("status", "OK");
		}
		
	}

	/* 삭제 버튼 */
	public CmmnMap deleteCustInfo(CmmnMap params) {

		/* string타입 : params 객체로부터 받은 값을 모두 문자열로 처리 */
		int cust_sn = params.getInt("cust_sn");
		String cust_yn = params.getString("cust_yn");

		/* 다시 params 객체에 문자열로 설정하여 저장하는 과정 */
		params.put("cust_sn", cust_sn);
		params.put("cust_yn", cust_yn);

		/*
		 * = cmmnDao에서 delete를 활용 xml : namespace='system.a_team1_cust_mng' select id =
		 * 'deleteCustInfo'인 부분
		 */
		cmmnDao.delete("system.a_team1_cust_mng.deleteCustInfo", params);

		return new CmmnMap().put("status", "OK");
	}
	
	/* 담당자 */
	public List<CmmnMap> getPicInfo(CmmnMap params) {
		List<CmmnMap> dataList = cmmnDao.selectList("system.a_team1_cust_mng.getPicInfo", params);
		
		return dataList;
	}
	
	public CmmnMap getInitInfo(CmmnMap params) {
		CmmnMap rslt = cmmnDao.selectOne("system.a_team1_cust_mng.getInitInfo", params);
		
		return rslt;
	}
}
