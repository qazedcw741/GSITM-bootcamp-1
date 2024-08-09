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
                        <li class="active"><strong>고객정보 목록 조회</strong></li>
                    </ol>

                    <h2>고객정보 목록</h2>
                    <br />

                    <div class="flex-column flex-gap-10" id="vueapp">
                        <template>
                            <div class="flex flex-100">
                                <div class="flex-wrap flex-66 flex flex-gap-10 flex-padding-10">
                                    <div class="form-group flex-15">
                                        <label class="fix-width-33">고객명:</label>
                                        <input class="form-control" v-model="cust_name" value="" >
                                    </div>
                                    <div class="form-group flex-15">
                                        <label class="fix-width-33">담당자:</label>
     									<input class="form-control" v-model="drt_name" value="">
                                    </div>
                                    <div class="form-group flex-20">
                                        <label class="fix-width-33">생년월일:</label>
                                        <select v-model="birth_year" >
                                        <option value="">선택안함</option>
									      <option v-for="num in descendingNumbers" :key="num" :value="num">{{ formatTwoDigits(num) }}</option>
									    </select>
									    <select v-model="birth_month" >
									    <option value="">선택안함</option>
									      <option v-for="num in 12" :key="num" :value="num">{{ formatTwoDigits(num) }}</option>
									    </select>
									    <select v-model="birth_day" >
									    <option value="">선택안함</option>
									      <option v-for="num in 31" :key="num" :value="num">{{ formatTwoDigits(num) }}</option>
									    </select>
                                    </div>
                                </div>

                                <div class="flex-wrap flex-33 flex flex-center flex-gap-10 flex-padding-10">
                                    <div class="form-group" style="width:45%;">
                                        <button type="button" class="btn btn-blue btn-icon icon-left form-control "
                                            v-model="search_val" @click="getT1SearchList(true)">
                                            검색하기
                                            <i class="entypo-search"></i>
                                        </button>
                                    </div>
                                    <div class="form-group" style="width:45%;">
                                        <button type="button" class="btn btn-blue btn-icon icon-left form-control"
                                            v-model="search_val" @click="getT1CustListAll(true)">
                                            전체조회
                                            <i class="entypo-search"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <div class="flex flex-100 flex-padding-10 flex-gap-10"
                                style="justify-content:flex-end;border: 1px solid #999999;">
                                <button type="button" class="btn btn-blue btn-icon icon-left" style="margin-left: 5px;"
                                    @click="popCustmnglistPrint">
                                    관리대장출력
                                    <i class="entypo-archive"></i>
                                </button>
                                <button type="button" class="btn btn-blue btn-icon icon-left" style="margin-left: 5px;"
                                    @click="popCustmngCardPrint">
                                    관리카드출력
                                    <i class="entypo-vcard"></i>
                                </button>
                                <button type="button" class="btn btn-orange btn-icon icon-left"
                                    style="margin-left: 5px;" @click="custInfoMng">
                                    고객관리
                                    <i class="entypo-users"></i>
                                </button>
                            </div>
                            <table class="table table-bordered datatable dataTable" id="grid_app"
                                style="border: 1px solid #999999;">
                                <thead>
                                    <tr class="replace-inputs">
                                        <th style="width: 5%;" class="center"><input type="checkbox" id="allCheck"
                                                @click="all_check(event.target)" style="cursor: pointer;"></th>
                                        <th style="width: 10%;" class="center">성명</th>
                                        <th style="width: 10%;" class="center">생년월일</th>
                                        <th style="width: 15%;" class="center">담당자</th>
                                        <th style="width: 15%;" class="center">휴대폰 번호</th>
                                        <th style="width: 15%;" class="center">직업</th>
                                        <th style="width: 35%;" class="center">주소</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="item in dataList" @dblclick="gotoDtl(item.cust_mbl_telno)"
                                        style="cursor: pointer;">
                                        <td class="center" @dblclick.stop="return false;"><input type="checkbox"
                                                :data-idx="item.cust_name" name="is_check" @click.stop="onCheck"
                                                style="cursor: pointer;">
                                        </td>
                                        <td class="center">{{item.cust_name}}</td>
                                        <td class="center">{{item.cust_birthdate}}</td>
                                        <td class="center">{{item.drt_name}}</td>
                                        <td class="center">{{item.cust_mbl_telno}}</td>
                                        <td class="center">{{item.cust_cr}}</td>
                                        <td class="center">{{item.cust_addr}}</td>
                                    </tr>
                                </tbody>
                            </table>
                            <div class="dataTables_paginate paging_simple_numbers"
						id="div_paginate"></div>
                        </template>
                    </div>


                    <jsp:include page="/WEB-INF/jsp/kcg/_include/system/footer.jsp" flush="false" />
                </div>
            </div>

