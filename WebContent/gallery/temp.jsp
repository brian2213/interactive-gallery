<%@ page import="java.io.*,java.util.*, javax.servlet.*"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page
	import="java.awt.image.BufferedImage,java.net.URL,javax.imageio.ImageIO"%>
<%@include file="header.jsp"%>
<div class="container-fluid">
	
	<%= getServletContext().getRealPath("/") %> 
	<br>
	<%=request.getContextPath() %>
	<br>
	<%=request.getRequestURL().toString().substring(0,request.getRequestURL().toString().lastIndexOf("/")+1)%>
	<img src='http://localhost:8080/MP2/gallery/image/2017-11-02/526E0108CAF9FD85F0E5280CBD061493/test.png'>
					<form action="FileUpload.jsp" method="post"
						enctype="multipart/form-data">
						<input type="file" name="file" size="5000" /> <br /> <input
							type="submit" value="Upload File" />
					</form>
</div>
<%@include file="footer.jsp"%>