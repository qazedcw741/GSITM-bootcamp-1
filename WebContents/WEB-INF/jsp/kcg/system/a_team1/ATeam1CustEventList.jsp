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
<title>EVENT</title>
</head>
<body class="page-body">
	<div class="page-container">
		<jsp:include page="/WEB-INF/jsp/kcg/_include/system/sidebar-menu.jsp" flush="false" />
		<div class="main-content">
			<jsp:include page="/WEB-INF/jsp/kcg/_include/system/header.jsp" flush="false" />
			<ol class="breadcrumb bc-3">
				<li><a href="#none" onclick="cf_movePage('/system')"><i class="fa fa-home"></i>Home</a></li>
				<li class="active"><strong>고객이벤트 조회</strong></li>
			</ol>
			<h2>고객이벤트 목록</h2>
			<br>
			<div class="flex-column flex-gap-10" id="vueapp">
       			 <template>  
           			 <div class="flex flex-100">
						<div class="flex-wrap flex-80 flex flex-gap-10 flex-padding-10">
							<div class="form-group flex-40">
								<label class="fix-width-33">고객명 :</label>
								<input class="form-control" v-model="cust_name">
							</div>
							<div class="form-group flex-40">
								<label class="fix-width-33">이벤트명:</label>
								<select class="form-control" id="search_nm" v-model="event_name" @change="searchOne(true)">
									<option value="birthday">Birthday</option>
									<option value="예금만기일">예금만기</option>
									<option value="목돈만기일">목돈만기</option>
									<option value="대출상환일">대출상환</option>
									<option value="적금만기일">적금만기</option>
								</select>
							</div>
							<div class="form-group flex-40">
								<label class="fix-width-33">휴대전화 :</label>
								<input class="form-control" v-model="cust_mbl_telno">
							</div>
							<div class="form-group flex-40">
								<label class="fix-width-33">이벤트날짜 :</label>
								<input type="date" class="form-control" v-model="event_date">
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
								<button type="button" class="btn btn-blue btn-icon icon-left form-control" @click="event(true)">
									진행중인 이벤트 <i class="entypo-search"></i>
								</button>
							</div>
						</div>
					</div>
					<div class="flex flex-100 flex-padding-10 flex-gap-10" style="justify-content:flex-end;border: 1px solid #999999;">
	                <button type="button" class="btn btn-blue btn-icon icon-left"
	                	style="margin-left: 5px;" @click="popCustmnglistPrint">인쇄<i class="entypo-print"></i>
                	</button>					          
            		</div>
					<table class="table table-bordered datatable dataTable" id="grid_app" style="border: 1px solid #999999;">
						<thead>
							<tr class="replace-inputs">
								<th style="width: 5%;" class="center">
								<input type="checkbox" id="allCheck" @click="all_check($event.target)" style="cursor: pointer;"></th>
								<th style="width: 15%;" class="center">고객명</th>
								<th style="width: 15%;" class="center">주민번호</th>
								<th style="width: 15%;" class="center">휴대전화번호</th>
								<th style="width: 15%;" class="center">이벤트명</th>
								<th style="width: 15%;" class="center">날짜</th>
							</tr>
						</thead>
						<tbody>
							<tr v-for="(item, index) in dataList" @dblclick="gotoDtl(item.cust_mbl_telno)" style="cursor: pointer;">
								<td class="center"><input type="checkbox" :data-idx="item.cust_name" name="is_check" @click="onCheck" style="cursor: pointer;"></td>
								<td class="center">{{ item.cust_name }}</td>
								<td class="center">{{ maskResidentNumber(item.cust_pridtf_no) }}</td>
								<td class="center">{{ item.cust_mbl_telno }}</td>
								<td class="center">{{ item.event_name }}</td>
								<td class="center">{{ item.event_date }}</td>
							</tr>
						</tbody>
					</table>
					<div class="dataTables_paginate paging_simple_numbers" id="div_paginate"></div>
				</template>
			</div>
			<jsp:include page="/WEB-INF/jsp/kcg/_include/system/footer.jsp" flush="false" />
		</div>
	</div>
	<div class="modal fade" id="pop_cust_info">
