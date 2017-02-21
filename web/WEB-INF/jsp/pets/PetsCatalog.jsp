<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page import="java.util.List" %>
<%@ page import="bean.pets.Entity" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="action.pets.PetsItemAction" %><%--
  Created by IntelliJ IDEA.
  User: gala
  Date: 2016/3/14
  Time: 14:00
  To change this template use File | Settings | File Templates.
--%>

<%
    //String s =(String) session.getAttribute("petsName");
    //String string = request.getSession().getParameter("name");
    //String str= string;
    //out.println("dsas"+string);
    //out.print(s);
    //String string =(String) session.getAttribute("name");
    //String string =(String) request.getSession().getAttribute("name");
   // String string = request.getParameter("name");
    //out.print(string);
%>

<%--<script>
    //创建ajax请求对象
    var xmlHttp;
    function createXMLHttpRequest(){
        if(window.ActiveXObject){
            xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
        else if(window.XMLHttpRequest){
            xmlHttp = new XMLHttpRequest();
        }
    }
    /**
     * 请求提交
     */
    function submit(data){
        //发送请求
        var searchContent =  $id("search_input").value;//查找内容
        var name = <%=s%>;
        createXMLHttpRequest();
        try{
            xmlHttp.onreadystatechange = handleStateChange;
            xmlHttp.open("POST", "/servlet/pets/PetsCatalogServlet?petsName="+name, true);
            xmlHttp.send(null);
        }catch(exception){
            alert("您要访问的资源不存在!");
        }
        $("sideToggleRight").attr("checked","checked");//无作用

    }
    function handleStateChange(){//处理结果
        if(xmlHttp.readyState == 4){
            if (xmlHttp.status == 200 || xmlHttp.status == 0){
                var t = xmlHttp.responseText;
                jsonobj = eval('('+t+')');
            }
        }
    }
</script>--%>
<%--<script>
    function ab(){
        document.getElementById("aq").innerHTML=<%=string%>+'asasas';
    }
</script>--%>

<%@include file="/commontop.jsp"%>
<%--<body onload="ab()">--%>
<%--<p id="aq"></p>--%>
<%
    //out.println("dhsd"+(string = request.getParameter("name")));
    //string = (String) request.getAttribute("name");
%>
<%
    /*String string = request.getParameter("name");
    out.println("asdasdasd="+string);
    if (string != null) {
        response.sendRedirect("/servlet/pets/PetsCatalogServlet?petsName="+string);
    }*/

    String string =(String) request.getSession().getAttribute("petsName");
    //request.getSession().removeAttribute("petsName");
    //String string = (String) request.getAttribute("petsName");
%>
<%--<jsp:forward page="/servlet/pets/PetsCatalogServlet">
    <jsp:param name="petsName" value='<%=s%>'/>
</jsp:forward>--%>
<div id="BackLink"><a href="/index.jsp">Return to Main Menu</a></div>

<div id="Catalog">

    <h2><%=string%></h2>
    <table bgcolor="aqua" border="1">
        <tr>
            <th>Product ID</th>
            <th>Name</th>
        </tr>
        <%
            List lists = (List) request.getSession().getAttribute("datas");
            List productHtmlNames = new ArrayList<>();
            List productPicUrls = new ArrayList<>();
            List productDess = new ArrayList<>();
            if (lists != null) {
                for (int i = 0; i < lists.size(); i++) {
                    productHtmlNames.add(((Entity) lists.get(i)).getName());
                    productPicUrls.add(((Entity) lists.get(i)).getPic_url());
                    productDess.add(((Entity) lists.get(i)).getDes());
                    //session.setAttribute("productHtmlName",((Entity) lists.get(i)).getName());
                    //session.setAttribute("productDes",((Entity) lists.get(i)).getDes());
                    //此处代码存在问题

                    out.println("<tr><td><a href=PetsItemAction?productId=" + ((Entity) lists.get(i)).getId()
                            + "&productName=" +string+
                            "&num="+i+
//                            +"&productHtmlName="+((Entity) lists.get(i)).getName()+
//                            "&productPicUrl="+((Entity) lists.get(i)).getPic_url()+
//                            + "&productDes="+((Entity) lists.get(i)).getDes().trim()+
                            ">" + ((Entity) lists.get(i)).getId() + "</a></td>");
                    //out.println("<a href=PetsItem.jsp?productId="+((Entity)lists.get(i)).getId()+"<td>"+((Entity)lists.get(i)).getId()+"</td>"+"</a>");
                    out.println("<td>" + ((Entity) lists.get(i)).getName() + "</td></tr>");
                }
                session.setAttribute("productHtmlNames",productHtmlNames);
                session.setAttribute("productPicUrls",productPicUrls);
                session.setAttribute("productDess",productDess);
            } else
                out.println("<font color='red'>" + null + "</font>");
        %>
        <%--<%
            out.println("<font color='red'>"+null+"</font>");
        %>--%>

    </table>
</div>
<%@include file="/commonbottom.jsp"%>
<%--<input type="hidden" value=>--%>
<%--</body>
</html>--%>
