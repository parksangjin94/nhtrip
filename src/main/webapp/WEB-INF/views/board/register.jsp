<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet"
   href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<style type="text/css">
* {
   margin: 0;
   padding: 0;
}
/* 메인 */
form {
   width: 500px;
   height: 500px;
   margin: 0 auto;
   background: #514d4b;
   text-align: center;
   color: white;
}

.a {
   text-align: center;
   display: grid;
   grid: "item1 item2" "item3 item4" "item5 item6";
   gap: 10px 0;
}

.a>dt {
   font-weight: bold;
}

.a>dd {
   text-align: left;
}

.a>dd>input, #content {
   background: #514d4b;
   border: 2px solid #fff;
   border-radius: 5px;
   text-align: center;
   color: white;
}

.a>dd:nth-of-type(1)>input {
   border: none;
}

form input[type=submit] {
   width: 80px;
   height: 30px;
   color: black;
   border-radius: 10px;
   text-align: center;
}

.a>dd:last-child>img {
   width: 100px;
   height: 100px;
   margin-left: 5px;
}

/* 데이트피커 */
</style>

<script type="text/javascript">
   //파일 이미지 미리보기

   function readURL(input) {
      var inputFile = $('#fileUpload');
      var files = inputFile[0].files //파일에 대한 정보
      var html = ""
      console.log(files)
      if (files != '') {
         for (var i = 0; i < files.length; i++) {
            var reader = new FileReader();
            reader.readAsDataURL(files[i]);//파일의 정보를 토대로 파일을 읽고 
            reader.onload = function(e) { // 파일 로드한 값을 표현한다
               //e : 이벤트 안에 result값이 파일의 정보를 가지고 있다.
               //console.log(e.target)
               html += "<img src='"+e.target.result+"'/>"
               //console.log(e.target.result)
               //html += "<img class='preview' alt='dlalwl'/>"

               //$('.preview').attr('src', e.target.result);
               //console.log(html)
               $('#imgPreview').html(html)
            }
         }
      }
   }
   
   function chk_form(){
      var title = $("#title").val()
      var city = $("#city").val()
      var content = $("#content").val()
      if( title == "" || title == undefined || title == null){
         console.log('타이틀값 : ' + title)
         $("#title").focus();
         alert('제목입력해')
         return false;
      }else if(city == "" || city == undefined || city == null){
         
         console.log('도시 : ' + city)
         $("#city").focus();
         alert('도시입력해')
         
         return false;
      }
      else if(content == "" || content == undefined || content == null){
         console.log('내용 : ' + content)
         $("#content").focus();
         alert('내용입력해')
         return false;
      }
      else {
         reg_form.submit();
      }
   }
   
</script>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
   <form  id= "reg_form" name="register" method="post" action="${contextPath}/board/registerSave"
      enctype="multipart/form-data">
      <dl class="a">
         <dt >작성자</dt>
         <dd>
            <input type="text" name="id" value=${loginUser } readonly />
         </dd>
         <dt>제목</dt>
         <dd>
         
         
            <input type="text" name="title" id="title" />
         </dd>
         
         <dt>등록일</dt>
         <dd>
            <input type="text" name="saveDate" id="datepicker">

            <script type="text/javascript">
               $(function() {
                  //모든 datepicker에 대한 공통 옵션 설정
                  $.datepicker
                        .setDefaults({
                           dateFormat : 'yy-mm-dd' //Input Display Format 변경
                           ,
                           showOtherMonths : true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
                           ,
                           showMonthAfterYear : true //년도 먼저 나오고, 뒤에 월 표시
                           ,
                           changeYear : true //콤보박스에서 년 선택 가능
                           ,
                           changeMonth : true //콤보박스에서 월 선택 가능                
                           ,
                           showOn : "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
                           ,
                           buttonImage : "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
                           ,
                           buttonImageOnly : true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
                           ,
                           buttonText : "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
                           ,
                           yearSuffix : "년" //달력의 년도 부분 뒤에 붙는 텍스트
                           ,
                           monthNamesShort : [ '1', '2', '3', '4',
                                 '5', '6', '7', '8', '9', '10',
                                 '11', '12' ] //달력의 월 부분 텍스트
                           ,
                           monthNames : [ '1월', '2월', '3월', '4월',
                                 '5월', '6월', '7월', '8월', '9월',
                                 '10월', '11월', '12월' ] //달력의 월 부분 Tooltip 텍스트
                           ,
                           dayNamesMin : [ '일', '월', '화', '수', '목',
                                 '금', '토' ] //달력의 요일 부분 텍스트
                           ,
                           dayNames : [ '일요일', '월요일', '화요일', '수요일',
                                 '목요일', '금요일', '토요일' ] //달력의 요일 부분 Tooltip 텍스트
                           ,
                           minDate : "-10Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
                           ,
                           maxDate : "+1M" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)
                        });

                  //input을 datepicker로 선언
                  $("#datepicker").datepicker();
                  $("#datepicker2").datepicker();

                  //From의 초기값을 오늘 날짜로 설정
                  $('#datepicker').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
                  //To의 초기값을 내일로 설정
                  $('#datepicker2').datepicker('setDate', '+1D'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
               });
            </script>
         </dd>
         <dt>나라</dt>
         <select name="country" style="width: 80px;, height: 30px;">
            <option value="none">=== 선택 ===</option>
            <option value="korea" selected>한국</option>
            <option value="australia">호주</option>
            <option value="czech">체코</option>
            <option value="brazil">브라질</option>
         </select>
         <!--
         
         <dd>
            <input type="text" name="country" />
         </dd>
           -->
         <dt>도시</dt>
         <dd>
            <input type="text" name="city" id="city" />
         </dd>
         <dt>내용</dt>
         <dd>
            <textarea id="content" name="content" cols="22"></textarea>
         </dd>

         <!-- 파일을 선택하면 onchange가 작동하고 input 자체(파일에 대한 값)를 readURL에 넘겨주겟다. -->
         <dt>
            <input type="file" name="file_name" id="fileUpload"
               onchange="readURL(this);" multiple />
         </dt>
         <dd id="imgPreview">
            <img class="preview" src="#" width="100" height="100"
               alt="선택된 이미지가 없습니다" />
         </dd>
      </dl>
      <br>
      <br> <input onclick="chk_form()" type="button" value="글쓰기" />
   </form>
</body>
</html>