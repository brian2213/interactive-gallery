<%@ page import="java.io.*,java.util.*, javax.servlet.*"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%
	String name = request.getParameter("gname");
	String description = request.getParameter("gdescription");

	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	try {
		ServletContext context = pageContext.getServletContext();
		String url = context.getInitParameter("mysqlurl");
		String id = context.getInitParameter("mysqlacc");
		String pwd = context.getInitParameter("mysqlpwd");
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		con = DriverManager.getConnection(url, id, pwd);
		pstmt = con.prepareStatement("insert into gallery values (default,?,?)",
				Statement.RETURN_GENERATED_KEYS);
		pstmt.clearParameters();
		pstmt.setString(1, name);
		pstmt.setString(2, description);
		pstmt.executeUpdate();
		rs = pstmt.getGeneratedKeys();
		while (rs.next()) {
			out.println("Successfully added. Gallery:" + name);
		}
		con.close();//close connection
	} catch (SQLException se) {
		// JDBC Error
		se.printStackTrace();
	} catch (Exception e) {
		// Class.forName Error
		e.printStackTrace();
	} finally {
		// close resource
		try {
			if (pstmt != null)
				pstmt.close();
		} catch (SQLException se2) {
		} // Do nothing
		try {
			if (con != null)
				con.close();
		} catch (SQLException se) {
			se.printStackTrace();
		}
	}
%>
<jsp:forward page = "gallery.jsp" />