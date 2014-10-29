
<%@page import="jp.zyyx.training.renshuu4.InformationBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
	
	if (!state.equals("INIT")) {
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


<form action='Register.jsp' method='post'>
	名前：
	<input type='text' name='name' value='<%= name %>'>
	<% 
		if (state == "ERROR" && !nameError.equals("")) {
			out.print(nameError);
		}
	%>
	<br> <br>
	年齢： <input type='text' name='yearold' value="<%= yearold %>"> 
	<% 
		if (state == "ERROR" && !yearoldError.equals("")) {
			out.print(yearoldError);
		}
	%>

	<br> <br>
	年：
	<select name = 'year'>
		<% for (int i = 1970; i <= 2007; i++) {
			if (Integer.parseInt(year) == i) {
				out.print("<option selected value = " + i +">" + i + "</option>");
			} else {
				out.print("<option value = " + i +">" + i + "</option>");
			}
		}%>
	</select> 
	月：
	<select name = 'month'>
		<% for (int i = 1; i <= 12; i++) {
			if (Integer.parseInt(month) == i) {
				out.print("<option selected value = " + i +">" + i + "</option>");
			} else {
				out.print("<option value = " + i +">" + i + "</option>");
			}

		}%>
	</select>
	 日：
	<select name = 'day'>
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

	<br> <br>
	 メールアドレス： <input type = 'text' name = 'mailAddress' value="<%= mailAddress%>"> 
	<% 
		if (state == "ERROR" && !mailMagazineError.equals("")) {
			out.print(mailMagazineError);
		}
	%>
	
	<br> <br>
	メルマガ: 
	<input type = 'radio' name = 'mailMagazine' value = 'true' <% if(mailMagazine.equals("true")) out.print("checked"); %>> 必要
	<input type = 'radio' name = 'mailMagazine' value = 'false' <% if(mailMagazine.equals("false")) out.print("checked"); %>> 不要 <br>
	<input type = 'submit'>
</form>

<jsp:include page="Footer.jsp"/>