<template>
	<div class="modal-dialog" style="width: 80%;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true" id="btn_popClose">&times;</button>
				<h4 class="modal-title" id="modify_nm">고객기본정보</h4>
			</div>
			<div class="modal-body">
                <div class="panel-body" style="display: flex;border: 1px;width: 100%;">			
                    <div class="left-panel" style="width: 50%;">
                        <div class="form-group">
                            <label for="err_eng_nm" class="fix-width-33">작성일자:</label>
                            <input type="text" class="form-control" id="wrt_dt" v-model="info.wrt_dt">
                        </div>
     
                        <div class="form-group">
                            <label for="err_eng_nm" class="fix-width-33">성명:</label>
                            <input type="text" class="form-control" id="cust_name" v-model="info.cust_name">
                        </div>
   
   
                        <div class="form-group">
                            <label for="err_eng_nm" class="fix-width-33">실명번호:</label>
                            <input type="text" class="form-control" id="cust_pridtf_no" v-model="info.cust_pridtf_no">
                        </div>
     
   
                        <div class="form-group">
                            <label for="err_eng_nm" class="fix-width-33">E-mail:</label>
                            <input type="text" class="form-control" id="cust_email" v-model="info.cust_email">
                        </div>
     
                        <div class="form-group">
                            <label for="err_eng_nm" class="fix-width-33">전화번호:</label>
                            <input type="text" class="form-control" id="cust_home_telno" v-model="info.cust_home_telno">
                        </div>
   
                        <div class="form-group">
                            <label for="err_eng_nm" class="fix-width-33">핸드폰번호:</label>
                            <input type="text" class="form-control" id="cust_mbl_telno" v-model="info.cust_mbl_telno">
                        </div>
   
                        <div class="form-group">
                            <label for="err_eng_nm" class="fix-width-33">직업:</label>
                            <input type="text" class="form-control" id="cust_cr" v-model="info.cust_cr">
                        </div>
     
                        <div class="form-group">
                            <label for="err_eng_nm" class="fix-width-33">주소:</label>
                            <input type="text" class="form-control" id="cust_addr" v-model="info.cust_addr">
                        </div>
     
                    </div>
                    <div class="right-panel"  style="width: 50%;">
                        <div class="form-group">
                            <label for="err_eng_nm">상담내역:</label>
                        </div>	
                    <div>
                        <textarea  id="cnsl_details" v-model="info.cnsl_details"style="width:100%;" ></textarea>              
                    </div>
                    </div>
                </div>          
			</div>
			<div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
         	</div>
		</div>
	</div>
