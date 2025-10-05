<%@ page import="java.io.*, java.net.*" %>
<html>
<head>
    <title>Login Page</title>
</head>
<body>
    <h2>Login</h2>
    <form method="post">
        Username: <input type="text" name="username" /><br />
        Password: <input type="password" name="password" /><br />
        <input type="submit" value="Login" />
    </form>

<%
  if ("POST".equalsIgnoreCase(request.getMethod())) {
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    try {
      URL url = new URL("http://backend.default.svc.cluster.local:5000/api/login");
      HttpURLConnection con = (HttpURLConnection) url.openConnection();
      con.setRequestMethod("POST");
      con.setRequestProperty("Content-Type", "application/json");
      con.setDoOutput(true);

      String json = "{\"username\":\"" + username + "\",\"password\":\"" + password + "\"}";
      OutputStream os = con.getOutputStream();
      os.write(json.getBytes());
      os.flush();
      os.close();

      int responseCode = con.getResponseCode();
      if (responseCode == 200) {
        session.setAttribute("username", username);
        response.sendRedirect("dashboard.jsp");
      } else {
        out.println("<p>Login failed. Please try again.</p>");
      }
    } catch (Exception e) {
      out.println("<p>Backend error: " + e.getMessage() + "</p>");
    }
  }
%>
</body>
</html>

