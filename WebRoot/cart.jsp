<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"%>
<%@ page import="Entity.Cart" %>
<%@ page import="Entity.Items" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>Shopping Cart</title>
 	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
    <link type="text/css" rel="stylesheet" href="css/style1.css" />
    <script language="javascript">
	    function delcfm() {
	        if (!confirm("Do you really want to delete it？")) {
	            window.event.returnValue = false;
	        }
	    }
   </script>
  </head>
  
  <body>
   <h1>My Shopping Cart</h1>
   <a href="index.jsp">Main Page</a> >> <a href="index.jsp">Books List</a>
   <hr> 
   <div id="shopping">
   <form action="" method="">		
			<table>
				<tr>
					<th>Item Name</th>
					<th>Item Price</th>
					<th>Total Price</th>
					<th>Quantity</th>
					<th>Operation</th>
				</tr>
				<% 
				   if(request.getSession().getAttribute("cart")!=null)
				   {
				%>
				<!-- 循环的开始 -->
				     <% 
				         Cart cart = (Cart)request.getSession().getAttribute("cart");
				         HashMap<Items,Integer> goods = cart.getGoods();
				         Set<Items> items = goods.keySet();
				         Iterator<Items> it = items.iterator();
				         
				         while(it.hasNext())
				         {
				            Items i = it.next();
				     %> 
				<tr name="products" id="product_id_1">
					<td class="thumb"><a href="ItemDetail.jsp?id=<%=i.getId()%>"><img src="images/<%=i.getPic()%>" /><%=i.getName()%></a></td>
					<td class="number"><%=i.getPrice() %></td>
					<td class="price" id="price_id_1">
						<span><%=i.getPrice()*goods.get(i) %></span>
						<input type="hidden" value="" />
					</td>
					<td class="number">
                     	<%=goods.get(i)%>					
					</td>                        
                    <td class="delete">
					  <a href="servlet/CartServlet?action=delete&id=<%=i.getId()%>" onclick="delcfm();">Delete</a>					                  
					</td>
				</tr>
				     <% 
				         }
				     %>
				<!--循环的结束-->
				
			</table>
			 <div class="total"><span id="total">In Total:<%=cart.getTotalPrice() %>$</span></div>
			  <% 
			    }
			 %>
			<div class="button"><input type="submit" value="" /></div>
		</form>
	</div>
  </body>
</html>
