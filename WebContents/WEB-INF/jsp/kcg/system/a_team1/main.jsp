<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
<jsp:include page="/WEB-INF/jsp/kcg/_include/system/header_meta.jsp"
	flush="false" />
<!-- Imported styles on this page -->
<base href="" />
<link rel="stylesheet"
	href="/static_resources/system/js/datatables/datatables.css">
<link rel="stylesheet"
	href="/static_resources/system/js/select2/select2-bootstrap.css">
<link rel="stylesheet"
	href="/static_resources/system/js/select2/select2.css">
<link rel="stylesheet"
	href="/static_resources/system/js/datatables/proddtl.css">
<link rel="stylesheet"
	href="/static_resources/system/css/exchange-calc.css">
<script src="https://unpkg.com/jquery@3.3.1/dist/jquery.slim.min.js"></script>
<title>환율 계산기</title>
</head>
<body class="page-body">

	<div class="page-container">

		<jsp:include page="/WEB-INF/jsp/kcg/_include/system/sidebar-menu.jsp"
			flush="false" />

		<div class="main-content"  style="width: 90%; margin-left: auto; margin-right: auto;">

			<jsp:include page="/WEB-INF/jsp/kcg/_include/system/header.jsp"
				flush="false" />

			<ol class="breadcrumb bc-3">
				<li><a href="#none" onclick="cf_movePage('/system')"><i
						class="fa fa-home"></i>Home</a></li>
				<li class="active"><strong>환율 계산기</strong></li>
			</ol>

			<h2>환율 계산기</h2>
			<br>


			<div class="flex-column flex-gap-10" id="vueapp" >
				<template>
				
				<div id="top_panel">

						<div id="left_panel">
						
							
							<div id="ftk_calc">

								<h4>외화-원화 계산기</h4>

								<div id="ftk_input_area">
									<div id="span">
										<label>외화</label>
										<br>
										<select id="ftk_select" @change="inputNum($event)">
											<option v-for="item in dataList" :value="item.cur_unit">{{item.cur_nm}}</option>
										</select>
										<input type="number" step="0.01" id="ftk_input" v-model="ftk_input" @input="inputNum($event)">
									</div>									
								</div>

								<div id="ftk_calc_area">
								
									<div id="exchange_label">
										<label>단순 환전</label>
										<br>
										<input type="number" step="0.01" v-model="ftk_exchange" disabled>
									</div>
									<div id="fee_label">
										<label>수수료</label>
										<br>
										<input type="number" step="0.01" v-model="ftk_fee" disabled>
									</div>									
									
								</div>

								<div id="ftk_result_area">
									<div id="span">
										<label>원화</label>
										<br>
										<input type="number" step="0.01" v-model="ftk_output" readonly>
									</div>
								</div>

							</div>
							
							<div id="ktf_calc">

								<h4>원화-외화 계산기</h4>

								<div id="ktf_input_area">
									<div id="span">
										<span id="span"></span>
										<label>원화</label>
										<br>
										<input type="number" step="0.01" id="ktf_input" v-model="ktf_input" @input="inputNum($event)">
									</div>
								</div>
							

								<div id="ktf_calc_area">
								
								<div id="exchange_label">
										<label>단순 환전</label>
										<br>
										<input type="number" step="0.01" v-model="ktf_exchange" disabled>
									</div>
									<div id="fee_label">
										<label>수수료</label>
										<br>
										<input type="number" step="0.01" v-model="ktf_fee" disabled>
									</div>										
								</div>
								
								<div id="ktf_output_area">
									<div id="span">
										<label>외화</label>
										<br>
										<select id="ktf_select" @change="inputNum($event)">
											<option v-for="item in dataList" :value="item.cur_unit">{{item.cur_nm}}</option>
										</select>
										<input type="number" step="0.01" id="ktf_output" v-model="ktf_output" readonly>
									</div>									
								</div>									

							</div>
							
						</div>
						
						
						
						<div id="right_panel">							

							<div id="ftf_calc">

								<h4>외화-외화 계산기</h4>

								<div id="ftf_input_area">
									<div id="span">
										<label>입력</label>
										<br>
										<select id="ftf_select1" @change="inputNum($event)">
											<option v-for="item in dataList" :value="item.cur_unit">{{item.cur_nm}}</option>
										</select>
										<input type="number" step="0.01" id="ftf_input" v-model="ftf_input" @input="inputNum($event)">
									</div>			
								</div>							

								<div id="ftf_calc_area">									
									<span id="span">										
										<label id="exchange_label">단순 환전</label>
										<br>
										<input type="number" step="0.01" v-model="ftf_exchange1" disabled>										
									</span>
									
									<span id="span">						
										<label id="fee_label">수수료</label>
										<br>
										<input type="number" step="0.01" v-model="ftf_fee1" disabled>
									</span>
									
									<div id="for_line"></div>
									
									<span id="span">
										<label id="exchange_label">중간 원화 값</label>
										<br>
										<input type="number" step="0.01" v-model="ftf_mid" disabled>
									</span>
									
									<div id="for_line"></div>
									
									<span id="span">
										<label id="exchange_label">단순 환전</label>
										<br>
										<input type="number" step="0.01" v-model="ftf_exchange2" disabled>
									</span>
							
									<span id="span">										
										<label id="fee_label">수수료</label>
										<br>
										<input type="number" step="0.01" v-model="ftf_fee2" disabled>
									</span>	
								</div>
								
								<div id="for_line"></div>
								
								<div id="ftf_output_area">
									<div id="span">
										<label>출력</label>
										<br>
										<select id="ftf_select2" @change="inputNum($event)">
											<option v-for="item in dataList" :value="item.cur_unit">{{item.cur_nm}}</option>
										</select>
										<input type="number" step="0.01" id="ftf_output" v-model="ftf_output" readonly>
									</div>									
								</div>								

							</div>

							<div>
								<H6>수수료는 5%, 우대율은 90% 입니다.</H6>
								<H6>외화-외화 환전은 수수료가 두 번 부과 되오니 주의 하시길 바랍니다.</H6>
							</div>

						
						</div>

					</div>
					
									
					<!-- 메인에 쓰실때는 버려도 되는 부분 -->
					 <div id="for_line"></div>
					<div>
						
						<h3>매매율 테이블</h3>
						<div>평일은 당일 기준, 주말은 당주 금요일 기준입니다.</div>

						<table class="table table-bordered datatable dataTable"
							id="grid_app" style="border: 1px solid #999999; " >
							<thead>
								<tr class="replace-inputs">									
									<th class="center">화폐 구분</th>
									<th class="center">화폐명</th>
									<th class="center">매매율(원화 기준)</th>
								</tr>
							</thead>
							
							<tbody>
								<tr v-for="item in dataList" >									
									<td class="center">{{item.cur_unit}}</td>
									<td class="center">{{item.cur_nm}}</td>
									<td class="center">{{item.deal_bas_r}}</td>
								</tr>
							
							</tbody>
						</table>
						<H6>일본 엔과 인도네시아 루피아는 100엔/루피아 기준입니다.</H6>
					</div>

				
				</template>

			
			</div>


			<jsp:include page="/WEB-INF/jsp/kcg/_include/system/footer.jsp"
				flush="false" />
		</div>
	</div>


