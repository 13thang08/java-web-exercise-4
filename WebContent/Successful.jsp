<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Bootstrap -->
<link type="text/css" rel="stylesheet" href="bootstrap-3.2.0-dist/css/bootstrap.css">
<script src="bootstrap-3.2.0-dist/js/bootstrap.js"></script>
<title>登録完了</title>
</head>
<body>
<label>登録しました!</label>
<p>
<jsp:useBean id="entry" class="jp.zyyx.training.renshuu4.InformationBean" scope="session" />
<%= entry %>
</p>
<%session.invalidate(); %>


</body>

</html>
</body>
</html>