<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/jsp/kcg/_include/system/header_meta.jsp"
	flush="false" />
<!-- Imported styles on this page -->
<link rel="stylesheet" href="/static_resources/system/js/datatables/datatables.css">
<link rel="stylesheet" href="/static_resources/system/js/datatables/proddtl.css">
<link rel="stylesheet" href="/static_resources/system/js/select2/select2-bootstrap.css">
<link rel="stylesheet" href="/static_resources/system/js/select2/select2.css">
	<title>설계이력조회</title>
</head>
<body class="page-body">

<div class="page-container">

	<jsp:include page="/WEB-INF/jsp/kcg/_include/system/sidebar-menu.jsp" flush="false"/>

	<div class="main-content">

		<jsp:include page="/WEB-INF/jsp/kcg/_include/system/header.jsp" flush="false"/>
		
		<ol class="breadcrumb bc-3">
			<li><a href="#none" onclick="cf_movePage('/system')"><i class="fa fa-home"></i>Home</a></li>
			<li class="active"><strong>설계이력조회</strong></li>
		</ol>
		<h2>프로모션 > 설계이력조회</h2>
		<br/>
		
		<div class="flex-column flex-gap-10" id="vueapp">
		 <template>  
         		<div class="flex flex-100">
				<div class="flex-wrap flex-80 flex flex-gap-10 flex-padding-10">
					<div class="form-group flex-40">
						<label class="fix-width-33">고객명 :</label>
						<input class="form-control" v-model="cust_name">
					</div>
					<div class="form-group flex-40">
						<label class="fix-width-33">휴대전화 :</label>
						<input class="form-control" v-model="cust_mbl_telno">
					</div>
					<div class="form-group flex-40">
						<label class="fix-width-33">상품유형:</label>
						<select class="form-control" id="search_nm" v-model="prod_type" @change="searchOne(true)">
							<option value="예금">예금</option>
							<option value="목돈">목돈</option>
							<option value="대출">대출</option>
							<option value="적금">적금</option>
						</select>
					</div>
					<div class="form-group flex-40">
						<label class="fix-width-33">상품명 :</label>
						<input class="form-control" v-model="prod_name">
					</div>
				</div>
				<div
					class="flex-wrap flex-20 flex flex-center flex-gap-10 flex-padding-10">
					<div class="form-group" style="width: 100%;">
						<button type="button" class="btn btn-blue btn-icon icon-left form-control" @click="searchOne(true)">
							조건검색 <i class="entypo-search"></i>
						</button>
					</div>
					<div class="form-group" style="width: 100%;">
						<button type="button" class="btn btn-blue btn-icon icon-left form-control" @click="getListAll(true)">
							전체검색 <i class="entypo-search"></i>
						</button>
					</div>
					<div class="form-group" style="width: 100%;">
						<button type="button" class="btn btn-blue btn-icon icon-left form-control" @click="prod(true)">
							진행중인 설계목록 <i class="entypo-search"></i>
						</button>
					</div>
				</div>
			</div>
			<div class="flex flex-100 flex-padding-10 flex-gap-10" style="justify-content:flex-end;border: 1px solid #999999;">
               <button type="button" class="btn btn-blue btn-icon icon-left"
               	style="margin-left: 5px;" @click="popPromionlistPrint">인쇄<i class="entypo-print"></i>
              	</button>					          
          		</div>
			<table class="table table-bordered datatable dataTable" id="grid_app" style="border: 1px solid #999999;">
				<thead>
				    <tr class="replace-inputs">
				        <th style="width: 5%;" class="center">
				            <input type="checkbox" id="allCheck" @click="all_check($event.target)" style="cursor: pointer;">
				        </th>
				        <th style="width: 10%;" class="center">고객명</th>
				        <th style="width: 15%;" class="center">휴대전화</th>
				        <th style="width: 10%;" class="center">제안일자</th>
				        <th style="width: 10%;" class="center">목표기간(개월)</th>
				        <th style="width: 10%;" class="center">상품유형</th>
				        <th style="width: 15%;" class="center">상품종류</th>
				        <th style="width: 15%;" class="center">제안금액</th>
				        <th style="width: 10%;" class="center">진행상태</th>
				    </tr>
				</thead>
				<tbody>
				    <tr v-for="(item, index) in dataList" style="cursor: pointer;">
				        <td class="center"><input type="checkbox" :data-idx="item.cust_name" name="is_check" @click="onCheck" style="cursor: pointer;"></td>
				        <td class="center">{{ item.cust_name }}</td>
				        <td class="center">{{ item.cust_mbl_telno }}</td>
				        <td class="center">{{ item.wrt_dt }}</td>
				        <td class="center">{{ item.goal }}</td>
				        <td class="center">{{ item.prod_type }}</td>
				        <td class="center">{{ item.prod_name }}</td>
				        <td class="center">{{ item.amt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') }}</td>
				        <td class="center">{{ item.state }}</td>
				    </tr>
				</tbody>
			</table>
			<div class="dataTables_paginate paging_simple_numbers" id="div_paginate">
			</div>
		</template>
		</div>
		<jsp:include page="/WEB-INF/jsp/kcg/_include/system/footer.jsp" flush="false"/>
	</div>
</div>
<div class="modal fade" id="pop_promion_list_print">
    <template>
        <div class="modal-dialog" style="width: 80%;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true" id="btn_popClose">&times;</button>
                    <h4 class="modal-title" id="modify_nm">설계목록 출력관리</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal form-groups-bordered">
                        <div>
                            [설계목록] 를(을) 출력하시겠습니까?<br>
                            ※설계목록은 개인정보관리 대상이므로 유의하셔야 합니다.
                        </div>
                        <div class="form-group">
                            <div class="col-sm-10">
                                출력인원 : {{printInfo.promionCount}}명
                            </div>
                        </div>
                        <div class="form-group">
                            <table class="table datatable dataTable">
                                <thead>
                                    <tr class="replace-inputs">
                                        <th style="width: 10%;" class="center">고객명</th>
										<th style="width: 15%;" class="center">휴대전화</th>
										<th style="width: 10%;" class="center">제안일자</th>
										<th style="width: 10%;" class="center">목표기간(개월)</th>
										<th style="width: 10%;" class="center">상품유형</th>
										<th style="width: 15%;" class="center">상품종류</th>
										<th style="width: 15%;" class="center">제안금액</th>
										<th style="width: 10%;" class="center">진행상태</th>
                                    </tr>
                                </thead>                        
                                <tbody>  
                                    <tr v-for="item in printInfo.promionList" >
                                        <td class="center">{{ item.cust_name }}</td>
										<td class="center">{{ item.cust_mbl_telno }}</td>
										<td class="center">{{ item.wrt_dt }}</td>
										<td class="center">{{ item.goal }}</td>
										<td class="center">{{ item.prod_type }}</td>
										<td class="center">{{ item.prod_name }}</td>
										<td class="center">{{ item.amt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') }}</td>
										<td class="center">{{ item.state }}</td>
                                    </tr>                                
                                </tbody>
                            </table>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" @click="print">인쇄</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
       
        <div id="promion_list_printArea" style="visibility: hidden; position: absolute; top: -9999px;">
            <table class="table datatable dataTable">
                <thead>
                    <tr class="replace-inputs">
                        <th style="width: 10%;" class="center">고객명</th>
						<th style="width: 15%;" class="center">휴대전화</th>
						<th style="width: 10%;" class="center">제안일자</th>
						<th style="width: 10%;" class="center">목표기간(개월)</th>
						<th style="width: 10%;" class="center">상품유형</th>
						<th style="width: 15%;" class="center">상품종류</th>
						<th style="width: 15%;" class="center">제안금액</th>
						<th style="width: 10%;" class="center">진행상태</th>
                    </tr>
                </thead>                          
                <tbody>    
                    <tr v-for="item in printInfo.promionList">
                        <td class="center">{{ item.cust_name }}</td>
						<td class="center">{{ item.cust_mbl_telno }}</td>
						<td class="center">{{ item.wrt_dt }}</td>
						<td class="center">{{ item.goal }}</td>
						<td class="center">{{ item.prod_type }}</td>
						<td class="center">{{ item.prod_name }}</td>
						<td class="center">{{ item.amt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') }}</td>
						<td class="center">{{ item.state }}</td>
                    </tr>                                
                </tbody>
            </table>
        </div>
    </template>
</div>
</body>
<script>
var vueapp = new Vue({
	el: "#vueapp",
	data: {
		dataList: [],
		cust_name: "",  
		cust_mbl_telno: "",  
		prod_type: "",  
		prod_name: "",
	},
	mounted: function() {
		var fromDtl = cf_getUrlParam("fromDtl");
		var pagingConfig = cv_sessionStorage.getItem("pagingConfig");
		
		if ("Y" === fromDtl && !cf_isEmpty(pagingConfig)) {
			cv_pagingConfig.pageNo = pagingConfig.pageNo;
			cv_pagingConfig.orders = pagingConfig.orders;

			var params = cv_sessionStorage.getItem("params");
			this.cust_name = params.cust_name;
			this.cust_mbl_telno = params.cust_mbl_telno;
			this.prod_type = params.prod_type;
			this.prod_type = params.prod_name;

			this.searchOne(true);
		} else {
			cv_sessionStorage.removeItem("pagingConfig")
				.removeItem("params");
			this.searchOne(true);
		}
	},
	methods: {
		searchOne: function(isInit) { // 조건검색 버튼
			// 데이터 초기화
			this.dataList = [];

			cv_pagingConfig.func = this.searchOne;
			if (isInit === true) {
				cv_pagingConfig.pageNo = 1;
				cv_pagingConfig.orders = [{ target: "wrt_dt", isAsc: true }];
			}
			
			// 검색 파라미터 설정
			var params = {
				cust_name: this.cust_name,
				cust_mbl_telno: this.cust_mbl_telno,
				prod_type: this.prod_type,
				prod_name: this.prod_name,
			};
			
			// 세션 스토리지에 설정
			cv_sessionStorage.setItem('pagingConfig', cv_pagingConfig).setItem('params', params);

			// AJAX 호출
			cf_ajax("/t1_prod_mng/selectOneT1Paging", params, this.getListCB);
		},
		
		getListAll: function(isInit) { // 전체리스트
		    // 검색 필드 초기화
		    this.cust_name = '';
		    this.cust_mbl_telno = '';
		    this.prod_type = '';
		    this.prod_name = '';

		    // 데이터 초기화
		    this.dataList = [];

		    // 페이징 설정 초기화
		    cv_pagingConfig.func = this.searchOne;
		    if (isInit === true) {
		        cv_pagingConfig.pageNo = 1;
		        cv_pagingConfig.orders = [{ target: "wrt_dt", isAsc: true }];
		    }

		    // 검색 파라미터 설정
		    var params = {
	    		cust_name: this.cust_name,
				cust_mbl_telno: this.cust_mbl_telno,
				prod_type: this.prod_type,
				prod_name: this.prod_name,
		    };

		    // 세션 스토리지에 페이징 설정 및 검색 파라미터 저장
		    cv_sessionStorage.setItem('pagingConfig', cv_pagingConfig).setItem('params', params);

		    // 서버에 요청 보내기
		    cf_ajax("/t1_prod_mng/getT1ListPaging", params, this.getListCB);
		},
		
		prod: function(isInit) { // 진행 중인 설계 목록
		    // 검색 필드 초기화
		    this.cust_name = '';
		    this.cust_mbl_telno = '';
		    this.prod_type = '';
		    this.prod_name = '';

		    // 데이터 초기화
		    this.dataList = [];

		    // 페이징 설정 초기화
		    cv_pagingConfig.func = this.searchOne;
		    if (isInit === true) {
		        cv_pagingConfig.pageNo = 1;
		        cv_pagingConfig.orders = [{ target: "wrt_dt", isAsc: true }];
		    }

		    // 검색 파라미터 설정
		    var params = {
	    		cust_name: this.cust_name,
				cust_mbl_telno: this.cust_mbl_telno,
				prod_type: this.prod_type,
				prod_name: this.prod_name,
		    };

		    // 세션 스토리지에 페이징 설정 및 검색 파라미터 저장
		    cv_sessionStorage.setItem('pagingConfig', cv_pagingConfig).setItem('params', params);		    

		 // 서버에 요청 보내기
		    cf_ajax("/t1_prod_mng/stateT1Paging", params, this.getListCB);
		
		 },
		
		getListCB: function(data) {
			console.log("데이터 리스트:", data.list);
			this.dataList = data.list;
			cv_pagingConfig.renderPagenation("system");
		},
		
		gotoDtl: function(item) {		    
		    var params = {
					cust_mbl_telno : cf_defaultIfEmpty(item.cust_mbl_telno, ""),
					prod_ty_cd : cf_defaultIfEmpty(item.prod_ty_cd, ""),
				}
		    
		    cf_movePage("/t1_prod_mng/dtlA", params); // 페이지 이동 함수 호출
		},
		sortList: function(obj) {
			cf_setSortConf(obj, "wrt_dt");
			this.searchOne();
		},
		all_check: function(obj) {  
			$('[name=is_check]').prop('checked', obj.checked);
		},
		onCheck: function() {
			$("#allCheck").prop('checked', $("[name=is_check]:checked").length === $("[name=is_check]").length);
		},
		popPromionlistPrint: function() {
			var chkedList = $("[name=is_check]:checked");
			if (chkedList.length == 0) {
				alert("출력할 대상을 선택하여 주십시오.");
				return;
			}
			
			var dateCopyList = [];
			var idx;
			chkedList.each(function(i) {
				idx = $(this).attr("data-idx");
				dateCopyList.push(vueapp.dataList.getElementFirst("cust_name", idx));
			});
			
			console.log(dateCopyList);	

			// 출력 팝업 띄우기
			pop_promion_list_print.init(dateCopyList);
			$('#pop_promion_list_print').modal('show');
		},
	},
});

var pop_promion_list_print = new Vue({
	el : "#pop_promion_list_print",
	data : {
		printInfo : {
			promionCount : 0,
			promionList : [],
		}
	},
	methods : {
		init : function(dateCopyList){
			this.initInfo(dateCopyList);
		},
		initInfo : function(dateCopyList){
			this.printInfo = {	
				promionCount : dateCopyList.length,
				promionList : dateCopyList,
			}
		},
		print: function() {
		    const printArea = document.getElementById('promion_list_printArea').innerHTML;
		    console.log(printArea);

		    const win = window.open();
		    win.document.open();

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
	},
});
</script>
</html>