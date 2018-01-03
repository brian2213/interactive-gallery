<%@ page import="java.io.*,java.util.*, javax.servlet.*"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page
	import="java.awt.image.BufferedImage,java.net.URL,javax.imageio.ImageIO"%>
<%@include file="header.jsp"%>
<div class="container-fluid">
	
	<form action="image.jsp">
		<div class="form-group">
			<label>Type</label> <input type="text" class="form-control"
				name='type' placeholder='e.q Animal'>
		</div>
		<div class="form-group">
			<label>Year</label> <input type="number" class="form-control"
				name='year' placeholder='From'>
				<input type="number" class="form-control"
				name='year2' placeholder='Until'>
		</div>
		<div class="form-group">
			<label>Location</label> <input type="text" class="form-control"
				name='location' placeholder='e.q US'>
		</div>
		<div class="form-group">
			<label>Artist</label> <input type="text" class="form-control"
				name='artist' placeholder='e.q Anteater'>
		</div>
		<button type="submit" class="btn btn-primary">Apply Filter</button>
	</form>
</div>
<%@include file="footer.jsp"%>