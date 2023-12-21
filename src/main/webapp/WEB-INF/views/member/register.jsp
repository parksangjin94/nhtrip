<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<%@ page import="java.util.Random"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>HNTRIP 회원가입</title>
<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400" rel="stylesheet" type="text/css" /> <!-- https://fonts.google.com/ -->
<link href="${contextPath }/resources/css/bootstrap.min.css" rel="stylesheet" type="text/css"/> <!-- https://getbootstrap.com/ -->
<link href="${contextPath }/resources/fontawesome/css/all.min.css" rel="stylesheet" type="text/css"/> <!-- https://fontawesome.com/ -->
<link href="${contextPath }/resources/css/templatemo-diagoona.css" rel="stylesheet" />
<link href="http://fonts.googleapis.com/earlyaccess/jejugothic.css" rel="stylesheet">
<link href="http://fonts.googleapis.com/earlyaccess/notosanskr.css" rel="stylesheet">
<link href="http://fonts.googleapis.com/earlyaccess/nanumgothic.css" rel="stylesheet">
<style type="text/css">
   span {
      color : #F15F5F;
      font-size: 0.7rem;
      font-style: bold;
   }
   font {
      font-family : 'Jeju Gothic', 'Noto Sans KR', 'Nanum Gothic', sans-serif;
   }
</style>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
   function chkDup(){
      var userId = $("#userId").val()
      if( userId == "" ){
         document.getElementById('userId').style.borderColor="#FF0000";
         document.getElementById('id_text').innerHTML = "아이디를 입력하세요."
         $("#userId").focus();
         return;
      }
      $.ajax({
         url : "chkId?id="+userId, type : "get", dataType : "json",
         success:function(data){
            var html = "<font size='1', color='#F15F5F'>이미 등록된 ID입니다.</font>"
            $("#chkDupId").html(html)
         },error : function(data){
            var html = "<font size='1', color='#F6F6F6'>사용 가능한 ID입니다.</font>"
            $("#chkDupId").html(html)
         }
      })
   }
   
   function chkId(){
      var uId = $("#userId").val();
      var num = uId.search(/[0-9]/g);
      var eng = uId.search(/[a-z]/ig);
      var spe = uId.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
      var kor = uId.search(/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/gi);
      if(uId.length < 4 || uId.length > 15){
         document.getElementById('id_text').innerHTML = "4자리~15자리 이내로 입력해주세요."
         return false;
      }else if(uId.search(/\s/)!=-1){
         document.getElementById('id_text').innerHTML = "공백없이 입력해주세요."
         return false;
      }else if(spe > 0){
         document.getElementById('id_text').innerHTML = "특수문자는 사용할 수 없습니다."
         return false;
      }else if(kor > 0){
         document.getElementById('id_text').innerHTML = "한글은 사용할 수 없습니다."
         return false;
      }else if(num < 0 || eng <0 ){
         document.getElementById('id_text').innerHTML = "영문,숫자를 혼합하여 입력해주세요."
         return false;
      }else{
         document.getElementById('id_text').innerHTML ="";
         return true;
      }
   }
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
   
   function chk_email(){
      var e = $("#email").val()
      var c = $("#code_check").val()
      var form = { email : e , code : c}
      console.log(form)
      $.ajax({
         url : "sendMail", type: "post",
         data : JSON.stringify(form),
         dataType : "json",
         contentType : "application/json; charset=UTF-8",
         success : function(data){
            viewChk()
         }
      })
   }

   function viewChk(){
      $("#hidden").show()
   }
   
   function chkCode(){
      var c1 = reg_form.code_check.value;
      var c2 = $("#code").val()
      if(c1 != c2){
         document.getElementById('code').style.borderColor="#FF0000";
         document.getElementById('chk_text').innerHTML = "인증번호가 틀렸습니다."
         return false;
      }else{
         document.getElementById('code').style.borderColor="black";
         document.getElementById('chk_text').style.fontSize="5px";
         document.getElementById('chk_text').style.color="white";
         document.getElementById('chk_text').innerHTML = "인증되었습니다."
         return true;
      }
   }
   
   function chk_form(){
      var id = $("#userId").val()
      var dupId = document.getElementById('chkDupId').value
      var name = $("#name").val()
      var p = $("#pwd").val()
      var email = $("#email").val()
      var email_code = $("#code").val()
      
      if( id == ""){
         document.getElementById('userId').style.borderColor="#FF0000";
         document.getElementById('id_text').innerHTML = "아이디를 입력하세요."
         $("#userId").focus();
         return false;
      }else if(dupId ==""){
         console.log("dupID 값 : " + dupId)
         alert('ID 중복을 확인하세요.');
         return false;
      }else if ( p == ""){
         document.getElementById('pwd').style.borderColor="#FF0000";
         document.getElementById('pwd_text').innerHTML = "비밀번호를 입력하세요."
         $("#pwd").focus();
         return false;
      }else if ( name == ""){
         document.getElementById('name').style.borderColor="#FF0000";
         document.getElementById('name_text').innerHTML = "이름을 입력하세요."
         $("#name").focus();
         return false;
      }else if (email == ""){
         document.getElementById('email').style.borderColor="#FF0000";
         document.getElementById('email_text').innerHTML = "이메일 주소를 입력하세요."
         $("#email").focus();
         return false;
      }else if(email_code == "" || chkCode() == false){
         alert('이메일 인증코드를 다시 확인해주세요.')
         return false;
      }else if(chkId()==true && chkPW() ==true 
            && pwdChkFunc() == true &&chkCode() == true){
         reg_form.submit();
      }
   }
   

