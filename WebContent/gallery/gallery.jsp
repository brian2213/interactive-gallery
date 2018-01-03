<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="header.jsp"%>
<div class="container-fluid">
	<div class="row container">

		<button class='btn btn-primary' data-toggle="collapse"
			data-target="#demo">Add new gallery</button>
	</div>
	<div class='row container'>
		<div id="demo" class="collapse">
			<form action="creategallery.jsp">
				<div class="form-group">
					<label for="exampleInputEmail1">Name</label> <input type="text"
						class="form-control" name='gname' placeholder="Enter Gallery name">
				</div>
				<div class="form-group">
					<label for="exampleInputPassword1">Description</label> <input
						type="text" class="form-control" name='gdescription'
						placeholder="Description for Gallery">
				</div>
				<button type="submit" class="btn btn-primary">Create</button>
			</form>
		</div>
	</div>
	<div class='row' style='padding-top:10px'>
	<%
		Connection con = null;
		Statement stmt = null;
		Statement stmt2 = null;
		try {
			ServletContext context = pageContext.getServletContext();
			String url = context.getInitParameter("mysqlurl");
			String id = context.getInitParameter("mysqlacc");
			String pwd = context.getInitParameter("mysqlpwd");
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			con = DriverManager.getConnection(url, id, pwd);
			stmt = con.createStatement();
			stmt2 = con.createStatement();
			String sql = "SELECT * FROM gallery";
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				out.println("<ul class='list-group' style='padding-left:10px'>");
				Statement temp = con.createStatement();
				ResultSet tempset = temp.executeQuery(
						"select count(*) cn from image where gallery_id=" + rs.getString("gallery_id"));
				tempset.next();
	%>
	<li class='list-group-item' ><a class='btn btn-success'
		href='image.jsp?id=<%=rs.getString("gallery_id")%>' role='button'>
			<%=rs.getString("name")%> <span class="badge badge-dark"><%=tempset.getString("cn")%></span>
	</a>
		<hr> <span><%=rs.getString("description")%></span> <a
		class='btn btn-warning btn-sm'
		href='modifygalleryPage.jsp?id=<%=rs.getString("gallery_id")%>'>
			Modify</a></li>
	<%

	out.println("</ul>");
		temp.close();
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
				if (stmt != null)
					stmt.close();
				if (stmt2 != null)
					stmt2.close();
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
</div>
</div>
<%@include file="footer.jsp"%>