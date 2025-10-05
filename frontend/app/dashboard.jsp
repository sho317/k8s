<%@ page import="java.io.*, java.net.*" %>
<html>
<head>
  <title>Submit Marks</title>
</head>
<body>
  <h2>Enter Marks</h2>
  <form method="post">
    Username: <input type="text" name="username"><br/>
    Physics: <input type="text" name="physics"><br/>
    Chemistry: <input type="text" name="chemistry"><br/>
    Maths: <input type="text" name="maths"><br/>
    <input type="submit" value="Submit">
  </form>

<%
  String method = request.getMethod();
  if ("POST".equalsIgnoreCase(method)) {
    String username = request.getParameter("username");
    String physics = request.getParameter("physics");
    String chemistry = request.getParameter("chemistry");
    String maths = request.getParameter("maths");

    try {
      String backendUrl = "http://backend:5000/api/marks";
      URL url = new URL(backendUrl);
      HttpURLConnection con = (HttpURLConnection) url.openConnection();
      con.setRequestMethod("POST");
      con.setRequestProperty("Content-Type", "application/json; utf-8");
      con.setDoOutput(true);

      String jsonInputString = String.format(
        "{\"username\":\"%s\", \"physics\":%s, \"chemistry\":%s, \"maths\":%s}",
        username, physics, chemistry, maths
      );

      try (OutputStream os = con.getOutputStream()) {
        byte[] input = jsonInputString.getBytes("utf-8");
        os.write(input, 0, input.length);
      }

      int responseCode = con.getResponseCode();
      out.println("<p>Backend response code: " + responseCode + "</p>");

      // Optional: read response
      BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
      String line;
      while ((line = in.readLine()) != null) {
        out.println("<p>" + line + "</p>");
      }
      in.close();

    } catch (Exception e) {
      out.println("<p>Error: " + e.getMessage() + "</p>");
    }
  }
%>
</body>
</html>

