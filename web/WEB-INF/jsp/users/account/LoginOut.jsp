<%--
  Created by IntelliJ IDEA.
  User: gala
  Date: 2016/3/14
  Time: 14:13
  To change this template use File | Settings | File Templates.
--%>
<%@include file="/commontop.jsp"%>
<%
    session.removeAttribute("href");
    session.removeAttribute("username");
    response.sendRedirect("/index.jsp");
%>
<%@include file="/commonbottom.jsp"%>
