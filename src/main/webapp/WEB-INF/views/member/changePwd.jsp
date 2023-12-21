<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400" rel="stylesheet" type="text/css" /> <!-- https://fonts.google.com/ -->
<link href="${contextPath }/resources/css/bootstrap.min.css" rel="stylesheet" type="text/css"/> <!-- https://getbootstrap.com/ -->
<link href="${contextPath }/resources/fontawesome/css/all.min.css" rel="stylesheet" type="text/css"/> <!-- https://fontawesome.com/ -->
<link href="${contextPath }/resources/css/templatemo-diagoona.css" rel="stylesheet" />
<link href="http://fonts.googleapis.com/earlyaccess/jejugothic.css" rel="stylesheet">
<link href="http://fonts.googleapis.com/earlyaccess/notosanskr.css" rel="stylesheet">
<link href="http://fonts.googleapis.com/earlyaccess/nanumgothic.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
	function chkPW(){
		var pw = $("#pwd").val();
		var num = pw.search(/[0-9]/g);
		var eng = pw.search(/[a-z]/ig);
		var spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
		if(pw.length < 8 || pw.length > 12){
			document.getElementById('pwd_text').innerHTML = "8자리~12자리 이내로 입력해주세요."
			return false;
		}else if(pw.search(/\s/)!=-1){
			document.getElementById('pwd_text').innerHTML = "공백없이 입력해주세요."
			return false;
		}else if(num < 0 || eng <0 || spe <0 ){
			document.getElementById('pwd_text').innerHTML = "영문,숫자,특수문자를 혼합하여 입력해주세요."
			return false;
		}else{
			console.log("통과");
			document.getElementById('pwd_text').innerHTML ="";
			return true;
		}
	}
	function pwdChkFunc(){
		var pw = $("#pwd").val();
		var pw2 = $("#pwd_chk").val();
		if(pw != pw2){
			document.getElementById('pwdChk_text').innerHTML = "비밀번호가 일치하지 않습니다.";
			return false;
		}else{
			document.getElementById('pwdChk_text').innerHTML = "";
			return true;
		}
	}
</script>
<title>HNTRIP 회원정보 찾기</title>
</head>
<body>
    <div class="tm-container">
        <div>
            <div class="tm-row pt-4">
                <div class="tm-col-left">
                    <div class="tm-site-header media">
                        <i class="fas fa-umbrella-beach fa-3x mt-1 tm-logo"></i>
                        <div class="media-body">
                            <h1 class="tm-sitename text-uppercase">HN TRIP</h1>
                            <p class="tm-slogon">new travel diary</p>
                        </div>        
                    </div>
                </div>
                <div class="tm-col-right">
                    <nav class="navbar navbar-expand-lg" id="tm-main-nav">
                        <button class="navbar-toggler toggler-example mr-0 ml-auto" type="button" 
                            data-toggle="collapse" data-target="#navbar-nav" 
                            aria-controls="navbar-nav" aria-expanded="false" aria-label="Toggle navigation">
                            <span><i class="fas fa-bars"></i></span>
                        </button>
                        <div class="collapse navbar-collapse tm-nav" id="navbar-nav">
                            <ul class="navbar-nav text-uppercase">
                                <li class="nav-item">
                                    <a class="nav-link tm-nav-link" href="${contextPath }/index">Home</a>
                                </li>
                                <li class="nav-item">
                                     <c:choose>
										<c:when test="${loginUser != null }">
											<a class="nav-link tm-nav-link" href="${contextPath }/board/likes">LIKES</a>
										</c:when>
										<c:otherwise>
											<a class="nav-link tm-nav-link" href="${contextPath }/member/register_form">JOIN US</a>
										</c:otherwise>
									</c:choose>                         
                                </li>
                                <li class="nav-item">
									<c:choose>
										<c:when test="${loginUser != null }">
											<a class="nav-link tm-nav-link" href="${contextPath }/member/logout">LOGOUT</a>
										</c:when>
										<c:otherwise>
											<a class="nav-link tm-nav-link" href="${contextPath }/member/login">LOGIN</a>
										</c:otherwise>
									</c:choose>
                                </li>                          
                            </ul>                            
                        </div>                        
                    </nav>
                </div>
            </div>
             <div class="tm-row">
                <div class="tm-col-left"></div>
                <main class="tm-col-right tm-contact-main"> <!-- Content -->
                    <section class="tm-content tm-contact">
						<div align="center">
							<h2 class="mb-4 tm-content-title">아이디 / 비밀번호 찾기</h2>
							<form id="changePwd_form" action="changeMemPwd" method="post">
								<table style="width : 660px;">
									<tr>
										<td class="tbtr">아이디</td>
										<td style="width:280px;"><input class="tb-in" type="text" name="id" id="userId" placeholder="아이디 입력">
									</td>
									<tr>
										<td class="tbtr">비밀번호</td>
										<td><input class="tb-pwd" type="password" name="pwd" id="pwd"
											onkeyup="chkPW()" placeholder="비밀번호 입력"><br> <span
											id="pwd_text"></span></td>
									</tr>
									<tr>
										<td class="tbtr">비밀번호 확인</td>
										<td><input class="tb-pwd" type="password" name="pwd_chk" id="pwd_chk"
											onkeyup="pwdChkFunc()" placeholder="비밀번호 확인"><br>
											<span id="pwdChk_text"></span></td>
									</tr>
								</table>
								<br>
								<input class="tb-btn" type="submit" value="비밀번호 변경">&nbsp;&nbsp;&nbsp;&nbsp;
								<input class="tb-btn" type="button"
									onclick="location.href='${contextPath}/index'" value="취소">
							</form>
						</div>
					</section>
                </main>
            </div>
        </div>        

        <div class="tm-row">
            <div class="tm-col-left text-center">            
                <ul class="tm-bg-controls-wrapper">
                    <li class="tm-bg-control active" data-id="0"></li>
                    <li class="tm-bg-control" data-id="1"></li>
                    <li class="tm-bg-control" data-id="2"></li>
                </ul>            
            </div>        
            <div class="tm-col-right tm-col-footer">
                <footer class="tm-site-footer text-right">
                    <p class="mb-0">Copyright 2020 Diagoona Co. 
                    
                    | Design: <a rel="nofollow" target="_parent" href="https://templatemo.com" class="tm-text-link">TemplateMo</a></p>
                </footer>
            </div>  
        </div>

        <div class="tm-bg"> <!-- Diagonal background design -->
            <div class="tm-bg-left"></div>
            <div class="tm-bg-right"></div>
        </div>
    </div>


    <script src="${contextPath }/resources/js/jquery-3.4.1.min.js"></script>
    <script src="${contextPath }/resources/js/bootstrap.min.js"></script>
    <script src="${contextPath }/resources/js/jquery.backstretch.min.js"></script>
    <script src="${contextPath }/resources/js/templatemo-script.js"></script>
</body>
</html>