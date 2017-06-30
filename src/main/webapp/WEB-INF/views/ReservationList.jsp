<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home</title>
    </head>
    <body>
        <div align="center">
            <h1>Reservation List</h1>
            
             
            <table border="1">
            <tr>
                <th>No</th>
                <th>Meeting Name</th>
                <th>Date</th>
                <th>Actions</th>
                </tr>
                 
                <c:forEach var="reservation" items="${reservationList}" varStatus="status">
                <tr>
                    <td>${status.index + 1}</td>
                    <td>${reservation.meeting_name}</td>
                    <td>${reservation.date}</td>
                    <td>
				<a href="/org/edit?id=${reservation.resid}">Edit</a>
				&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="/org/delete?id=${reservation.resid}">Delete</a>
				</td>
                </tr>
                </c:forEach>             
            </table>
        </div>
    </body>
</html>