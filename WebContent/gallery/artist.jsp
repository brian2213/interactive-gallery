<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="header.jsp"%>
<div class="container-fluid">
	<%
		
		String name = request.getParameter("name");
		String year = request.getParameter("year");
		String year2 = request.getParameter("year2");
		String country = request.getParameter("country");

		String namePredicate = name == null || name == "" ? "" : " name like('%" + name + "%') ";
		String countryPredicate = country == null || country == "" ? "" : " country like('%" + country + "%') ";
		String yearPredicate = year == null || year == "" ? "" : " birth_year>= " + year;
		String year2Predicate = year2 == null || year2 == "" ? "" : " birth_year<= " + year2;
		String ifWhere = countryPredicate.length() > 0 || namePredicate.length() > 0 || yearPredicate.length() > 0
				|| year2Predicate.length() > 0 ? " where " : "";

		Connection con = null;
		Statement stmt = null;
		try {
			ServletContext context = pageContext.getServletContext();
			String url = context.getInitParameter("mysqlurl");
			String id = context.getInitParameter("mysqlacc");
			String pwd = context.getInitParameter("mysqlpwd");
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			con = DriverManager.getConnection(url, id, pwd);
			stmt = con.createStatement();
			String sql = "SELECT * FROM artist" + ifWhere + countryPredicate
					+ (countryPredicate != "" && year2Predicate != "" ? " and " : "") + year2Predicate
					+ (yearPredicate != "" && year2Predicate != "" ? " and " : "") + yearPredicate
					+ (namePredicate != "" && year != "" ? " and " : "") + namePredicate;
			ResultSet rs = stmt.executeQuery(sql);
	%>

	<div class="row container">
		<h2>Artist</h2>
	</div>
	<div class="row container">
		<div class='col-md-2'>
			<button class='btn btn-primary' data-toggle="collapse"
				data-target="#demo">Filter</button>
			<div id="demo" class="collapse">
				<form action="artist.jsp">
					<div class="form-group">
						<label>Name</label> <input type="text" class="form-control"
							name='name' placeholder='e.q Anteater'>
					</div>
					<div class="form-group">
						<label>Country</label> <input type="text" class="form-control"
							name='country' placeholder='e.q US'>
					</div>
					<div class="form-group">
						<label>Birth Year</label> <input type="number"
							class="form-control" name='year' placeholder='From'> <input
							type="number" class="form-control" name='year2'
							placeholder='Until'>
					</div>
					<button type="submit" class="btn btn-primary">Apply Filter</button>
				</form>
			</div>
		</div>

		<div class='col-md-2'>
			<button class='btn btn-primary' data-toggle="collapse"
				data-target="#create">Add new artist</button>
		</div>
		<div id="create" class="collapse">
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
					<label for="exampleInputPassword1">Country</label> <input
						type="text" class="form-control" name='acountry'
						placeholder="Country">
				</div>
				<div class="form-group">
					<label for="exampleInputPassword1">Description</label> <input
						type="text" class="form-control" name='adescription'
						placeholder="Description for Artist">
				</div>
				<button type="submit" class="btn btn-primary">Create</button>
			</form>
		</div>

	</div>
</div>
<div class="row container" style='padding-top: 50px; padding-left: 30px'>

	<%
		while (rs.next()) {///generating photoswipe
	%>
	<a class='btn'
		href='modifyartistPage.jsp?artistid=<%=rs.getString("artist_id")%>'><%=rs.getString("name")%></a>
	<%
		}
	%>


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