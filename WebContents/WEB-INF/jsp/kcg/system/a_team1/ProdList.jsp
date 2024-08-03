<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <jsp:include page="/WEB-INF/jsp/kcg/_include/system/header_meta.jsp" flush="false" />
            <!-- Imported styles on this page -->
            <link rel="stylesheet" href="/static_resources/system/js/datatables/datatables.css">
            <link rel="stylesheet" href="/static_resources/system/js/select2/select2-bootstrap.css">
            <link rel="stylesheet" href="/static_resources/system/js/select2/select2.css">
            <link rel="stylesheet" href="/static_resources/system/js/datatables/proddtl.css">
            <title>관리자시스템</title>
        </head>

        <body class="page-body">

            <div class="page-container">

                <jsp:include page="/WEB-INF/jsp/kcg/_include/system/sidebar-menu.jsp" flush="false" />

                <div class="main-content">

                    <jsp:include page="/WEB-INF/jsp/kcg/_include/system/header.jsp" flush="false" />

                    <ol class="breadcrumb bc-3">
                        <li><a href="#none" onclick="cf_movePage('/system')"><i class="fa fa-home"></i>Home</a></li>
                        <li class="active"><strong>상품 목록 조회</strong></li>
                    </ol>

                    <h2>상품 목록 조회</h2>
                    <br/>
					
					
                    <div class="flex-column flex-gap-10" id="vueapp">
                        <template>
                        
                        <!-- 					검색 창 -->
                        
                            <div class="flex flex-100">
                                <div class="flex-wrap flex-66 flex flex-gap-10 flex-padding-10">
                                    <div class="form-group flex-40">
                                        <label class="fix-width-33">상품명 :</label>
                                        <input class="form-control" type="text" v-model="prod_name" value="">
                                    </div>
                                    <div class="form-group flex-40">
                                        <label class="fix-width-33">상품 타입:</label>
<!--                                         <input class="form-control" type="text" v-model="prod_type" value=""> -->
                                        <select class="form-control" id="prod_type" v-model="prod_type">
                                        	<option value="">미 선택</option> 
											<option value="예금">예금</option>
											<option value="적금">적금</option>
											<option value="대출">대출</option>
											<option value="목돈">목돈 마련 적금</option>
										</select>
                                    </div>
                                    <div class="form-group flex-40">
                                        <label class="fix-width-33">판매 시작일:</label>
                                        <input class="form-control" type="text" v-model="prod_start_sale" value="">
                                    </div>
                                    <div class="form-group flex-40">
                                        <label class="fix-width-33">납입주기:</label>
<!--                                         <input class="form-control" type="number" v-model="prod_payment_cycle" value=""> -->
                                        <select class="form-control" id="prod_payment_cycle" v-model="prod_payment_cycle">
											<option value="">미 선택</option> 
											<option value="1">매 달 납입</option>
											<option value="3">매 분기 납입</option>
											<option value="6">반 년마다 납입</option>
											<option value="12">매 년 납입</option>
										</select>
                                    </div>
                                    
                                </div>
<!-- 										검색 버튼 -->
                                <div class="flex-wrap flex-33 flex flex-center flex-gap-10 flex-padding-10">
                                    <div class="form-group" style="width:45%;">
                                        <button type="button" class="btn btn-blue btn-icon icon-left form-control " @click="getProdSearch(true)">
                                            조건검색
                                            <i class="entypo-search"></i>
                                        </button>
                                    </div>
                                    <div class="form-group" style="width:45%;">
                                        <button type="button" class="btn btn-blue btn-icon icon-left form-control"
                                            v-model="search_val" @click="getProdList(true)">
                                            전체검색
                                            <i class="entypo-search"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                            
                            
