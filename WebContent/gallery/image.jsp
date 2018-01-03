<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="header.jsp"%>
<div class="container-fluid">
	<%
		String galleryID = request.getParameter("id");
		String year = request.getParameter("year");
		String year2 = request.getParameter("year2");
		String location = request.getParameter("location");
		String artist = request.getParameter("artist");//
		String type = request.getParameter("type");//

		String artistPredicate = artist == null || artist == "" ? "" : " where name like ('%" + artist + "%')";

		String yearPredicate = year == null || year == "" ? "" : " year>= " + year;
		String year2Predicate = year2 == null || year2 == "" ? "" : " year<= " + year2;
		String typePredicate = type == null || type == "" ? "" : " type in ('" + type + "') ";
		String locationPredicate = location == null || location == "" ? "" : " location in ('" + location + "') ";
		String idPredicate = galleryID == null || galleryID == "" ? "" : " gallery_id = " + galleryID;

		String ifWhere = yearPredicate != "" || year2Predicate != "" || typePredicate != "" || locationPredicate != ""
				|| idPredicate != "" ? " where " : "";

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

			String innersql = "select title,year,type,artist_id,image_id,detail_id,name,link,height,width,description from image natural join (select artist_id,name from artist "
					+ artistPredicate + ") as a natural join detail " + ifWhere + year2Predicate
					+ (yearPredicate != "" && year2Predicate != "" ? " and " : "") + yearPredicate
					+ (typePredicate != "" && year != "" ? " and " : "") + typePredicate
					+ (typePredicate != "" && locationPredicate != "" ? " and " : "") + locationPredicate
					+ (locationPredicate != "" && idPredicate != "" ? " and " : "") + idPredicate;
			ResultSet rs2 = stmt2.executeQuery(innersql);
	%>

	<div class="row container">
		<h2>Gallery</h2>
	</div>
	<div class="row container">

		<button class='btn btn-primary' data-toggle="collapse"
			data-target="#demo">Add new image</button>
	</div>
	<div class='row container'>
		<div id="demo" class="collapse">
			<form action="FileUpload.jsp" class="dropzone">
			</form>
			<form action="createimage.jsp">
				<div class="form-group">
					<label>Title</label> <input type="text" class="form-control"
						name='ititle' placeholder="Enter image title">
				</div>
				<div class="form-group">
					<label>Link</label> <input id="urllink" type="url" class="form-control"
						name='ilink' placeholder="Enter image link">
				</div>
				<div class="form-group">
					<label>Artist</label> <input type="text" class="form-control"
						name='iartist' placeholder="Enter artist name">
				</div>
				<div class="form-group">
					<label>Type</label> <input type="text" class="form-control"
						name='itype' placeholder="Enter image type">
				</div>
				<div class="form-group">
					<label>Year</label> <input type="number" class="form-control"
						name='iyear' placeholder="Enter image year">
				</div>
				<div class="form-group">
					<label>Country</label> <input type="text" class="form-control"
						name='icountry' placeholder="Enter country">
				</div>
				<div class="form-group">
					<label>Description</label> <input type="text" class="form-control"
						name='idescription' placeholder="Description for image">
				</div>
				<input type="hidden" name="galleryID" value="<%=galleryID%>">
				<button type="submit" class="btn btn-primary">Create</button>
			</form>
		</div>
	</div>
</div>
<div class="row container" style='padding-top: 50px; padding-left: 30px'>
	<div class="my-gallery" itemscope
		itemtype="http://schema.org/ImageGallery">

		<%
			while (rs2.next()) {///generating photoswipe
		%>
		<figure itemprop="associatedMedia" itemscope
			itemtype="http://schema.org/ImageObject">
			<a href='<%=rs2.getString("link")%>' itemprop="contentUrl"
				data-size='<%=rs2.getString("width")%>x<%=rs2.getString("height")%>'>
				<img src='<%=rs2.getString("link")%>' itemprop="thumbnail"
				alt='<%=rs2.getString("description")%>' />
			</a>
			<figcaption itemprop="caption description">
				Title:
				<%=rs2.getString("title")%>
				<br> <span itemprop="copyrightHolder">Artist: <a
					href="modifyartistPage.jsp?artistid=<%=rs2.getString("artist_id")%>"><%=rs2.getString("name")%></a></span>
				<br> Year:
				<%=rs2.getString("year")%>
				<br> Type:
				<%=rs2.getString("type")%>
				<br> Description:
				<%=rs2.getString("description")%>
				<br> <a class='btn btn-warning'
					href='modifyimagePage.jsp?imageid=<%=rs2.getString("image_id")%>'>
					modify</a> <a class='btn btn-danger'
					href='deleteimage.jsp?imageid=<%=rs2.getString("image_id")%>'>
					delete</a>
			</figcaption>
			<span>Title: <%=rs2.getString("title")%></span>
			<br>
			<%-- <span itemprop="copyrightHolder">Artist: <a
				href="artist.jsp?id=<%=rs2.getString("artist_id")%>"><%=rs2.getString("name")%></a></span> --%>

		</figure>

		<%
			}
		%>

	</div>
	<%@include file="photoswipe.jsp"%>

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