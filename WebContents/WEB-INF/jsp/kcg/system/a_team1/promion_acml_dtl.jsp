<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/WEB-INF/jsp/kcg/_include/system/header_meta.jsp" flush="false"/>
	<!-- Imported styles on this page -->
	<link rel="stylesheet" href="/static_resources/system/js/datatables/datatables.css">
	<link rel="stylesheet" href="/static_resources/system/js/select2/select2-bootstrap.css">
	<link rel="stylesheet" href="/static_resources/system/js/select2/select2.css">
	<link rel="stylesheet" href="/static_resources/system/js/datatables/promion.css">
	
	<!-- Bilboard Chart(https://naver.github.io/billboard.js) -->
	<script src="https://d3js.org/d3.v6.min.js"></script>
	<script src="/static_resources/system/js/datatables/billboard.js"></script>
	<link rel="stylesheet" href="/static_resources/system/js/datatables/billboard.css">
	
	<title>금융계산기</title>
</head>
<body class="page-body">

<div class="page-container">

	<jsp:include page="/WEB-INF/jsp/kcg/_include/system/sidebar-menu.jsp" flush="false"/>

	<div class="main-content">

		<jsp:include page="/WEB-INF/jsp/kcg/_include/system/header.jsp" flush="false"/>
		
		<ol class="breadcrumb bc-3">
			<li><a href="#none" onclick="cf_movePage('/system')"><i class="fa fa-home"></i>Home</a></li>
			<li class="active"><strong>금융계산기</strong></li>
		</ol>
	
		<h2>프로모션 > 금융계산기 (목돈마련적금 설계)</h2>
		<br/>
		<div class="row">
			<div class="dataTables_wrapper flex" id="vueapp">
			<template>
			
				<div class="left flex-column flex-gap-10 flex-40" v-if="info.simpl_ty_cd == '1'">
                    <h4>고객정보</h4>
                    <div class="form-group">
                        <label>작성일자:</label>
                        <input class="form-control" v-model="custInfo.wrt_dt" disabled />
                    </div>
                    <div class="form-group">
                        <label>성명:</label>
                        <input class="form-control" v-model="custInfo.cust_name" disabled />
                        <button type="button" class="btn" @click="popupCust()">
                             <i class="fa fa-search"></i>
                         </button>
                    </div>
                    <div class="form-group">
                        <label>실명번호:</label>
                        <input class="form-control" v-model="custInfo.cust_pridtf_no" disabled />
                    </div>
                    <div class="form-group">
                        <label>E-mail:</label>
                        <input class="form-control" v-model="custInfo.cust_addr" disabled />
                    </div>
                    <div class="form-group">
                        <label>전화번호:</label>
                        <input class="form-control" v-model="custInfo.cust_home_telno" disabled />
                    </div>
                    <div class="form-group">
                        <label>핸드폰번호:</label>
                        <input class="form-control" v-model="custInfo.cust_mbl_telno" disabled />
                    </div>
                    <div class="form-group">
                        <label>직업:</label>
                        <input class="form-control" v-model="custInfo.cust_cr" disabled />
                    </div>
                    <div class="form-group">
                        <label>주소:</label>
                        <input class="form-control" v-model="custInfo.cust_addr" disabled />
                    </div>
                    <div class="form-group">
                        <label>신용점수:</label>
                        <input class="form-control" v-model="custInfo.cust_credit_score" disabled />
                    </div>
					<div v-if="recommendPdFiltered.length > 0">
						<h4>추천 상품</h4>
						<ul>
							<li v-for="prod in recommendPdFiltered" :key="prod.prod_sn">
								{{ prod.prod_name }} (금리: {{ prod.pr_min_ir }}% ~ {{
								prod.pr_max_ir }}%)</li>
						</ul>
					</div>
					<div v-else>추천 상품이 없습니다.</div>
						</div>
                
                
				<div class="right flex-column flex-100">
                    <div class="right-top">
                        <ul class="nav">
                            <li class="nav-tab" @click="tabChange(1)">적금 설계</li>
                            <li class="nav-tab active" @click="tabChange(2)">목돈마련적금 설계</li>
                            <li class="nav-tab" @click="tabChange(3)">예금 설계</li>
                            <li class="nav-tab" @click="tabChange(4)">대출 설계</li>
                        </ul>
                        <div class="nav-content flex-column flex-gap-10">
                        	<!--<div class="form-group" style="justify-content: left">
                                <label>설계번호:</label>
                                <input class="form-control" id="prod_ds_sn" v-model="info.prod_ds_sn" disabled />
                            </div>-->
                            <div class="form-group" style="justify-content: left">
                                <label>상품선택:</label>
                                <input class="form-control" id="prod_cd" v-model="prod.prod_sn" readonly />
                                <input class="form-control" id="prod_nm" v-model="prod.prod_name" />
                                <button type="button" class="btn" @click="popupProd()">
                                    <i class="fa fa-search"></i>
                                </button>
                            </div>
                            <div class="form-group" style="justify-content: left">
                                <label>납입주기:</label>
                                <select class="form-control" id="pay_ty_cd" v-model="prod.prod_payment_cycle" style="padding-top: 3px;" readonly>
									<option value="1">월납</option>
									<option value="2">년납</option>
									<option value="3">일시납</option>
								</select>
                            </div>
                            <div class="form-group" style="justify-content: left">
                                <label>목표금액 (원):</label>
                                <input class="form-control flex-50" type="text" id="circle_acml_amt" v-model="calc.dsgn_acml_goal_amt" style="width: 700px;"/>
                                <button type="button" class="btn btn-transparent flex-20" @click="setCircleAcmlAmt(100)">+100만원</button>
                                <button type="button" class="btn btn-transparent flex-20" @click="setCircleAcmlAmt(500)">+500만원</button>
                                <button type="button" class="btn btn-transparent flex-20" @click="setCircleAcmlAmt(1000)">+1000만원</button>
                                <button type="button" class="btn btn-navy flex-20" @click="setCircleAcmlAmt(0)">정정</button>
                            </div>
                            <div class="form-group" style="justify-content: left">
                                <label>목표기간 (개월):</label>
                                <input class="form-control flex-50" type="text" id="goal_prd" v-model="calc.dsgn_acml_goal_prd" style="width: 700px;"/>
                                <button type="button" class="btn btn-transparent flex-20" @click="setGoalPrd(3)">+3개월</button>
                                <button type="button" class="btn btn-transparent flex-20" @click="setGoalPrd(6)">+6개월</button>
                                <button type="button" class="btn btn-transparent flex-20" @click="setGoalPrd(12)">+12개월</button>
                                <button type="button" class="btn btn-navy flex-20" @click="setGoalPrd(0)">정정</button>
                            </div>
                            <div class="form-group" style="justify-content: left">
                                <label>적용금리 (%):</label>
                                <input class="form-control" type="text" id="aply_rate" v-model="aplyRate" readonly />
                            </div>
                            <div class="form-group" style="justify-content: left">
                                <label>이자과세:</label>
								<select class="form-control" id="int_tax_ty_cd" v-model="prod.prod_interest_taxation" style="padding-top: 3px;" readonly>
									<option value="1">일반과세 (15.4%)</option>
									<option value="2">세금우대 (9.5%)</option>
									<option value="3">비과세</option>
								</select>
                            </div>
                            <div class="form-group" style="justify-content: left">
                                <label>작성일자:</label>
								<input class="form-control" v-model="prod.wrt_dt" disabled />
                            </div>
                        </div>
                    </div>
                    
					<div class="dt-buttons" style="padding-top: 15px;">
						<input id="external" type="radio" v-model="info.simpl_ty_cd" value="1" :disabled="info.prod_ds_sn!=''&&info.prod_ds_sn!=undefined">
						<label class="tab_item" for="external">정상설계</label>
						<input id="internal" type="radio" v-model="info.simpl_ty_cd"  value="0" :disabled="info.prod_ds_sn!=''&&info.prod_ds_sn!=undefined">
						<label class="tab_item" for="internal">간편설계</label>
					</div>
					<div class="dataTables_filter">
						<button type="button" class="btn btn-red btn-small" @click="prcCalc()">
							이자계산
						</button>
						<button type="button" class="btn btn-orange btn-small" @click="saveProd()">
							설계저장
						</button>
						<button type="button" class="btn btn-blue btn-icon btn-small" @click="popupPrint()">
							설계발행 <i class="entypo-print"></i>
						</button>
						<button type="button" class="btn btn-blue btn-icon btn-small" @click="gotoList()">
							목록 <i class="entypo-list"></i>
						</button>
					</div>
					
                    <ul class="nav">
                        <li class="nav-tab active">계산결과</li>
                    </ul>
                    <div class="right-bottom flex-100">
                        <form class="form flex-column" method="POST" action="#">
	                        <table>
	                        	<tr>
	                        		<td class="center" style="width: 40%; vertical-align: top;">
	                        			<div class="form-wrapper flex flex-wrap flex-gap-10">
	                        				<div class="form-group">
			                                    <label>회차불입금액:</label>
			                                    <input class="form-control" id="circle_acml_amt" v-model="calc.dsgn_acml_amt_fmt" disabled />
			                                </div>
			                                <div class="form-group">
			                                    <label>불입금액합계:</label>
			                                    <input class="form-control" id="tot_dpst_amt" v-model="calc.dsgn_acml_tot_amt_fmt" disabled />
			                                </div>
			                                <div class="form-group">
			                                    <label>세전이자:</label>
			                                    <input class="form-control" id="tot_dpst_int" v-model="calc.dsgn_acml_tot_int_fmt" disabled />
			                                </div>
			                                <div class="form-group">
			                                    <label>세전수령액:</label>
			                                    <input class="form-control" id="bfo_rcve_amt" v-model="calc.dsgn_acml_bfr_rcve_amt_fmt" disabled />
			                                </div>
			                                <div class="form-group">
			                                    <label>이자과세금:</label>
			                                    <input class="form-control" id="int_tax_amt" v-model="calc.dsgn_acml_int_tax_amt_fmt" disabled />
			                                </div>
			                                <div class="form-group">
			                                    <label>세후수령액:</label>
			                                    <input class="form-control" id="atx_rcve_amt" v-model="calc.dsgn_acml_atx_rcve_amt_fmt" disabled />
			                                </div>
			                            </div>	
			                            
			                            <div class="panel-heading">
											<div class="panel-title">계산결과 CHART</div>
										</div>
										<div id="chart" class="bottom-right-bottom flex-100"></div>
	                        		</td>
	                        		<td class="center" style="width: 3%;">
	                        		</td>
	                        		<td class="center" style="width: 57%; vertical-align: top;">
			                            <table class="table table-bordered datatable dataTable" id="grid_app">
											<thead>
												<tr class="replace-inputs">
													<th style="width: 10%;" class="center">회차</th>
													<th style="width: 23%;" class="center">회차불입금액</th>
													<th style="width: 23%;" class="center">누적불입금액</th>
													<th style="width: 21%;" class="center">회차이자</th>
													<th style="width: 23%;" class="center">회차원리금</th>
												</tr>
											</thead>
											<tbody id="grid_tbody">
											</tbody>
										</table>
	                        		</td>
	                        	</tr>
	                        </table>
                        </form>
                    </div>
                </div>
                
                <!-- 프린트 Start -->
                <div border="1"  class="modal fade" id="printArea">
                    <span style="font-size: 30px; font-weight: bold">[ {{custInfo.cust_nm}} ]</span> <span style="font-size: 30px;">고객님!! </span>
                    <span style="color: red; font-size: 30px; font-weight: bold">[ {{info.prod_nm}} ]</span> <span style="font-size: 30px;">가입을 제안 드립니다. </span>
				    <table border="1" style="width: 1000px; height: 700px;">
				       <tr>
				       		<td class="center" style="width: 12%;">
				       			<label>상품설계기준</label>
				       		</td>
							<td class="left" style="width: 35%;">
								<label>상품명:</label>
								{{prod.prod_name}}<br>
								<label>납입주기:</label>
								<span id="payment-cycle"></span><br>
								<label>불입금액:</label>
								{{calc.dsgn_acml_amt_fmt}} 원<br>
								<label>불입기간:</label>
								{{calc.dsgn_acml_goal_prd}} 개월<br>
								<label>적용금리:</label>
								{{prod.pr_max_ir}} %<br>
								<label>이자과세:</label>
								<span id="interestTaxation"></span><br>
							</td>
							<td rowspan="2" style="width: 53%;">
								<div id="printArea_chart"></div>
							</td>
				       </tr>
				       <tr>
				       		<td class="center">
				       			<label>상품설계산출결과</label>
				       		</td>
							<td class="left">
								<label>원금:</label>
								{{calc.dsgn_acml_tot_amt_fmt}} 원<br>
								<label>이자:</label>
								{{calc.dsgn_acml_tot_int_fmt}} 원<br>
								<label>총금액:</label>
								{{calc.dsgn_acml_bfr_rcve_amt}} 원<br>
								<label>세액공제금액:</label>
								{{calc.dsgn_acml_int_tax_amt}} 원
							</td>
				       </tr>
				    </table>
				</div>
				<!-- 프린트 End -->
				
			</template>
			</div>
		</div>
		
		<br />
		
		<jsp:include page="/WEB-INF/jsp/kcg/_include/system/footer.jsp" flush="false"/>
		
	</div>
</div>

<!-- 상품팝업 -->
<div class="modal fade" id="pop_prod">
<template>
	<div class="modal-dialog" style="width: 500px;">
		<div class="modal-content">
			<div class="modal-body">
				<div class="dataTables_wrapper">					
					<div class="dt-buttons">
						<div>
							<label>코드:</label>
							<input type="search" id="pop_prod_cd" style="width: 80px;" v-model="prod_sn">
							<label>코드명:</label>
							<input type="search" id="pop_prod_nm" style="width: 200px;" v-model="prod_name">
							<button type="button" class="btn btn-red" style="margin-left: 5px;" @click="getListOne">
								검색
							</button>
						</div>
					</div>
				</div>
				<div style="height: 400px;overflow: auto;" class="dataTables_wrapper">		
					<table class="table table-bordered datatable dataTable">
						<thead style="position: sticky;top: 0px;">
							<tr>
								<th class="center" style="width: 22%;">상품코드</th>
								<th class="center" style="width: 40%;">상품명</th>
								<th class="center" style="width: 38%;">적용금리(최소~최대)</th>
							</tr>
						</thead>
						<tbody>
							<tr v-for="item in dataList" @click="selProd(item.prod_sn)" style="cursor: pointer;">
								<td class="center">{{item.prod_sn}}</td>
								<td class="center">{{item.prod_name}}</td>
								<td class="center">{{item.pr_min_ir}}% ~ {{item.pr_max_ir}}%</td>
							</tr>
						</tbody>
					</table>	
				</div>				
			</div>
		</div>
	</div>
</template>
</div>
                            
<!-- 고객팝업 -->
<div class="modal fade" id="pop_cust">
<template>
	<div class="modal-dialog" style="width: 500px;">
		<div class="modal-content">
			<div class="modal-body">
				<div class="dataTables_wrapper">					
					<div class="dt-buttons">
						<div>
							<label>고객명:</label>
							<input type="search" id="pop_cust_nm" style="width: 250px;" v-model="cust_name">
							<button type="button" class="btn btn-red" style="margin-left: 5px;" @click="getList">
								검색
							</button>
						</div>
					</div>
				</div>
				<div style="height: 400px;overflow: auto;" class="dataTables_wrapper">		
					<table class="table table-bordered datatable dataTable">
						<thead style="position: sticky;top: 0px;">
							<tr>
								<th class="center" style="width: 25%;">고객명</th>
								<th class="center" style="width: 20%;">생년월일</th>
								<th class="center" style="width: 30%;">핸드폰번호</th>
							</tr>
						</thead>
						<tbody>
							<tr v-for="item in dataList" @click="selCust(item)" style="cursor: pointer;">
								<td class="center">{{item.cust_name}}</td>
								<td class="center">{{item.cust_birthdate}}</td>
								<td class="center">{{item.cust_mbl_telno}}</td>
							</tr>
						</tbody>
					</table>
					<div class="dataTables_paginate paging_simple_numbers" id="div_paginate">
					</div>  
				</div>				
			</div>
		</div>
	</div>
</template>
</div>

</body>
<script>
var vueapp = new Vue({
	el : "#vueapp",
	data : {
		recommendPd : [],
		prod_name: "",
		pr_max_ir: "",
		pr_min_ir: "",
		info : {
			prod_ds_sn : "${prod_ds_sn}", 
			cust_mbl_telno : "${cust_mbl_telno}", 
			prod_ty_cd : "${prod_ty_cd}", 
			simpl_ty_cd : "0",
			wrt_dt : "",
			int_cty_cd : "",
			prod_cd : "",
			prod_nm : "",
			goal_prd : "",
			circle_acml_amt : "",
			tot_dpst_amt : "",
			tot_dpst_int : "",
			int_tax_amt : "",
			bfo_rcve_amt : "",
			atx_rcve_amt : "",
			
			circle_acml_amt_fmt : "",
			tot_dpst_amt_fmt : "",
			tot_dpst_int_fmt : "",
			int_tax_amt_fmt : "",
			bfo_rcve_amt_fmt : "",
			atx_rcve_amt_fmt : "",
		},
		custInfo : {
			cust_mbl_telno : "",//고객 휴번
			cust_name : "",//고객명
			cust_pridtf_no : "",//고객주번
			cust_birthdate : "",//고객생일
			cust_email : "",//고객이멜
			cust_home_telno : "",//고객전번
			cust_cr : "",//고객직업
			cust_addr : "",//고객주소
			wrt_dt : "",
			cust_credit_score : "", // 신용점수
		},
		prod : {
			prod_sn : "", //상품번호
			prod_name : "", //상품명
			prod_payment_cycle : "", //납입주기
			prod_interest_taxation : "", //이자과세
			pr_max_ir : "", //최대금리
			wrt_dt : "", //작성일자
		},
		calc : {
			dsgn_acml_amt : "", //불입금액
			dsgn_acml_goal_amt : "", //목표금액
			dsgn_acml_goal_prd : "", //목표기간
			dsgn_acml_tot_amt : "", //불입금액합계
			dsgn_acml_tot_int  : "", //세전이자
			dsgn_acml_bfr_rcve_amt : "", //세전수령액
			dsgn_acml_int_tax_amt : "", //이자과세금
			dsgn_acml_atx_rcve_amt : "", //세후수령액
			
			dsgn_acml_amt_fmt : "",
			dsgn_acml_tot_amt_fmt : "",
			dsgn_acml_tot_int_fmt : "",
			dsgn_acml_int_tax_amt_fmt : "",
			dsgn_acml_bfr_rcve_amt_fmt : "",
			dsgn_acml_atx_rcve_amt_fmt : "",
		},
	},
	mounted : function(){
		
		if(!cf_isEmpty(this.info.cust_mbl_telno)){
			this.getCustInfo();
		}
		if(!cf_isEmpty(this.info.prod_ds_sn)){
			this.getDsgInfo();
		}
	},
	computed : {
        aplyRate : function(){
            return this.prod.pr_max_ir + '%';
        },
	    recommendPdFiltered() {
	        return this.recommendPd.filter(prod => {
	            if (this.custInfo.cust_cr === '학생') {
	                // 직업이 학생일 때는 상품 번호가 12인 학자금 대출 상품만 추천
	                return prod.prod_sn === 8;
	            } else {
	                // 그 외의 경우, 상품 번호가 12가 아닌 상품 중에서
	                // 상품 점수가 고객의 신용 점수보다 낮은 상품 추천
	                return prod.prod_sn !== 8 && prod.prod_score <= this.custInfo.cust_credit_score;
	            }
	        });
	    }
	},
	watch: { 
	    'custInfo.cust_mbl_telno': function(newVal, oldVal) {
	        // 고객의 핸드폰 번호가 변경될 때 추천 상품 다시 가져오기
	        if (newVal) {
	            this.getRecommendPd();
	        }
	    }
	},
	methods : {
		saveProd : function(){
			var data = {
					dsgn_acml_prod_sn : this.prod.prod_sn, //상품번호
					dsgn_acml_prod_name : this.prod.prod_name, //상품명
					dsgn_acml_pay_ty_cd : this.prod.prod_payment_cycle, //납입주기
					dsgn_acml_int_tax_ty_cd : this.prod.prod_interest_taxation, //이자과세
					dsgn_acml_aply_rate : this.prod.pr_max_ir, //최대금리
					dsgn_acml_wrt_dt : this.prod.wrt_dt, //작성일자
					dsgn_acml_amt : this.calc.dsgn_acml_amt, //불입금액
					dsgn_acml_goal_amt : this.calc.dsgn_acml_goal_amt, //목표금액
					dsgn_acml_goal_prd : this.calc.dsgn_acml_goal_prd, //목표기간
					dsgn_acml_tot_amt : this.calc.dsgn_acml_tot_amt, //불입금액합계
					dsgn_acml_tot_int  : this.calc.dsgn_acml_tot_int, //세전이자
					dsgn_acml_int_tax_amt : this.calc.dsgn_acml_int_tax_amt, //이자과세금
					dsgn_acml_atx_rcve_amt : this.calc.dsgn_acml_atx_rcve_amt, //세후수령액
					dsgn_acml_cust_sn : this.custInfo.cust_mbl_telno, //고객코드
			}
			if(!confirm("저장하시겠습니까?")) return;
			
			cf_ajax("/t1_prod_mng/putProdAcml" , data , this.successAlert);
			
		},
		successAlert : function(){
			alert("저장되었습니다.");
		},
		tabChange : function(index) {
			
			if(this.info.prod_ds_sn != "" && this.info.prod_ds_sn != undefined) {
				alert("신규일 경우만 TAB 이동이 가능합니다.");
				return;
			}
			
			var params = {
				cust_mbl_telno : cf_defaultIfEmpty(this.info.cust_mbl_telno, ""),
				prod_ty_cd : index,
			}
			cf_movePage("/t1_prod_mng/dtlA", params);
			
		},
		getDsgInfo : function(){
			cf_ajax("/promion_mng/getDsgInfo", this.info, this.getDsgInfoCB);
		},
		getDsgInfoCB : function(data){
			this.info = data;
			this.info.simpl_ty_cd = "1";
			
			this.prcCalc();
		},
		save : function(){
			
			if(this.info.simpl_ty_cd != "1"){
				alert("정상설계만 저장할 수 있습니다.");
				return;
			}else if(cf_isEmpty(this.info.atx_rcve_amt) || this.info.atx_rcve_amt == 0){
				alert("이자계산 후 저장할 수 있습니다.");
				return;
			}else if(cf_isEmpty(this.custInfo.cust_nm)){
				alert("고객정보를 선택하세요.");
				return;
			}
			
			if(!confirm("저장하시겠습니까?")) return;
			
			this.info.cust_mbl_telno = this.custInfo.cust_mbl_telno;
			this.info.int_cty_cd = "1";
			
			cf_ajax("/promion_mng/save", this.info, this.saveCB);
		},
		saveCB : function(data){
			alert("저장되었습니다.");
			cf_movePage('/promion_mng/list');
		},
		getProdInfo : function(){
			var params = {
					prod_sn : this.prod.prod_sn,
			}
			cf_ajax("/t1_prod_mng/putProdInfo", params , this.getProdInfoCB);
		},
		getProdInfoCB : function(data){
			this.prod = data;
			this.prod.wrt_dt = getToday();
			document.getElementById('interestTaxation').textContent = (this.prod.prod_interest_taxation === 1) ? '일반과세' : (this.prod.prod_interest_taxation === 2) ? '세금우대' : '정보 없음';
			document.getElementById('payment-cycle').textContent = (this.prod.prod_payment_cycle === 1) ? '월납' : (this.prod.prod_payment_cycle ===3 ) ? '일시납' : '정보없음';
		},
		getCustInfo : function(){
            var params = {
                cust_mbl_telno : this.custInfo.cust_mbl_telno,
            }
            cf_ajax("/t1custMng/getT1CustInfoProd", params, this.getCustInfoCB);
        },
		getCustInfoCB : function(data){
			this.custInfo = data;
			this.info.simpl_ty_cd = "1";
		},
		setCircleAcmlAmt : function(nAmt){
			if(nAmt == 0) {
				this.calc.dsgn_acml_goal_amt = 0;
			}else {
				this.calc.dsgn_acml_goal_amt = Number(this.calc.dsgn_acml_goal_amt) + nAmt*10000;
			}
		},
		setGoalPrd : function(nPrd){
			if(nPrd == 0) {
				this.calc.dsgn_acml_goal_prd = 0;
			}else {
				this.calc.dsgn_acml_goal_prd = Number(this.calc.dsgn_acml_goal_prd) + nPrd;
			}
		},
		popupProd : function(){
			pop_prod.getList();
			$("#pop_prod").modal("show");
		},
		popupCust : function(){
			pop_cust.getList();
			$("#pop_cust").modal("show");
		},
		getRecommendPd: function () {
	           // 추천 상품을 가져오기 위한 메서드
	       var params = {
	         cust_mbl_telno: this.custInfo.cust_mbl_telno,
	         cust_credit_score: this.custInfo.cust_credit_score,
	         cust_cr: this.custInfo.cust_cr,
	         prod_name : this.prod.prod_name,
	         pr_max_ir : this.prod.pr_max_ir,
	         pr_min_ir : this.prod.pr_min_ir,
	            
	      };
	      cf_ajax("/t1_prod_mng/getRecommendPd", params, this.getRecommendPdCB);
	    },
		prcCalc : function(){
			
			if(cf_isEmpty(this.prod.prod_name)){
				alert("상품을 선택하세요.");
				return;
			}else if(cf_isEmpty(this.calc.dsgn_acml_goal_amt) || this.calc.dsgn_acml_goal_amt == 0){
				alert("목표금액을 입력하세요.");
				return;
			}else if(cf_isEmpty(this.calc.dsgn_acml_goal_prd) || this.calc.dsgn_acml_goal_prd == 0){
				alert("목표기간을 입력하세요.");
				return;
			}
			//else if(cf_isEmpty(this.aplyRate) || this.aplyRate == 0){
			//	alert("적용금리를 입력하세요.");
			//	return;
			//}
			
			var nGoalAmt	= Math.round(this.calc.dsgn_acml_goal_amt); // 목표금액
			//var nPymAmt		= Math.round(this.calc.dsgn_dpst_amt); // 불입금액
			var nRvcy		= Math.round(this.prod.prod_payment_cycle); // 납입주기
			var nPrd		= Math.round(this.calc.dsgn_acml_goal_prd); // 목표기간
			var nApplItr	= Math.round(this.prod.pr_max_ir); // 적용금리
				nApplItr	= nApplItr / 12 / 100;
			
			var nScPayAmt	= 0;	// 회차붙입금액
			var nAcmPayAmt	= 0;	// 누적불입금액
			var nScPniAmt	= 0;	// 회차원리금
			var nScInt		= 0;	// 회차이자
			var nAcmInt		= 0;	// 누적이자
			var nTax		= 0;	// 이자과세
			if(this.prod.prod_interest_taxation == "1") {		// 일반과세
				nTax = 15.4 / 100;
			} else if(this.prod.prod_interest_taxation == "2") {	// 세금우대
				nTax = 9.5 / 100;
			} else {									// 비과세
				nTax = 0;
			}
			
			if(nRvcy == 1){
				nScPayAmt = nGoalAmt/(nPrd+ (78*nApplItr)) //회차불입금액
			}
			
			var html = '';
			for(var i=1; i<=nPrd; i++) {
				
				//if(nRvcy == 1) {
				//	console.log("1입니다")
				//} else if(i % nRvcy == 1) {
				//	nScPayAmt = nPymAmt * nRvcy;
				//} else {
				//	nAmt = 0;
				//}
				
				nAcmPayAmt = nAcmPayAmt + nScPayAmt; //누적불입금액
				nScInt = nAcmPayAmt * nApplItr; //회차이자
				//nScInt = nScPayAmt * nApplItr; //회차이자
				nAcmInt = nAcmInt + nScInt; //누적이자
				nScPniAmt = nAcmPayAmt + nAcmInt; //회차원리금
				//nScPniAmt = nScPniAmt + nScPayAmt + nScInt;
				//nAcmInt += nScInt;
				
				html += '<tr>';
				html += '<td class="right" style="text-align: right;">' + i + '</td>';
				html += '<td class="right" style="text-align: right;">' + numberFormat(Math.round(nScPayAmt)) + '</td>';
				html += '<td class="right" style="text-align: right;">' + numberFormat(Math.round(nAcmPayAmt)) + '</td>';
				html += '<td class="right" style="text-align: right;">' + numberFormat(Math.round(nScInt)) + '</td>';
				html += '<td class="right" style="text-align: right;">' + numberFormat(Math.round(nScPniAmt)) + '</td>';
				html += '</tr>';
			}
			
			this.calc.dsgn_acml_amt = (Math.round(nScPayAmt))
			this.calc.dsgn_acml_tot_amt = (Math.round(nAcmPayAmt)); //불입총금액
			this.calc.dsgn_acml_tot_int = (Math.round(nAcmInt)); //세전이자
			this.calc.dsgn_acml_int_tax_amt = (Math.round(nAcmInt * nTax)); //이자과세금
			this.calc.dsgn_acml_bfr_rcve_amt = (Math.round(nScPniAmt)); //세전수령금
			this.calc.dsgn_acml_atx_rcve_amt = (Math.round(nScPniAmt - nAcmInt * nTax)); //세후수령금
        	
			this.calc.dsgn_acml_amt_fmt = this.calc.dsgn_acml_amt.numformat();
			this.calc.dsgn_acml_tot_amt_fmt = this.calc.dsgn_acml_tot_amt.numformat();
			this.calc.dsgn_acml_tot_int_fmt = this.calc.dsgn_acml_tot_int.numformat();
			this.calc.dsgn_acml_int_tax_amt_fmt = this.calc.dsgn_acml_int_tax_amt.numformat();
			this.calc.dsgn_acml_bfr_rcve_amt_fmt = this.calc.dsgn_acml_bfr_rcve_amt.numformat();
			this.calc.dsgn_acml_atx_rcve_amt_fmt = this.calc.dsgn_acml_atx_rcve_amt.numformat();
			this.info.atx_rcve_amt_fmt = this.info.atx_rcve_amt.numformat();
			
			$("#grid_tbody").html(html);
			
			// 차트
			var chart = bb.generate({
                data: {
                    columns: [
                        ["불입금액합계"	, this.calc.dsgn_acml_tot_amt],
                        ["세전이자"	, this.calc.dsgn_acml_tot_int],
                        ["세전수령액"	, this.calc.dsgn_acml_bfr_rcve_amt],
                        ["이자과세금"	, this.calc.dsgn_acml_int_tax_amt],
                        ["세후수령액"	, this.calc.dsgn_acml_atx_rcve_amt],
                    ],
                    type: "bar",
                    groups: [
                        []
                    ],
                    order: null
                },
                bindto: "#chart"
            });
		},
		gotoList : function(){
            cf_movePage('/t1_prod_mng/promionList');
		},
		popupPrint : function(){
			
			if (!window.confirm("설계발행하시겠습니까?")) {
    			return;
            }
			
			$("#print_prod_nm").val("상품명");
			
			document.getElementById('printArea_chart').innerHTML = document.getElementById('chart').innerHTML;
			
			const printArea = document.getElementById('printArea').innerHTML;

			win = window.open();
			self.focus();
			win.document.open();

			/*
			1. div 안의 모든 태그들을 innerHTML을 사용하여 매개변수로 받는다.
			2. window.open() 을 사용하여 새 팝업창을 띄운다.
			3. 열린 새 팝업창에 기본 <html><head><body>를 추가한다.
			4. <body> 안에 매개변수로 받은 printArea를 추가한다.
			5. window.print() 로 인쇄
			6. 인쇄 확인이 되면 팝업창은 자동으로 window.close()를 호출하여 닫힘
			 */
			win.document.write('<html><head>');

			win.document.write('<link rel="stylesheet" href="/static_resources/system/js/datatables/datatables.css">');
			win.document.write('<link rel="stylesheet" href="/static_resources/system/js/select2/select2-bootstrap.css">');
			win.document.write('<link rel="stylesheet" href="/static_resources/system/js/select2/select2.css">');

			win.document.write('<title></title><style>');
			win.document.write('td.center {text-align: center;}');
			win.document.write('th.center {text-align: center;}');
			win.document.write('body {font-size: 14px;}');
			win.document.write('</style></head><body>');
			win.document.write(printArea);
			win.document.write('</body></html>');
			win.document.close();
			win.print();
			win.close();
		},
	}
});

<!--시험용-->
var prod = new Vue ({
	el : "#prod",
	data : {
		info : {
			dsgn_dpst_sn : "",
			dsgn_dpst_prod_cd : "",
			dsgn_dpst_name : "",
			dsgn_dpst_pay_ty_cd : "",
			dsgn_dpst_amt : "",
			dsgn_dpst_prd : "",
			dsgn_dpst_aply_rate : "",
			dsgn_dpst_int_tax_ty_cd : "",
			dsgn_dpst_tot_amt : "",
			dsgn_dpst_tot_int : "",
			dsgn_dpst_int_tax_amt : "",
			dsgn_dpst_atx_rcve_amt : "",	
		},
	},
	mounted : function(){
		this.getProdOne();
	},
	methods : {
		getProdOne : function(){
			cf_ajax("/t1_prod_mng/getProdOne"  , null ,this.getProd);
		},
		getProd : function(data){
			this.info = data;
		}
	},
});

var putProd = new Vue({
	el : "#putProd",
	data : {
		info : {
			dsgn_dpst_sn : "",
			dsgn_dpst_prod_cd : "",
			dsgn_dpst_name : "",
			dsgn_dpst_pay_ty_cd : "",
			dsgn_dpst_amt : "",
			dsgn_dpst_prd : "",
			dsgn_dpst_aply_rate : "",
			dsgn_dpst_int_tax_ty_cd : "",
			dsgn_dpst_tot_amt : "",
			dsgn_dpst_tot_int : "",
			dsgn_dpst_int_tax_amt : "",
			dsgn_dpst_atx_rcve_amt : "",	
		}
	},
	methods : {
		putProdOne : function(){
			cf_ajax("/t1_prod_mng/putProdOne", this.info);
			console.log(info.dsgn_dpst_sn);
		}
	}
	
});
<!--시험용-->

var pop_prod = new Vue({
	el : "#pop_prod",
	data : {
		dataList : [],
		prod_sn : "",
		prod_name : "",
		pr_max_ir : "",
		pr_min_ir : "",
	},
	mounted : function(){
		<!--this.getList();-->
	},
	methods : {
		getList : function(){
			this.dataList = [];
			var params = {
				prod_sn : this.prod_sn,
				prod_name : this.prod_name,
				prod_ty_cd : vueapp.info.prod_ty_cd,
				prod_category : "목돈",
			}
			cf_ajax("/t1_prod_mng/getProdListA", params, function(data){
				pop_prod.dataList = data;
			});
		},
		selProd : function(prod_sn){
			
			vueapp.prod.prod_sn = prod_sn;
			vueapp.getProdInfo();
			
			$("#pop_prod").modal("hide");
		},
		getListOne : function(prod_sn,prod_name){
			this.dataList = [];
			var params = {
					prod_sn : this.prod_sn,
					prod_name : this.prod_name,
			}
			console.log("Parameters: ", params);
			cf_ajax("/t1_prod_mng/getProdOne" , params , function(data){
				pop_prod.dataList = data;
			});
		}
	},
});

var pop_cust = new Vue({
	el: "#pop_cust",
	data: {
		dataList: [],
		cust_name: "",
		cust_pridtf_no: "",
		cust_email: "",
		cust_homt_telno: "",
		cust_mbl_telno: "",
		cust_cr: "",
		cust_addr: "",
		
	},
	mounted: function(){
	},
	methods: {
		getList: function(){
			var params = {
				cust_name: this.cust_name,
				cust_birthdate: "",
				cust_mbl_telno: "",
			};
			cf_ajax("/t1custMng/getT1CustList", params, function(data){
				pop_cust.dataList = data;
			});
		},
		selCust: function(item){
			vueapp.custInfo.cust_mbl_telno = item.cust_mbl_telno;
			vueapp.getCustInfo();		
			$("#pop_cust").modal("hide");
		},
	},
});
</script>


<script>
    function numberFormat(num) {
		num = num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		return num;
	}
    
    function getToday() {
    	const today = new Date(); 
    	const year = today.getFullYear(); 	// 년도
    	const month = (today.getMonth() + 1).toString().padStart(2, '0');  	// 월
    	const day = today.getDate().toString().padStart(2, '0'); 	// 일
    	
    	return year + "-" + month + "-" + day;
    }
    
</script>
</html>