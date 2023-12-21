<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.security.SecureRandom"%>
<%@ page import="java.math.BigInteger"%>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>HNTRIP LOGIN</title>
<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400" rel="stylesheet" type="text/css" /> <!-- https://fonts.google.com/ -->
<link href="${contextPath }/resources/css/bootstrap.min.css" rel="stylesheet" type="text/css"/> <!-- https://getbootstrap.com/ -->
<link href="${contextPath }/resources/fontawesome/css/all.min.css" rel="stylesheet" type="text/css"/> <!-- https://fontawesome.com/ -->
<link href="${contextPath }/resources/css/templatemo-diagoona.css" rel="stylesheet" />
<link href="http://fonts.googleapis.com/earlyaccess/jejugothic.css" rel="stylesheet">
<link href="http://fonts.googleapis.com/earlyaccess/notosanskr.css" rel="stylesheet">
<link href="http://fonts.googleapis.com/earlyaccess/nanumgothic.css" rel="stylesheet">
<!-- 네이버 로그인 -->
<script
	src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js"
	charset="utf-8"></script>
<script
	src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js"
	charset="utf-8"></script>
<!--  카카오 로그인-->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script type="text/javascript">
	function naverLogin() {
		var naverLogin = new naver.LoginWithNaverId({
			clientId : "gOu7UJfHmcwmD8ic4Ar5",
			callbackUrl : "http://localhost:8085/root/member/naverCallback",
			isPopup : false, /* 팝업을 통한 연동처리 여부 */
			loginButton : {
				color : "green",
				type : 3,
				height : 60
			}
		/* 로그인 버튼의 타입을 지정 */
		});
		naverLogin.init();
	}
</script>

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
            
            
            
                   <!-- api 스크립트 -->
            
        <%
		String clientId2 = "ba90b94fc88f2ca04ef48f2ab43249aa";
		String redirectURI2 = "http://localhost:8085/root/member/kakaoLogin";
		String kakaoApiUrl = "https://kauth.kakao.com/oauth/authorize?";
		kakaoApiUrl += "client_id=" + clientId2;
		kakaoApiUrl += "&redirect_uri=" + redirectURI2;
		kakaoApiUrl += "&response_type=code";
		%>
		<%
		String clientId = "gOu7UJfHmcwmD8ic4Ar5";//애플리케이션 클라이언트 아이디값";
		String redirectURI = URLEncoder.encode("http://localhost:8085/root/member/naverCallback", "UTF-8");
		SecureRandom random = new SecureRandom();
		String state = new BigInteger(130, random).toString();
		String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
		apiURL += "&client_id=" + clientId;
		apiURL += "&redirect_uri=" + redirectURI;
		apiURL += "&state=" + state;
		session.setAttribute("state", state);
		%>
                        
            <div class="tm-row">
                <div class="tm-col-left"></div>
                <main class="tm-col-right tm-contact-main"> <!-- Content -->
                    <section class="tm-content tm-contact">
                        <h2 class="mb-4 tm-content-title">LOGIN</h2>
                        <p class="mb-85">아직 회원가입 하지 않으셨나요?<br>HNTRIP과 여행 추억을 공유해주세요</p>
						<form id="contact-form" action="loginCheck" method="POST">
                            <div class="form-group mb-4">
                                <input type="text" name="id" class="form-control" placeholder="Input ID" required="" />
                            </div>
                            <div class="form-group mb-4">
                                <input type="password" name="pwd" class="form-control" placeholder="Input PASSWORD" required="" />
                            </div>
								<input type="checkbox" name="autoLogin">&nbsp;&nbsp;Auto Login                            
                            <div class="text-right">
                            	<a style="padding-top:15px; padding-right : 50px; color:white; font-family: 'Jeju Gothic', sans-serif;" href="${contextPath}/member/findInfo">아이디 / 비밀번호 찾기</a>
                                <button type="submit" class="btn btn-big btn-primary">LOGIN</button><br><br>
                            		<a href="<%=kakaoApiUrl%>"> 
									<img src="//k.kakaocdn.net/14/dn/btqCn0WEmI3/nijroPfbpCa4at5EIsjyf0/o.jpg" width="222" /></a>
                            		<a href="<%=apiURL%>">
									<img height="50" width="222" src="https://static.nid.naver.com/oauth/big_g.PNG" /></a>
                            </div>    
                            
                        </form>
						
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