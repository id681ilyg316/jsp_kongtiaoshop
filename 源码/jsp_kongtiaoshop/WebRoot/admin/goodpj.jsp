<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="util.Info"%>
<%@page import="util.PageManager"%>
<%@page import="dao.CommDAO"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="en">
  <head>
	<meta charset="utf-8">
    <title>后台管理系统</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <base href="<%=basePath%>">
    <meta name="description" content="Admin panel developed with the Bootstrap from Twitter.">
    <meta name="author" content="travis">
    
	<link rel="stylesheet" type="text/css" href="/kongtiaoshop/admin/lib/bootstrap/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="/kongtiaoshop/admin/stylesheets/theme.css">
    <link rel="stylesheet" href="/kongtiaoshop/admin/lib/font-awesome/css/font-awesome.css">

    <script src="/kongtiaoshop/admin/lib/jquery-1.7.2.min.js" type="text/javascript"></script>
	
    <!-- Demo page code -->

    <style type="text/css">
        #line-chart {
            height:300px;
            width:800px;
            margin: 0px auto;
            margin-top: 1em;
        }
        .brand { font-family: georgia, serif; }
        .brand .first {
            color: #ccc;
            font-style: italic;
        }
        .brand .second {
            color: #fff;
            font-weight: bold;
        }
    </style>

    <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

    <!-- Le fav and touch icons -->
    <link rel="shortcut icon" href="../assets/ico/favicon.ico">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="../assets/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="../assets/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="../assets/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="../assets/ico/apple-touch-icon-57-precomposed.png">

	
  </head>
  
  <body class="">
    
    <%
    CommDAO dao = new CommDAO(); 
	String gid = request.getParameter("gid");
	 String sql = "select * from pj where 1=1  and goodid="+gid;
	 String url = "/schoolseclivekongtiaojysys/admin/goodpj.jsp?1=1";
	 String key = request.getParameter("key")==null?"":request.getParameter("key");
	 String key1 = request.getParameter("key1")==null?"":request.getParameter("key1");
	 String f = request.getParameter("f");
	 if(f==null)
	 {
	 key = Info.getUTFStr(key);
	 }
	 if(!key.equals(""))
	 {
	 sql+=" and (title like'%"+key+"%')";
	 url+="&key="+key;
	 }
	 sql+=" order by id desc";
%>

	<jsp:include page="/admin/top.jsp"></jsp:include>
    
    <jsp:include page="/admin/left.jsp"></jsp:include>
    

    
       <div class="content">
        
        <div class="header">
            
            <h1 class="page-title">评价管理</h1>
        </div>
        
                <ul class="breadcrumb">
            <li><a href="admin/index.jsp">Home</a> <span class="divider">/</span></li>
            <li class="active">评价管理</li>
        </ul>

        <div class="container-fluid">
            <div class="row-fluid">
            <%String suc = (String)request.getAttribute("suc");
			if(suc!=null){%>
			    <div class="alert alert-info">
			        <button type="button" class="close" data-dismiss="alert">×</button>
			        	<%=suc %>
		    	</div>
			<%}%>
			
<div class="well">
    <table class="table">
      <thead>
        <tr>
          <th>内容</th>
          <th>评分</th>
          <th>时间</th>
          <th>评价人</th>
          <th>回复</th>
          <th>操作</th>
          <th style="width: 26px;"></th>
        </tr>
      </thead>
      <tbody>
      <%String did = request.getParameter("did");
      if(did!=null)
      {
   		dao.commOper("delete from  pj  where id="+did);
      }
      
      PageManager pageManager = PageManager.getPage(url,10, request);
      pageManager.doList(sql);
      PageManager bean= (PageManager)request.getAttribute("page");
      ArrayList<HashMap> list=(ArrayList)bean.getCollection();
      	for(HashMap map:list){
      		HashMap mmap = dao.select("select * from member where id="+map.get("memberid")).get(0);
	    %>
        <tr>
          <td><%=map.get("msg") %></td>
          <td><%=map.get("jb") %></td>
          <td><%=map.get("savetime") %></td>
          <td><%=mmap.get("tname") %></td>
          <td><%=map.get("hf") %></td>
          <td>
              
              <a href="admin/goodpjhf.jsp?id=<%=map.get("id") %>&gid=<%=gid %>"><i class="icon-pencil"></i></a>
              <a href="admin/goodpj.jsp?did=<%=map.get("id") %>" ><i class="icon-remove"></i></a>
          </td>
        </tr>
        <%} %>
      </tbody>
    </table>
</div>
<div class="pagination">
    ${page.info }
</div>

    <script src="/kongtiaoshop/admin/lib/bootstrap/js/bootstrap.js"></script>
  </body>
</html>
