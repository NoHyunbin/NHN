<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page  contentType="text/html;charset=UTF-8"%>

<!DOCTYPE HTML>
<html>
<head>
	<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/resources/bootstrap-3.3/css/bootstrap.min.css">
	<script type="text/javascript" src="${pageContext.servletContext.contextPath}/resources/js/jquery-2.1.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.servletContext.contextPath}/resources/bootstrap-3.3/js/bootstrap.min.js"></script>
	
	<!-- NHN FreeBoard's font -->
	<link href='http://fonts.googleapis.com/css?family=Playball' rel='stylesheet' type='text/css'>
	
	<!-- Website Font style -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.1/css/font-awesome.min.css">
	<style type="text/css">
		.about-section h2 {
			  color: #34495E;
			  font-size: 4em;
			  font-weight: 400;
			  font-family: 'Playball', cursive;
			}
		
		/* table setting */
		table#acrylic {
            border-collapse: separate;
            background: #fff;
            -moz-border-radius: 10px;
            -webkit-border-radius: 10px;
            border-radius: 10px;
            margin: 10px auto;
            -moz-box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.3);
            -webkit-box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.3);
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.3);
            cursor: pointer;
        }
        
        #acrylic thead {
            -moz-border-radius: 10px;
            -webkit-border-radius: 10px;
            border-radius: 10px;
        }
        
        #acrylic thead th {
            font-family: 'Roboto';
            font-size: 16px;
            font-weight: 400;
            color: white;
            text-shadow: 1px 1px 0px rgba(0, 0, 0, 0.5);
            text-align: center;
            padding: 20px;
            background-size: 100%;
            background-image: -webkit-gradient(linear, 50% 0%, 50% 100%, color-stop(0%, #3C5064), color-stop(100%, #34495e));
            background-image: -moz-linear-gradient(#3C5064, #34495e);
            background-image: -webkit-linear-gradient(#3C5064, #34495e);
            background-image: linear-gradient(#3C5064, #34495e);
            border-top: 1px solid #858d99;
        }
        
        #acrylic thead th:first-child {
            -moz-border-top-right-radius: 10px;
            -webkit-border-top-left-radius: 10px;
            border-top-left-radius: 10px;
        }
        
        #acrylic thead th:last-child {
            -moz-border-top-right-radius: 10px;
            -webkit-border-top-right-radius: 10px;
            border-top-right-radius: 10px;
        }
        
        #acrylic tbody tr td {
            font-family: 'Open Sans', sans-serif;
            font-weight: 400;
            color: #5f6062;
            font-size: 13px;
            padding: 10px 10px 10px 10px;
            border-bottom: 1px solid #e0e0e0;
        }
        
        #acrylic tbody tr:nth-child(2n) {
            background: #f0f3f5;
        }
        
        #acrylic tbody tr:last-child td {
            border-bottom: none;
        }
        
        #acrylic tbody tr:last-child td:first-child {
            -moz-border-bottom-right-radius: 10px;
            -webkit-border-bottom-left-radius: 10px;
            border-bottom-left-radius: 10px;
        }
        
        #acrylic tbody tr:last-child td:last-child {
            -moz-border-bottom-right-radius: 10px;
            -webkit-border-bottom-right-radius: 10px;
            border-bottom-right-radius: 10px;
        }
        
        #acrylic tbody:hover > tr td {
            filter: progid: DXImageTransform.Microsoft.Alpha(Opacity=50);
            opacity: 0.5;
        }
        
        #acrylic tbody:hover > tr:hover td {
            text-shadow: none;
            color: #2d2d2d;
            filter: progid: DXImageTransform.Microsoft.Alpha(enabled=false);
            opacity: 1;
            transition: 0.2s all;
        }
	</style>
	
	<script type="text/javascript">
		$(document).ready(function() {
			$("#messageModal").on('hidden.bs.modal', function() {
				$("#successMessage").html("");
				$("#failMessage").html("");
			});
			
			$("#writeModal").on('shown.bs.modal', function() {
				$("#write_bemail").focus();
			});
			
			$("#messageModal").on('hidden.bs.modal', function() {
				$("#write_bemail").focus();
				$("#successMessage").html("");
				$("#failMessage").html("");
			});
		});
		
		/* ------------------------------- 글쓰기 ------------------------------- */
		/* 글쓰기 버튼 클릭 */
		function onClickBtnWrite() {
			console.log("onClickBtnWrite() 실행");
			$("#writeModal").modal("show");
		}
		
		/* 글쓰기 완료 버튼 */
		function onClickBtnWritefin() {
			console.log("onClickBtnWritefin() 실행");
			var bemail = $("#writeModal #write_bemail").val();
			var bpassword = $("#writeModal #write_bpassword").val();
			var bcontent = $("#writeModal #write_bcontent").val();
			
			if ( !emailCheck(bemail) ) {
				$("#writeModal #bemail").val("");
				$("#failMessage").html("email 형식을 확인해주세요");
				$("#messageModal").modal("show");
			} else {
				$.ajax({
					url: "write",
					data: {"bemail":bemail, "bpassword":bpassword, "bcontent":bcontent},
					method:"post",
					success: function(data) {
						if( data.result == "success" ) {
							$("#successMessage").html("글쓰기 완료");
							$("#messageIcon").attr('class', "fa fa-check-circle");
							$("#messageModal").modal("show");
							$("#messageModal").on('hidden.bs.modal', function() {
								location.reload();
							});
						} else if ( data.result == "Email Pattern Error" ) {
							$("#writeModal #bemail").val("");
							$("#failMessage").html("email 형식을 확인해주세요");
							$("#messageModal").modal("show");
						} else {
							$("#failMessage").html("글쓰기 실패");
							$("#messageModal").modal("show");
						}
					}
				});
			}
		}
		
		/* 글쓰기 취소 버튼 */
		function onClickBtnWriteCancel() {
			console.log("onClickBtnWriteCancel() 실행");
			$("#writeModal #write_bemail").val("");
			$("#writeModal #write_bpassword").val("");
			$("#writeModal #write_bcontent").val("");
			$("#writeModal").modal("hide");
		}
		/* ------------------------------- 글쓰기 ------------------------------- */
		
		/* ------------------------------- 글 상세보기 ------------------------------- */
		function showInfo(board) {
			$("#showInfo_bno").val(board.bno);
			$("#showInfo_bemail").val(board.bemail);
			$("#showInfo_bwritetime").val(board.bwritetime);
			$("#showInfo_bmodifytime").val(board.bmodifytime);
			$("#showInfo_bcontent").val(board.bcontent);
			$("#showInfo_passwordPoint").hide();
			$("#btnModifyFin").hide();
			$("#showInfoModal").modal("show");		
		}
		
		function onClickBtnShowInfoOK() {
			location.reload();
		}
		/* ------------------------------- 글 상세보기 ------------------------------- */
		
		/* ------------------------------- 글 수정 ------------------------------- */
		function onClickBtnModify() {
			$("#btnModify").hide();
			$("#btnModifyFin").show();
			$("#showInfo_passwordPoint").show();
			$("#showInfo_bpassword").attr("readonly",false);
			$("#showInfo_bcontent").attr("readonly",false);
			$("#btnShowInfoOK").html("<b>취소</b>");
		}
		
		function onClickBtnModifyFin() {
			var bno = $("#showInfo_bno").val();
			var bpassword = $("#showInfo_bpassword").val();
			var bcontent = $("#showInfo_bcontent").val();
			
			$.ajax({
				url: "modify",
				data: {"bno":bno, "bpassword":bpassword, "bcontent":bcontent},
				method:"post",
				success: function(data) {
					if(data.result == "success") {
						$("#successMessage").html("수정 완료");
						$("#messageIcon").attr('class', "fa fa-check-circle");
						$("#messageModal").modal("show");
						$("#messageModal").on('hidden.bs.modal', function() {
							location.reload();
						});
					} else if ( data.result == "password error" ) {
						$("#failMessage").html("잘못된 비밀번호 입니다");
						$("#messageModal").modal("show");
					} else {
						$("#failMessage").html("수정 실패");
						$("#messageModal").modal("show");
					}
				}
			});
			
		}
		/* ------------------------------- 글 수정 ------------------------------- */
		
		
		/* Email Regex Check */
		function emailCheck(bemail){
			console.log(bemail);
			var regex = /[a-zA-Z0-9_]+@[a-zA-Z0-9.-]+\.[a-zA-Z0-9_]+/;
			
			if( !regex.test(bemail) ) { 
				return false; 
			}else{
				return true;
			}
		}
		
		/* Message OK Button */
		function onClickBtnOK() {
			$("#messageModal").modal("hide");
		}	
	</script>
