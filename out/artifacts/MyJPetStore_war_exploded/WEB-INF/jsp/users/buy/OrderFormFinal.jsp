<%@ page import="java.util.List" %>
<%@ page import="bean.pets.ShoppingCart" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: gala
  Date: 2016/3/14
  Time: 14:17
  To change this template use File | Settings | File Templates.
--%>
<%@include file="/commontop.jsp"%>

<%
    Register register = (Register) session.getAttribute("register")==null?
            (Register) session.getAttribute("register_"):(Register) session.getAttribute("register");
    Register register1 = session.getAttribute("shipping")==null?register:
            (Register) session.getAttribute("shipping");
    //再次对register和register1进行赋值
    if (register == null) {
        register = (Register) session.getAttribute("register_order_ser");
    }
    if (register1 == null) {
        register1 = (Register) session.getAttribute("register1_order_ser");
    }
%>
<div id="BackLink"><a href="/index.jsp">Return to Main Menu</a></div>

<div id="Catalog">

    <table>
        <tr>
            <th align="center" colspan="2">Order #<%=session.getAttribute("order_id_final")%>
                <%=session.getAttribute("date_fianl")%></th>
        </tr>
        <tr>
            <th colspan="2">Payment Details</th>
        </tr>
        <tr>
            <td>Card Type:</td>
            <td>Visa</td>
        </tr>
        <tr>
            <td>Card Number:</td>
            <td>999 9999 9999 9999 * Fake
                number!</td>
        </tr>
        <tr>
            <td>Expiry Date (MM/YYYY):</td>
            <td>12/03</td>
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
            <td>Courier:</td>
            <td>UPS</td>
        </tr>
        <tr>
            <td colspan="2">Status: P</td>
        </tr>
        <tr>
            <td colspan="2">
                <table>
                    <tr>
                        <th><b>Item ID</b></th>
                        <th><b>Description</b></th>
                        <th><b>Quantity</b></th>
                        <th><b>Price</b></th>
                        <th><b>Total Cost</b></th>
                    </tr>
                    <%
                        List datas_cart = (List) request.getSession().getAttribute("datas_cart");//((ShoppingCart) datas_cart).get(i)
                        List datas_cart_product_des = new ArrayList<>();
                        List datas_cart_item_des = new ArrayList<>();
                        List datas_cart_pic = new ArrayList<>();
                        List datas_cart_name = new ArrayList<>();
                    %>

                    <%
                        String str,money;int quantity=0;double totalMoney=0,sum=0;
                        for (int i = 0; i <datas_cart.size() ; i++) {
                            quantity = ((ShoppingCart) datas_cart.get(i)).getQuantity();
                            money = ((ShoppingCart) datas_cart.get(i)).getPrice();
                            totalMoney = Double.parseDouble(money.substring(1,money.length()))*quantity;
                            out.println("<tr><td><a href=PetsInfoAction?itemId="+((ShoppingCart) datas_cart.get(i)).getItemId()
                                    +"&stock="+((ShoppingCart) datas_cart.get(i)).getStock()
                                    +"&itemPrice="+((ShoppingCart) datas_cart.get(i)).getPrice()
                                    +"&num_item="+i
                                    +">"
                                    +((ShoppingCart) datas_cart.get(i)).getItemId()+"</a></td>"
                                    +"<td>"+((ShoppingCart) datas_cart.get(i)).getItemDes()+"</td>"
                                    +"<td>"+quantity+"</td>"
                                    +"<td>"+money+"</td>"
                                    +"<td>$"+totalMoney+"</td>"
                                    +"</tr>");

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

                        //session.setAttribute("sum_cart",sum);
                    %>

                    <tr>
                        <td colspan="7">Sub Total: $<%=sum%> </td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
                <%
                    //session.removeAttribute("datas_cart");

                    //这里可以设置另外一个sessoin值，然后在购物车页面进行判断，如果此值不为空，说明购物车已经提交，则将购物车的sessoin设为空值即可
                %>
            </td>
        </tr>

    </table>

</div>


<%@include file="/commonbottom.jsp"%>