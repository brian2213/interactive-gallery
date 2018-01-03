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
		String imageid = request.getParameter("imageid");

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
			rs = fetch.executeQuery("select * from image natural join detail where image_id=" + imageid);
			while (rs.next()) {
	%>
	<img src='<%=rs.getString("link")%>'>
	<form action="modifyimage.jsp">
		<div class="form-group">
			<label for="exampleInputEmail1">Title</label> <input type="text"
				class="form-control" name='ititle'
				value="<%=rs.getString("title")%>">
		</div>
		<div class="form-group">
			<label for="exampleInputPassword1">Link</label> <input
				type="url" class="form-control" name='ilink'
				value="<%=rs.getString("link")%>">
		</div>
		<div class="form-group">
			<label for="exampleInputPassword1">Type</label> <input
				type="text" class="form-control" name='itype'
				value="<%=rs.getString("type")%>">
		</div>
		<div class="form-group">
			<label for="exampleInputPassword1">Year</label> <input
				type="number" class="form-control" name='iyear'
				value="<%=rs.getInt("year")%>">
		</div>
		<div class="form-group">
			<label for="exampleInputPassword1">Location</label> <input
				type="text" class="form-control" name='ilocation'
				value="<%=rs.getString("location")%>">
		</div>
		<div class="form-group">
			<label for="exampleInputPassword1">Description</label> <input
				type="text" class="form-control" name='idescription'
				value="<%=rs.getString("description")%>">
		</div>
		<input type="hidden" name="imageid" value="<%=imageid%>">
		<button type="submit" class="btn btn-primary">Modify</button>
	</form>
	<%
		}
			/* pstmt = con.prepareStatement("delete from image where image_id=?", Statement.RETURN_GENERATED_KEYS);
			pstmt.clearParameters();
			pstmt.setString(1, imageid);
			pstmt.executeUpdate();
			rs = pstmt.getGeneratedKeys();
			while (rs.next()) {
				out.println("Image deleted");
			} */
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