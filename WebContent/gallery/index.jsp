<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="header.jsp"%>
<div class="container-fluid">

<h1><a class='btn btn-warning' href="http://54.213.213.63:8080/MP2/gallery/index.jsp">Demo link(click me) deployed on AWS</a></h1>
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
			out.println("<h4>1.List all the galleries (including name and descriptions).</h2>");
			out.println("<ul class='list-group'>");
			while (rs.next()) {
				out.println("<li class='list-group-item'> Name:" + rs.getString("name") + " Description:"
						+ rs.getString("description") + "</li>");
			}
			out.println("</ul>");/* 
			rs = stmt.executeQuery("SELECT * FROM artist");
			out.println("<h4>List all the artists</h2>");
			out.println("<ul class='list-group'>");
			while (rs.next()) {
				out.println("<li class='list-group-item'> Name:" + rs.getString("name") + " Year:"
						+ rs.getString("birth_year") + " Country:" + rs.getString("country") + " Description:"
						+ rs.getString("description") + "</li>");
			}
			out.println("</ul>"); */

			rs = stmt.executeQuery("SELECT * FROM gallery");
			out.println("<h4>2.List all the images and the number of images in a gallery (Click to show images)</h2>");
			out.println("<ul class='list-group'>");
			while (rs.next()) {
				Statement temp = con.createStatement();
				ResultSet tempset = temp.executeQuery(
						"select count(*) cn from image where gallery_id=" + rs.getString("gallery_id"));
				tempset.next();
				out.println("<li class='list-group-item'><a class='btn btn-primary' href='image.jsp?id="
						+ rs.getString("gallery_id") + "' role='button'>" + rs.getString("name")
						+ "</a><hr><span>Number of images " + tempset.getString("cn") + "</span></li>");
				temp.close();

			}
			out.println("</ul>");
			out.println(
					"<h4>3.List the details of a given image (This function should be a link from the result of function 2. It should show the picture, the artist name, and all the details of the artwork.)</h2>");
			out.println("<p>By clicking the image at problem 2.</p>");
			out.println(
					"<h4>4. List the details of an artist. (This function should be a link from the result of function 3.)</h2>");
			out.println("<p>By clicking the desired artist at <a class='btn btn-primary' href='artist.jsp'>artist</a>.</p>");
			out.println("<h4>5.Creating new Gallery</h4>");
	%>
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
	<%
		out.println("<h4>6.Creating new Artist</h4>");
	%>
	<form action="createartist.jsp">
		<div class="form-group">
			<label for="exampleInputEmail1">Name</label> <input type="text"
				class="form-control" name='aname' placeholder="Enter Artist name">
		</div>
		<div class="form-group">
			<label for="exampleInputPassword1">Birth Year</label> <input
				type="number" class="form-control" name='ayear'
				placeholder="Birth Year">
		</div>
		<div class="form-group">
			<label for="exampleInputPassword1">Country</label> <input type="text"
				class="form-control" name='acountry' placeholder="Country">
		</div>
		<div class="form-group">
			<label for="exampleInputPassword1">Description</label> <input
				type="text" class="form-control" name='adescription'
				placeholder="Description for Artist">
		</div>
		<button type="submit" class="btn btn-primary">Create</button>
	</form>
	<h4>7. Add a new image to a gallery. To simplify, you can just
		input the link of the picture instead of actually uploading it. This
		function should also input the artist_id, and input all the details of
		the image.</h4>
	<span>Go into any one of the gallery and click the add new image button you can either use a link or upload the image(ex. <a class='btn btn-primary' href='image.jsp?id=1'>sample</a>)</span>
	<h4>8. Delete an image from the gallery. You should also delete
		the details of the image but not the artist.</h4>
	Click the delete button after clicking the desirable image in a gallery. (ex. <a class='btn btn-primary' href='image.jsp?id=1#&gid=1&pid=1'>sample</a>)
	<h4>9. Modify the details of an image (including title and link).</h4>
	Click the modify button after clicking the desirable image in a gallery. (ex. <a class='btn btn-primary' href='image.jsp?id=1#&gid=1&pid=1'>sample</a>)
	<h4>10. Modify the details of an artist.</h4>
	Go to artist page and click the desired artist to modify. (ex. <a class='btn btn-primary' href='modifyartistPage.jsp?artistid=1'>sample</a>)
	<h4>11. Modify the title and description of a gallery.</h4>
	Go to gallery page and click modify button. (ex. <a class='btn btn-primary' href='modifygalleryPage.jsp?id=1'>sample</a>)
	<h4>12. Find the images by type (“Find” means to list all the
		results.)</h4>
	Go to find image page (ex. <a class='btn btn-primary' href='modifygalleryPage.jsp?id=1'>sample</a>)
	<h4>13. Find the images by a given range of creation year.</h4>
	Go to find image page (ex. <a class='btn btn-primary' href='modifygalleryPage.jsp?id=1'>sample</a>)
	<h4>14. Find the images by artist name.</h4>
	Go to find image page (ex. <a class='btn btn-primary' href='modifygalleryPage.jsp?id=1'>sample</a>)
	<h4>15. Find the images by location.</h4>
	Go to find image page (ex. <a class='btn btn-primary' href='modifygalleryPage.jsp?id=1'>sample</a>)
	<h4>16. Find the artists by country.</h4>
	Go to artist page (ex. <a class='btn btn-primary' href='artist.jsp'>sample</a>)
	<h4>17. Find the artists by birth year.</h4>
	Go to artist page (ex. <a class='btn btn-primary' href='artist.jsp'>sample</a>)
	<h4>Upload</h4>
	Go into any one of the gallery and click the add new image button you can either use a link or upload the image(ex. <a class='btn btn-primary' href='image.jsp?id=1'>sample</a>)
	<%
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
<%@include file="footer.jsp"%>