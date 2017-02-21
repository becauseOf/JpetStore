<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: gala
  Date: 2016/3/14
  Time: 14:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@include file="/commontop.jsp"%>
<ul class="messages"><li>
    <%
        String error_login = (String) session.getAttribute("error_login");
        if (error_login != null) {
            out.print("<font color='red'>"+error_login+"</font>");
        }
    %>
</li></ul>
<div id="Catalog">
    <form method="post" action="LoginAction">
        <p><a href="ChangeLanguageAction.action?request_locale=zh_CN&login=true"><s:text name="chinese"/>&nbsp;</a><a href="ChangeLanguageAction.action?request_locale=en_US&login=true"><s:text name="english"/></a> </p>
        <p><s:text name="login.title"/></p>
        <p><s:text name="login.username"/>  <s:textfield name="userName" key="login.username"/> <br/><br/>
            <s:text name="login.password"/>  <s:password name="passWord" key="login.password"/></p>
        <s:submit name="input" key="login.button"/>

        <%
            String error = (String) request.getAttribute("error");
            if (error != null) {
                out.print("<font color='red'>"+error+"</font>");
            }
        %>
    </form>
    <s:text name="login.tail"/> <a href="RegisterAction"><s:text name="login.register"/></a>
</div>
<%@include file="/commonbottom.jsp"%>
