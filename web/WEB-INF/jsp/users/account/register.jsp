<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: gala
  Date: 2016/3/14
  Time: 14:13
  To change this template use File | Settings | File Templates.
--%>
<%@include file="/commontop.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>


<div id="Catalog">
    <form method="post" action="RegisterAction.action" name="registerForm">
        <p><a href="ChangeLanguageAction.action?request_locale=zh_CN"><s:text name="chinese"/>&nbsp;</a><a href="ChangeLanguageAction.action?request_locale=en_US"><s:text name="english"/></a> </p>
        <h3>User Information</h3>

        <table>
            <tr>
                <td><s:text name="register.username" /></td>
                <td> <s:textfield name="username" key="register.username" onblur="usernameIsExist()"/><div id="usernameMsg"></div></td>
                <%--<%
                    //String error = (String) request.getSession().getAttribute("error");
                    String error = (String)session.getAttribute("error");
                    if (error != null) {
                        out.print("<font color='red'>"+error+"</font>");
                    }
                    //request.getSession().removeAttribute("error");
                    session.removeAttribute("error");
                %>--%>

            </tr>
            <tr>
                <td><s:text name="register.password"/></td>
                <td> <s:password name="password" key="register.password"/></td>
            </tr>
            <tr>
                <td><s:text name="register.repeatedPassword" /></td>
                <td> <s:password name="repeatedPassword" key="register.repeatedPassword" onblur="isPasswordSame()"/><div id="passwordMsg"></div></td>
            </tr>
            <%--定义验证码--%>
            <tr>
                <td><s:text name="register.securityCode" /></td>
                <td> <s:textfield name="securityCode" key="register.securityCode" id = "code" onblur="isSecurityCorrect()"/><img src="SecurityCodeImageAction" style="cursor:pointer;" title="can not see?click it change the image!" id="Verify"><div id="passwordMsg1"></div></td>
            </tr>
            <%
                String error1 = (String)session.getAttribute("error1");
                if (error1 != null) {
                    out.print("<font color='red'>"+error1+"</font>");
                }
                session.removeAttribute("error1");
            %>
        </table>

        <h3>Account Information</h3>

        <%--<s:fielderror cssStyle="color: red;"/>--%>
        <table>
            <tr>
                <td><s:text name="register.first_name"/></td>
                <td> <s:textfield name="first_name" key="register.first_name"/></td>
                <td>${errors["register.first_name"][0]}</td>

            </tr>
            <tr>
                <td><s:text name="register.last_name"/></td>
                <td> <s:textfield name="last_name" key="register.last_name"/></td>
                <td>${errors["register.last_name"][0]}</td>
            </tr>
            <tr>
                <td><s:text name="register.email"/></td>
                <td> <s:textfield name="email" key="register.email"/></td>
                <td>${errors["register.email"][0]}</td>
            </tr>
            <tr>
                <td><s:text name="register.phone"/></td>
                <td> <s:textfield name="phone" key="register.phone"/></td>
                <td>${errors["register.phone"][0]}</td>
            </tr>
            <tr>
                <td><s:text name="register.address1"/></td>
                <td> <s:textfield name="address1" key="register.address1" size="40"/></td>
            </tr>
            <tr>
                <td><s:text name="register.address2"/></td>
                <td> <s:textfield name="address2" key="register.address2" size="40"/></td>
            </tr>
            <tr>
                <td><s:text name="register.city"/></td>
                <td> <s:textfield name="city" key="register.city"/></td>
            </tr>
            <tr>
                <td><s:text name="register.state"/></td>
                <td> <s:textfield name="state" key="register.state"/></td>
            </tr>
            <tr>
                <td><s:text name="register.zip"/></td>
                <td> <s:textfield name="zip" key="register.zip"/></td>
                <td>${errors["register.zip"][0]}</td>
            </tr>
            <tr>
                <td><s:text name="register.country"/></td>
                <td> <s:textfield name="country" key="register.country" size="15"/></td>
            </tr>
        </table>

        <h3>Profile Information</h3>

        <table>
            <tr>
                <td><s:text name="register.Profile.languagePreference"/></td>
                <td>
                    <select> <option value="english">english</option><option value="japanese">japanese</option>
                    </select></td>
            </tr>
            <tr>
                <td><s:text name="register.Profile.favouriteCategoryId"/></td>
                <td>
                    <select><option value="FISH">FISH</option><option value="DOGS">DOGS</option><option value="REPTILES">REPTILES</option><option value="CATS">CATS</option><option value="BIRDS">BIRDS</option>
                    </select></td>
            </tr>
            <tr>
                <td><s:text name="register.Profile.listOption"/></td>
                <td><input type="checkbox" value="true" /></td>
            </tr>
            <tr>
                <td><s:text name="register.Profile.bannerOption"/></td>
                <td><input type="checkbox" value="true" /></td>
            </tr>

        </table>


        <input name="newAccount" type="submit" value="Save Account Information" />

        <div style="display: none;"><input type="hidden" name="_sourcePage" value="a" /><input type="hidden" name="__fp" value="ATOpASBP--=" /></div></form>
    <a href="OrderAction.action">My Orders</a></div>

</div>
<%@include file="/commonbottom.jsp"%>