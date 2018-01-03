<%@ page import="java.io.*,java.util.*, javax.servlet.*"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page
	import="java.awt.image.BufferedImage,java.net.URL,javax.imageio.ImageIO"%>
<%
	String description = request.getParameter("idescription");
	String artist = request.getParameter("iartist");
	String type = request.getParameter("itype");
	String title = request.getParameter("ititle");
	String link = request.getParameter("ilink");
	String year = request.getParameter("iyear");
	String country = request.getParameter("icountry");
	String galleryID=request.getParameter("galleryID");
	String height = "1080";
	String width = "1920";
	try {
		BufferedImage image;
		URL url = new URL(link);
		image = ImageIO.read(url);
		if (image == null) {
			
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
	try {
		ServletContext context = pageContext.getServletContext();
		String url = context.getInitParameter("mysqlurl");
		String id = context.getInitParameter("mysqlacc");
		String pwd = context.getInitParameter("mysqlpwd");
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		con = DriverManager.getConnection(url, id, pwd);
		pstmt = con.prepareStatement("insert into detail values (default,default,?,?,?,?,?,?)",
				Statement.RETURN_GENERATED_KEYS);
		pstmt.clearParameters();
		pstmt.setString(1, year);
		pstmt.setString(2, type);
		pstmt.setString(3, width);
		pstmt.setString(4, height);
		pstmt.setString(5, country);
		pstmt.setString(6, description);
		pstmt.executeUpdate();
		rs = pstmt.getGeneratedKeys();
		int detailid=-1;
		while (rs.next()) {
			out.println("Successfully added. Description:" + rs.getInt(1));
			detailid=rs.getInt(1);
		}
		
		
		if(detailid>0){
			
			int artistID=-1;
			pstmt=con.prepareStatement("select artist_id from artist where name='"+artist+"'");
			rs=pstmt.executeQuery();
			rs.next();
			try{
			artistID=rs.getInt(1);
			} catch (SQLException se) {
				// JDBC Error
				se.printStackTrace();
			} catch (Exception e) {
				// Class.forName Error
				e.printStackTrace();
			} 
			pstmt = con.prepareStatement("insert into image values (default,?,?,?,?,?)",
					Statement.RETURN_GENERATED_KEYS);
			pstmt.clearParameters();
			pstmt.setString(1, title);
			pstmt.setString(2, link);
			pstmt.setInt(4, artistID);
			pstmt.setInt(3, Integer.valueOf(galleryID));
			pstmt.setInt(5, detailid);
			pstmt.executeUpdate();
			rs = pstmt.getGeneratedKeys();
			int imageId=-1;
			while (rs.next()) {
				out.println("Successfully added. Image:" + rs.getInt(1));
				imageId=rs.getInt(1);
			}
			if(imageId>0){
				pstmt = con.prepareStatement("update detail set image_id=? where detail_id=?",
						Statement.RETURN_GENERATED_KEYS);
				pstmt.clearParameters();
				pstmt.setInt(2, detailid);
				pstmt.setInt(1, imageId);
				pstmt.executeUpdate();
				rs = pstmt.getGeneratedKeys();
				while (rs.next()) {
					out.println("Successfully updated. detail:" + rs.getInt(1));
				}
			}
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