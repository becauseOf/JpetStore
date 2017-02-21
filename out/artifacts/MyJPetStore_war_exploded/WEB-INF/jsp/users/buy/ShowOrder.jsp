<%@ page import="java.util.List" %>
<%@ page import="bean.user.Order" %><%--
  Created by IntelliJ IDEA.
  User: gala
  Date: 2016/3/14
  Time: 14:13
  To change this template use File | Settings | File Templates.
--%>
<%@include file="/commontop.jsp"%>

<div id="Content">

    <h2 style="text-align:center;">My Orders</h2>

    <table>
        <tr>
            <th>Order ID</th>
            <th>Date</th>
            <th>Total Price</th>
        </tr>


        <%
            List message_order_outline = (List) request.getSession().getAttribute("message_order_outline");
        %>

        <%
            for (int i = 0; i <message_order_outline.size() ; i++) {

                out.println("<tr><td><a href=OrderAction?order_id="+((Order) message_order_outline.get(i)).getId()
                        +">"
                        +((Order) message_order_outline.get(i)).getId()+"</a></td>"
                        +"<td>"+((Order) message_order_outline.get(i)).getDate()+"</td>"
                        +"<td>"+((Order) message_order_outline.get(i)).getTotal_pri()+"</td>"
                        +"</tr>");
            }
        %>

        <%--<tr>
            <td><a href="/a/actions/Order.action?viewOrder=&amp;orderId=1000">1000</a></td>
            <td>2016/03/28 12:00:00</td>
            <td>$18.50</td>
        </tr>

        <tr>
            <td><a href="/a/actions/Order.action?viewOrder=&amp;orderId=1001">1001</a></td>
            <td>2016/03/28 12:00:00</td>
            <td>$37.00</td>
        </tr>--%>

    </table>
<%@include file="/commonbottom.jsp"%>
