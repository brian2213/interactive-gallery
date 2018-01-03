<%@ page import="java.io.*,java.util.*, javax.servlet.*"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page
	import="java.awt.image.BufferedImage,java.net.URL,javax.imageio.ImageIO"%>
<%@include file="header.jsp"%>
<div class="container-fluid">
	<%
		String artistid = request.getParameter("artistid");
		String description = request.getParameter("adescription");
		String name = request.getParameter("aname");
		String year = request.getParameter("ayear");
		String country = request.getParameter("alocation");
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Statement disableSafe = null;
		Statement enableSafe = null;
		try {
			ServletContext context = pageContext.getServletContext();
			String url = context.getInitParameter("mysqlurl");
			String id = context.getInitParameter("mysqlacc");
			String pwd = context.getInitParameter("mysqlpwd");
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			con = DriverManager.getConnection(url, id, pwd);
			disableSafe = con.createStatement();
			enableSafe = con.createStatement();
			disableSafe.execute("SET SQL_SAFE_UPDATES=0");
			
			pstmt = con.prepareStatement("update artist set name=?,birth_year=?,country=?,description=? where artist_id="+artistid ,
					Statement.RETURN_GENERATED_KEYS);
			pstmt.clearParameters();
			pstmt.setString(1, name);
			pstmt.setString(2, year);
			pstmt.setString(3, country);
			pstmt.setString(4, description);
			pstmt.executeUpdate();
			rs = pstmt.getGeneratedKeys();
			while (rs.next()) {
				out.println("Successfully Update. artist:" + rs.getInt(1));
				out.println("detail done");
			}
			
			disableSafe.execute("SET SQL_SAFE_UPDATES=1");
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
				try {
					disableSafe.execute("SET SQL_SAFE_UPDATES=1");
				} catch (Exception e) {

				}
				if (enableSafe != null)
					enableSafe.close();
				if (disableSafe != null)
					disableSafe.close();
			} catch (SQLException se2) {
			} // Do nothing
			try {
				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();
				if (enableSafe != null)
					enableSafe.close();
				if (disableSafe != null)
					disableSafe.close();
			} catch (SQLException se) {
				se.printStackTrace();
			}
		}
	%>
</div>
<jsp:forward page = "artist.jsp" />