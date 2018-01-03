<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
    // JDBC 驱动名及数据库 URL
      String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
      String DB_URL = "jdbc:mysql://localhost:3306/test01";
 
    // 数据库的用户名与密码，需要根据自己的设置
      String USER = "brian";
      String PASS = "brian";
      
      Connection conn = null;
      Statement stmt = null;
      try{
          // 注册 JDBC 驱动
          Class.forName("com.mysql.jdbc.Driver");
      
          // 打开链接
          out.println("连接数据库...");
          conn = DriverManager.getConnection(DB_URL,USER,PASS);
            // 执行查询
          out.println(" 实例化Statement对...");
          stmt = conn.createStatement();
          String sql;
          sql = "SELECT id, name, url FROM websites";
          ResultSet rs = stmt.executeQuery(sql);
      
          // 展开结果集数据库
          while(rs.next()){
              // 通过字段检索
              int id  = rs.getInt("id");
              String name = rs.getString("name");
              String url = rs.getString("url");
  
              // 输出数据
              out.print("ID: " + id);
              out.print(", 站点名称: " + name);
              out.print(", 站点 URL: " + url);
              out.print("\n");
          }
          // 完成后关闭
          rs.close();
          stmt.close();
          conn.close();
      }catch(SQLException se){
          // 处理 JDBC 错误
          se.printStackTrace();
      }catch(Exception e){
          // 处理 Class.forName 错误
          e.printStackTrace();
      }finally{
          // 关闭资源
          try{
              if(stmt!=null) stmt.close();
          }catch(SQLException se2){
          }// 什么都不做
          try{
              if(conn!=null) conn.close();
          }catch(SQLException se){
              se.printStackTrace();
          }
      }
      out.println("Goodbye!");
    %>
</body>
</html>