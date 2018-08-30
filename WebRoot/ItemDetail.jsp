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
	<link href="css/main.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="js/lhgcore.js"></script>
    <script type="text/javascript" src="js/lhgdialog.js"></script>
    <script type="text/javascript">
      function selflog_show(id)
      { 
         var quan =  document.getElementById("quantity").value; 
         J.dialog.get({id: 'haoyue_creat',title: 'Purchased Successful',width: 600,height:400, link: '<%=path%>/servlet/CartServlet?id='+id+'&quantity='+quan+'&action=add', cover:true});
      }
      function add()
      {
         var quan = parseInt(document.getElementById("quantity").value);
         if(quan<100)
         {
            document.getElementById("quantity").value = ++quan;
         }
      }
      function sub()
      {
         var quan = parseInt(document.getElementById("quantity").value);
         if(quan>1)
         {
            document.getElementById("quantity").value = --quan;
         }
      }
     
    </script>
	
    <style type="text/css">
	   hr{
	     
	     border-color:FF7F00; 
	   }
	   
	   div{
	      float:left;
	      margin-left: 30px;
	      margin-right:30px;
	      margin-top: 5px;
	      margin-bottom: 5px;
	     
	   }
	   div dd{
	      margin:0px;
	      font-size:10pt;
	   }
	   div dd.dd_name
	   {
	      color:blue;
	   }
	   div dd.dd_city
	   {
	      color:#000;
	   }
	   div #cart
	   {
	     margin:0px auto;
	     text-align:right; 
	   }
	   span{
	     padding:0 2px;border:1px #c0c0c0 solid;cursor:pointer;
	   }
	   a{
	      text-decoration: none; 
	   }
	</style>
  </head>
  
  <body>
    <h1>Book Detail</h1>
    <a href="index.jsp">Main Page</a> >> <a href="index.jsp">Books List</a>
    <hr>
    <center>
    <table width="750" height="60" cellpadding="0" cellspacing="0" border="0">
      <tr>
      <% 
      			request.setCharacterEncoding("utf-8");
               	ItemsDAO itemsDao = new ItemsDAO(); 
				Items item = itemsDao.getItemsById(Integer.parseInt(request.getParameter("id")));
				if (item != null) {
           %>   
        <td width="70%" valign="top">
          <table>
          	<tr>
          		<td rowspan="4"><img src="images/<%= item.getPic() %>" width="200" height="160"/></td>
          	</tr>
          	<tr>
          		<td><B><%=item.getName() %></B></td>
          	</tr>
          	<tr>
          		<td>Origin: <%=item.getOrigin() %></td>		
          	</tr>
          	<tr>
          		<td>Price: <%=item.getPrice() %></td>		
          	</tr>
          	<tr> <!-- 下面这句是一个有加减按钮的输入框的套用语句，配合上面的fuction -->
                 <td>Quantity：<span id="sub" onclick="sub();">-</span><input type="text" id="quantity" name="quantity" value="1" size="2"/><span id="add" onclick="add();">+</span></td>
            </tr> 
          </table>
          <div id="cart">
               <img src="images/buy_now.png"><a href="javascript:selflog_show(<%=item.getId() %>)"><img src="images/in_cart.png"></a><a href="servlet/CartServlet?action=show"><img src="images/view_cart.jpg"/></a>
          </div>
          <%
                  }
          %>
        </td>
        <%
        	String CookieList = "";
        	Cookie[] cookies = request.getCookies();
        	 if(cookies!=null&&cookies.length>0) {
        	 	for (Cookie c:cookies) {
					if (c.getName().equals("BooksViewedCookie")) {
						CookieList = c.getValue();
						break;
					}        	
        		}
        	 }
        	if (CookieList.equals("")) {
        		CookieList = request.getParameter("id");
        	} else if (CookieList.charAt(CookieList.length() - 1) != request.getParameter("id").charAt(0)){
        		CookieList +=  "#" + request.getParameter("id");
        		String[] arr = CookieList.split("#");
	        	if (arr != null && arr.length > 100) {
	        		int l = arr.length;
	        		CookieList = "";
	        		for (int i = 20; i > 1; i--){
	        			CookieList += arr[l-i]+"#";
	        		}
	        		CookieList += arr[l-1];
	        	}
	        	assert(!CookieList.equals(""));
	        	Cookie cookie = new Cookie("BooksViewedCookie", CookieList);
	        	response.addCookie(cookie);    
        	}
        	
         %>
          <td width="30%" bgcolor="#EEE" align="center">
             <br>
             <b>Viewd History</b><br>
             <% 
                ArrayList<Items> itemlist = itemsDao.getViewedList(CookieList,5);
                if(itemlist!=null&&itemlist.size()>0 )
                {
                   for(Items i:itemlist)
                   {      
             %>
             <div>
             <dl>
               <dt>
                 <a href="ItemDetail.jsp?id=<%=i.getId()%>"><img src="images/<%=i.getPic() %>" width="120" height="90" border="1"/></a>
               </dt>
               <dd class="dd_name"><%=i.getName() %></dd> 
               <dd class="dd_origin">Origin:<%=i.getOrigin() %>&nbsp;&nbsp;Price:<%=i.getPrice() %> $ </dd> 
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