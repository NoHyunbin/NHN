<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page  contentType="text/html;charset=UTF-8"%>

<!DOCTYPE HTML>
<html>
<head>
	<!-- NHN FreeBoard's font -->
	<link href='http://fonts.googleapis.com/css?family=Playball' rel='stylesheet' type='text/css'>
	<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/resources/bootstrap-3.3/css/bootstrap.min.css">
	
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
		function showInfo(bno) {
			console.log(bno + " showInfo() 실행");
		}
		
		function onClickBtnWrite() {
			console.log("onClickBtnWrite() 실행");
		}
	
	</script>
</head>
<body>
<div class="about-section"> 
	   <div class="container" align="center"><h2 style="padding: 30px">NHN &nbsp;FreeBoard</h2>
	   
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
						<tr onclick="showInfo('${board.bno}')">
							<td style="width: 15px"> &nbsp; ${board.bno} </td>
							<td style="width: 170px"> ${board.bemail} </td>
							<td> ${board.bcontent} </td>
							<td style="width: 150px"> ${board.bwritetime} </td>
<%-- 							<td style="width: 50px">
								<input onclick="showModifyModal({
													bno:'${board.bno}',
													bemail:'${board.bemail}',
													bcontent:'${board.bcontent}',
													bwritetime:'${board.bwritetime}',
													bmodifytime:'${board.bmodifytime}'
												})" type="button" value="수정"/>
								<button type="button" onclick="showDeleteModal('${board.bno}')">삭제</button>
							</td> --%>
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
</body>
</html>
