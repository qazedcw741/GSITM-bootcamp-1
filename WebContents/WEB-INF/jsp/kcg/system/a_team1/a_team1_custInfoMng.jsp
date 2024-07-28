<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
      <!DOCTYPE html>
      <html>

      <head>
         <jsp:include page="/WEB-INF/jsp/kcg/_include/system/header_meta.jsp" flush="false" />

         <script src="/static_resources/system/js/bootstrap-datepicker.js"></script>
         <script src="/static_resources/system/js/bootstrap-datepicker.ko.js"></script>
         <link rel="stylesheet" href="/static_resources/system/js/datatables/proddtl.css">

         <!-- Imported styles on this page -->
         <title>관리자시스템</title>
      </head>

      <body class="page-body">

         <div class="page-container">

            <jsp:include page="/WEB-INF/jsp/kcg/_include/system/sidebar-menu.jsp" flush="false" />

            <div class="main-content">

               <jsp:include page="/WEB-INF/jsp/kcg/_include/system/header.jsp" flush="false" />

               <ol class="breadcrumb bc-3">

               <div class="section-header" style="border-bottom: 2px solid black; text-align: center; padding: 10px; font-weight: 800; font-size: 25px;">
                 <span>고객정보 관리</span>
               </div>
               <br />
               <div id="vueapp" style="display: flex;justify-items: center;">
                  <template>
                     <div class="panel-body" style="border: 1px solid #666666;width: 100%;">
                     
                           <!-- 고객 검색 -->
                           <div class="left-panel flex-33">
                              <label style="font-size: 15px; font-weight: bold; font-family : sans-serif; background-color: #f0f0f0; text-align: center; padding: 10px;">고객 검색</label>
                              
                              <!-- 고객 검색 -->
                                 <!-- 고객 이름 검색 창 -->
                                 <!-- 고객 이름 : a_team1 data : cust_name으로 변경  -->
                                 <input type="text" name="cust_name" placeholder="Enter Keyword  Name" id="cust_name" v-model="cust_name"> 
                                 <!-- 고객 번호 검색 창 -->
                                 <!-- 고객 이름 : a_team1 data : cust_pridtf_no으로 변경 -->
                                 <input type="text" name="cust_pridtf_no" placeholder="Enter Keyword PridtfNo" id="cust_pridtf_no" v-model="cust_pridtf_no"> 
                                 <!-- 고객 검색 버튼 -->
                                 <button type="button" type="button" name="searchOne" id="searchOne" class="search-button" @click="searchOne">조건 검색</button>
                                 <button type="button" name="search" id="search" class="search-button" @click="search">전체 검색</button>
                                 
                              <!-- 고객 검색 > 리스트 -->
                              <table class="table table-bordered datatable dataTable">
                                 <thead style="position: sticky;top: 0px;">
                                    <tr>
                                       <th class="center" style="width: 20%;">고객명</th>
                                    </tr>
                                 </thead>
                                 <tbody>
                                    <tr v-for="item in custInfoList" 
                                       style="cursor: pointer;">
                                       <td class="center">
                                       <input type="radio" :data-idx="item.cust_name" name="is_check" @click="selRadioCustItem(item.cust_sn)">{{item.cust_name}}
                                       <input type="hidden" name="item.cust_sn">
                                       </td>
                                    </tr>
                                 </tbody>
                                 
                              </table>
                                 
                        </div>
                        <!-- 고객 검색 -->
                        
                        
                        <!-- 고객 CRUD -->
                        <div  class="left-panel flex-66" style="text-align: center;">
                           <label style="font-size: 15px; font-weight: bold; font-family : sans-serif; background-color: #f0f0f0; text-align: center; padding: 10px;">고객 정보</label>
                              <div style="padding: 10px;">
                                 <div class="form-group" style="dispay : flex; justify-content: space-around;">
                                    <label for="err_eng_nm" style="width: 80px;">작성일자:</label>
                                    <input type="date" class="form-control" id="wrt_dt" v-model="wrt_dt">
                                 </div>
      
                                 <div class="form-group">
                                    <label for="prod_nm" style="width: 80px;">*고객명:</label>
                                    <input type="text" class="form-control" id="cust_name2" v-model="cust_name2">
                                    <input type="hidden" class="form-control" id="cust_sn2" v-model="cust_sn2">
                                 </div>
      
      
                                 <div class="form-group">
                                    <label for="err_eng_nm" style="width: 80px;">*실명번호:</label>
                                    <input type="text" class="form-control" id="cust_pridtf_no2" v-model="cust_pridtf_no2">
                                 </div>
                                 
                                 <div class="form-group">
                                     <label for="err_eng_nm" style="width: 80px;">이메일:</label>
                                     <input type="text" class="form-control" id="cust_email" v-model="cust_email">
                                 </div>
                                 
                                 <div class="form-group">
                                    <label for="err_eng_nm" style="width: 80px;">전화번호:</label>
                                    <input type="text" class="form-control" id="cust_home_telno" v-model="cust_home_telno">
                                 </div>
      
                                 <div class="form-group">
                                    <label for="err_eng_nm" style="width: 80px;">핸드폰번호:</label>
                                    <input type="text" class="form-control" id="cust_mbl_telno"
                                       v-model="cust_mbl_telno">
                                 </div>
      
                                 <div class="form-group">
                                    <label for="err_eng_nm" style="width: 80px;">직업:</label>
                                    <select id="occp_ty_cd" class="form-control" v-model="occp_ty_cd">
                                       <option value="10000000">관리자(사무직)</option>
                                       <option value="10100000">전문가 및 관련 종사자</option>
                                       <option value="10200000">사무 종사자</option>
                                       <option value="10300000">서비스 종사자</option>
                                       <option value="10400000">판매 종사자</option>
                                       <option value="10500000">농림어업 숙련 종사자</option>
                                       <option value="10600000">기능원 및 관련 기능 종사자</option>
                                       <option value="10700000">장치·기계조작 및 조립 종사자</option>
                                       <option value="10800000">단순노무 종사자</option>
                                       <option value="10900000">군인</option>
                                       <option value="11000000">주부,학생 및 기타 비경제활동인구</option>
                                    </select>
                                    <input type="text" id="cust_cr" v-model="cust_cr">
                                 </div>
      
                                 <div class="form-group">
                                    <label for="prod_nm" style="width: 80px;">고객 주소:</label>
                                    <input type="text" class="form-control" id="cust_addr" v-model="cust_addr" style="height: 100px;">
                                 </div>
      
                                 <div class="form-group">
                                    <label for="prod_nm" >상담내역:</label>
                                    <div  class="form-control" style="height: 200px; display: flex;">
                                       <input type="date" class="form-control" id=cnsl_date_after v-model="cnsl_date_after"  style="border-left: 4px solid black; border-top: none; border-right: none; border-bottom: none;">
                                       <textarea type="text" class="form-control" id=cnsl_details_after v-model="cnsl_details_after" style="border-left: 4px solid black; border-top: none; border-right: none; border-bottom: none; height: 100px; "></textarea>
                                    </div>
                                 </div>
                                 
                                 <div class="form-group" style="dispay : flex; justify-content: space-around;">
                                                   <label for="err_cd">담당자명 : </label>
                                                       <input type="text" class="form-control" id="drt_name" v-model="drt_name"  >
                                                       <input type="hidden" class="form-control" id="drt_sn" v-model="drt_sn">
                                                       <button type="button" class="btn" @click="popupPicInfo">
                                                           <i class="fa fa-search"></i>
                                                       </button>
                                               </div>
                                               <div class="form-group" style="dispay : flex; justify-content: space-around;">
                                                   <label for="err_kor_nm">부서명 : </label>
                                                   <input type="text" class="form-control" id="drt_dpt"  v-model="drt_dpt">
                                               </div>
                                               <div class="form-group" style="dispay : flex; justify-content: space-around;">
                                                   <label for="err_eng_nm">연락처 : </label>
                                                   <input type="text" class="form-control" id="drt_phone"  v-model="drt_phone">
                                               </div>
                                               <div class="form-group" style="dispay : flex; justify-content: space-around;">
                                                   <label for="err_eng_nm">E-mail : </label>
                                                   <input type="text" class="form-control" id="drt_eml"  v-model="drt_eml">
                                               </div>
                                               <div class="form-group" style="dispay : flex; justify-content: space-around;">
                                                   <label for="err_eng_nm">입사일자 : </label>
                                                   <input type="text" class="form-control" id="drt_hd"  v-model="drt_hd">
                                               </div>
                                           </div>
                                
                                            
                              <div class="form-group">
                                 <div class="">
                                    <button type="button" class="btn btn-blue btn-icon icon-left"
                                       style="margin-left: 5px;" @click="custPopInsert">
                                       등록
                                       <i class="entypo-search"></i>
                                    </button>
                                    <!-- <button type="button" class="btn btn-blue btn-icon icon-left"
                                       style="margin-left: 5px;" @click="custInsert">
                                       등록
                                       <i class="entypo-search"></i>
                                    </button> -->
                                    <button type="button" class="btn btn-blue btn-icon icon-left"
                                       style="margin-left: 5px;" @click="custPopInsert">
                                       변경
                                       <i class="entypo-search"></i>
                                    </button>
                                    <button type="button" class="btn btn-red btn-icon icon-left"
                                       style="margin-left: 5px;" @click="custPopDelete">
                                       삭제
                                       <i class="entypo-search"></i>
                                    </button> 
                                    <button type="button" class="btn btn-green btn-icon icon-left"
                                       style="margin-left: 5px;" @click="custClear">
                                       신규
                                       <i class="entypo-search"></i>
                                    </button>
                                    <!-- <button type="button" class="btn btn-blue btn-icon icon-left" 
                                    style="margin-left: 5px;" @click="popDamdangSet">
                                                담당자설정
                                                <i class="entypo-user"></i>
                                            </button> -->
                                    <!-- <button type="button" class="btn btn-blue btn-icon icon-left"
                                       style="margin-left: 5px;" @click="custInfoList">
                                       고객목록
                                       <i class="entypo-search"></i>
                                    </button> -->
                                 </div>
                              </div>
                        </div>
                        <!-- 고객 CRUD -->
                        
                        <!-- 고객 이전 상담내역 -->
                        <div class="right-panel flex-66" style="text-align: center;">
                              
                                 <label style="font-size: 15px; font-weight: bold; font-family : sans-serif; background-color: #f0f0f0; text-align: center; padding: 10px;">상담내역</label>
                                 
                                 <div  class="form-control" style=" height: 100%;">
                                    <div  style=" height: 200px; display: flex;">
                                    <!-- <div  style=" height: 200px; display: flex;" v-for="item in infoList"> -->
                                       <!-- <input type="date" class="form-control" id=cnsl_date v-model="item.cnsl_date"  
                                             style="border-left: 4px solid black; border-top: none; border-right: none; border-bottom: none; width: 100px;" readonly disabled>
                                       
                                       <textarea type="text" class="form-control" id=cnsl_details v-model="item.cnsl_details" 
                                                 style="border-left: 4px solid black; border-top: none; border-right: none; border-bottom: none; height: 100px; " readonly disabled>
                                       </textarea> -->
                                       
                                       <table class="table table-bordered datatable dataTable">
                                                    <thead style="position: sticky;top: 0px;">
                                                        <tr>
                                                            <!-- <th class="center" style="width: 5%;"></th> -->
                                                            <th class="center" style="width: 20%;">날짜</th>
                                                            <th class="center" style="width: 20%;">상담내용</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr v-for="item in infoList">
                                                            <!-- <td class="center">
                                                               <input type="checkbox">
                                                            </td> -->
                                                            <td class="center">
                                                               <input type="date" class="form-control" id=cnsl_date v-model="item.cnsl_date"  
                                                            style="border-left: 4px solid black; border-top: none; border-right: none; border-bottom: none;" readonly disabled>
                                                            </td>
                                                            <td class="center">
                                                               <textarea type="text" class="form-control" id=cnsl_details v-model="item.cnsl_details" 
                                                             style="border-left: 4px solid black; border-top: none; border-right: none; border-bottom: none; height: 100px; " readonly disabled>
                                                   </textarea>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                       
                                    </div>
                                 </div>
            
                        </div>
                        <!-- 고객 이전 상담내역 -->
                     </div>
                  </template>
               </div>
               
               <br />
               
               
               <jsp:include page="/WEB-INF/jsp/kcg/_include/system/footer.jsp" flush="false" />
            </div>
         </div>
         
         <!-- 담당자 팝업 -->
            <div class="modal fade" id="pop_pic_info">
                <template>
                    <div class="modal-dialog" style="width: 500px;">
                        <div class="modal-content">
                            <div class="modal-body">
                                <div style="height: 400px;overflow: auto;" class="dataTables_wrapper">
                                    <table class="table table-bordered datatable dataTable">
                                        <thead style="position: sticky;top: 0px;">
                                            <tr>
                                                <th class="center" style="width: 20%;">담당자명</th>
                                                <th class="center" style="width: 20%;">부서명</th>
                                                <th class="center" style="width: 20%;">이메일</th>
                                                <th class="center" style="width: 50%;">연락처</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr v-for="item in dataList" @click="selItem(item.drt_sn)" style="cursor: pointer;">
                                                <td class="center">{{item.drt_name}}</td>
                                                <td class="center">{{item.drt_dpt}}</td>
                                                <td class="center">{{item.drt_eml}}</td>
                                                <td class="center">{{item.drt_phone}}</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </template>
            </div>
            <!-- 담당자 팝업 -->
            
            <!-- 등록 | 변경 팝업 -->
            <div class="modal fade" id="pop_insert_info">
                <template>
                    <div class="modal-dialog" style="width: 800px;">
                        <div class="modal-content">
                            <div class="modal-body">
                                <div style="height: 700px;overflow: auto;" class="dataTables_wrapper">
                                    <div  class="left-panel flex-66" style="text-align: center;">
                           <label style="font-size: 15px; font-weight: bold; font-family : sans-serif; background-color: #f0f0f0; text-align: center; padding: 10px;">고객 정보</label>
                              <div style="padding: 10px;">
                                 <div class="alert alert-success d-flex align-items-center" role="alert">
                                   <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-info-circle-fill" viewBox="0 0 16 16">
                                      <path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16m.93-9.412-1 4.705c-.07.34.029.533.304.533.194 0 .487-.07.686-.246l-.088.416c-.287.346-.92.598-1.465.598-.703 0-1.002-.422-.808-1.319l.738-3.468c.064-.293.006-.399-.287-.47l-.451-.081.082-.381 2.29-.287zM8 5.5a1 1 0 1 1 0-2 1 1 0 0 1 0 2"/>
                                    </svg>
                                   <div>
                                     *저장할 고객 정보를 다시 한 번 확인해주세요*
                                   </div>
                                 </div>
                              
                                 <div class="form-group" style="dispay : flex; justify-content: space-around;">
                                    <label for="err_eng_nm" style="width: 80px;">작성일자:</label>
                                    <input type="date" class="form-control" id="wrt_dt" v-model="wrt_dt">
                                 </div>
      
                                 <div class="form-group">
                                    <label for="prod_nm" style="width: 80px;">*고객명:</label>
                                    <input type="text" class="form-control" id="cust_name2" v-model="cust_name2">
                                    <input type="hidden" class="form-control" id="cust_sn2" v-model="cust_sn2">
                                 </div>
      
      
                                 <div class="form-group">
                                    <label for="err_eng_nm" style="width: 80px;">*실명번호:</label>
                                    <input type="text" class="form-control" id="cust_pridtf_no2" v-model="cust_pridtf_no2">
                                 </div>
                                 
                                 <div class="form-group">
                                     <label for="err_eng_nm" style="width: 80px;">이메일:</label>
                                     <input type="text" class="form-control" id="cust_email" v-model="cust_email">
                                 </div>
                                 
                                 <div class="form-group">
                                    <label for="err_eng_nm" style="width: 80px;">전화번호:</label>
                                    <input type="text" class="form-control" id="cust_home_telno" v-model="cust_home_telno">
                                 </div>
      
                                 <div class="form-group">
                                    <label for="err_eng_nm" style="width: 80px;">핸드폰번호:</label>
                                    <input type="text" class="form-control" id="cust_mbl_telno"
                                       v-model="cust_mbl_telno">
                                 </div>
      
                                 <div class="form-group">
                                    <label for="err_eng_nm" style="width: 80px;">직업:</label>
                                    <select id="occp_ty_cd" class="form-control" v-model="occp_ty_cd">
                                       <option value="10000000">관리자(사무직)</option>
                                       <option value="10100000">전문가 및 관련 종사자</option>
                                       <option value="10200000">사무 종사자</option>
                                       <option value="10300000">서비스 종사자</option>
                                       <option value="10400000">판매 종사자</option>
                                       <option value="10500000">농림어업 숙련 종사자</option>
                                       <option value="10600000">기능원 및 관련 기능 종사자</option>
                                       <option value="10700000">장치·기계조작 및 조립 종사자</option>
                                       <option value="10800000">단순노무 종사자</option>
                                       <option value="10900000">군인</option>
                                       <option value="11000000">주부,학생 및 기타 비경제활동인구</option>
                                    </select>
                                    <input type="text" id="cust_cr" v-model="cust_cr">
                                 </div>
      
                                 <div class="form-group">
                                    <label for="prod_nm" style="width: 80px;">고객 주소:</label>
                                    <input type="text" class="form-control" id="cust_addr" v-model="cust_addr" style="height: 100px;">
                                 </div>
      
                                 <div class="form-group">
                                    <label for="prod_nm" >상담내역:</label>
                                    <div  class="form-control" style="height: 200px; display: flex;">
                                       <input type="date" class="form-control" id=cnsl_date_after v-model="cnsl_date_after"  style="border-left: 4px solid black; border-top: none; border-right: none; border-bottom: none;">
                                       <textarea type="text" class="form-control" id=cnsl_details_after v-model="cnsl_details_after" style="border-left: 4px solid black; border-top: none; border-right: none; border-bottom: none; height: 100px; "></textarea>
                                    </div>
                                 </div>
                                 
                                 <div class="alert alert-warning d-flex align-items-center" role="alert">
                                   <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-exclamation-triangle-fill flex-shrink-0 me-2" viewBox="0 0 16 16" role="img" aria-label="Warning:">
                                     <path d="M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5zm.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/>
                                   </svg>
                                   <div>
                                     *담당자 정보는 여기서 수정 불가합니다. | 취소 후 담당자 변경 부탁드립니다.*
                                   </div>
                                 </div>
                                 
                                 <div class="form-group" style="dispay : flex; justify-content: space-around;">
                                                   <label for="err_cd">담당자명 : </label>
                                                       <input type="text" class="form-control" id="drt_name" v-model="drt_name"  readonly disabled>
                                                       <input type="hidden" class="form-control" id="drt_sn" v-model="drt_sn">
                                               </div>
                                               <div class="form-group" style="dispay : flex; justify-content: space-around;">
                                                   <label for="err_kor_nm">부서명 : </label>
                                                   <input type="text" class="form-control" id="drt_dpt"  v-model="drt_dpt" readonly disabled>
                                               </div>
                                               <div class="form-group" style="dispay : flex; justify-content: space-around;">
                                                   <label for="err_eng_nm">연락처 : </label>
                                                   <input type="text" class="form-control" id="drt_phone"  v-model="drt_phone" readonly disabled>
                                               </div>
                                               <div class="form-group" style="dispay : flex; justify-content: space-around;">
                                                   <label for="err_eng_nm">E-mail : </label>
                                                   <input type="text" class="form-control" id="drt_eml"  v-model="drt_eml" readonly disabled>
                                               </div>
                                               <div class="form-group" style="dispay : flex; justify-content: space-around;">
                                                   <label for="err_eng_nm">입사일자 : </label>
                                                   <input type="text" class="form-control" id="drt_hd"  v-model="drt_hd" readonly disabled>
                                               </div>
                                           </div>
                                
                                            
                              <div class="form-group">
                                 <div class="">
                                 
                                    <button type="button" class="btn btn-blue btn-icon icon-left"
                                       style="margin-left: 5px;" @click="custInsert" v-if="cust_sn2 === '' ">
                                       등록
                                       <i class="entypo-search"></i>
                                    </button>
                                    <button type="button" class="btn btn-blue btn-icon icon-left"
                                       style="margin-left: 5px;" @click="custUpdate" v-if="cust_sn2 != '' ">
                                       변경
                                       <i class="entypo-search"></i>
                                    </button>
                                    <button type="button" class="btn btn-blue btn-icon icon-left"
                                       style="margin-left: 5px;" @click="formClear">
                                       취소
                                       <i class="entypo-search"></i>
                                    </button>
                                 
                                 </div>
                              </div>
                        </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </template>
            </div>
            <!-- 등록 | 변경 팝업 -->
            
            <!-- 삭제 팝업 -->
            <div class="modal fade" id="pop_delete_info">
                <template>
                    <div class="modal-dialog" style="width: 800px;">
                        <div class="modal-content">
                            <div class="modal-body">
                                <div style="height: 350px; overflow: auto;" class="dataTables_wrapper">
                                    <div  class="left-panel flex-66" style="text-align: center;">
                           <label style="font-size: 15px; font-weight: bold; font-family : sans-serif; background-color: #f0f0f0; text-align: center; padding: 10px;">고객 정보</label>
                              <div style="padding: 10px;">
                                 <div class="alert alert-danger d-flex align-items-center" role="alert">
                                   <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-exclamation-triangle-fill flex-shrink-0 me-2" viewBox="0 0 16 16" role="img" aria-label="Warning:">
                                     <path d="M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5zm.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/>
                                   </svg>
                                   <div>
                                     *삭제할 고객 정보를 다시 한 번 확인해주세요*
                                   </div>
                                 </div>
                                 <table class="table table-bordered datatable dataTable">
                                              <thead style="position: sticky;top: 0px;">
                                                  <tr>
                                                      <th class="center" style="width: 20%;">고객번호</th>
                                                      <th class="center" style="width: 20%;">*고객명</th>
                                                      <th class="center" style="width: 20%;">*실명번호</th>
                                                  </tr>
                                              </thead>
                                              <tbody>
                                                  <tr style="cursor: pointer;">
                                                      <td class="center" style="text-align: center;">
                                                         <input type="text" class="form-control" id="cust_sn2" v-model="cust_sn2"  readonly disabled>
                                                         <input type="hidden" class="form-control" id="cust_sn2" v-model="cust_sn2">
                                                      </td>
                                                      <td class="center" style="text-align: center;">
                                                         <input type="text" class="form-control" id="cust_name2" v-model="cust_name2"  readonly disabled>
                                                      </td>
                                                      <td class="center" style="text-align: center;">
                                                         <input type="text" class="form-control" id="cust_pridtf_no2" v-model="cust_pridtf_no2"  readonly disabled>
                                                      </td>
                                                  </tr>
                                              </tbody>
                                          </table>
                                 
                              <div class="form-group">
                           
                                    <button type="button" class="btn btn-blue btn-icon icon-left"
                                       style="margin-left: 5px;" @click="custDelete">
                                       삭제
                                       <i class="entypo-search"></i>
                                    </button> 
                                    <button type="button" class="btn btn-blue btn-icon icon-left"
                                       style="margin-left: 5px;" @click="formClear">
                                       취소
                                       <i class="entypo-search"></i>
                                    </button>
                                 
                              </div>
                        </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </template>
            </div>
            <!-- 삭제 팝업 -->
         
      </body>
