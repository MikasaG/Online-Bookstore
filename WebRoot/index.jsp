<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"%>
<%@ page import="Entity.Items"%>
<%@ page import="DAO.ItemsDAO"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Online Book Store</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style type="text/css">
	   div{
	      float:left;
	      margin: 10px;
	   }
	   div dd{
	      margin:0px;
	      font-size:10pt;
	   }
	   div dd.dd_name
	   {
	      color:blue;
	   }
	   div dd.dd_origin
	   {
	      color:#000;
	   }
	</style>
  </head>
  
  <body>
    <h1>Book Store</h1>
    <hr>
    <center>
    <table width="750" height="60" cellpadding="0" cellspacing="0" border="0">
      <tr>
        <td>
           <% 
               ItemsDAO itemsDao = new ItemsDAO(); 
               ArrayList<Items> list = itemsDao.getAllItems();
               if(list!=null&&list.size()>0)
               {
	               for(int i=0;i<list.size();i++)
	               {
	                  Items item = list.get(i);
           %>   
          <div>
             <dl>
               <dt>
                 <a href="ItemDetail.jsp?id=<%=item.getId()%>"><img src="images/<%=item.getPic()%>" width="120" height="90" border="1"/></a>
               </dt>
               <dd class="dd_name"><%=item.getName() %></dd> 
               <dd class="dd_origin">Origin:<%=item.getOrigin() %>&nbsp;&nbsp;Price:$ <%=item.getPrice() %></dd> 
             </dl>
          </div>
          <%
                   }
              } 
          %>
        </td>
      </tr>
    </table>
    </center>
  </body>
</html>