</template>
</div>
<div class="modal fade" id="pop_cust_mnglist_print">
    <template>
        <div class="modal-dialog" style="width: 80%;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true" id="btn_popClose">&times;</button>
                    <h4 class="modal-title" id="modify_nm">고객이벤트목록 출력관리</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal form-groups-bordered">
                        <div>
                            [고객이벤트목록] 를(을) 출력하시겠습니까?<br>
                            ※고객정보는 개인정보관리 대상이므로 유의하셔야 합니다.
                        </div>
                        <div class="form-group">
                            <div class="col-sm-10">
                                출력인원 : {{printInfo.custCount}}명
                            </div>
                        </div>
                        <div class="form-group">
                            <table class="table datatable dataTable">
                                <thead>
                                    <tr class="replace-inputs">
                                        <th style="width: 15%;" class="center">고객명</th>
                                        <th style="width: 15%;" class="center">주민번호</th>
                                        <th style="width: 15%;" class="center">휴대전화번호</th>
                                        <th style="width: 15%;" class="center">이벤트명</th>
                                        <th style="width: 15%;" class="center">날짜</th>
                                    </tr>
                                </thead>                        
                                <tbody>  
                                    <tr v-for="item in printInfo.custList" >
                                        <td class="center">{{ item.cust_name }}</td>
                                        <td class="center">{{ maskResidentNumber(item.cust_pridtf_no) }}</td>
                                        <td class="center">{{ item.cust_mbl_telno }}</td>
                                        <td class="center">{{ item.event_name }}</td>
                                        <td class="center">{{ item.event_date }}</td>
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
        <!-- Move cust_mnglist_printArea inside Vue template -->
        <div id="cust_mnglist_printArea" style="visibility: hidden; position: absolute; top: -9999px;">
            <table class="table datatable dataTable">
                <thead>
                    <tr class="replace-inputs">
                        <th style="width: 15%;" class="center">고객명</th>
                        <th style="width: 15%;" class="center">주민번호</th>
                        <th style="width: 15%;" class="center">휴대전화번호</th>
                        <th style="width: 15%;" class="center">이벤트명</th>
                        <th style="width: 15%;" class="center">날짜</th>
                    </tr>
                </thead>                          
                <tbody>    
                    <tr v-for="item in printInfo.custList">
                        <td class="center">{{ item.cust_name }}</td>
                        <td class="center">{{ maskResidentNumber(item.cust_pridtf_no) }}</td>
                        <td class="center">{{ item.cust_mbl_telno }}</td>
                        <td class="center">{{ item.event_name }}</td>
                        <td class="center">{{ item.event_date }}</td>  
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
		event_name: "",  
		event_date: "",  
		search_val: "",
		search_nm: "",
		cust_mbl_telno: "",
	},
	mounted: function() {
		var fromDtl = cf_getUrlParam("fromDtl");
		var pagingConfig = cv_sessionStorage.getItem("pagingConfig");
		
		if ("Y" === fromDtl && !cf_isEmpty(pagingConfig)) {
			cv_pagingConfig.pageNo = pagingConfig.pageNo;
			cv_pagingConfig.orders = pagingConfig.orders;

			var params = cv_sessionStorage.getItem("params");
			this.cust_name = params.cust_name;
			this.event_name = params.event_name;
			this.event_date = params.event_date;
			this.search_val = params.search_val;
			this.search_nm = params.search_nm;
			this.cust_mbl_telno = params.cust_mbl_telno;

			this.searchOne(true);
		} else {
			cv_sessionStorage.removeItem("pagingConfig")
				.removeItem("params");
			this.searchOne(true);
		}
	},
	methods: {
		
		maskResidentNumber: function(cust_pridtf_no) {
            var parts = cust_pridtf_no.split('-');
            if (parts.length !== 2) {
                return cust_pridtf_no;
            }
            return parts[0] + '-' + parts[1].slice(0, 1) + '******';
        },
        	
		searchOne: function(isInit) { // 조건검색 버튼
			// 데이터 초기화
			this.dataList = [];

			cv_pagingConfig.func = this.searchOne;
			if (isInit === true) {
				cv_pagingConfig.pageNo = 1;
				cv_pagingConfig.orders = [{ target: "event_date", isAsc: true }];
			}
			
			// 검색 파라미터 설정
			var params = {
				cust_name: this.cust_name,
				event_name: this.event_name,
				event_date: this.event_date,
				search_val: this.search_val,
				search_nm: this.search_nm,
				cust_mbl_telno: this.cust_mbl_telno
			};
			
			// 세션 스토리지에 설정
			cv_sessionStorage.setItem('pagingConfig', cv_pagingConfig).setItem('params', params);

			// AJAX 호출
			cf_ajax("/aTeam1/custEventMng/getT1List", params, this.getListCB);
		},
		
		getListAll: function(isInit) { // 전체리스트
		    // 검색 필드 초기화
		    this.cust_name = '';
		    this.event_name = '';
		    this.event_date = '';
		    this.search_val = '';
		    this.search_nm = '';
		    this.cust_mbl_telno = '';

		    // 데이터 초기화
		    this.dataList = [];

		    // 페이징 설정 초기화
		    cv_pagingConfig.func = this.searchOne;
		    if (isInit === true) {
		        cv_pagingConfig.pageNo = 1;
		        cv_pagingConfig.orders = [{ target: "event_date", isAsc: true }];
		    }

		    // 검색 파라미터 설정
		    var params = {
		        cust_name: this.cust_name,
		        event_name: this.event_name,
		        event_date: this.event_date,
		        search_nm: this.search_nm,
		        search_val: this.search_val,
		        cust_mbl_telno: this.cust_mbl_telno,
		    };

		    // 세션 스토리지에 페이징 설정 및 검색 파라미터 저장
		    cv_sessionStorage.setItem('pagingConfig', cv_pagingConfig).setItem('params', params);

		    // 서버에 요청 보내기
		    cf_ajax("/aTeam1/custEventMng/getT1ListAll", params, this.getListCB);
		},
		
		event: function(isInit) { // 진행 중인 이벤트 목록
		    // 검색 필드 초기화
		    this.cust_name = '';
		    this.event_name = '';
		    this.event_date = '';
		    this.search_val = '';
		    this.search_nm = '';
		    this.cust_mbl_telno = '';

		    // 데이터 초기화
		    this.dataList = [];

		    // 페이징 설정 초기화
		    cv_pagingConfig.func = this.searchOne;
		    if (isInit === true) {
		        cv_pagingConfig.pageNo = 1;
		        cv_pagingConfig.orders = [{ target: "event_date", isAsc: true }];
		    }

		    // 검색 파라미터 설정
		    var params = {
		        cust_name: this.cust_name,
		        event_name: this.event_name,
		        event_date: this.event_date,
		        search_nm: this.search_nm,
		        search_val: this.search_val,
		        cust_mbl_telno: this.cust_mbl_telno,
		    };

		    // 세션 스토리지에 페이징 설정 및 검색 파라미터 저장
		    cv_sessionStorage.setItem('pagingConfig', cv_pagingConfig).setItem('params', params);		    

		 // 서버에 요청 보내기
		    cf_ajax("/aTeam1/custEventMng/getT1ListEvent", params, this.getListCB);
		
		 },
		
		getListCB: function(data) {
			console.log("데이터 리스트:", data.list);
			this.dataList = data.list;
			cv_pagingConfig.renderPagenation("system");
		},
		
		gotoDtl: function(cust_mbl_telno) {
			console.log(cust_mbl_telno);
			pop_cust_info.init(cust_mbl_telno);
			$('#pop_cust_info').modal('show');
		},
		sortList: function(obj) {
			cf_setSortConf(obj, "event_date");
			this.searchOne();
		},
		sortListAll: function(obj) {
			cf_setSortConf(obj, "event_date");
			this.getListAll();
		},
		all_check: function(obj) {  
			$('[name=is_check]').prop('checked', obj.checked);
		},
		onCheck: function() {
			$("#allCheck").prop('checked', $("[name=is_check]:checked").length === $("[name=is_check]").length);
		},
		popCustmnglistPrint: function() {
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
			pop_cust_mnglist_print.init(dateCopyList);
			$('#pop_cust_mnglist_print').modal('show');
		},
	},
});

