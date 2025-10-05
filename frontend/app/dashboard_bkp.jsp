<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  String username = (String) session.getAttribute("username");
  if (username == null) {
    response.sendRedirect("login.jsp");
    return;
  }
%>
<html>
<head><title>Dashboard</title></head>
<body>
  <h2>Welcome, <%= username %></h2>
  <form method="post" action="submitMarks">
    Physics: <input type="number" name="physics" /><br/>
    Chemistry: <input type="number" name="chemistry" /><br/>
    Mathematics: <input type="number" name="mathematics" /><br/>
    <input type="submit" value="Submit Marks" />
  </form>
</body>
</html>

