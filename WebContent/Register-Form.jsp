
<%@page import="jp.zyyx.training.renshuu4.InformationBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Bootstrap -->
<link type="text/css" rel="stylesheet" href="bootstrap-3.2.0-dist/css/bootstrap.css">
<script src="bootstrap-3.2.0-dist/js/bootstrap.js"></script>
<title>会員登録</title>
</head>
<body>


<%-- フォルムのデータを初期化、セッションにデータあれば、フォルムにフィル --%>
<% 
	String state = "INIT";
	String name = "";
	String yearold = "";
	String year = "1970";
	String month = "1";
	String day = "1";
	String mailAddress = "";
	String mailMagazine = "false";
	String nameError = "";
	String yearoldError = "";
	String dateError = "";
	String mailMagazineError = "";
	if (session.getAttribute("state") != null) {
		state = session.getAttribute("state").toString();
	}
	
	if (state.equals("EDIT") || state.equals("ERROR")) {
		InformationBean entry = (InformationBean) session.getAttribute("entry");
		if (entry != null) {
			name = entry.getName();
			yearold  = entry.getYearold();
			year = Integer.toString(entry.getYear());
			month = Integer.toString(entry.getMonth());
			day = Integer.toString(entry.getDay());
			mailAddress = entry.getMailAddress();
			mailMagazine = String.valueOf(entry.isMailMagazine());
			
			if (session.getAttribute("nameError") != null) {
				nameError = session.getAttribute("nameError").toString();
			}
			if (session.getAttribute("yearoldError") != null) {
				yearoldError = session.getAttribute("yearoldError").toString();
			}
			if (session.getAttribute("dateError") != null) {
				dateError = session.getAttribute("dateError").toString();
			}
			if (session.getAttribute("mailMagazineError") != null) {
				mailMagazineError = session.getAttribute("mailMagazineError").toString();
			}
		}
	}
session.invalidate();
%>


<form role="form" action='Register.jsp' method='post'>

	<div class="control-group">
	<label class="control-label" >名前</label>
	<input type='text' name='name' value='<%= name %>' class="input-xlarge">
	<% 
		if (state == "ERROR" && !nameError.equals("")) {
			out.print(nameError);
		}
	%>
	</div>
		
	<div class="control-group">
	<label class="control-label">年齢</label>
	<input type='text' name='yearold' value="<%= yearold %>" class="input-xlagrge"> 
	<% 
		if (state == "ERROR" && !yearoldError.equals("")) {
			out.print(yearoldError);
		}
	%>
	</div>

	<div class="control-group">
	<label class="control-label">年</label>
	<select name = 'year' class="selectpicker">
		<% for (int i = 1970; i <= 2007; i++) {
			if (Integer.parseInt(year) == i) {
				out.print("<option selected value = " + i +">" + i + "</option>");
			} else {
				out.print("<option value = " + i +">" + i + "</option>");
			}
		}%>
	</select> 
	
	<label class="control-labe">月</label>
	<select name = 'month' class="selectpicker">
		<% for (int i = 1; i <= 12; i++) {
			if (Integer.parseInt(month) == i) {
				out.print("<option selected value = " + i +">" + i + "</option>");
			} else {
				out.print("<option value = " + i +">" + i + "</option>");
			}

		}%>
	</select>
	 
	<label class="control-label">日</label>
	<select name = 'day' class="selectpicker">
	<% for (int i = 1; i <= 31; i++) {
		if (Integer.parseInt(day) == i) {
			out.print("<option selected value = " + i +">" + i + "</option>");
		} else {
			out.print("<option value = " + i +">" + i + "</option>");
		}

	} %>
	</select> 
	<% 
		if (state == "ERROR" && !dateError.equals("")) {
			out.print(dateError);
		}
	%>
	</div>

	<div class="control-group">
	<label class="control-label">メールアドレス</label>
	<input type = 'text' name = 'mailAddress' value="<%= mailAddress%>" class="input-xlarge"> 
	<% 
		if (state == "ERROR" && !mailMagazineError.equals("")) {
			out.print(mailMagazineError);
		}
	%>
	</div>
	
	<div class="control-group">
	<label class="control-label">メルマガ</label>
	<label class="radio-inline"><input type = 'radio' name = 'mailMagazine' value = 'true' <% if(mailMagazine.equals("true")) out.print("checked"); %>>必要</label>
	<label class="radio-inline"><input type = 'radio' name = 'mailMagazine' value = 'false' <% if(mailMagazine.equals("false")) out.print("checked"); %>>不要</label>
	</div>
	<input type = 'submit' class="btn btn-default btn-xs">
</form>

<jsp:include page="Footer.jsp"/>