</head>
<body>
	<div class="about-section"> 
		<div class="container" align="center">
		<a href="${pageContext.servletContext.contextPath}"><h2 style="padding: 30px">NHN &nbsp;FreeBoard</h2></a>
	   
		<!-- 방명록 -->
			<table id="acrylic" style="width:1000px;">
				<thead>
					<tr>
						<th> No </th>
						<th> 이메일 </th>
						<th> 내용 </th>
						<th> 작성일 </th>
					</tr>
				</thead>
				
				<tbody>
					<c:forEach var="board" items="${list}">
						<tr onclick="showInfo({
												bno:'${board.bno}',
												bemail:'${board.bemail}',
												bpassword:'${board.bpassword}',
												bcontent:'${board.bcontent}',
												bwritetime:'${board.bwritetime}',
												bmodifytime:'${board.bmodifytime}'
											})">
							<td style="width: 15px"> &nbsp; ${board.bno} </td>
							<td style="width: 170px"> ${board.bemail} </td>
							<td> ${board.bcontent} </td>
							<td style="width: 150px"> ${board.bwritetime} </td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<div align="right" style="padding-right: 70px">
				<button id="write" type="button" class="btn btn-default" onclick="onClickBtnWrite()" style="color: #34495e"><b>글쓰기</b></button>
	 		</div>
	 		
	 		<!-- 아이디, 이름으로 검색 -->
			<form action="${pageContext.servletContext.contextPath}/list">
				<i class="fa fa-search" aria-hidden="true" style="font-size: 20px"></i> &nbsp;
				<input type="text" placeholder="이메일 입력" name="search" value="${search}"/>			
				<input type="submit" value="검색"/>
			</form>
			
		</div> <!-- container-end -->
	</div>
	
	<!-- ########################## 글쓰기 Modal ########################## -->
	<div id="writeModal" class="modal fade" tabindex="-1" role="dialog" style="margin: auto" onkeydown="if(event.keyCode==13){javascript:onClickBtnWritefin();}">
		<div class="modal-dialog" role="document" style="width:700px; margin-top: 200px;">
	    	<div class="modal-content" style="width:700px; margin: 0">
	    	
	    		<!-- modal-header -->
	     		<div class="modal-header" style="background-color: #34495e; color:white">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title">방명록 쓰기</h4>
	      		</div>
	      		
	      		<!-- modal-body -->
	      		<div class="modal-body">
					<form id="modifyForm">
						<div class="form-group">
							<div class="input-group">
								<span style="width: 130px" class="input-group-addon"><b>이메일</b></span>
								<input style="width: 300px" type="email" class="form-control" name="write_bemail" id="write_bemail" placeholder="ex) email@email.com"/>
							</div>
						</div>
						
						<div class="form-group">
							<div class="input-group">
								<span style="width: 130px" class="input-group-addon"><b>비밀번호</b></span>
								<input style="width: 300px" type="password" class="form-control" name="write_bpassword" id="write_bpassword" placeholder="1~20글자 입력하세요"/>
							</div>
						</div>
						
						<div class="form-group">
							<div class="input-group">
								<span style="width: 130px" class="input-group-addon"><b>내용</b></span>
								<input style="width: 500px" type="text" class="form-control" name="write_bcontent" id="write_bcontent"/>
							</div>
						</div>						
					</form>		
	      		</div>
	      	
		      	<!-- modal-footer -->	
				<div class="modal-footer" style="background-color: #34495e; color:white">
			        <button id="btnWrite" type="button" class="btn btn-default" onclick="onClickBtnWritefin()" style="color: #34495e"><b>완료</b></button>
			        <button id="btnWriteCancel" type="button" class="btn btn-default" onclick="onClickBtnWriteCancel()" style="color: #34495e"><b>취소</b></button>
				</div>
				
			</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	<!-- ########################## 글쓰기 Modal ########################## -->
	
	<!-- ########################## 상세보기 & 수정 Modal ########################## -->
	<div id="showInfoModal" class="modal fade" tabindex="-1" role="dialog" style="margin: auto">
		<div class="modal-dialog" role="document" style="width:700px; margin-top: 200px;">
	    	<div class="modal-content" style="width:700px; margin: 0">
	    	
	    		<!-- modal-header -->
	     		<div class="modal-header" style="background-color: #34495e; color:white">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title">상세 내용</h4>
	      		</div>
	      		
	      		<!-- modal-body -->
	      		<div class="modal-body">
					<form id="modifyForm">
					
						<input type="hidden" id="showInfo_bno"/>
						
						<div class="form-group">
							<div class="input-group">
								<span style="width: 130px; padding:0px; background-color: #34495e; color:white" class="input-group-addon"><b>글쓴이</b></span>
								<b><input style="width: 300px" type="text" class="form-control" name="showInfo_bemail" id="showInfo_bemail" readonly/></b>
							</div>
						</div>
						
						<div class="form-group">
							<div class="input-group">
								<span style="width: 130px" class="input-group-addon"><b>글작성 시간</b></span>
								<input style="width: 300px" type="text" class="form-control" name="showInfo_bwritetime" id="showInfo_bwritetime" readonly/>
							</div>
						</div>
						
						<div class="form-group">
							<div class="input-group">
								<span style="width: 130px" class="input-group-addon"><b>마지막 수정</b></span>
								<input style="width: 300px" type="text" class="form-control" name="showInfo_bmodifytime" id="showInfo_bmodifytime" readonly/>
							</div>
						</div>
						
						<div class="form-group" id="showInfo_passwordPoint">
							<div class="input-group">
								<span style="width: 130px" class="input-group-addon"><b>비밀번호</b></span>
								<input style="width: 300px" type="password" class="form-control" name="showInfo_bpassword" id="showInfo_bpassword" readonly/>
							</div>
						</div>	
						
						<div class="form-group">
							<div class="input-group">
								<span style="width: 130px" class="input-group-addon"><b>내용</b></span>
								<input style="width: 500px" type="text" class="form-control" name="showInfo_bcontent" id="showInfo_bcontent" readonly/>
							</div>
						</div>
					</form>		
	      		</div>
	      	
		      	<!-- modal-footer -->	
				<div class="modal-footer" style="background-color: #34495e; color:white">
			        <button id="btnModify" type="button" class="btn btn-default" onclick="onClickBtnModify()" style="color: #34495e"><b>수정</b></button>
			        <button id="btnModifyFin" type="button" class="btn btn-default" onclick="onClickBtnModifyFin()" style="color: #34495e"><b>수정완료</b></button>
			        <button id="btnShowInfoOK" type="button" class="btn btn-default" onclick="onClickBtnShowInfoOK()" style="color: #34495e"><b>확인</b></button>
				</div>
				
			</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	<!-- ########################## 상세보기 & 수정 Modal ########################## -->
	
	<!-- ########################## Message Modal ########################## -->
	<div id="messageModal" class="modal fade" tabindex="-1" role="dialog" style="margin: auto" onkeydown="if(event.keyCode==13){javascript:onClickBtnOK();}">
		<div class="modal-dialog" role="document" style="width:300px; margin-top: 210px;">
	    	<div class="modal-content" style="width:300px; margin: 0">
	    	
	    		<!-- modal-header -->
	     		<div class="modal-header" style="background-color: #34495e; color:white; text-align: left">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<i id="headerIcon" class="fa fa-bell-o" style="font-size: 20px" aria-hidden="true"> 알림</i>
	      		</div>
	      		
	      		<!-- modal-body -->
	      		<div class="modal-body" align="center">
	      			<i id="messageIcon" class="fa fa-exclamation-triangle" style="font-size: 100px; color: #34495e" aria-hidden="true"></i><br/>
					<b style="font-size: 20px; color: #1bbc9b" id="successMessage"></b>
					<b style="font-size: 20px; color: red" id="failMessage"></b>
	      		</div>
	      	
		      	<!-- modal-footer -->	
				<div class="modal-footer" style="background-color: #34495e; color:white">
			        <button id="messageOk" type="button" class="btn btn-default" onclick="onClickBtnOK()" style="color: #34495e"><b>확인</b></button>
				</div>
				
			</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	<!-- ########################## Message Modal ########################## -->
</body>
</html>
