<%@ page import="java.util.List" %>
<%@ page import="action.user.ShoppingCartAction" %><%--
  Created by IntelliJ IDEA.
  User: gala
  Date: 2016/3/14
  Time: 14:00
  To change this template use File | Settings | File Templates.
--%>
<%@include file="/commontop.jsp"%>
<%
    int num_item = Integer.parseInt(request.getParameter("num_item")==null?(String)request.getAttribute("num_item"):request.getParameter("num_item"));
    int num = request.getSession().getAttribute("num")==null?num_item:(int) request.getSession().getAttribute("num");//有两个值可选

    if (session.getAttribute("isFromCart") != null) {
        num = num_item;
    }

    //注意要及时移除session值
    session.removeAttribute("isFromCart");

    List productDess =(List) request.getSession().getAttribute("productDess");
    List itemDess =(List) request.getSession().getAttribute("itemDess");
    List productPicUrls =(List) request.getSession().getAttribute("productPicUrls");


    List productHtmlNames = (List) request.getSession().getAttribute("productHtmlNames");

    String itemId =request.getParameter("itemId")==null?(String)request.getAttribute("itemId"):request.getParameter("itemId");
    int stock = Integer.parseInt(request.getParameter("stock")==null?(String)request.getAttribute("stock"):request.getParameter("stock"));
    String itemPrice = request.getParameter("itemPrice")==null?(String)request.getAttribute("itemPrice"):request.getParameter("itemPrice");

%>
<div id="Catalog">
    <table>
        <tr>
            <td><image src=<%=productPicUrls.get(num)%>><%=productDess.get(num)%></td>
        </tr>
        <tr>
            <td><b> <%=itemId%> </b></td>
        </tr>
        <tr>
            <td><b><font size="4"> <%=itemDess.get(num_item)%></font></b></td>
        </tr>
        <tr>
            <td><%=productHtmlNames.get(num)%></td>
        </tr>2
        <tr>
            <td><%=stock%> in stock.</td>
        </tr>
        <tr>
            <td><%=itemPrice%></td>
        </tr>
        <%
            out.println("<tr><td><a href=ShoppingCartAction?itemId="+itemId
                    +"&stock="+stock
                    +"&itemId="+itemId
                    +"&itemPrice="+itemPrice
                    +"&is_add="+"true"
                    +"&productName="+request.getSession().getAttribute("productName")
                    +" class='Button'"+">"
                    +"Add to Cart"+"</a></td></tr>");
        %>

    </table>
    <%--<%
        out.println("<img src="+productPicUrls.get(num)+">");//图片
        out.println("<p>"+productDess.get(num)+"</p>");
        out.println("<p>"+itemId+"</p>");
        out.println("<p>"+itemDess.get(num_item)+"</p>");
        out.println("<p>"+productHtmlNames.get(num)+"</p>");
        out.println("<p>"+stock+" in stock</p>");
        out.println("<p>"+itemPrice+"</p>");
    %>--%>
</div>
<%@include file="/commonbottom.jsp"%>