</script>   
<%!
   private String rand() {
       Random ran = new Random();
       String str="";
       int num;
       while(str.length() != 6) { // 6자리의 문자열을 생성
          num = ran.nextInt(75)+48; // 0~74 + 48 (숫자,소문자, 대문자) (48~122)
          if((num>=48 && num<=57)||(num>=65 && num<=90)||(num>=97 && num<=122)) {
             str+=(char)num;
          }else {
             continue;
          }
       }
       return str;
    }
%>
</head>
<body>
    <div class="tm-container">
        <div>
            <div class="tm-row pt-4">
                <div class="tm-col-left">
                    <div class="tm-site-header media">
                        <i class="fas fa-umbrella-beach fa-3x mt-1 tm-logo"></i>
                        <div class="media-body">
                            <h1 class="tm-sitename text-uppercase">HNTRIP</h1>
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
                                 <a class="nav-link tm-nav-link trigger" href="${contextPath }/member/register_form">JOIN US</a>
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
                                <c:choose>
                                   <c:when test="${loginUser != null }">
                                      <li class="nav-link tm-nav-link">${loginUser}님 환영합니다.</li>
                                     </c:when>
                                     <c:otherwise></c:otherwise>
                                </c:choose>               
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
                     <h2 class="mb-4 tm-content-title">회 원 가 입</h2>
                     <form id="reg_form" action="register" method="post">
                        <table style="width : 660px;">
                           <tr>
                              <td class="tbtr">아이디</td>
                              <td style="width:280px;"><input class="tb-in" type="text" name="id" id="userId"
                                 onkeyup="chkId()" placeholder="아이디 입력"> <input class="tb-btn" 
                                 type="button" onclick="chkDup()" value="아이디 중복확인"><br>
                              </td>
                              <td class="tb-chk"><span id="chkDupId"></span></td>
                           </tr>
                           <tr>
                              <td></td>
                              <td><span id="id_text"></span></td>
                           </tr>
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
                           <tr>
                              <td class="tbtr">이름</td>
                              <td><input class="tb-in" type="text" name="name" id="name"
                                 placeholder="이름"><br> <span id="name_text"></span>
                              </td>
                           </tr>
                           <tr>
                              <td class="tbtr">이메일</td>
                              <td><input class="tb-in" type="text" name="email" id="email"
                                 placeholder="이메일 주소 입력"> <input class="tb-btn" type="button"
                                 onclick="chk_email()" value="이메일 인증"><br> <span
                                 id="email_text"></span></td>
                              <td><input type="hidden" readonly="readonly" name="code"
                                 id="code_check" value="<%=rand()%>"></td>
                           </tr>
                           <tr id="hidden" style="display: none;">
                              <td></td>
                              <td><input class="tb-in" type="text" id="code"
                                 placeholder="인증코드를 입력해주세요"> <input class="tb-btn" type="button" 
                                 onclick="chkCode()" value="인증 확인"><br> <span
                                 id="chk_text"></span></td>
                           </tr>
                        </table>
                        <br>
                        <input class="tb-btn" type="button" onclick="chk_form()" value="회원가입">&nbsp;&nbsp;&nbsp;&nbsp;
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