<%@ page import="dao.DAO" %>
<%@ page import="bean.user.Register" %><%--
  Created by IntelliJ IDEA.
  User: gala
  Date: 2016/3/14
  Time: 14:17
  To change this template use File | Settings | File Templates.
--%>
<%@include file="/commontop.jsp"%>
<%
    String islogin = (String) session.getAttribute("href");
    Register register=new Register();
    //response.sendRedirect("/jsp/users/account/login.jsp");
    if (islogin==null) {
        response.sendRedirect("/jsp/users/account/login.jsp");
        session.setAttribute("error_login","You must sign on before attempting to check out.  Please sign on and try checking out again.");
    }else{
        register = (Register) session.getAttribute("register");
    }
    //获取用户信息的billing address信息，进行填充，可以写在java bean中，而不必写在servlet中
%>
<div id="Catalog"><form method="post" action="OrderAction.action">

    <table>
        <tr>
            <th colspan=2>Payment Details</th>
        </tr>
        <tr>
            <td>Card Type:</td>
            <td><select name="order.cardType">
                <option value="Visa" selected="selected">Visa</option><option value="MasterCard">MasterCard</option><option value="American Express">American Express</option>
            </select></td>
        </tr>
        <tr>
            <td>Card Number:</td>
            <td><input name="order.creditCard" type="text" value="999 9999 9999 9999" /> * Use a fake
                number!</td>
        </tr>
        <tr>
            <td>Expiry Date (MM/YYYY):</td>
            <td><input name="order.expiryDate" type="text" value="12/03" /></td>
        </tr>
        <tr>
            <th colspan=2>Billing Address</th>
        </tr>

        <tr>
            <td>First name:</td>
            <td><input name="order.billToFirstName" value="<%=register.getFirst_name()%>"/></td>
        </tr>
        <tr>
            <td>Last name:</td>
            <td><input name="order.billToLastName" type="text" value="<%=register.getLast_name()%>" /></td>
        </tr>
        <tr>
            <td>Address 1:</td>
            <td><input size="40" name="order.billAddress1" type="text" value="<%=register.getAddress1()%>" /></td>
        </tr>
        <tr>
            <td>Address 2:</td>
            <td><input size="40" name="order.billAddress2" type="text" value="<%=register.getAddress2()%>" /></td>
        </tr>
        <tr>
            <td>City:</td>
            <td><input name="order.billCity" type="text" value="<%=register.getCity()%>" /></td>
        </tr>
        <tr>
            <td>State:</td>
            <td><input size="4" name="order.billState" type="text" value="<%=register.getState()%>" /></td>
        </tr>
        <tr>
            <td>Zip:</td>
            <td><input size="10" name="order.billZip" type="text" value="<%=register.getZip()%>" /></td>
        </tr>
        <tr>
            <td>Country:</td>
            <td><input size="15" name="order.billCountry" type="text" value="<%=register.getCountry()%>" /></td>
        </tr>

        <tr>
            <td colspan=2><input name="shippingAddressRequired" type="checkbox" value="true" />
                Ship to different address...</td>
        </tr>

    </table>

    <input name="newOrder" type="submit" value="Continue" />

    <div style="display: none;"><input type="hidden" name="_sourcePage" value="71LSj0pyirx71HcvSkHnrcRVOdR6zb4m_UnBJbMhfcRDVNVbddLnzw==" /><input type="hidden" name="__fp" value="1A7nDF9RctcMVhLTraloswGhooM0wAdpTWphB2X_HMWe6hLVeb9DWoV0HC_VemXT" /></div></form></div>


<%@include file="/commonbottom.jsp"%>