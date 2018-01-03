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
		String galleryid = request.getParameter("id");

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Statement fetch = null;
		try {
			ServletContext context = pageContext.getServletContext();
			String url = context.getInitParameter("mysqlurl");
			String id = context.getInitParameter("mysqlacc");
			String pwd = context.getInitParameter("mysqlpwd");
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			con = DriverManager.getConnection(url, id, pwd);
			fetch = con.createStatement();
			rs = fetch.executeQuery("select * from gallery where gallery_id=" + galleryid);
			while (rs.next()) {
	%>
	<form action="modifygallery.jsp">
		<div class="form-group">
			<label for="exampleInputEmail1">Title</label> <input type="text"
				class="form-control" name='name' value="<%=rs.getString("name")%>">
		</div>
		<div class="form-group">
			<label for="exampleInputPassword1">Description</label> <input
				type="text" class="form-control" name='description'
				value="<%=rs.getString("description")%>">
		</div>
		<input type="hidden" name="galleryid" value="<%=galleryid%>">
		<button type="submit" class="btn btn-primary">Modify</button>
	</form>
	<%
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
				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();
				} catch (SQLException se) {
				se.printStackTrace();
			}
		}
	%>
</div>
<%@include file="footer.jsp"%>