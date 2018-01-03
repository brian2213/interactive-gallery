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
			rs = fetch.executeQuery("select * from artist where artist_id=" + artistid);
			while (rs.next()) {
	%>
	<form action="modifyartist.jsp">
		<div class="form-group">
			<label for="exampleInputEmail1">Name</label> <input type="text"
				class="form-control" name='aname'
				value="<%=rs.getString("name")%>">
		</div>
		<div class="form-group">
			<label for="exampleInputPassword1">Year</label> <input
				type="number" class="form-control" name='ayear'
				value="<%=rs.getInt("birth_year")%>">
		</div>
		<div class="form-group">
			<label for="exampleInputPassword1">Country</label> <input
				type="text" class="form-control" name='alocation'
				value="<%=rs.getString("country")%>">
		</div>
		<div class="form-group">
			<label for="exampleInputPassword1">Description</label> <input
				type="text" class="form-control" name='adescription'
				value="<%=rs.getString("description")%>">
		</div>
		<input type="hidden" name="artistid" value="<%=artistid%>">
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