var pop_cust_info = new Vue({
    el: "#pop_cust_info",
    data: {
        info: {
            cust_name: "",
            cust_cr: "",
            cust_pridtf_no: "",  
            cust_email: "",
            cust_home_telno: "",
            cust_mbl_telno: "",
            cust_addr: "",
            wrt_dt: "",
            cnsl_details: "",
        }
    },
    methods: {
        init: function(cust_mbl_telno) {
            this.info.cust_mbl_telno = cust_mbl_telno;  // 입력 받은 cust_pridtf_no로 설정
            if (!cf_isEmpty(this.info.cust_mbl_telno)) {
                this.getInfo();
            }
        },
        getInfo: function() {
            var params = {
            	cust_mbl_telno: this.info.cust_mbl_telno,
            };
            cf_ajax("/aTeam1/custEventMng/getT1Info", params, this.getInfoCB);
        },
        getInfoCB: function(data) {
            this.info = data;  // 서버에서 받은 데이터로 info 객체를 업데이트
        },
    },
});

var pop_cust_mnglist_print = new Vue({
	el : "#pop_cust_mnglist_print",
	data : {
		printInfo : {
			custCount : 0,
			custList : [],
		}
	},
	methods : {
		maskResidentNumber: function(cust_pridtf_no) {
            var parts = cust_pridtf_no.split('-');
            if (parts.length !== 2) {
                return cust_pridtf_no;
            }
            return parts[0] + '-' + parts[1].slice(0, 1) + '******';
        },
		init : function(dateCopyList){
			this.initInfo(dateCopyList);
		},
		initInfo : function(dateCopyList){
			this.printInfo = {	
				custCount : dateCopyList.length,
				custList : dateCopyList,
			}
		},
		print: function() {
		    const printArea = document.getElementById('cust_mnglist_printArea').innerHTML;
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