</body>

<script>
	var vueapp = new Vue({
		el : "#vueapp",
		data : {
			dataList : [],
			
			result : "",
			cur_unit: "",
			deal_bas_r: "",
			cur_nm : "",
			
			//외화-원화 요소
			ftk_input: "",
			ftk_fee: "",
			ftk_exchange: "",
			ftk_output: "",

			//원화-외화 요소
			ktf_input: "",
			ktf_fee: "",
			ktf_exchange: "",
			ktf_output: "",

			//외화-외화 요소
			ftf_input: "",
			ftf_fee1: "",
			ftf_exchange1: "",
			ftf_output: "",
			ftf_fee2: "",
			ftf_exchange2: "",
			ftf_mid: "",
			
		},
		mounted : function() {
			// 마운트하면 List 불러오기(전체 리스트)
			var fromDtl = cf_getUrlParam("fromDtl");
      var pagingConfig = cv_sessionStorage.getItem("pagingConfig");
                    
      if("Y" === fromDtl && !cf_isEmpty(pagingConfig)){
        cv_pagingConfig.pageNo = pagingConfig.pageNo;
        cv_pagingConfig.orders = pagingConfig.orders;
            			
            		
        var params = cv_sessionStorage.getItem("params");
            	 		
        this.result = params.result;
        this.cur_unit = params.cur_unit;            
        this.deal_bas_r = params.deal_bas_r;
				this.cur_nm = params.cur_nm;   	

        this.getExchangeRate(true);
      } else {
        cv_sessionStorage
          .removeItem("pagingConfig")
          .removeItem("params");
        this.getExchangeRate(true);
      }   
		},
		methods : {
			getExchangeRate : function(isInit) {

				var params = {
					result : this.result,
					cur_unit : this.cur_unit,
					deal_bas_r : this.deal_bas_r,
					cur_nm : this.cur_nm,
				}
				cv_sessionStorage.setItem('params', params);

				cf_ajax("/t1_exchange_mng/getListMap", params, this.getListCB);
			},
			getListCB : function(data){
		     this.dataList = data;
		     console.log("getListCB.dataList : ", this.dataList);

		      },      
		      itemaddmouseover: function (obj) {
		         /* console.log(obj);   */
		             
		        }, 
			inputNum : function(event){
				var id = event.target.id;
				console.log("인풋넘:펑션 event id: " + id);

				if(id === "ftk_input" || id === "ftk_select"){
					this.forToKorCalc();
				} else if (id === "ktf_input" || id === "ktf_select") {
					this.korToForCalc();
				} else if (id === "ftf_input" || id === "ftf_select1" || id === "ftf_select2") {
					this.forToForCalc();
				}
			
			},
			forToKorCalc : function(){				
				var select = document.getElementById('ftk_select').value;
				var selected_unit = this.dataList.find(item => item.cur_unit === select);				
				var rate = selected_unit.deal_bas_r;
				var input = Number(this.ftk_input);

				//받아온 deal_bas_r은 스트링 타입인데 1000의 자리이상이면 중간의 ,때문에 형변환이 안된다.
				//그것을 방지하기 위해서 ,를 제거하는 구문
				let replaced_rate = rate.replace(',', '');

				if(select === "KRW"){
					console.log("셀렉트 박스 원화");
					this.ftk_output = input;
					this.ftk_fee = "";
					this.ftk_exchange = "";
				} else if (select === "IDR(100)" || select === "JPY(100)"){
					console.log("셀렉트 박스 엔 or 루피아화");
					replaced_rate = replaced_rate * 0.01;

					this.ftk_fee = (input * replaced_rate * 0.005).toFixed(2);
					this.ftk_exchange = (input * replaced_rate).toFixed(2);
					
					var fee = Number(this.ftk_fee);
					var exchange = Number(this.ftk_exchange);

					this.ftk_output = fee + exchange;
				} else {					
					this.ftk_fee = Number((input * replaced_rate * 0.005).toFixed(2));
					this.ftk_exchange = Number((input * replaced_rate).toFixed(2));					

					var fee = Number(this.ftk_fee);
					this.ftk_fee = fee;
					var exchange = Number(this.ftk_exchange);
					this.ftk_exchange = exchange;

					this.ftk_output = fee + exchange;
				}
			},
			korToForCalc : function(){
				var select = document.getElementById('ktf_select').value;
				var selected_unit = this.dataList.find(item => item.cur_unit === select);				
				var rate = selected_unit.deal_bas_r;
				var input = Number(this.ktf_input);

				//받아온 deal_bas_r은 스트링 타입인데 1000의 자리이상이면 중간의 ,때문에 형변환이 안된다.
				//그것을 방지하기 위해서 ,를 제거하는 구문
				let replaced_rate = rate.replace(',', '');

				if(select === "KRW"){
					console.log("셀렉트 박스 원화");
					this.ktf_output = input;
					this.ktf_fee = "";
					this.ktf_exchange = "";
				} else if (select === "IDR(100)" || select === "JPY(100)"){
					console.log("셀렉트 박스 엔 or 루피아화");
					replaced_rate = replaced_rate * 0.01;

					this.ktf_exchange = (input/replaced_rate).toFixed(2);
					this.ktf_fee = (this.ktf_exchange * 0.005).toFixed(2);
					
					
					var fee = Number(this.ktf_fee);
					var exchange = Number(this.ktf_exchange);

					this.ktf_output = exchange - fee;
				} else {		
					this.ktf_exchange = Number((input/replaced_rate).toFixed(2));			
					this.ktf_fee = Number((this.ktf_exchange * 0.005).toFixed(2));
										

					var fee = Number(this.ktf_fee);
					this.ktf_fee = fee;
					var exchange = Number(this.ktf_exchange);
					this.ktf_exchange = exchange;

					this.ktf_output = exchange - fee;
				}

			},
			forToForCalc : function (){
				var select1 = document.getElementById('ftf_select1').value;
				var select2 = document.getElementById('ftf_select2').value;
				var selected_unit1 = this.dataList.find(item => item.cur_unit === select1);
				var selected_unit2 = this.dataList.find(item => item.cur_unit === select2);

				var rate1 = selected_unit1.deal_bas_r;
				var rate2 = selected_unit2.deal_bas_r;

				//받아온 deal_bas_r은 스트링 타입인데 1000의 자리이상이면 중간의 ,때문에 형변환이 안된다.
				//그것을 방지하기 위해서 ,를 제거하는 구문
				let replaced_rate1 = rate1.replace(',', '');
				let replaced_rate2 = rate2.replace(',', '');

				var input = Number(this.ftf_input);

				if(select1 === select2){
					this.ftf_output = input;
				} else {
					if(select1 === "IDR(100)" || select1 === "JPY(100)"){
						replaced_rate1 = replaced_rate1 * 0.01;
					}

					if(select2 === "IDR(100)" || select2 === "JPY(100)"){
						replaced_rate2 = replaced_rate2 * 0.01;
					}

					//인풋 수수료, 단순 환율 계산
					var fee1 = Number(this.ftf_input * replaced_rate1 * 0.005).toFixed(2);
					var exchange1 = Number(this.ftf_input * replaced_rate1).toFixed(2);
					//인풋 외화에서 원화 계산
					var mid = (exchange1 - fee1).toFixed(2);
					//중간 수수료, 단순 환율 계산
					var exchange2 = Number(mid/replaced_rate2).toFixed(2);
					var fee2 = Number(exchange2/replaced_rate2).toFixed(2);
					//원화에서 아웃풋 계산
					this.ftf_output = (exchange2 - fee2).toFixed(2);
					
					this.ftf_exchange1 = exchange1;
					this.ftf_fee1 = fee1;
					this.ftf_exchange2 = exchange2;
					this.ftf_fee2 = fee2;
					this.ftf_mid = mid;
				}	
			},

		},

	});
</script>
</html>