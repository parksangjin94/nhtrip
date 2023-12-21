<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyPage</title>
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css"/>
<style type="text/css">
*{
	margin: 0; padding: 0; text-decoration: none !important;
}
.wrap {
	font-family: Helvetica Neue, Helvetica, Arial, sans-serif;
	font-size: 14px;
	display: flex;
	justify-content: center; /* 좌우 기준 중앙정렬 */
	align-items: center; /* 위아래 기준 중앙정렬 */
	min-height: 110vh;
	background:black;
}
.swiper {
	width: 1200px;
	padding-top: 50px;
	padding-bottom: 200px;
}
.swiper-slide {
	background-position: center;
	background-size: cover;
	width: 400px;
	height: 400px;
	/*
	-webkit-box-reflect: below 1px linear-gradient(transparent, transparent, #0006);
	*/
}
img {
	width: 100%; height: 100%; border-radius: 10px;
}

.content {
	width: 450px; height: 450px; color: white; background: black;
	position: relative; left: -270px; top: -75px; z-index: 10;
	padding: 25px; box-shadow: 0 0 30px gray;
}
.contentBox { width: 100%; height: 360px;}
table { font-size: 15pt; }
table tr td:nth-child(1) {
	width: 140px; font-weight: bold; height: 30px;
}
table tr td:nth-child(2) {
	width: 360px; word-break: break-all;
}
table.contentData tr:last-child {
	height: 180px; vertical-align: top;
}

div.comment { text-align: right; display: none; }
div.comment a {
	 padding: 3px 7px; color: white; font-size: 13pt;
}
div.comment a:hover {
	 background: gray;
}
.commentGroup { width: 100%; height: 320px; overflow: auto; }
.commentGroup::-webkit-scrollbar {
	width: 5px; /*스크롤바의 너비*/
}
.commentGroup::-webkit-scrollbar-thumb {
	background-color: gray; /*스크롤바의 색상*/
	border-radius: 10px;
}
.commentGroup::-webkit-scrollbar-track {
	background-color: black; /*스크롤바 트랙 색상*/
}
table.commentData { text-align: center; }
table.commentData tr td:nth-child(2) { text-align: left; }

div.btnGroup, div.commentWrite { text-align: center; }
a.btn {
	color: black !important; font-size: 18px; font-weight: bold; background: white;
	display: inline-block; padding: 10px 20px; border-radius: 20px;
}
a.onhit { background: gray; color: white !important; }
a.btn:hover {
	background: gray; color: white;
}

.commentWrite { display: none; }
.commentWrite input[type="text"] {
	border: none; border-bottom: 1px solid white;
	background: black; color: white; width: 70%; height: 30px;
	word-break: break-all;
}
.commentWrite a {
	background: white; color: black; padding: 12px 15px;
	border-radius: 10px; font-weight: bold;
}
.commentWrite a:hover {
	background: gray; color: white;
}