<!--             고객기본정보조회 팝업 -->
            <div class="modal fade" id="pop_cust_detail">
                <template>
                    <div class="modal-dialog4">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"
                                    id="btn_popClose">&times;</button>
                                <h4 class="modal-title" id="modify_nm">고객기본정보</h4>
                            </div>
                            <div class="modal-body">
                                <form class="form-horizontal form-groups-bordered">
                                    <div class="clearAfter">
                                        <div class="left">
                                            <div class="form-group">
                                                <label for="err_cd" class="col-sm-3 control-label">마지막 상담일자</label>
                                                <div class="col-sm-9">
                                                    <input type="text" id="cnsl_date" v-model="info.cnsl_date" disabled>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="err_kor_nm" class="col-sm-3 control-label">성명</label>
                                                <div class="col-sm-9">
                                                    <input type="text" id="cust_name" v-model="info.cust_name" disabled>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="err_eng_nm" class="col-sm-3 control-label">주민등록번호</label>
                                                <div class="col-sm-9">
                                                    <input type="text" id="cust_safety_num" v-model="info.cust_safety_num" disabled>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="err_eng_nm" class="col-sm-3 control-label">E-mail</label>
                                                <div class="col-sm-9">
                                                    <input type="text" id="cust_email" v-model="info.cust_email" disabled>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="err_eng_nm" class="col-sm-3 control-label">전화번호</label>
                                                <div class="col-sm-9">
                                                    <input type="text" id="cust_home_telno" v-model="info.cust_home_telno" disabled>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="err_eng_nm" class="col-sm-3 control-label">핸드폰번호</label>
                                                <div class="col-sm-9">
                                                    <input type="text" id="cust_mbl_telno"
                                                        v-model="info.cust_mbl_telno" disabled>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="err_eng_nm" class="col-sm-3 control-label">직업</label>
                                                <div class="col-sm-9">
                                                    <input type="text" id="cust_cr" v-model="info.cust_cr" disabled>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="err_eng_nm" class="col-sm-3 control-label">주소</label>
                                                <div class="col-sm-9">
                                                    <input id="cust_addr" v-model="info.cust_addr"
                                                        style="width:40%;" disabled></input>
                                                </div>
                                            </div>
											<div class="form-group">
                                                <label for="err_eng_nm" class="col-sm-3 control-label">상담내역</label>
                                                <div class="col-sm-9">   
                                                <input id="cnsl_details" v-model="info.cnsl_details"
                                                        style="width:40%;" disabled></input>
                                                 </div>
                                             </div>
                                    </div>
                                </form>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </template>
            </div>


            <!--// 고객기본정보조회 팝업  -->

            <!-- 관리대장출력 팝업 -->
            <div class="modal fade" id="pop_cust_mnglist_print">
                <template>
                    <div class="modal-dialog4">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"
                                    id="btn_popClose">&times;</button>
                                <h4 class="modal-title" id="modify_nm">고객정보출력관리</h4>
                            </div>
                            <div class="modal-body">
                                <form class="form-horizontal form-groups-bordered">
                                    <div>
                                        [고객관리카드] 를(을) 출력하시겠습니까?<br>
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
                                                    <th style="width: 20%;" class="center">성명</th>
                                                    <th style="width: 20%;" class="center">생년월일</th>
                                                    <th style="width: 30%;" class="center">핸드폰번호</th>
                                                    <th style="width: 30%;" class="center">직업</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr v-for="item in printInfo.custList">
                                                    <td class="center">{{item.cust_name}}</td>
                                                    <td class="center">{{item.cust_birthdate}}</td>
                                                    <td class="center">{{item.cust_mbl_telno}}</td>
                                                    <td class="center">{{item.cust_cr}}</td>
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
                    <div id="cust_mnglist_printArea" style="height:0px;display:none;">
                        <table class="table datatable dataTable">
                            <thead>
                                <tr class="replace-inputs">
                                    <th style="width: 20%;" class="center">성명</th>
                                    <th style="width: 20%;" class="center">생년월일</th>
                                    <th style="width: 30%;" class="center">핸드폰번호</th>
                                    <th style="width: 30%;" class="center">직업</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="item in printInfo.custList">
                                    <td class="center">{{item.cust_name}}</td>
                                    <td class="center">{{item.cust_birthdate}}</td>
                                    <td class="center">{{item.cust_mbl_telno}}</td>
                                    <td class="center">{{item.cust_cr}}</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </template>
            </div>
            <!--// 관리대장출력 팝업  -->

            <!-- 고객관리카드 출력 팝업 -->
            <div class="modal fade" id="pop_cust_card_print">
                <template>
                    <div class="modal-dialog4">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"
                                    id="btn_popClose">&times;</button>
                                <h4 class="modal-title" id="modify_nm">고객관리카드 출력</h4>
                            </div>
                            <div class="modal-body">
                                <form class="form-horizontal form-groups-bordered">
                                    <div>
                                        [고객관리카드] 를(을) 출력하시겠습니까?<br>
                                        ※고객정보는 개인정보관리 대상이므로 유의하셔야 합니다.
                                    </div>
                                    <div class="clearAfter">
                                        <div class="left">
                                            <div class="form-group">
                                                <label for="err_cd" class="col-sm-3 control-label">고객명</label>
                                                <div class="col-sm-9">
                                                    <input type="text" id="cust_name" v-model="info.cust_name" disabled>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="err_cd" class="col-sm-3 control-label">주민번호</label>
                                                <div class="col-sm-9">
                                                    <input type="text" id="cust_safety_num" v-model="info.cust_safety_num" disabled>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="err_cd" class="col-sm-3 control-label">E-mail</label>
                                                <div class="col-sm-9">
                                                    <input type="text" id="cust_email" v-model="info.cust_email" disabled>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="err_cd" class="col-sm-3 control-label">전화번호</label>
                                                <div class="col-sm-9">
                                                    <input type="text" id="cust_home_telno" v-model="info.cust_home_telno" disabled>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="err_cd" class="col-sm-3 control-label">핸드폰번호</label>
                                                <div class="col-sm-9">
                                                    <input type="text" id="cust_mbl_telno"
                                                        v-model="info.cust_mbl_telno" disabled>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="err_cd" class="col-sm-3 control-label">직업</label>
                                                <div class="col-sm-9">
                                                    <input type="text" id="cust_cr" v-model="info.cust_cr" disabled>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="err_cd" class="col-sm-3 control-label">주소</label>
                                                <div class="col-sm-9">
                                                    <input id="cust_addr" v-model="info.cust_addr"
                                                        style="width:40%;" disabled></input>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="err_cd" class="col-sm-3 control-label">담당자</label>
                                                <div class="col-sm-9">
                                                    <input type="text" id="drt_name" v-model="info.drt_name" disabled>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="err_cd" class="col-sm-3 control-label">부서</label>
                                                <div class="col-sm-9">
                                                    <input type="text" id="drt_dpt" v-model="info.drt_dpt" disabled>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="err_cd" class="col-sm-3 control-label">연락처</label>
                                                <div class="col-sm-9">
                                                    <input type="text" id="drt_phone" v-model="info.drt_phone" disabled>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="err_eng_nm" class="col-sm-2 control-label">상담내역</label>
                                            </div>
                                            <div class="col-sm-10">
                                                <tr>
                                                    <input id="cnsl_details" v-model="info.cnsl_details"
                                                        style="width:40%;" disabled></input>
                                                </tr>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-primary" @click="print_card">인쇄</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                    <div id="t1_single_cust_printArea" style="display: none;">
            <table>
               <tbody>
                  <tr>
                     <th colspan="2" style="font-weight: bold; text-align: left;">[고객정보]</th>
                  </tr>
                  <tr>
                     <th>고객명</th>
                     <td>{{ info.cust_name}}</td>
                  </tr>
                  <tr>
                     <th>주민번호</th>
                     <td>{{ info.cust_safety_num}}</td>
                  </tr>
                  <tr>
                     <th>E-mail</th>
                     <td>{{ info.cust_email}}</td>
                  </tr>
                  <tr>
                     <th>전화번호</th>
                     <td>{{ info.cust_home_telno}}</td>
                  </tr>
                  <tr>
                     <th>핸드폰</th>
                     <td>{{ info.cust_mbl_telno}}</td>
                  </tr>
                  <tr>
                     <th>직업</th>
                     <td>{{ info.cust_cr}}</td>
                  </tr>
                  <tr>
                     <th>주소</th>
                     <td>{{ info.cust_addr }}</td>
                  </tr>
                  <tr>
                     <th></th>
                     <td></td> <!-- 줄 공백 -->
                  </tr>
                  <tr>
                     <th colspan="2" style="font-weight: bold; text-align: left;">[담당자정보]</th>
                  </tr>
                  <tr>
                     <th>담당자</th>
                     <td>{{ info.drt_name }}</td>
                  </tr>
                  <tr>
                     <th>부서</th>
                     <td>{{ info.drt_dpt }}</td>
                  </tr>
                   <tr>
                      <th>연락처</th>
                      <td>{{ info.drt_phone }}</td>
                  </tr>
                  <tr>
                     <th></th>
                     <td></td>
                  </tr>
                  <tr>
                     <th colspan="2" style="font-weight: bold; text-align: left;">[상담내역]</th>
                  </tr>
                  <tr>
                     <td colspan="2">{{ info.cnsl_details }}</td>
                  </tr>
               </tbody>
            </table>
         </div>
      </template>
   </div>
                </template>
            </div>
            <!--// 고객관리카드 출력 팝업  -->

        </body>
        <script>
            var vueapp = new Vue({
                el: "#vueapp",
                data: {
                    dataList: [],
                    search_nm: "",
                    search_val: "",
                    cust_name: "",
                    cust_cr: "",
                    cust_birthdate: "",
                    cust_email: "",
                    cust_home_telno: "",
                    cust_mbl_telno: "",
                    cust_addr: "",
                    cust_drt: "",
                    cust_safety_num: "",
                    drt_name:"",
                    birth_year:"",
                    birth_month:"",
                    birth_day:"",
                    drt_phone:"",
                    descendingNumbers: [],
                    
                },
                mounted: function () {
                    var fromDtl = cf_getUrlParam("fromDtl");
                    var pagingConfig = cv_sessionStorage.getItem("pagingConfig");
                    if ("Y" === fromDtl && !cf_isEmpty(pagingConfig)) {
                        cv_pagingConfig.pageNo = pagingConfig.pageNo;
                        cv_pagingConfig.orders = pagingConfig.orders;

                        var params = cv_sessionStorage.getItem("params");
                        this.search_nm = params.search_nm,
                        this.drt_name = params.drt_name,
                        this.cust_name = params.cust_name,
                        this.cust_birthdate = params.cust_birthdate,
                        this.birth_year = params.birth_year,
                        this.birth_month = params.birth_month,
                        this.birth_day = params.birth_day,
                        this.search_val = params.search_val,
                        this.generateDescendingNumbers();
                        this.handleSearch();
                        
                        this.getT1SearchList(true);
                    } else {
                        cv_sessionStorage
                            .removeItem("pagingConfig")
                            .removeItem("params");
                        this.generateDescendingNumbers();
                        this.getT1SearchList(true);
                    }
                },
                methods: {
                	getT1SearchList: function (isInit) {

                        cv_pagingConfig.func = this.getT1SearchList;
                        if (isInit === true) {
                            cv_pagingConfig.pageNo = 1;
                            cv_pagingConfig.orders = [{ target: "cust_name", isAsc: false }];
                        }

                        var params = {
                            search_nm: this.search_nm,
                            search_val: this.search_val,
                            drt_name: this.drt_name,
                            cust_name: this.cust_name,
                            birth_year: this.birth_year,
                            birth_month: this.birth_month,
                            birth_day: this.birth_day,
                            
                        }

                        cv_sessionStorage
                            .setItem('pagingConfig', cv_pagingConfig)
                            .setItem('params', params);

                        cf_ajax("/t1custMng/getT1SearchList", params, this.getListCB);
                    },
                    getT1CustListAll: function (isInit) {

                        cv_pagingConfig.func = this.getT1CustListAll;
                        if (isInit === true) {
                            cv_pagingConfig.pageNo = 1;
                            cv_pagingConfig.orders = [{ target: "cust_name", isAsc: false }];
                        }

                        var params = {
                            search_nm: this.search_nm,
                            search_val: this.search_val,
                        }

                        cv_sessionStorage
                            .setItem('pagingConfig', cv_pagingConfig)
                            .setItem('params', params);

                        cf_ajax("/t1custMng/getT1CustListAll", params, this.getListCB);
                    },
                    getListCB: function (data) {
                        this.dataList = data.list;
                        cv_pagingConfig.renderPagenation("system");
                    },
                    formatTwoDigits(num) {
                        return num.toString().padStart(2, '0'); //1~9문자열 변환
                    },
                    handleSearch() {
                        if (this.birth_year === "") {
                            this.birth_month = "";
                            this.birth_day = "";
                        }

                        var params = {
                            cust_name: this.cust_name,
                            drt_name: this.drt_name,
                            birth_year: this.birth_year,
                            birth_month: this.birth_month,
                            birth_day: this.birth_day
                        };
                        this.getT1SearchList(true); 
                    },
                    handleBirthYearChange() {
                        if (this.birth_year === "") {
                            this.birth_month = "";
                            this.birth_day = "";
                        }
                        this.handleSearch(); 
                    },
                    generateDescendingNumbers() {
                          this.descendingNumbers = Array.from({ length: 99 }, (_, index) => 99 - index);
                    },
                    gotoDtl: function (cust_mbl_telno) {
                        console.log(cust_mbl_telno);
                        pop_cust_detail.init(cust_mbl_telno);
                        $('#pop_cust_detail').modal('show');
                    },
                    sortList: function (obj) {
                        cf_setSortConf(obj, "cust_name");
                        this.getT1CustCardList();
                    },
                    sortListAll: function (obj) {
                        cf_setSortConf(obj, "cust_name");
                        this.getT1CustListAll();
                    },
                    all_check: function (obj) {
                        $('[name=is_check]').prop('checked', obj.checked);
                    },
                    onCheck: function () {
                        $("#allCheck").prop('checked',
                            $("[name=is_check]:checked").length === $("[name=is_check]").length
                        );
                    },
                    popCustmnglistPrint: function () {
                        var chkedList = $("[name=is_check]:checked");
                        if (chkedList.length == 0) {
                            alert("출력할 대상을 선택하여 주십시오.");
                            return;
                        }
                        //check list 가져오기..
                        var dateCopyList = [];
                        var idx;
                        chkedList.each(function (i) {
                            idx = $(this).attr("data-idx");
                            dateCopyList.push(vueapp.dataList.getElementFirst("cust_name", idx));
                        });

                        console.log(dateCopyList);

                        //출력팝업 띄우기
                        pop_cust_mnglist_print.init(dateCopyList);
                        $('#pop_cust_mnglist_print').modal('show');

                    },
                    popCustmngCardPrint: function () {
                        var chkedList = $("[name=is_check]:checked");
                        if (chkedList.length == 0) {
                            alert("출력할 대상을 선택하여 주십시오.");
                            return;
                        } else if (chkedList.length > 1) {
                            alert("출력할 대상을 한개만 선택하여 주십시오.");
                            return;
                        }

                        //check list 가져오기..
                        var dateCopyList = [];
                        var idx;
                        chkedList.each(function (i) {
                            idx = $(this).attr("data-idx");
                            dateCopyList.push(vueapp.dataList.getElementFirst("cust_name", idx));
                        });

                        console.log(dateCopyList);

                        //출력팝업 띄우기
                        pop_cust_card_print.init(dateCopyList);
                        $('#pop_cust_card_print').modal('show');
                    },

                    custInfoMng: function () {
                        cf_movePage('/a_team1_custMng/a_team1_custInfoMng');
                    },
                    picInfoMng: function () {
                        cf_movePage('/custMng/picInfoMng');
                    },
                },
            });
			//더블클릭 상세정보
            var pop_cust_detail = new Vue({
                el: "#pop_cust_detail",
                data: {
                    info: {
                        cust_mbl_telno: "${cust_mbl_telno}",
                        cust_name: "",
                        cust_pridtf_no: "",
                        cust_email: "",
                        cust_home_telno: "",
                        cust_mbl_telno: "",
                        cust_safety_num: "",
                        cust_cr: "",
                        cust_addr: "",
                        cnsl_date: "",
                        cnsl_details: "",
                    }
                },
                methods: {
                    init: function (cust_mbl_telno) {
                        this.initInfo();
                        this.info.cust_mbl_telno = cust_mbl_telno;
                        if (!cf_isEmpty(this.info.cust_mbl_telno)) {
                            this.getInfo();
                        }
                    },
                    initInfo: function () {
                        this.info = {
                            cust_mbl_telno: "",
                            cust_name: "",
                            cust_pridtf_no: "",
                            cust_email: "",
                            cust_home_telno: "",
                            cust_cr: "",
                            cnsl_date: "",
                            cust_addr: "",
                            cnsl_details: "",
                        }
                    },
                    getInfo: function () {
                        var params = {
                            cust_mbl_telno: this.info.cust_mbl_telno,
                        }
                        cf_ajax("/t1custMng/getT1CustInfo", params, this.getInfoCB);
                    },
                    getInfoCB: function (data) {
                        this.info = data;
                    },
                },
            });
			//담당고객 리스트 출력
            var pop_cust_mnglist_print = new Vue({
                el: "#pop_cust_mnglist_print",
                data: {
                    printInfo: {
                        custCount: 0,
                        custList: [],
                    }
                },
                methods: {
                    init: function (dateCopyList) {
                        this.initInfo(dateCopyList);
                    },
                    initInfo: function (dateCopyList) {
                        this.printInfo = {
                            custCount: dateCopyList.length,
                            custList: dateCopyList,
                        }
                    },
                    print: function () {
                        const printArea = document.getElementById('cust_mnglist_printArea').innerHTML;
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
			//고객정보출력
            var pop_cust_card_print = new Vue({
                el: "#pop_cust_card_print",
                data: {
                    info: {
                        cust_mbl_telno: "",
                        cust_name: "",
                        cust_pridtf_no: "",
                        cust_email: "",
                        cust_home_telno: "",
                        cust_cr: "",
                        cust_addr: "",
                        drt_name: "",
                        drt_dpt: "",
                        drt_phone: "",
                        cnsl_details: "",
                    }
                },
                methods: {
                    init: function (dateCopyList) {
                        this.initInfo(dateCopyList);
                        this.info.cust_mbl_telno = dateCopyList[0].cust_mbl_telno;
                        if (!cf_isEmpty(this.info.cust_mbl_telno)) {
                            this.getT1CustCardDetail();
                        }
                    },
                    initInfo: function () {
                        this.info = {
                        		cust_mbl_telno: "",
                                cust_name: "",
                                cust_pridtf_no: "",
                                cust_email: "",
                                cust_home_telno: "",
                                cust_cr: "",
                                cust_addr: "",
                                drt_name: "",
                                drt_dpt: "",
                                drt_phone: "",
                                cnsl_details: "",
                        }
                    },
                    getT1CustCardDetail: function () {
                        var params = {
                            cust_mbl_telno: this.info.cust_mbl_telno,
                        }
                        cf_ajax("/t1custMng/getT1CustCardDetail", params, this.getInfoCB);
                    },
                    getInfoCB: function (data) {
                        this.info = data;
                    },
                    print_card: function () {
                        const printArea = document.getElementById('t1_single_cust_printArea').innerHTML;
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
                        //win.document.write('<html><head>');

                        win.document.write('<link rel="stylesheet" href="/static_resources/system/js/datatables/datatables.css">');
                        win.document.write('<link rel="stylesheet" href="/static_resources/system/js/select2/select2-bootstrap.css">');
                        win.document.write('<link rel="stylesheet" href="/static_resources/system/js/select2/select2.css">');

                        win.document.write('<title></title><style>');
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