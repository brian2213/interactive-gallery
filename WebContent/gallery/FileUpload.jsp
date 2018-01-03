<%@ page import="java.io.*,java.util.*, javax.servlet.*"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%@ page import="org.apache.commons.io.output.*"%>
<%@ page import="java.text.DateFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%
   File file ;
   int maxFileSize = 10000 * 1024;
   int maxMemSize = 10000 * 1024;
   ServletContext context = pageContext.getServletContext();
   DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	Date date = new Date();
   String id=session.getId();//sessionID avoid mutiusers but not grarantee uniquness per upload that UUID is more suitable
   String filePath = getServletContext().getRealPath("/")+"/gallery/image"+"/"+dateFormat.format(date)+"/"+id+"/";
   String fileName="";
   new File(filePath).mkdirs();
/*    System.out.print( request.getRemoteAddr() ); */
   //System.out.println( request.getRemoteHost() );
   // Verify the content type
   String contentType = request.getContentType();
   if ((contentType.indexOf("multipart/form-data") >= 0)) {

      DiskFileItemFactory factory = new DiskFileItemFactory();
      // maximum size that will be stored in memory
      factory.setSizeThreshold(maxMemSize);
      // Location to save data that is larger than maxMemSize.
     factory.setRepository(new File(getServletContext().getRealPath("/")+"temp"));  
     /*   factory.setRepository(new File("~/temp/")); */

      // Create a new file upload handler
      ServletFileUpload upload = new ServletFileUpload(factory);
      // maximum file size to be uploaded.
      upload.setSizeMax( maxFileSize );
      
      
      try{ 
         // Parse the request to get file items.
         List fileItems = upload.parseRequest(request);

         // Process the uploaded file items
         Iterator i = fileItems.iterator();

       /*   out.println("<html>");
         out.println("<head>");
         out.println("<title>JSP File upload</title>");  
         out.println("</head>");
         out.println("<body>"); */
         while ( i.hasNext () ) 
         {
            FileItem fi = (FileItem)i.next();
            if ( !fi.isFormField () )	
            {
            // Get the uploaded file parameters
            String fieldName = fi.getFieldName();
             fileName = fi.getName();
            boolean isInMemory = fi.isInMemory();
            long sizeInBytes = fi.getSize();
            // Write the file
            if( fileName.lastIndexOf("\\") >= 0 ){
            file = new File( filePath + 
            fileName.substring( fileName.lastIndexOf("\\"))) ;
            }else{
            file = new File( filePath + 
            fileName.substring(fileName.lastIndexOf("\\")+1)) ;
            }
            fi.write( file ) ;
            
            session.setAttribute("fileName", filePath+fileName);
           /*  out.println("Uploaded Filename: " + filePath + 
            fileName + "<br>"); */
            }
         }
   /*       out.println("</body>");
         out.println("</html>"); */
      }catch(Exception ex) {
         System.out.println(ex);
       
      }
   }else{
	

   }
   String url=request.getRequestURL().toString().substring(0,request.getRequestURL().toString().lastIndexOf("/"));
   out.println(url+"/image"+"/"+dateFormat.format(date)+"/"+id+"/"+fileName);
%>