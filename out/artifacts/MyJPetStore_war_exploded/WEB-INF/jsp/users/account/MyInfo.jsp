<%@ page import="java.util.List" %>
<%@ page import="dao.DAO" %>
<%@ page import="bean.user.Register" %><%--
  Created by IntelliJ IDEA.
  User: gala
  Date: 2016/3/14
  Time: 14:00
  To change this template use File | Settings | File Templates.
--%>
<%@include file="/commontop.jsp"%>
<%
    Register register = new Register();
    register.setAccountInfo((String) session.getAttribute("username"));
    session.setAttribute("register",register);
    Register.Profile profile = register.new Profile();
//    profile.setProfileInfo((String) session.getAttribute("username"));
%>

<script>
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
        createXMLHttpRequest();
        try{
            xmlHttp.onreadystatechange = handleStateChange;
            xmlHttp.open("POST", "PetsCatalogAction?petsName="+name, true);
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
    function usernameIsExist(){

    }
</script>

<%--同时也可以进行账户信息的修改--%>
<div id="Catalog">
    <form method="post" action="RegisterAction.action">

        <h3>User Information</h3>

        <table>
            <tr>
                <td>User ID:</td>
                <td><%=session.getAttribute("username")%></td>
            </tr>
            <tr>
                <td>New password:</td>
                <td><input name="password" type="text" /></td>
            </tr>
            <tr>
                <td>Repeat password:</td>
                <td><input name="repeatedPassword" type="text" /></td>
            </tr>
        </table>
        <h3>Account Information</h3>

        <table>
            <tr>
                <td>First name:</td>
                <td><input name="account.firstName" type="text" value="<%=register.getFirst_name()%>"/></td>
            </tr>
            <tr>
                <td>Last name:</td>
                <td><input name="account.lastName" type="text" value="<%=register.getLast_name()%>" /></td>
            </tr>
            <tr>
                <td>Email:</td>
                <td><input size="40" name="account.email" type="text" value="<%=register.getEmail()%>" /></td>
            </tr>
            <tr>
                <td>Phone:</td>
                <td><input name="account.phone" type="text" value="<%=register.getPhone()%>" /></td>
            </tr>
            <tr>
                <td>Address 1:</td>
                <td><input size="40" name="account.address1" type="text" value="<%=register.getAddress1()%>" /></td>
            </tr>
            <tr>
                <td>Address 2:</td>
                <td><input size="40" name="account.address2" type="text" value="<%=register.getAddress2()%>" /></td>
            </tr>
            <tr>
                <td>City:</td>
                <td><input name="account.city" type="text" value="<%=register.getCity()%>" /></td>
            </tr>
            <tr>
                <td>State:</td>
                <td><input size="4" name="account.state" type="text" value="<%=register.getState()%>" /></td>
            </tr>
            <tr>
                <td>Zip:</td>
                <td><input size="10" name="account.zip" type="text" value="<%=register.getZip()%>" /></td>
            </tr>
            <tr>
                <td>Country:</td>
                <td><input size="15" name="account.country" type="text" value="<%=register.getCountry()%>" /></td>
            </tr>
        </table>

        <h3>Profile Information</h3>

        <table>
            <tr>
                <td>Language Preference:</td>
                <td><select name="account.languagePreference">
                    <option value="english" selected="selected">english</option><option value="japanese">japanese</option>
                </select></td>
            </tr>
            <tr>
                <td>Favourite Category:</td>
                <td><select name="account.favouriteCategoryId">
                    <option value="FISH">FISH</option><option value="DOGS" selected="selected">DOGS</option><option value="REPTILES">REPTILES</option><option value="CATS">CATS</option><option value="BIRDS">BIRDS</option>
                </select></td>
            </tr>
            <tr>
                <td>Enable MyList</td>
                <td><input name="account.listOption" checked="checked" type="checkbox" value="true" /></td>
            </tr>
            <tr>
                <td>Enable MyBanner</td>
                <%String str =profile.getBannerOption()==null?"":"checked=\"checked\"";%>>
                <td><input name="account.bannerOption"   type="checkbox" value="true" <%=str%> /> </td>
            </tr>

        </table>


        <input name="editAccount" type="submit" value="Save Account Information" />

        </form> <a href="OrderAction.action">My Orders</a></div>
<%@include file="/commonbottom.jsp"%>