a.fbtn {
	color: black !important; background: white; border-radius: 10px;
	padding: 4px 7px; font-size: 12pt; text-decoration: none;
}
a.fbtn:hover {
	color: white !important; background: gray;
}
a.onfollow {
	color: white !important; background: gray;
}
.li_first { padding-left: 50px; }
</style>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
//좋아요
var cnt = 0;
function hit(){
	let url = ""
	if(cnt == 0){
		if(${myHit} == true){//hit테이블에 아이디가 있을 경우(이미 좋아요 누름)
			url = "downHit"
			$("#hit").removeClass("onhit")
		}else{
			url = "upHit"
			$("#hit").addClass("onhit")
		}
		cnt++;
	}else { //cnt가 0이 아니면 이미 해당 페이지에서 한번 히트가 처리됬으므로 반대로 처리
		if(${myHit} == true){
			url = "upHit"
			$("#hit").addClass("onhit")
		}else{
			url = "downHit"
			$("#hit").removeClass("onhit")
		}
		cnt--;
	}
	url += "?writeNo="+${myData.writeNo};
	$.ajax({
		url : url,
		type : "get",
		success : function(data){
			$("#hit").text("♥ "+data)
			console.log("성공")
			if(url == "downHit?writeNo="+${myData.writeNo}){
				alert('좋아요가 취소되었습니다.')
			}else{
				alert('좋아요가 등록되었습니다.')
			}
		},
		error : function(){
			alert("문제 발생!")
		}
	})
}
//댓글 리스트
function commentList(){
	$.ajax({
		url : "replyData?writeNo="+${myData.writeNo},
		type : "GET",
		dataType : "json",
		success : function(reply) {
			console.log(reply)
			let html = ""
			reply.forEach(function(data) {
				html += "<tr><td>" + data.id + "</td>";
				html += "<td>" + data.content + "</td></tr>"
			})
			//console.log(html)
			$(".commentData").html(html)
		},
		error : function() {
			alert('데이터를 가져올 수 없습니다')
		}
	})
	$(".contentData").hide();
	$(".btnGroup").hide();
	$(".comment").show();
	$(".commentWrite").show();
}
//댓글 창 닫기
function commentClose() {
	$(".contentData").show();
	$(".btnGroup").show();
	$(".comment").hide();
	$(".commentWrite").hide();
}
//댓글 등록
function commentAdd(){
	let no = ${myData.writeNo}; //현재 글번호 받아오기
	let id = "${loginUser}";//현재 로그인한 아이디 받아오기
	let cmt = $("#commentText").val();
	let form = {writeNo : no, id : id, content : cmt}
	console.log(form)
	$.ajax({
		url : "replyAdd", type : "POST",
		data : JSON.stringify(form),
		contentType : "application/json; charset=utf-8",
		success : function(result){
			console.log(result);
			if(result == true){
				commentList();
			}else {
				alert('댓글은 100byte까지만 등록 가능합니다.')
			}
			$("#commentText").val("");
		},
		error : function(){
			alert('댓글 등록에 실패하였습니다.');
		}
	})
}
//팔로우
var fcnt = 0;
function follow(){
	let url = ""
		if(fcnt == 0){
			if(${myFollow} == true){//follow테이블에 아이디가 있을 경우(이미 팔로우 누름)
				url = "delFollow"
				$("#follow").removeClass("onfollow")
			}else{
				url = "addFollow"
				$("#follow").addClass("onfollow")
			}
			fcnt++;
		}else { //fcnt가 0이 아니면 이미 해당 페이지에서 한번 팔로우가 처리됬으므로 반대로 처리
			if(${myFollow} == true){
				url = "addFollow"
				$("#follow").addClass("onfollow")
			}else{
				url = "delFollow"
				$("#follow").removeClass("onfollow")
			}
			fcnt--;
		}
	let id = "${loginUser}";//현재 로그인한 아이디 받아오기
	let fid = "${myData.id}"; //현재 글 쓴 아이디 받아오기
	let form = {id : id, followId : fid}
		$.ajax({
			url : url,
			type : "POST",
			data : JSON.stringify(form),
			contentType : "application/json; charset=utf-8",
			success : function(result){
				console.log("ajax follow 성공")
				console.log(result)
				if(result == true){
					if(url == "delFollow"){
						alert(fid+'님을 팔로우 취소하셨습니다.')
					}else{
						alert(fid+'님을 팔로우 하셨습니다.')
					}
				}else {
					console.log("실패")
				}
			},
			error : function(){
				alert("문제 발생!")
			}
		})
}
</script>
</head>
<body>
<jsp:include page="../default/header.jsp"/>
<div class="wrap">
	<div class="swiper">
		<div class="swiper-wrapper">
			<!-- div 파일 갯수만큼 for문 -->
			<c:forEach var="img" items="${myImg}">
				<div class="swiper-slide">
					<img src="${contextPath}/board/download?fileName=${img.fileName}">
				</div>
			</c:forEach>
		</div>
		<!-- Add Pagination -->
		<div class="swiper-pagination"></div>
	</div><!-- swiper end -->
	
	<div class="content">
		<div class="contentBox">
			<!-- 글 내용 화면 -->
			<table class="contentData">
				<tr>
					<td>ID</td>
					<td>
						${myData.id}&nbsp;&nbsp;
						<c:if test="${loginUser != myData.id}">
							<c:if test="${myFollow == false}">
								<a href="javascript:void(0)" onclick="follow()" id="follow" class="fbtn">follow</a>
							</c:if>
							<c:if test="${myFollow == true}">
								<a href="javascript:void(0)" onclick="follow()" id="follow" class="fbtn onfollow">follow</a>
							</c:if>
						</c:if>
					</td>
				</tr>
				<tr>
					<td>COUNTRY</td> <td>${myData.country}</td>
				</tr>
				<tr>
					<td>CITY</td> <td>${myData.city}</td>
				</tr>
				<tr>
					<td>DATE</td> <td>${myData.saveDate}</td>
				</tr>
				<tr>
					<td>TITLE</td> <td>${myData.title}</td>
				</tr>
				<tr>
					<td>CONTENT</td> <td>${myData.content}</td>
				</tr>
			</table>
			<!-- 댓글 화면 -->
			<div class="comment">
				<a onclick="commentClose()" href="javascript:void(0)">X</a>
				<div class="commentGroup">
					<table class="commentData">
					</table>
				</div>
			</div>
		</div><!-- contentBox end -->
		
		<div class="btnGroup">
			<c:if test="${myHit == false}">
				<a onclick="hit()" href="javascript:void(0)" id="hit" class="btn">♥ ${myData.hit}</a>
			</c:if>
			<c:if test="${myHit == true}">
				<a onclick="hit()" href="javascript:void(0)" id="hit" class="btn onhit">♥ ${myData.hit}</a>
			</c:if>
			&nbsp;&nbsp;&nbsp;
			<a onclick="commentList()" href="javascript:void(0)" class="btn">comment</a>&nbsp;&nbsp;&nbsp;
			<a href="${contextPath}/board/main?id=${myData.id}" class="btn">map</a>
		</div>
		<div class="commentWrite">
			<input type="text" id="commentText">&nbsp;&nbsp;
			<a onclick="commentAdd()" href="javascript:void(0)">등록</a>
		</div>
	</div><!-- content end -->
</div><!-- wrap end -->
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<script>
	var swiper = new Swiper(".swiper", {
		effect : "coverflow",
		grabCursor : true,
		centeredSlides : true,
		slidesPerView : 3,
		coverflowEffect : {
			rotate : 10,// 슬라이더 회전 각 : 클수록 슬라이딩시 회전이 커짐
			stretch : 200,// 슬라이더간 거리(픽셀) : 클수록 슬라이더가 서로 많이 겹침
			depth : 200,// 깊이 효과값 : 클수록 멀리있는 느낌이 강해짐
			modifier : 1,// 효과 배수 : 위 숫자값들에 이 값을 곱하기 처리하여 효과를 강하게 처리함
			slideShadows : true,
		},
		//loop : true,
		initialSlide: ${myImg.size()-1}, //슬라이더 시작 위치, 색인 번호
	});
	//swiper 현재 위치 알려줌
	swiper.on('transitionEnd', function() {
		console.log('now index :::', swiper.realIndex);
	});
</script>
</body>
</html>