<script>
         var vueapp = new Vue({
            el: "#vueapp",
            data: {
               cust_sn : "",
               cust_sn2 : "",
               wrt_dt : "",
               /* 고객 이름 : a_team1 data : cust_name으로 변경 */
               cust_name: "",
                cust_name2: "",
               wrt_dt: "", 
               /* 고객 이름 : a_team1 data : cust_pridtf_no으로 변경 */
               cust_pridtf_no: "",
               cust_pridtf_no2: "",
               cust_email: "",
               cust_home_telno: "",
               cust_mbl_telno: "",
               occp_ty_cd: "",
               cust_cr: "",
               cust_addr: "",
               /* 고객 검색 InfoList */
               custInfoList:[],
               /* radio 선택 버튼 = v-model*/
               radio_cust_nm:"",
               tsk_dtl_cn : "",
               cnsl_date : "",
               cnsl_details : "",
               cnsl_date_after : "",
               cnsl_details_after : "",
               infoList:[],
               /* cnslData : "", */
               drt_sn :'',
               drt_name :'',
               drt_phone :'',
               drt_dpt :'',
               drt_eml :'',
               drt_hd :'',
            },
            mounted: function () {
               var params = cv_sessionStorage.getItem("params");
               this.cust_sn = params.cust_sn;
            },
            methods: {
               
               /* 전체 고객 검색 | @RequestMapping("/searchAllAjax") */
               search: function () {
                  this.custInfoList = [];
                  /* 검색 창에 입력이 되어 있으면 reset */
                  this.cust_name = '';
                  this.cust_pridtf_no = '';
                  
                  /* controller: @RequestMapping 경로 | 보낼 data x | return data */
                  cf_ajax("/a_team1_custMng/searchAllAjax", {}, this.getCustAllList); 
                  
               },
               /* 전체 고객 검색  - getCustAllList */
               getCustAllList: function (data) {
                  this.custInfoList = data;
                  /* console.log(data);
                  console.log(custInfoList); */
               },
            
               /* 조건 검색 | 고객 이름, 주민번호 검색 | @RequestMapping("/searchOneAjax")*/
               searchOne: function(cust_name, cust_pridtf_no) {
                  this.custInfoList = [];
                  cust_name = this.cust_name;
                  cust_pridtf_no = this.cust_pridtf_no;
                  
                  var params = {
                     cust_name : cust_name,
                     cust_pridtf_no : cust_pridtf_no
                  }
                  cf_ajax("/a_team1_custMng/searchOneAjax", params, this.getCustOneList);
               },
               /* 조건 검색  - getCustOneList */
               getCustOneList: function (data) {
                  this.custInfoList = data;
               /*    console.log(data);
                  console.log(custInfoList); */
               },
               
               /* radio 고객 선택 | */
               selRadioCustItem: function(cust_sn) {
                  this.infoList = [];
                  cust_sn = cust_sn;
                  console.log(cust_sn);
                  
                  var params = {
                     cust_sn : cust_sn,
                  }
                  cf_ajax("/a_team1_custMng/radioCustOneAjax", params, this.getRadioCustOne);
                  
               },
      
               /* radio 고객 선택 : 고객 정보 - getRadioCustOne */
               getRadioCustOne: function (data) {
                  
                  /* 고객 정보 모든 List 값 = */
                  this.wrt_dt = data[0].wrt_dt;
                  this.cust_sn2 = data[0].cust_sn2;
                  this.cust_name2 = data[0].cust_name2;
                  this.wrt_dt = data[0].wrt_dt;
                  this.cust_pridtf_no2 = data[0].cust_pridtf_no2;
                  this.cust_email = data[0].cust_email;
                  this.cust_home_telno = data[0].cust_home_telno;
                  this.cust_mbl_telno = data[0].cust_mbl_telno;
                  this.cust_cr = data[0].cust_cr;
                  this.cust_addr = data[0].cust_addr;
                  this.tsk_dtl_cn = data[0].tsk_dtl_cn;
                  this.occp_ty_cd = data[0].occp_ty_cd;
                  this.drt_sn = data[0].drt_sn;
                  this.drt_name = data[0].drt_name;
                  this.drt_phone = data[0].drt_phone;
                  this.drt_dpt = data[0].drt_dpt;
                  this.drt_eml = data[0].drt_eml;
                  
                  
                  var originalDate = new Date(data[0].drt_hd);

                  var formattedDate = originalDate.toISOString().slice(0,10); 

                  this.drt_hd = formattedDate;
                  
                  /* this.drt_hd = data[0].drt_hd; */
                  
                  /* 이전 상담 내역_반복 출력*/
                  this.infoList = data;
               
                  
                  /* this.cnslData =  this.cnsl_date + '\n' + this.cnsl_details; */
                  
            
               },
               
               /* radio 고객 선택 : 상담 정보 - getRadioCnslOne */
               /* getRadioCnslOne: function (data) {
                  this.custInfoList = data;
                  console.log(data);
               }, */
               
               /* 신규 버튼 - custClear */
               custClear: function () {
               
                  this.wrt_dt = '';
                  this.cust_name2 = '';
                  this.cust_sn2 = '';
                  this.cust_pridtf_no2 = '';
                  this.cust_email = '';
                  this.cust_home_telno = '';
                  this.cust_mbl_telno = '';
                  this.cust_addr = '';
                  this.tsk_dtl_cn = '';
                  this.occp_ty_cd = '';
                  this.cust_cr = '';
                  this.cnsl_date = '';
                  this.cnsl_details = '';
                  this.cnsl_date_after = '';
                  this.cnsl_details_after = '';
                  this.infoList = '';
                  this.drt_sn = '';
                  this.drt_name = '';
                  this.drt_phone = '';
                  this.drt_dpt = '';
                  this.drt_eml = '';
                  this.drt_hd = '';
               },
               
               /* 등록 | 변경 팝업 */   
               custPopInsert :function () {
                  wrt_dt = vueapp.wrt_dt;
                  cust_name = vueapp.cust_name2;
                  cust_pridtf_no = vueapp.cust_pridtf_no2;
                  cust_email = vueapp.cust_email;
                  cust_home_telno = vueapp.cust_home_telno;
                  cust_mbl_telno = vueapp.cust_mbl_telno;
                  occp_ty_cd = vueapp.occp_ty_cd;
                  cust_cr = vueapp.cust_cr;
                  cust_addr = vueapp.cust_addr;
                  cnsl_date_after = vueapp.cnsl_date_after;
                  cnsl_date_after = vueapp.cnsl_date_after;
                  var cust_yn = "Y";
                  drt_sn = vueapp.drt_sn;

                  var params = {
                     wrt_dt : wrt_dt,
                     cust_name: cust_name,
                     cust_pridtf_no: cust_pridtf_no,
                     cust_email: cust_email,
                     cust_home_telno: cust_home_telno,
                     cust_mbl_telno: cust_mbl_telno,
                     occp_ty_cd: occp_ty_cd,
                     cust_cr: cust_cr,
                     cust_addr: cust_addr,
                     cust_yn : cust_yn,
                     cnsl_date_after : cnsl_date_after,
                     cnsl_date_after : cnsl_date_after,
                     drt_sn : drt_sn,
               
                  }
                  pop_insert_info.init(params);
                  
                  $('#pop_insert_info').modal('show');
               },
               
               
               /* 등록 버튼 - custInsert */
               /* custInsert: function () {
               
                  wrt_dt = vueapp.wrt_dt;
                  cust_name = vueapp.cust_name2;
                  cust_pridtf_no = vueapp.cust_pridtf_no2;
                  cust_email = vueapp.cust_email;
                  cust_home_telno = vueapp.cust_home_telno;
                  cust_mbl_telno = vueapp.cust_mbl_telno;
                  occp_ty_cd = vueapp.occp_ty_cd;
                  cust_cr = vueapp.cust_cr;
                  cust_addr = vueapp.cust_addr;
                  cnsl_date = vueapp.cnsl_date_after;
                  cnsl_details = vueapp.cnsl_details_after;
                  var cust_yn = "Y";
                  drt_sn = vueapp.drt_sn;

                  var params = {
                     wrt_dt : wrt_dt,
                     cust_name: cust_name,
                     cust_pridtf_no: cust_pridtf_no,
                     cust_email: cust_email,
                     cust_home_telno: cust_home_telno,
                     cust_mbl_telno: cust_mbl_telno,
                     occp_ty_cd: occp_ty_cd,
                     cust_cr: cust_cr,
                     cust_addr: cust_addr,
                     cust_yn : cust_yn,
                     cnsl_date : cnsl_date,
                     cnsl_details : cnsl_details,
                     drt_sn : drt_sn,
               
                  }
                  
                  console.log(params);
                  /* custClear 함수 호출 : 입력창 RESET */
                  /* cf_ajax("/a_team1_custMng/insertCustInfo", params, this.custClear);
               },  */
                
            
               
               /* 수정 버튼 - custUpdate */
               /* custUpdate: function () {
               
                  cust_sn = vueapp.cust_sn2;
                  wrt_dt = vueapp.wrt_dt;
                  cust_name = vueapp.cust_name2;
                  cust_pridtf_no = vueapp.cust_pridtf_no2;
                  cust_email = vueapp.cust_email;
                  cust_home_telno = vueapp.cust_home_telno;
                  cust_mbl_telno = vueapp.cust_mbl_telno;
                  occp_ty_cd = vueapp.occp_ty_cd;
                  cust_cr = vueapp.cust_cr;
                  cust_addr = vueapp.cust_addr;
                  cnsl_date = vueapp.cnsl_date_after;
                  cnsl_details = vueapp.cnsl_details_after;
                  drt_sn = vueapp.drt_sn;
               
                  var params = {
                     cust_sn : cust_sn,
                     wrt_dt : wrt_dt,
                     cust_name: cust_name,
                     cust_pridtf_no: cust_pridtf_no,
                     cust_email: cust_email,
                     cust_home_telno: cust_home_telno,
                     cust_mbl_telno: cust_mbl_telno,
                     occp_ty_cd: occp_ty_cd,
                     cust_cr: cust_cr,
                     cust_addr: cust_addr,
                     cnsl_date : cnsl_date,
                     cnsl_details : cnsl_details,
                     drt_sn : drt_sn,
                  
                  }

                  /* custClear 함수 호출 : 입력창 RESET */
                  /* cf_ajax("/a_team1_custMng/updateCustInfo", params,  this.custClear);
               }, */ 
               
               /* 삭제 버튼 - custDelete */
               /* custDelete: function () {
                  
                  
               
                  cust_sn = vueapp.cust_sn2;
                  var cust_yn = "N";

                  var params = {
                     cust_sn : cust_sn,
                     cust_yn : cust_yn
                  } */
                  /* custClear 함수 호출 : 입력창 RESET */
               /*    cf_ajax("/a_team1_custMng/deleteCustInfo", params, this.getCustAllList);
               }, */
               
               
               
               
               /* 삭제 팝업  */
               custPopDelete: function () {
                  console.log("=============팝업show")
                  cust_sn = vueapp.cust_sn2;
                  var cust_yn = "N";
                  cust_name = vueapp.cust_name2;
                  cust_pridtf_no = vueapp.cust_pridtf_no2;

                  var params = {
                        cust_sn : cust_sn,
                        cust_yn : cust_yn,
                        cust_name: cust_name,
                        cust_pridtf_no: cust_pridtf_no,
                     }
                  
                  pop_delete_info.init(params);
                  
                  $('#pop_delete_info').modal('show');
               
               },
               
               /* 담당자 목록    */            
               popupPicInfo: function () {
                        pop_pic_info.init();
                        $('#pop_pic_info').modal('show');
                    },
                
                    getPicSelInfo: function (drt_sn) {
                       
                       console.log(drt_sn +"===========================")
                        var params = {
                           drt_sn: drt_sn,
                        }
                        cf_ajax("/a_team1_custMng/getInitInfo", params, this.getInfoCB);
                    },
                    
                    getInfoCB: function (data) {
                       this.drt_sn = data.drt_sn;
                  this.drt_name = data.drt_name;
                  this.drt_phone = data.drt_phone;
                  this.drt_dpt = data.drt_dpt;
                  this.drt_eml = data.drt_eml;
                  
                  var originalDate = new Date(data.drt_hd);

                  var formattedDate = originalDate.toISOString().slice(0,10); 

                  this.drt_hd = formattedDate;
                    },

            
               
            },
               
            });
         
            
         /* 담당자 목록    */   
         var pop_pic_info = new Vue({
                el: "#pop_pic_info",
                data: {
                    dataList: [],
                },
                methods: {
                    init: function () {
                        this.getPicInfo();
                    },
                    getPicInfo: function () {
                        this.dataList = [];
                        var params = {
                              drt_name: drt_name,
                        }

                        cf_ajax("/a_team1_custMng/getPicInfo", params, function (data) {
                            pop_pic_info.dataList = data;
                        });
                    },
                    selItem: function (drt_sn) {
                        $('#pop_pic_info').modal('hide');
                        
                        vueapp.getPicSelInfo(drt_sn);
                    },
                },
            });
         
         /* 등록 | 변경 팝업 */   
         var pop_insert_info = new Vue({
                el: "#pop_insert_info",
                data: {
                   cust_sn : "",
               cust_sn2 : "",
               wrt_dt : "",
               cust_name: "",
                cust_name2: "",
               wrt_dt: "", 
               cust_pridtf_no: "",
               cust_pridtf_no2: "",
               cust_email: "",
               cust_home_telno: "",
               cust_mbl_telno: "",
               occp_ty_cd: "",
               cust_cr: "",
               cust_addr: "",
               cnsl_date_after : "",
               cnsl_date_after : "",
               drt_sn :'',
               drt_name :'',
               drt_phone :'',
               drt_dpt :'',
               drt_eml :'',
               drt_hd :'',
               
                },
                methods: {
                    init: function () {
                        this.getPicInfo();
                    },
                    getPicInfo: function () {
                       console.log("=========================",cust_sn2);
                       
                       this.cust_sn2 = vueapp.cust_sn2;
                       this.wrt_dt = vueapp.wrt_dt;
                       this.cust_name2 = vueapp.cust_name2;
                       this.cust_pridtf_no2 = vueapp.cust_pridtf_no2;
                       this.cust_email = vueapp.cust_email;
                       this.cust_home_telno = vueapp.cust_home_telno;
                       this.cust_mbl_telno = vueapp.cust_mbl_telno;
                       this.occp_ty_cd = vueapp.occp_ty_cd;
                       this.cust_cr = vueapp.cust_cr;
                       this.cust_addr = vueapp.cust_addr;
                       this.cnsl_date_after = vueapp.cnsl_date_after;
                       this.cnsl_details_after = vueapp.cnsl_details_after;
                  var cust_yn = "Y";
                  this.drt_sn = vueapp.drt_sn;
                  this.drt_name = vueapp.drt_name;
                  this.drt_phone = vueapp.drt_phone;
                  this.drt_dpt = vueapp.drt_dpt;
                  this.drt_eml = vueapp.drt_eml;
                  this.drt_hd = vueapp.drt_hd;
                        
                    },
                    /* 등록 버튼 - custInsert */
               custInsert: function () {
                  
                  wrt_dt = this.wrt_dt;
                  cust_name = this.cust_name2;
                  cust_pridtf_no = this.cust_pridtf_no2;
                  cust_email = this.cust_email;
                  cust_home_telno = this.cust_home_telno;
                  cust_mbl_telno = this.cust_mbl_telno;
                  occp_ty_cd = this.occp_ty_cd;
                  cust_cr = this.cust_cr;
                  cust_addr = this.cust_addr;
                  cnsl_date = this.cnsl_date_after;
                  cnsl_details = this.cnsl_details_after;
                  var cust_yn = "Y";
                  drt_sn = this.drt_sn;

                  var params = {
                     wrt_dt : wrt_dt,
                     cust_name: cust_name,
                     cust_pridtf_no: cust_pridtf_no,
                     cust_email: cust_email,
                     cust_home_telno: cust_home_telno,
                     cust_mbl_telno: cust_mbl_telno,
                     occp_ty_cd: occp_ty_cd,
                     cust_cr: cust_cr,
                     cust_addr: cust_addr,
                     cust_yn : cust_yn,
                     cnsl_date : cnsl_date,
                     cnsl_details : cnsl_details,
                     drt_sn : drt_sn,
               
                  }
                  
                  console.log(params);
                  /* custClear 함수 호출 : 입력창 RESET */
                  cf_ajax("/a_team1_custMng/insertCustInfo", params, this.custClear);
               },
               
               /* 변경 버튼 */
               custUpdate: function () {
                  
                  cust_sn = this.cust_sn2;
                  wrt_dt = this.wrt_dt;
                  cust_name = this.cust_name2;
                  cust_pridtf_no = this.cust_pridtf_no2;
                  cust_email = this.cust_email;
                  cust_home_telno = this.cust_home_telno;
                  cust_mbl_telno = this.cust_mbl_telno;
                  occp_ty_cd = this.occp_ty_cd;
                  cust_cr = this.cust_cr;
                  cust_addr = this.cust_addr;
                  cnsl_date = this.cnsl_date_after;
                  cnsl_details = this.cnsl_details_after;
                  drt_sn = this.drt_sn;
               
                  var params = {
                     cust_sn : cust_sn,
                     wrt_dt : wrt_dt,
                     cust_name: cust_name,
                     cust_pridtf_no: cust_pridtf_no,
                     cust_email: cust_email,
                     cust_home_telno: cust_home_telno,
                     cust_mbl_telno: cust_mbl_telno,
                     occp_ty_cd: occp_ty_cd,
                     cust_cr: cust_cr,
                     cust_addr: cust_addr,
                     cnsl_date : cnsl_date,
                     cnsl_details : cnsl_details,
                     drt_sn : drt_sn,
                  
                  }

                  /* custClear 함수 호출 : 입력창 RESET */
                  cf_ajax("/a_team1_custMng/updateCustInfo", params,  this.custClear);
               },
               
               custClear: function () {
                        $('#pop_insert_info').modal('hide');
                        vueapp.search();
                         vueapp.custClear();
                    },
                    
                    formClear: function () {
                        $('#pop_insert_info').modal('hide');
                        vueapp.search();
                    },
                },
            });
         
         
         
         /*삭제 팝업 */   
         var pop_delete_info = new Vue({
                el: "#pop_delete_info",
                data: {
                   cust_sn : "",
               cust_sn2 : "",
               cust_name: "",
                cust_name2: "",
               cust_pridtf_no: "",
               cust_pridtf_no2: "",
               
                },
                methods: {
                    init: function () {
                        this.getPicInfo();
                    },
                    getPicInfo: function () {
                       console.log(cust_sn2);
                       this.cust_sn2 = vueapp.cust_sn2;
                       this.cust_name2 = vueapp.cust_name2;
                       this.cust_pridtf_no2 = vueapp.cust_pridtf_no2;
                       var cust_yn = "N";
                        
                    },
                    
                    /* 삭제 버튼 - custDelete */
                custDelete: function () {
                  cust_sn = vueapp.cust_sn2;
                  var cust_yn = "N";

                  var params = {
                     cust_sn : cust_sn,
                     cust_yn : cust_yn
                  } 
                  /* custClear 함수 호출 : 입력창 RESET */
                   cf_ajax("/a_team1_custMng/deleteCustInfo", params, this.custClear);
               },
                   
               custClear: function () {
                        $('#pop_delete_info').modal('hide');
                        vueapp.search();
                        vueapp.custClear();
                    },
                    
                    formClear: function () {
                        $('#pop_delete_info').modal('hide');
                        vueapp.search();
                    },
                },
            });
            
          

      </script>
      
      
      </html>   