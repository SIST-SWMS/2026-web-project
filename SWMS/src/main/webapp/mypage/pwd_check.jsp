<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 비밀번호 입력하는 화면 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
<style>
body{
    background:#f8f9fa;
}

.pwd-box{
    width:450px;
    margin:100px auto;
    padding:40px;
    background:#fff;
    border:1px solid #ddd;
    border-radius:10px;
    box-shadow:0 2px 8px rgba(0,0,0,0.08);
}

.pwd-title{
    text-align:center;
    font-size:26px;
    font-weight:bold;
    margin-bottom:35px;
}

.pwd-row{
    display:flex;
    flex-direction:column;
    margin-bottom:30px;
}

.pwd-row label{
    font-size:16px;
    font-weight:bold;
    margin-bottom:10px;
}

.pwd-row input{
    height:45px;
    padding:0 12px;
    border:1px solid #ccc;
    border-radius:6px;
    font-size:15px;
}

.btn-area{
    text-align:center;
}

.btn-area .btn{
    width:120px;
    height:45px;
    font-size:16px;
}
</style>

</head>
<body>
         <!-- 비밀번호 입력화면 -->
	<div class="pwd-box">
    <div class="pwd-title">비밀번호 확인</div>

    <form>
        <div class="pwd-row">
            <label for="pwd">비밀번호</label>
            <input type="password" id="pwd" name="pwd">
        </div>

        <div class="btn-area">
            <input type="submit" value="확인" class="btn btn-dark">
        </div>
    </form>
</div>
</body>
</html>