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
	<link rel="stylesheet" href="/static_resources/system/js/datatables/proddtl.css">
	
	<title>상품정보관리</title>
</head>
<body class="page-body">

<div class="page-container">

	<jsp:include page="/WEB-INF/jsp/kcg/_include/system/sidebar-menu.jsp" flush="false"/>

	<div class="main-content">

		<jsp:include page="/WEB-INF/jsp/kcg/_include/system/header.jsp" flush="false"/>
		
		<ol class="breadcrumb bc-3">
			<li><a href="#none" onclick="cf_movePage('/system')"><i class="fa fa-home"></i>Home</a></li>
			<li class="active"><strong>상품정보관리</strong></li>
		</ol>
	
		<h2>상품관리 > 상품정보관리</h2>
		<br/>
		
		<div class="row">
			<div id="vueapp" style="display: flex;justify-items: center;" >
			<template>
				<div class="panel-body flex-100" >			
					<div class="left-panel flex-66">
						<div class="form-group">
							<label for="prod_name" class="fix-width-33">상품명:</label>
							<input type="text" class="form-control" id="prod_name" v-model="info.prod_name">
						</div>
						<div class="form-group">
							<label for="prod_sn" class="fix-width-33">상품 시리얼 넘버:</label>
							<input type="hidden" class="form-control" id="prod_sn" v-model="info.prod_sn">
							<input type="number" class="form-control" id="prod_sn" v-model="info.prod_sn" placeholder="신규 작성일 시에는 비워두세요." readonly disable>
						</div>
						<div class="form-group">
							<label for="prod_type" class="fix-width-33">상품유형:</label>
<!-- 							<input type="text" class="form-control" id="prod_type" v-model="info.prod_type"> -->
							<select class="form-control" id="prod_type" v-model="info.prod_type">
								<option value="예금">예금</option>
								<option value="적금">적금</option>
								<option value="대출">대출</option>
								<option value="목돈">목돈 마련 적금</option>
							</select>
						</div>
			
<!-- 						<div class="form-group"> -->
<!-- 							<label for="sbstg_ty_cd" class="fix-width-33">가입대상:</label> -->
<!-- 							<input class="form-control" id="sbstg_ty_cd" v-model="info.sbstg_ty_cd"> -->
<!-- 						</div> -->
						
						<div class="form-group">
							<label for="prod_min_amount" class="fix-width-33">가입금액:</label>
							<div class="form-control">
								<label>(최소)</label>
								<input type="text"  id="prod_min_amount" v-model="info.prod_min_amount">
								<label>원 ~ (최대)</label>
								<input type="text"  id="prod_max_amount" v-model="info.prod_max_amount">
								<label>원</label>
							</div>
						</div>
						
						<div class="form-group">
							<label for="prod_payment_cycle" class="fix-width-33">납입주기:</label>
<!-- 							<input type="text" class="form-control" id="prod_payment_cycle" v-model="info.prod_payment_cycle"> -->
							<select class="form-control" id="prod_payment_cycle" v-model="info.prod_payment_cycle">
								<option value="1">매 달 납입</option>
								<option value="3">매 분기 납입</option>
								<option value="6">반 년마다 납입</option>
								<option value="12">매 년 납입</option>
							</select>
						</div>		
			
