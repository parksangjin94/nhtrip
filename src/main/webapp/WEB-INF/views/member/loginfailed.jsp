<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LOGIN FAILED...</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
	var message = "${msg}";
	function sendMsg(){
		if(message != null){
			alert(message);
			location.href="${url}";
		}
	}
</script>
</head>
<body onload="sendMsg();">
</body>
</html>