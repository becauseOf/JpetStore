<%@ page import="java.util.List" %>
<%@ page import="bean.pets.EntityItem" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="action.pets.PetsInfoAction" %>
<%@ page import="action.user.ShoppingCartAction" %><%--
  Created by IntelliJ IDEA.
  User: gala
  Date: 2016/3/14
  Time: 14:01
  To change this template use File | Settings | File Templates.
--%>
<%@include file="/commontop.jsp"%>
<%
    String productId = (String)request.getParameter("productId");
    String productName = (String)request.getParameter("productName");
    String productDes = (String)request.getParameter("productDes");
    //String productPicUrl = (String)request.getParameter("productPicUrl");
    List productPicUrls = (List) request.getSession().getAttribute("productPicUrls");
//    String productHtmlName = (String)request.getParameter("productHtmlName");
    List productHtmlNames = (List) request.getSession().getAttribute("productHtmlNames");
    int num=0;
    if (request.getSession().getAttribute("num") != null) {
        num = (int) request.getSession().getAttribute("num");
    }
    //此处为新添加选项！！！
    //session.setAttribute("num",num);
    //int num = (int) request.getSession().getAttribute("num");
%>


<%
    /*if (productId != null&&productName!=null) {
        //out.print(productName);
        response.sendRedirect("/servlet/pets/PetsItemServlet?productId="+productId+"&productName="+productName);
    }*/
%>
<div id="Catalog">
    <p><%=productHtmlNames.get(num)%></p>
    <table bgcolor="aqua" border="1">
        <tr>
            <th>Item ID</th>
            <th>Product ID</th>
            <th>Description</th>
            <th>List Price</th>
            <th>&nbsp;</th>
        </tr>

        <%
            List lists = (List) request.getSession().getAttribute("itemDatas");
            List itemDess = new ArrayList<>();
            if (lists != null) {
                for (int i = 0; i < lists.size(); i++) {

                    itemDess.add(((EntityItem)lists.get(i)).getItemDes());
                    out.println("<tr><td><a href=PetsInfoAction?itemId="+((EntityItem)lists.get(i)).getItemId()
                            //+"&productPicUrl="+productPicUrls.get(num)
                            +"&stock="+((EntityItem)lists.get(i)).getStock()
                            //+"&productHtmlName="+productHtmlNames.get(num)
                            +"&itemPrice="+((EntityItem)lists.get(i)).getPrice()
                            +"&num_item="+i
//                            +"&itemDes="+((EntityItem)lists.get(i)).getItemDes()
                            //+"&productDes="+productDes
                            +">"
                            +((EntityItem)lists.get(i)).getItemId()+"</a></td>");
                    out.println("<td>"+((EntityItem)lists.get(i)).getProductId()+"</td>");
                    out.println("<td>"+((EntityItem)lists.get(i)).getItemDes()+"</td>");
                    out.println("<td>"+((EntityItem)lists.get(i)).getPrice()+"</td>");

                    out.println("<td><a href=ShoppingCartAction?itemId="+((EntityItem)lists.get(i)).getItemId()
                            //+"&productPicUrl="+productPicUrls.get(num)
                            +"&stock="+((EntityItem)lists.get(i)).getStock()
                            //+"&productHtmlName="+productHtmlNames.get(num)
                            +"&productId="+((EntityItem)lists.get(i)).getProductId()
                            +"&itemId="+((EntityItem)lists.get(i)).getItemId()
                            +"&itemPrice="+((EntityItem)lists.get(i)).getPrice()
                            +"&num_item="+i
                            +"&is_add="+"true"
                            +"&productName="+request.getSession().getAttribute("productName")
                            +" class='Button'"+">"
                            +"Add to Cart"+"</a></td></tr>");
                }
                session.setAttribute("itemDess",itemDess);
            }
            else
                out.println("<font color='red'>"+null+"</font>");
        %>
    </table>
</div>
<%@include file="/commonbottom.jsp"%>
