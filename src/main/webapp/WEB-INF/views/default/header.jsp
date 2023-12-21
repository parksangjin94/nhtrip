<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<style type="text/css">
<!--
* {
   margin: 0; text-decoration: none !important;
}
.left { width:33.333%; }
.center { width:33.333%; }
.right { width:33.333%; }
nav {
   width: 100%;
   display: flex;
   position: absolute;
   z-index: 10;
   background: black;
}

nav ul {
   list-style: none;
   display: flex;
}

nav ul li {
   margin: 0 3px;
   display: flex;
   padding: 5px 10px;
}

nav ul li a {
   margin-top: 10px;
   text-decoration: none;
   color: white;
   font-size: 12pt;
}
.spanmain {
   margin-top: 10px;
   color: white;
   font-size: 12pt;
   padding-left: 300px;
}
form { 
   display: flex;
   margin-top: 8px;
 }
-->
</style>
</head>
<body>
   <div>
      <nav>
         <div class="left">
            <ul>
               <c:choose>
                  <c:when test="${loginUser != null }">
                     <li class="li_first"><a
                        href="${contextPath }/board/main?id=${loginUser}">MY PAGE</a></li>
                  </c:when>
                  <c:otherwise></c:otherwise>
               </c:choose>

               <li><c:choose>
                     <c:when test="${loginUser != null }">
                        <a href="${contextPath }/board/likes">LIKES</a>
                     </c:when>
                     <c:otherwise>
                        <a href="${contextPath }/member/register_form">JOIN US</a>
                     </c:otherwise>
                  </c:choose></li>

               <li><c:choose>
                     <c:when test="${loginUser != null }">
                        <a href="${contextPath }/member/logout">LOGOUT</a>
                     </c:when>
                     <c:otherwise>
                        <a href="${contextPath }/member/login">LOGIN</a>
                     </c:otherwise>
                  </c:choose></li>
            </ul>
         </div>
         <div class="center">
            <ul>
               <li><c:choose>
                     <c:when test="${loginUser != null }">
                        <form action="${contextPath }/board/search" method="post">
                           <select name="key" class="form-control" id="sel1">
                              <option value="country">국가별</option>
                              <option value="city">도시별</option>
                              <option value="hit">제목별</option>
                           </select>

                           <div class="input-group">
                              <input type="text" name="word" class="form-control"
                                 placeholder="Search" style="width: 270px;">
                              <div class="input-group-btn">
                                 <button class="btn btn-default" type="submit">
                                    <i class="glyphicon glyphicon-search"></i>
                                 </button>
                              </div>
                           </div>
                        </form>
                     </c:when>
                  </c:choose></li>
            </ul>
         </div>
         <div class="right">
            <ul>
               <li><c:choose>
                     <c:when test="${loginUser != null }">
                        <span class="spanmain">${loginUser }님 환영합니다</span>
                     </c:when>
                  </c:choose></li>
            </ul>
         </div>
      </nav>
   </div>
</body>
</html>