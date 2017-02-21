<%@ page import="java.util.List" %>
<%@ page import="bean.pets.ShoppingCart" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: gala
  Date: 2016/3/14
  Time: 14:17
  To change this template use File | Settings | File Templates.
--%>
<%@include file="/commontop.jsp"%>

<div id="BackLink"><a href="/index.jsp">Return to Main Menu</a></div>
<div id="Catalog">

    <%--<div id="Cart">--%>
        <form method="post" action="ShoppingCartAction.action">
            <table>
                <tr>
                    <th><b>Item ID</b></th>
                    <th><b>Product ID</b></th>
                    <th><b>Description</b></th>
                    <th><b>In Stock?</b></th>
                    <th><b>Quantity</b></th>
                    <th><b>List Price</b></th>
                    <th><b>Total Cost</b></th>
                    <th>&nbsp;</th>
                </tr>
                <%
                    List datas_cart = (List) request.getSession().getAttribute("datas_cart");//((ShoppingCart) datas_cart).get(i)
                    List datas_cart_product_des = new ArrayList<>();
                    List datas_cart_item_des = new ArrayList<>();
                    List datas_cart_pic = new ArrayList<>();
                    List datas_cart_name = new ArrayList<>();
                %>


                <%
                    String s="",str="";double sum=0;
                    if (datas_cart != null) {
                        s = datas_cart.size() != 0?"":"Your cart is empty.";
                        String money;int quantity=0;double totalMoney=0;

                        for (int i = 0; i <datas_cart.size() ; i++) {
                            quantity = ((ShoppingCart) datas_cart.get(i)).getQuantity();
                            money = ((ShoppingCart) datas_cart.get(i)).getPrice();
                            totalMoney = Double.parseDouble(money.substring(1,money.length()))*quantity;
                            str = (((ShoppingCart) datas_cart.get(i)).getStock()>0)?"true":"false";


                            sum+=totalMoney;

                            datas_cart_item_des.add(((ShoppingCart) datas_cart.get(i)).getItemDes());
                            datas_cart_name.add(((ShoppingCart) datas_cart.get(i)).getProductHtmlNames());
                            datas_cart_pic.add(((ShoppingCart) datas_cart.get(i)).getProductPicUrls());
                            datas_cart_product_des.add(((ShoppingCart) datas_cart.get(i)).getProductDess());
                        }

                        session.setAttribute("itemDess",datas_cart_item_des);
                        session.setAttribute("productHtmlNames",datas_cart_name);
                        session.setAttribute("productPicUrls",datas_cart_pic);
                        session.setAttribute("productDess",datas_cart_product_des);
                        session.setAttribute("isFromCart","true");//确保num和num_item的值正确

                        session.setAttribute("sum_cart",sum);
                    }
                %>


                <s:iterator value="datas_cart" status="status" var="o">
                    <tr>
                        <td>
                            <a href="
                            <s:url action="PetsInfoAction">
                                <s:param name="itemId" value="%{#o.itemId}"/>
                                <s:param name="stock" value="%{#o.stock}"/>
                                <s:param name="itemPrice" value="%{#o.price}"/>
                                <s:param name="num_item" value="%{#status.index}"/>
                            </s:url>"
                            ><s:property value="itemId"/></a>
                        </td>
                        <td><s:property value="productId"/></td>
                        <td><s:property value="itemDes"/></td>
                        <td><s:property value="stock>0?true:false"/></td>
                        <td><s:textfield size="3" value="%{#o.quantity}" name="%{#o.itemId}"/></td>
                        <td><s:property value="price"/></td>
                        <td><s:property value="price.substring(1,price.length())*quantity"/></td>
                        <%--居然可以在ognl表达式中直接调用java函数，简直666--%>
                        <td>
                            <a href="
                            <s:url action="ShoppingCartAction">
                                <s:param name="item_remove" value="%{#o.itemId}"/>
                                <s:param name="is_remove" value="true"/>
                            </s:url>"
                               class='Button'>Remove</a>
                        </td>
                    </tr>
                </s:iterator>


                <%--差距所在：update是from表单请求servlet,而remove则是一个链接指向servlet--%>

                <%--<tr>
                    <td><a href="/a/actions/Catalog.action?viewItem=&amp;itemId=EST-4"><%=request.getParameter("itemId")%></a></td>
                    <td><%=request.getParameter("productId")%></td>
                    <td><%=((List)session.getAttribute("itemDess"))
                            .get(Integer.parseInt(request.getParameter("num_item")))
                    %></td>
                    <td><%=(Integer.parseInt(request.getParameter("stock"))>0)?"true":"false"%></td>
                    <td><input size="3" name="EST-4" type="text" value="1" /></td>
                    <td><%=request.getParameter("itemPrice")%></td>
                    <td><%=request.getParameter("itemPrice")%></td>
                    <td><a href="/a/actions/Cart.action?removeItemFromCart=&amp;cartItem=EST-4" class="Button">Remove</a></td>
                </tr>--%>

                <tr>
                    <td colspan="8"><b><%=s%></b></td>
                </tr>
                <tr>
                    <td colspan="7">Sub Total: $<%=sum%><input name="updateCartQuantities" type="submit" value="Update Cart" /></td>
                    <td>&nbsp;</td>
                </tr>
                <input type="hidden" name="Update_Cart" value="Update_Cart"/>
            </table>
            <div style="display: none;">
                <input type="hidden" name="_sourcePage" value="BmEKjdL3EkNt8cL2cydwPBHgajeJ6sz0ZBIZCaXcQ_Y=" /><input type="hidden" name="__fp" value="DBefr-X3YDM=" />
            </div>
        </form>
<%--<%
    if (datas_cart != null) {
        if (datas_cart.size() > 0) {

            out.print("<a href=\"EditOrderAction\" class=\"Button\">Proceed to Checkout</a>");
        }
    }
%>--%>

        <a href="EditOrderAction" class="Button">Proceed to Checkout</a>
    <%--</div>--%>

    <%--<div id="MyList">

    </div>

    <div id="Separator">&nbsp;</div>--%>
</div>

<%@include file="/commonbottom.jsp"%>
