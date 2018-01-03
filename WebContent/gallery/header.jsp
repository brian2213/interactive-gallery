<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Core CSS file -->
<link rel="stylesheet" href="dist/photoswipe.css">

<!-- Skin CSS file (styling of UI - buttons, caption, etc.)
     In the folder of skin CSS file there are also:
     - .png and .svg icons sprite, 
     - preloader.gif (for browsers that do not support CSS animations) -->
<link rel="stylesheet" href="dist/default-skin/default-skin.css">
<link rel="stylesheet" href="src/css/bootstrap.min.css">
<link rel="stylesheet" href="src/css/photoswipe.css">
<link rel="stylesheet" href="src/css/dropzone.css">
<!-- Core JS file -->
<script src="dist/photoswipe.min.js" type="text/javascript"></script>

<!-- UI JS file -->
<script src="dist/photoswipe-ui-default.min.js" type="text/javascript"></script>
<script src="src/js/jquery-3.2.1.slim.min.js" type="text/javascript"></script>
<script src="src/js/popper.min.js" type="text/javascript"></script>
<script src="src/js/bootstrap.min.js" type="text/javascript"></script>
<script src="src/js/dropzone.js" type="text/javascript"></script>
<style>
body { padding-top: 70px; 
margin-bottom: 60px;}
/* Finesse the page header spacing */

</style>
<title>Gallery</title>
</head>
<body>
<nav class="nav nav-pills navbar navbar-expand-md navbar-dark bg-dark fixed-top">
  <a class="flex-sm-fill text-sm-center nav-link active" href="gallery.jsp">Gallery</a>
  <a class="flex-sm-fill text-sm-center nav-link" href="findPage.jsp">Find Image</a>
  <a class="flex-sm-fill text-sm-center nav-link" href="artist.jsp">Artist</a>
  <a class="flex-sm-fill text-sm-center nav-link disabled" href="index.jsp">Index</a>
</nav>