<!-- 						<div class="form-group"> -->
<!-- 							<label for="pr_min_ir" class="fix-width-33">적용이율(최저):</label> -->
<!-- 							<input type="text" class="form-control" id="pr_min_ir" v-model="info.pr_min_ir"> -->
<!-- 						</div>				 -->
		
						<div class="form-group">
							<label for="pr_min_ir" class="fix-width-33">적용이율:</label>
							<div class="form-control">
								<label>(최소)</label>
								<input type="text" id="pr_min_irn" v-model="info.pr_min_ir">
								<label>%  ~ (최대)</label>
								<input type="text"  id="pr_max_ir" v-model="info.pr_max_ir">
								<label>%</label>
							</div>
						</div>
		
						<div class="form-group">
							<label for="prod_air_bgng_ymd" class="fix-width-33">적용기간:</label>
							<div class="form-control">
								<input type="date"  id="prod_start_period" v-model="info.prod_start_period">
								<label>To</label>
								<input type="date"  id="prod_deadline_period" v-model="info.prod_deadline_period">
								<label>End</label>
							</div>
						</div>
		
						<div class="form-group">
							<label for="prod_interest_taxation" class="fix-width-33">이자과세구분:</label>
							<select class="form-control" id="prod_interest_taxation" v-model="info.prod_interest_taxation">
								<option value="1">일반과세</option>
								<option value="2">세금우대</option>
								<option value="3">비과세</option>
							</select>
						</div>						
						
						<div class="form-group">
							<label for="prod_sales_status" class="fix-width-33">판매상태:</label>
							<select class="form-control" id="prod_sales_status" v-model="info.prod_sales_status">
								<option value="0">정상(판매)</option>
								<option value="1">판매준비</option>
								<option value="2">판매인가</option>
								<option value="3">판매중지</option>
							</select>
						</div>						
		
						<div class="form-group">
							<label for="prod_start_sale" class="fix-width-33">판매기간(시작:</label>
							<div class="form-control">
								<input type="date"  id="prod_start_sale" v-model="info.prod_start_sale">
								<label>To</label>
								<input type="date"  id="prod_end_sale" v-model="info.prod_end_sale">
								<label>End</label>
							</div>
						</div>
							
						<div class="form-group">
							<div class="">
								<button type="button" class="btn btn-green btn-icon btn-small" @click="save">
									저장
									<i class="entypo-check"></i>
								</button>
								<button type="button" id="btn_delete" class="btn btn-red btn-icon btn-small" @click="delInfo">
									삭제
									<i class="entypo-trash"></i>
								</button>
								<button type="button" class="btn btn-blue btn-icon btn-small" @click="gotoList">
									목록
									<i class="entypo-list"></i>
								</button>
							</div>
						</div>
					</div>
					<div class="right-panel flex-33">
						<label>이율변동내역</label>
						<textarea type="text" style="width:100%;font-size:13px; border:1px solid #666666;" rows="37" cols="33"  id="field_contents" >{{ info.str_hist }}</textarea>
					</div>
			</div>						
			</template>		

			</div>
		</div>
		
		<br />
		
		<jsp:include page="/WEB-INF/jsp/kcg/_include/system/footer.jsp" flush="false"/>
		
	</div>
</div>
</body>
<script>

var vueapp = new Vue({
	el : "#vueapp",
	data : {
		info : {
			prod_sn : "${prod_sn}",
			str_hist : "",
			save_mode : "insert",
		},
	},
	mounted : function(){
		console.log("mounted@@@this.info.prod_sn: " + this.info.prod_sn)
		if(!cf_isEmpty(this.info.prod_sn)){
			console.log("prod_sn값이 있을때만 떠야 함")
			this.getInfo();			
		}
	},
	methods : {
		getInfo : function(){
			cf_ajax("/t1_prod_mng/getInfo", this.info, this.getInfoCB);
		},
		getInfoCB : function(data){
			this.info = data;
			//시리얼 번호가 비어있지 않으면 getInfo -> getInfoCB로 save_mode를 update로 바꿈(서비스 단에서 다른 쿼리문을 쓰기 위함)
			this.info.save_mode = "update";
		},
		save : function(){
			
			console.log("save시의 상품 시리얼 코드 : " + this.info.prod_sn)
			
			if(cf_isEmpty(this.info.prod_name)){
				alert("상품명을 입력하세요.");
				return;
			}else if(cf_isEmpty(this.info.prod_type)){
				alert("상품유형을 입력하세요.");
				return;
			}			
			
			if(!confirm("저장하시겠습니까?")) return;
			
			cf_ajax("/t1_prod_mng/save", this.info, this.saveCB);
		},
		saveCB : function(data){
			alert("저장되었습니다.");
			this.info.prod_sn = data.prod_sn;
			this.getInfo();
		},
		delInfo : function(){
			if(!confirm("삭제하시겠습니까?")) return;
			cf_ajax("/t1_prod_mng/delete", this.info, this.delInfoCB);
		},
		delInfoCB : function(data){
			this.gotoList();
		},
		gotoList : function(){
			cf_movePage('/t1_prod_mng/ProdList');
		},
	}
});
</script>
</html>