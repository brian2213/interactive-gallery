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
		String description = request.getParameter("idescription");
		String artist = request.getParameter("iartist");
		String type = request.getParameter("itype");
		String title = request.getParameter("ititle");
		String link = request.getParameter("ilink");
		String year = request.getParameter("iyear");
		String country = request.getParameter("ilocation");
		String galleryID = request.getParameter("galleryID");
		String height = "NA";
		String width = "NA";
		try {
			BufferedImage image;
			URL url = new URL(link);
			image = ImageIO.read(url);
			if (image == null) {
				out.println("link is not a image");
				return;
			}
			height = "" + image.getHeight();
			width = "" + image.getWidth();
			//System.out.println("Height : " + height);
			//System.out.println("Width : " + width);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
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
			
			pstmt = con.prepareStatement("update detail set year=?,type=?,height=?,width=?,location=?,description=? where image_id="+imageid ,
					Statement.RETURN_GENERATED_KEYS);
			pstmt.clearParameters();
			pstmt.setString(1, year);
			pstmt.setString(2, type);
			pstmt.setString(4, width);
			pstmt.setString(3, height);
			pstmt.setString(5, country);
			pstmt.setString(6, description);
			pstmt.executeUpdate();
			rs = pstmt.getGeneratedKeys();
			while (rs.next()) {
				out.println("Successfully Update. detail:" + rs.getInt(1));
				out.println("detail done");
			}
			
			pstmt = con.prepareStatement("update image set title=?,link=? where image_id="+imageid,
					Statement.RETURN_GENERATED_KEYS);
			pstmt.clearParameters();
			pstmt.setString(1, title);
			pstmt.setString(2, link);
			pstmt.executeUpdate();
			rs = pstmt.getGeneratedKeys();
			while (rs.next()) {
				out.println("Successfully Update. image:" + rs.getInt(1));
				out.println("image done");
			}
			
			/* pstmt = con.prepareStatement("delete from image where image_id=?", Statement.RETURN_GENERATED_KEYS);
			pstmt.clearParameters();
			pstmt.setString(1, imageid);
			pstmt.executeUpdate();
			rs = pstmt.getGeneratedKeys();
			while (rs.next()) {
				out.println("Image deleted");
			} */
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
<jsp:forward page = "gallery.jsp" />