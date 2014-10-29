<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Bootstrap -->
<link type="text/css" rel="stylesheet" href="bootstrap-3.2.0-dist/css/bootstrap.css">
<script src="bootstrap-3.2.0-dist/js/bootstrap.js"></script>
<title>情報を確認してください</title>
</head>
<body>

<jsp:useBean id="entry" class="jp.zyyx.training.renshuu4.InformationBean" scope="session" />
<jsp:setProperty name="entry" property="*"/>

<%-- 入力したデータを表示 --%>
<label>情報を確認してください</label><br>
<%= entry %>
<form action="ProcessRegisterInformation" method="post">
<br>
<input type="submit" value="次へ" name="navigate" class="btn btn-default btn-xs">
<input type="submit" value="戻る" name="navigate" class="btn btn-default btn-xs">
</form>

</body>
</html>