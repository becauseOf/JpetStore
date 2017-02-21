<%@ page import="bean.user.Register" %><%--
  Created by IntelliJ IDEA.
  User: gala
  Date: 2016/3/14
  Time: 14:17
  To change this template use File | Settings | File Templates.
--%>
<%@include file="/commontop.jsp"%>
<%
    Register register = (Register) session.getAttribute("register");
%>
<div id="Catalog"><form method="post" action="OrderAction.action">

    <table>
        <tr>
            <th colspan=2>Shipping Address</th>
        </tr>

        <tr>
            <td>First name:</td>
            <td><input name="order.shipToFirstName" type="text" value="<%=register.getFirst_name()%>"/></td>
        </tr>
        <tr>
            <td>Last name:</td>
            <td><input name="order.shipToLastName" type="text" value="<%=register.getLast_name()%>"/></td>
        </tr>
        <tr>
            <td>Address 1:</td>
            <td><input size="40" name="order.shipAddress1" type="text" value="<%=register.getAddress1()%>"/></td>
        </tr>
        <tr>
            <td>Address 2:</td>
            <td><input size="40" name="order.shipAddress2" type="text" value="<%=register.getAddress2()%>"/></td>
        </tr>
        <tr>
            <td>City:</td>
            <td><input name="order.shipCity" type="text" value="<%=register.getCity()%>"/></td>
        </tr>
        <tr>
            <td>State:</td>
            <td><input size="4" name="order.shipState" type="text" value="<%=register.getState()%>"/></td>
        </tr>
        <tr>
            <td>Zip:</td>
            <td><input size="10" name="order.shipZip" type="text" value="<%=register.getZip()%>"/></td>
        </tr>
        <tr>
            <td>Country:</td>
            <td><input size="15" name="order.shipCountry" type="text" value="<%=register.getCountry()%>"/></td>
        </tr>


    </table>

    <input type="hidden" name="is_shipping" value="true"/>
    <input name="newOrder" type="submit" value="Continue" />
    <div style="display: none;"><input type="hidden" name="_sourcePage" value="QWoBMjrmNKPtHmHQu6vXEqWxAu7HvE2xSwLFYuJsqW6hYTEMYCOw_A==" /><input type="hidden" name="__fp" value="ieCmTOhkyjc=" /></div>
</form>
</div>


<%@include file="/commonbottom.jsp"%>