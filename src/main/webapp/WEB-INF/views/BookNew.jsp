<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Timetable</title>
    <style type="text/css">
    body
    {
        font-family: arial;
    }
     </style>
<script>
function test(){
	var dt1 = document.getElementById("dt1").value;
	var dt2 = document.getElementById("dt2").value;
	window.location.href="/org/BookList?start_date="+dt1+"&end_date="+dt2;
}
</script>
</head>
<body>
<% String tm = request.getParameter("tm");%>
<form:form action="BookSave" method="post" modelAttribute="reservation">
<h4>BOOK NEW</h4>
<table>
<tr>
 <td>
  Meeting name: </td>
<td><form:input path="meeting_name"/></td>  </tr>
  <tr>
  <th>Date: </th>
<td><form:input path="date"/></td>  </tr>
  <tr>
  <th>Start time:</th>
  <td><form:input path="start_time" value="<%= tm%>"/></td>
  </tr>
  <tr>
  <th>Duration:</th>
<td><form:input path="duration"/></td>  </tr>

  <tr></tr> <tr></tr>
  <tr>
  <td colspan="2" align="center">
                    <input type="submit" value="Save">
                </td>
<th><button type="button" onclick="location.href='table'">Cancel</button>
</th></tr></table>
</form:form>

                    <!--  <br/><br/>Start date <input type="text" id="dt1" name="date1" /><br/><br/>
                    End date <input type="text" id="dt2" name="date2" />
                    <% String date1 = request.getParameter("date1");%>
                    <% String date2 = request.getParameter("date2");%>
        <h2><a href="#" onclick="test()">Reservation List</a></h2>-->

</body>
</html>
