<%@ page import="java.util.Date" %>
<%@ page import="javafx.scene.input.DataFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="bean.user.Order" %>
<%--
  Created by IntelliJ IDEA.
  User: gala
  Date: 2016/3/14
  Time: 14:17
  To change this template use File | Settings | File Templates.
--%>
<%@include file="/commontop.jsp"%>
<%
    Register register_1 = (Register) session.getAttribute("register");
    session.removeAttribute("register");
    Register register = (Register) session.getAttribute("register")==null?
            (Register) session.getAttribute("register_"):(Register) session.getAttribute("register");
    Register register1 = session.getAttribute("shipping")==null?register_1:
            (Register) session.getAttribute("shipping");
    session.setAttribute("register_order",register1);
//    session.setAttribute("register_order",register);
    session.setAttribute("register1_order",register1);
    register = register1;

%>
<div id="BackLink"><a href="/index.jsp  ">Return to Main Menu</a></div>

<div id="Catalog">Please confirm the information below and then
    press continue...

    <table>
        <tr>
            <th align="center" colspan="2"><font size="4"><b>Order</b></font>
                <br />
                <font size="3"><b>
                    <%
                        Date data = new Date();
                        SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
                        String str = format.format(data),str_order= Order.getOrderId();
                        session.setAttribute("date_fianl",str);
                        session.setAttribute("order_id_final",str_order);
                        out.print(str);
                    %></b></font>
            </th>
        </tr>

        <tr>
            <th colspan="2">Billing Address</th>
        </tr>
        <tr>
            <td>First name:</td>
            <td><%=register.getFirst_name()%></td>
        </tr>
        <tr>
            <td>Last name:</td>
            <td><%=register.getLast_name()%></td>
        </tr>
        <tr>
            <td>Address 1:</td>
            <td><%=register.getAddress1()%></td>
        </tr>
        <tr>
            <td>Address 2:</td>
            <td><%=register.getAddress2()%></td>
        </tr>
        <tr>
            <td>City:</td>
            <td><%=register.getCity()%></td>
        </tr>
        <tr>
            <td>State:</td>
            <td><%=register.getState()%></td>
        </tr>
        <tr>
            <td>Zip:</td>
            <td><%=register.getZip()%></td>
        </tr>
        <tr>
            <td>Country:</td>
            <td><%=register.getCountry()%></td>
        </tr>
        <tr>
            <th colspan="2">Shipping Address</th>
        </tr>
        <tr>
            <td>First name:</td>
            <td><%=register1.getFirst_name()%></td>
        </tr>
        <tr>
            <td>Last name:</td>
            <td><%=register1.getLast_name()%></td>
        </tr>
        <tr>
            <td>Address 1:</td>
            <td><%=register1.getAddress1()%></td>
        </tr>
        <tr>
            <td>Address 2:</td>
            <td><%=register1.getAddress2()%></td>
        </tr>
        <tr>
            <td>City:</td>
            <td><%=register1.getCity()%></td>
        </tr>
        <tr>
            <td>State:</td>
            <td><%=register1.getState()%></td>
        </tr>
        <tr>
            <td>Zip:</td>
            <td><%=register1.getZip()%></td>
        </tr>
        <tr>
            <td>Country:</td>
            <td><%=register1.getCountry()%></td>
        </tr>
        <tr>

    </table>

    <form action="OrderAction.action" method="post">
        <input type="hidden" name="is_confirm" value="true"/>
        <input type="hidden" name="date" value="<%=str%>"/>
        <input type="hidden" name="order_id" value="<%=str_order%>"/>
        <input type="submit" class="Button" value="Confirm"/>
    </form>
    <%--<a href="/a/actions/Order.action?newOrder=&amp;confirmed=true" class="Button">Confirm</a>--%>
</div>


<%@include file="/commonbottom.jsp"%>