<%@ page import="java.util.List" %>
<%@ page import="bean.pets.Entity" %>
<%@ page import="bean.pets.EntityItem" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="action.pets.PetsItemAction" %><%--
  Created by IntelliJ IDEA.
  User: gala
  Date: 2016/3/14
  Time: 14:15
  To change this template use File | Settings | File Templates.
--%>

<%@include file="/commontop.jsp"%>
<div id="Catalog">
    <table>
        <tr>
            <th>des</th>
            <th>Product ID</th>
            <th>Name</th>
        </tr>
        <%
            List lists = (List) session.getAttribute("searchDatas");
            List productHtmlNames = new ArrayList<>();
            List productPicUrls = new ArrayList<>();
            List productDess = new ArrayList<>();

            if (lists != null) {
                for (int i = 0; i < lists.size(); i++) {
                    productHtmlNames.add(((Entity) lists.get(i)).getName());
                    productPicUrls.add(((Entity) lists.get(i)).getPic_url());
                    productDess.add(((Entity) lists.get(i)).getDes());
                    out.println("<tr><td><img src="+((Entity)lists.get(i)).getPic_url()+">"
                            +"<a href=PetsItemAction?productId=" + ((Entity) lists.get(i)).getId()
                            +"&form_key="+((Entity) lists.get(i)).form_key
                            +"&num="+i
                            + "&productName=" + session.getAttribute("search_form_name")
                            +"&productId="+((Entity) lists.get(i)).getId()
                            +"&productHtmlName="+((Entity) lists.get(i)).getName()+
                            "&productPicUrl="+((Entity) lists.get(i)).getPic_url()
                            + "&productDes="+((Entity) lists.get(i)).getDes().trim()+
                            ">" + ((Entity) lists.get(i)).getDes() + "</a>"+"</td>"
                            +"<td><a href=PetsItemAction?productId=" + ((Entity) lists.get(i)).getId()
//                            +"<td><a href=/jsp/pets/PetsItem.jsp?productId=" + ((Entity) lists.get(i)).getId()
                            + "&productName=" + session.getAttribute("search_form_name")
                            +"&num="+i
                            +"&productHtmlName="+((Entity) lists.get(i)).getName()+
                            "&productPicUrl="+((Entity) lists.get(i)).getPic_url()
                            + "&productDes="+((Entity) lists.get(i)).getDes().trim()+
                            ">" + ((Entity) lists.get(i)).getId() + "</a></td>"
                            +"<td>"+((Entity) lists.get(i)).getName()+"</td><tr>");
                }
                session.setAttribute("productHtmlNames",productHtmlNames);
                session.setAttribute("productPicUrls",productPicUrls);
                session.setAttribute("productDess",productDess);
                session.setAttribute("search_datas",lists);
                session.setAttribute("search_form_name",session.getAttribute("search_form_name"));
            } else
                out.println("<font color='red'>" + null + "</font>");
        %>
    </table>
</div>
<%@include file="/commonbottom.jsp"%>