<!--                             	검색 란 아래 버튼  -->
                            <div class="flex flex-100 flex-padding-10 flex-gap-10"
                                style="justify-content:flex-end;border: 1px solid #999999;">
                                <button type="button" class="btn btn-blue btn-icon icon-left" style="margin-left: 5px;"
                                    @click="popProdListPrint">
                                    출력
                                    <i class="entypo-archive"></i>
                                </button>
                                <button type="button" class="btn btn-blue btn-icon icon-left" style="margin-left: 5px;"
                                    @click="goToClearForm">
                                    등록
                                    <i class="entypo-vcard"></i>
                                </button>
                            </div>
                            
                            
                            
                            
                            <table class="table table-bordered datatable dataTable" id="grid_app"
                                style="border: 1px solid #999999;">
                                <thead>
                                    <tr class="replace-inputs">
                                        <th style="width: 5%;" class="center"><input type="checkbox" id="allCheck"
                                                @click="all_check(event.target)" style="cursor: pointer;"></th>
                                        <th class="center"
                                        	@click="sortList(event.target)" sort_target="prod_sn">색인</th>
                                        <th class="center"
                                        	@click="sortList(event.target)" sort_target="prod_name">상품명</th>
                                        <th class="center"
                                        	@click="sortList(event.target)" sort_target="prod_type">상품타입</th>
                                        <th class="center"
                                        	@click="sortList(event.target)" sort_target="prod_min_amount">최소 판매 액</th>
                                        <th class="center"
                                        	@click="sortList(event.target)" sort_target="prod_max_amount">최고 판매 액</th>
                                        <th class="center"
                                        	@click="sortList(event.target)" sort_target="prod_payment_cycle">납입 주기</th>
                                        <th class="center"
                                        	@click="sortList(event.target)" sort_target="prod_start_period">판매 시작</th>
                                        <th class="center"
                                        	@click="sortList(event.target)" sort_target="prod_deadline_period">판매 마감</th>
                                        <th class="center"
                                        	@click="sortList(event.target)" sort_target="prod_interest_taxation">이율</th>
                                        <th class="center"
                                        	@click="sortList(event.target)" sort_target="prod_sales_status">판매 상태</th>
                                        <th class="center"
                                        	@click="sortList(event.target)" sort_target="prod_start_sale">판매 시작일</th>
                                        <th class="center"
                                        	@click="sortList(event.target)" sort_target="prod_end_sale">판매 종료일</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="item in dataList" @dblclick="gotoDtl(item.prod_sn)"
                                        style="cursor: pointer;">
                                        <td class="center" @dblclick.stop="return false;">
                                        <input type="checkbox"
                                                :data-idx="item.prod_name" name="is_check" @click.stop="onCheck"
                                                style="cursor: pointer;">
                                        </td>
                                        <td class="center">{{item.prod_sn}}</td>
                                        <td class="center">{{item.prod_name}}</td>
                                        <td class="center">{{item.prod_type}}</td>
                                        <td class="center">{{item.prod_min_amount}}</td>
                                        <td class="center">{{item.prod_max_amount}}</td>
										<td class="center">
											<span v-if="item.prod_payment_cycle === 1">월납</span>
											<span v-else-if="item.prod_payment_cycle === 3">일시납</span>
										</td>
										<td class="center">{{item.prod_start_period}}</td>
                                        <td class="center">{{item.prod_deadline_period}}</td>
                                        <td class="center">
                                        	<span v-if="item.prod_interest_taxation === 1">일반과세</span>
                                        	<span v-else-if="item.prod_interest_taxation === 2">세금우대</span>
                                        </td>
                                        <td class="center">
                                        	<span v-if="item.prod_sales_status === 0">정상(판매)</span>
                                        	<span v-else-if="item.prod_sales_status === 1">판매준비</span>
                                        	<span v-else-if="item.prod_sales_status === 2">판매인가</span>
                                        	<span v-else-if="item.prod_sales_status === 3">판매종지</span>
                                        </td>
                                        <td class="center">{{item.prod_start_sale}}</td>
                                        <td class="center">{{item.prod_end_sale}}</td>
                                    </tr>
                                </tbody>
                            </table>
                            <br>
                            <div class="dataTables_paginate paging_simple_numbers"
						id="div_paginate"></div>
                            
                        </template>
                    </div>


                    <jsp:include page="/WEB-INF/jsp/kcg/_include/system/footer.jsp" flush="false" />
                </div>
            </div>
            
            <!-- 출력팝업DIV -->
    <div class="modal fade" id="popup_print">
        <template>
            <div class="modal-dialog" style="width: 80%;">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"
                            aria-hidden="true" id="btn_popClose">&times;</button>
                        <h4 class="modal-title" id="modify_nm">상품목록 출력관리</h4>
                    </div>
                    <div class="modal-body">
                        <form class="form-horizontal form-groups-bordered">
                            <div>
                                [상품목록] 를(을) 출력하시겠습니까?<br> ※판매상품정보는 대외비이므로 유의하셔야 합니다.
                            </div>
                            <div class="form-group">
                                <div class="col-sm-10">출력대상 : {{printInfo.prodCount}}건</div>
                            </div>
                            <div class="form-group" id="printArea">
                                <table class="table datatable dataTable">
                                    <thead>
                                        <tr class="replace-inputs">
                                            <th style="width: 25%;" class="center">상품 시리얼 넘버</th>
                                            <th style="width: 50%;" class="center">상품 명</th>
                                            <th style="width: 10%;" class="center">상품 유형</th>
                                            <th style="width: 15%;" class="center">납입 주기</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr v-for="item in printInfo.prodList">
                                            <td class="center">{{item.prod_sn}}</td>
                                            <td class="left">{{item.prod_name}}</td>
                                            <td class="center">{{item.prod_type}}</td>
                                            <td class="center">{{item.prod_payment_cycle}}개월</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>

                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" @click="print">인쇄</button>
                        <button type="button" class="btn btn-secondary"
                            data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </template>
    </div>
 
        </body>
        
        
        
        <script>
            var vueapp = new Vue({
                el: "#vueapp",
                data: {
                    dataList: [],
                    prod_sn: "",
            		prod_name: "",
            		prod_type: "",
            		prod_min_amount: "",
            		prod_max_amount: "",
            		prod_payment_cycle: "",
            		prod_start_period: "",
            		prod_deadline_period: "",
            		prod_interest_taxation: "",
            		prod_sales_status: "",
            		prod_start_sale: "",
            		prod_end_sale: "",
                  	
            		search_nm: "",
                    search_val: "",
                },
                mounted: function () {
                    // 마운트하면 List 불러오기(전체 리스트)
                    var fromDtl = cf_getUrlParam("fromDtl");
                    var pagingConfig = cv_sessionStorage.getItem("pagingConfig");
                    
                    if("Y" === fromDtl && !cf_isEmpty(pagingConfig)){
            			cv_pagingConfig.pageNo = pagingConfig.pageNo;
            			cv_pagingConfig.orders = pagingConfig.orders;
            			
            	 		var params = cv_sessionStorage.getItem("params");            	 		
            	 		
            	 		this.prod_name = params.prod_name;
            	 		this.prod_type = params.prod_type;          
            	 		this.prod_start_sale = params.prod_start_sale;    
            	 		this.prod_payment_cycle = params.prod_payment_cycle;   	 		
            	 		        	 		
            	 		this.search_nm = params.search_nm;
            	 		this.search_val = params.search_val;

            	 		this.getProdList(true);
            		} else {
            			cv_sessionStorage
            				.removeItem("pagingConfig")
            				.removeItem("params");
            			this.getProdList(true);
            		}                    
                                     
                },
                methods: {
                    getProdList: function (isInit) {
                    	
                        cv_pagingConfig.func = this.getProdList;
                        if (isInit === true) {
                            cv_pagingConfig.pageNo = 1;
                            cv_pagingConfig.orders = [{ target: "prod_sn", isAsc: true }];
                        }

                        var params = {
                        	prod_name: this.prod_name,
                        	prod_type: this.prod_type,
                        	prod_start_sale: this.prod_start_sale,
                        	prod_payment_cycle: this.prod_payment_cycle,
                        	
                            search_nm: this.search_nm,
                            search_val: this.search_val,
                        }

                        cv_sessionStorage
                            .setItem('pagingConfig', cv_pagingConfig)
                            .setItem('params', params);

                        cf_ajax("/t1_prod_mng/getProdList", params, this.getListCB);
                        },
                    getProdSearch: function (isInit) {
                        
                        cv_pagingConfig.func = this.getProdSearch;
                        if (isInit === true) {
                            cv_pagingConfig.pageNo = 1;
                            cv_pagingConfig.orders = [{ target: "prod_sn", isAsc: true }];
                        }

                        var params = {
                            search_nm: this.search_nm,
                            search_val: this.search_val,
                            prod_name: this.prod_name,
                    		prod_type: this.prod_type,
                    		prod_start_sale: this.prod_start_sale,
                    		prod_payment_cycle: this.prod_payment_cycle,
                        }
                        
                        cv_sessionStorage
                            .setItem('pagingConfig', cv_pagingConfig)
                            .setItem('params', params);

                        cf_ajax("/t1_prod_mng/getProdSearch", params, this.getListCB);
                    },
                    
                    getListCB: function (data) {
                    	console.log("getListCB: ")
                        console.log(data);
                    	console.log(data.list);
                    	
                        this.dataList = data.list;
                        cv_pagingConfig.renderPagenation("system");
                    },
                    gotoDtl: function (prod_sn) {
	                    var params = {
	                    		prod_sn : cf_defaultIfEmpty(prod_sn, ""),
	                	}
	                	cf_movePage("/t1_prod_mng/dtl", params);
                    },
                    sortList: function (obj) {
                        cf_setSortConf(obj, "prod_sn");
                        this.getProdSearch();
                        this.getProdList();
                    },
//                     sortListAll: function (obj) {
//                         cf_setSortConf(obj, "prod_sn");
//                         this.getProdList();
//                     },
                    all_check: function (obj) {
                        $('[name=is_check]').prop('checked', obj.checked);
                    },
                    onCheck: function () {
                        $("#allCheck").prop('checked',
                            $("[name=is_check]:checked").length === $("[name=is_check]").length
                        );
                    },
                    goToClearForm: function(){
                    	cf_movePage("/t1_prod_mng/dtl");
                    },
                    popProdListPrint: function (prod_name) {
                        var chkedList = $("[name=is_check]:checked");
                        if (chkedList.length == 0) {
                            alert("출력할 대상을 선택하여 주십시오.");
                            return;
                        }
                        //check list 가져오기..
                        var dateCopyList = [];
                        var idx;
                        
                        console.log("this.dataList: ")
                        console.log(this.dataList);
                        
                        chkedList.each(function (i) {
                            idx = $(this).attr("data-idx");
                            dateCopyList.push(vueapp.dataList.getElementFirst("prod_name", idx));
                        });

                        console.log("popProdListPrint.dateCopyList: ");
                        console.log(dateCopyList);

                        //출력팝업 띄우기
                        pop_prod_print.init(dateCopyList);
                        $('#popup_print').modal('show');

                    },
                },
            });

            var pop_prod_print = new Vue({
                el: "#popup_print",
                data: {
                    printInfo: {
                        prodCount: 0,
                        prodList: [],
                    }
                },
                methods: {
                    init: function (dateCopyList) {
                        this.initInfo(dateCopyList);
                    },
                    initInfo: function (dateCopyList) {
                        this.printInfo = {
                            prodCount: dateCopyList.length,
                            prodList: dateCopyList,
                        }
                    },
                    print: function () {
                        const printArea = document.getElementById('printArea').innerHTML;
                        console.log(printArea);

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

                        /*
                        win.document.write('<link rel="icon" href="/static_resources/system/images/favicon.ico">');
                        win.document.write('<link rel="stylesheet" href="/static_resources/system/js/jquery-ui/css/no-theme/jquery-ui-1.10.3.custom.min.css">');
                        win.document.write('<link rel="stylesheet" href="/static_resources/system/css/font-icons/entypo/css/entypo.css">');
                        win.document.write('<link rel="stylesheet" href="/static_resources/lib/fonts/font-awesome-4.7.0/css/font-awesome.css">');
                        win.document.write('<link rel="stylesheet" href="/static_resources/system/css/bootstrap.css">');
                        win.document.write('<link rel="stylesheet" href="/static_resources/system/css/neon-core.css">');
                        win.document.write('<link rel="stylesheet" href="/static_resources/system/css/neon-theme.css">');
                        win.document.write('<link rel="stylesheet" href="/static_resources/system/css/neon-forms.css">');
                        win.document.write('<link rel="stylesheet" href="/static_resources/system/css/custom.css">');
                        */

                        win.document.write('<link rel="stylesheet" href="/static_resources/system/js/datatables/datatables.css">');
                        win.document.write('<link rel="stylesheet" href="/static_resources/system/js/select2/select2-bootstrap.css">');
                        win.document.write('<link rel="stylesheet" href="/static_resources/system/js/select2/select2.css">');

                        win.document.write('<title></title><style>');
                        win.document.write('td.center {text-align: center;}');
                        win.document.write('th.center {text-align: center;}');
                        win.document.write('body {font-size: 14px;}');
                        //win.document.write('body, td {font-falmily: Verdana; font-size: 10pt;}');
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