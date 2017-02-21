<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="bean.user.Log" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: gala
  Date: 2016/3/14
  Time: 14:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>


<%@ page import="bean.user.Register" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.util.HashMap" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html xmlns:jsp="http://java.sun.com/JSP/Page">
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>My JpetStore</title>

    <link href='http://fonts.useso.com/css?family=Open+Sans:400,300,400italic,600,700' rel='stylesheet' type='text/css'>
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet">
    <link href="css/flexslider.css" rel="stylesheet">
    <link href="css/templatemo-style.css" rel="stylesheet">
    <link href="css/mycss.css" rel="stylesheet"/>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->




    <%--我的js代码--%>
    <link rel="stylesheet" href="/css/jquery-ui.css">

    <%--<script src="//code.jquery.com/jquery-1.10.2.js"></script>--%>
    <%--<script src="js/jquery-2.2.2.js"/>--%>
    <script src="/js/jquery-2.1.4.min.js"></script>
    <script src="/js/highcharts.js"></script>

    <script type="text/javascript" src="/js/jquery-ui.js"></script>
    <script type="text/javascript" src="/js/prefixfree.min.js"></script>



    <script type="text/javascript" src="js/moment.js"></script>							<!-- moment.js -->
    <script type="text/javascript" src="js/bootstrap.min.js"></script>					<!-- bootstrap js -->
    <script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>	<!-- bootstrap date time picker js, http://eonasdan.github.io/bootstrap-datetimepicker/ -->
    <script type="text/javascript" src="js/jquery.flexslider-min.js"></script>
    <!--
        <script src="js/froogaloop.js"></script>
        <script src="js/jquery.fitvid.js"></script>
    -->
    <script type="text/javascript" src="js/templatemo-script.js"></script>      		<!-- Templatemo Script -->







</head>
<body class="tm-gray-bg">
<!-- Header --><input type="hidden" id="successData" value="">
<div class="tm-header">
    <div class="container">
        <div class="row">
            <div class="col-lg-6 col-md-4 col-sm-3 tm-site-name-container">
                <a href="index.jsp" class="tm-site-name">JPetStore</a>
            </div>
            <div class="col-lg-6 col-md-8 col-sm-9">
                <div class="mobile-menu-icon">
                    <i class="fa fa-bars"></i>
                </div>
                <nav class="tm-nav">
                    <ul>
                        <%--<li><a href="index.jsp" class="active">Home</a></li>--%>
                        <li><%
                            String href = (String) session.getAttribute("href");
                            if (href == null) {
                                out.print("<a href='LoginAction?signIn=true' class=\"active\">Sign In</a>");
//                    out.print("<a href='/jsp/users/account/login.jsp'>Sign In</a>");
                            }else{
                                out.print("<a href='LoginAction' class=\"active\">Sign Out</a>");
//                    out.print("<a href='/jsp/users/account/LoginOut.jsp'>Sign Out</a>");
                                Register register = new Register();
                                String s = (String) session.getAttribute("username");
                                register.setAccountInfo(s);
                                session.setAttribute("register",register);
                                //session.setAttribute("shipping",register);
                            }
                            //session.removeAttribute("href");
                        %></li>
                        <li><a href="ShoppingCartAction.action" ><img align="middle" name="img_cart" src="img/cart1.png" /></a></li>
                        <%
                            if (href != null) {
                                if (session.getAttribute("username").equals("xs")) {
                                    out.print("<li><a href='LogAction'>View Log</a></li>");
                                }
                                out.print("<li><a href='AccountInfoAction'>My Account</a></li>");
                            }
                        %>
                        <%--<li><a href="index.jsp">help</a></li>--%>
                    </ul>
                    <div id="Search">
                        <div id="SearchContent" class="ui-widget"><form method="post" action="SearchAction">
                            <input size="14" name="keyword" type="text" id="ajaxsearch" title="please iput keyword!" WIDTH="5px"/>
                            <input name="searchProducts" type="submit" value="Search" id="search-btn" class="tm-banner-link"/>
                        </form></div>
                    </div>

                </nav>
            </div>
        </div>
    </div>
</div>

<%
    Map map = (Map) session.getAttribute("logMap");
    List times = (List) map.get("times");
    List productsCounts = (List) map.get("productsCounts");
    List petsCounts = (List) map.get("petsCounts");
%>

<div id="Catalog">
    <h3>view site's time span</h3>

    <table>
        <tr>
            <th>time</th>
        </tr>

            <%
                for (int i =0;i<times.size();i++){
                    out.println("<tr><td>"+((Log) times.get(i)).getTime()+"</td></tr>");
                }
            %>



    </table>

    <h3>product name's view count</h3>

    <table>
        <tr>
            <th>product name</th>
            <th>count</th>
        </tr>

            <%
                String[] strsPets = new String[petsCounts.size()];
                int[] countPets = new int[petsCounts.size()];
                for (int i =0;i<petsCounts.size();i++){
                    out.println("<tr><td>"+((Log) petsCounts.get(i)).getName()+"</td>"+"<td>"+((Log) petsCounts.get(i)).getCount()+"</td> </tr>");
                    strsPets[i] = ((Log) petsCounts.get(i)).getName();
                    countPets[i] = Integer.parseInt(((Log) petsCounts.get(i)).getCount());
                }
            %>


    </table>

    <h3>pets type view count</h3>

    <table>
        <tr>
            <th>pets name</th>
            <th>count</th>
        </tr>


            <%
                for (int i =0;i<productsCounts.size();i++){
                    out.println(" <tr><td>"+((Log) productsCounts.get(i)).getName()+"</td>"+"<td>"+((Log) productsCounts.get(i)).getCount()+"</td></tr>");
                }
            %>


    </table>
</div>


<div id="container" style=""></div>


<script language="JavaScript">
    $(document).ready(function() {
        var title = {
            text: '日志'
        };
        var subtitle = {
            text: 'product name\'s view count'
        };

        var xAxis = {
            categories: ['fish','reptiles','birds','dogs','cats']
                    <%--[<%=strsPets%>]--%>
                <%--<%
                   for(int i = 0; i < petsCounts.size(); i++) {
                     System.out.print(((Log) petsCounts.get(i)).getName()+",");
                   }
                   %>--%>

        };
//        xAxis.push({categories:strsPets})

//        xAxis.categories = strsPets;


        var yAxis = {
            title: {
                text: 'view count(次)'
            },
            plotLines: [{
                value: 0,
                width: 1,
                color: '#808080'
            }]
        };

        var tooltip = {
            valueSuffix: '次'
        }

        var legend = {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'middle',
            borderWidth: 0
        };

        var series =  [
            {
                name: 'count',
                data: [
                    <%=((Log) petsCounts.get(0)).getCount()%>,
                    <%=((Log) petsCounts.get(1)).getCount()%>,
                    <%=((Log) petsCounts.get(2)).getCount()%>,
                    <%=((Log) petsCounts.get(3)).getCount()%>,
                    <%=((Log) petsCounts.get(4)).getCount()%>
                        <%--<%
                        for(int i = 0; i < petsCounts.size(); i++) {
                          System.out.print(((Log) petsCounts.get(i)).getCount()+",");
                        }
                        %>--%>
                ]

                /*data:(function(){
                    var strsPets = [1,2];
                    return strsPets;
                })*/
            }
        ];

        var json = {};

//        alert("sasaaas");



        json.title = title;
        json.subtitle = subtitle;
        json.xAxis = xAxis;
        json.yAxis = yAxis;
        json.tooltip = tooltip;
        json.legend = legend;
        json.series = series;

        $('#container').highcharts(json);
    });








</script>


<%@include file="/commonbottom.jsp"%>
<%--
<script>
    $(document).ready(function() {
        var x = [];//X轴
        var y = [];//Y轴
        var xtext = [];//X轴TEXT
        <%
        List<Map<String, Object>> list = petsCounts;
        Map<String, Object> map1 = new HashMap<String, Object>();
        map.put("list", list);
         Gson gson = new Gson();
        String s = gson.toJson(map1);
        %>
        var json =  JSON.parse(<%=s%>>);
        alert(<%=s%>+'sasasas');
        json.list[key].y = json.list[key].age; //给Y轴赋值
        xtext = json.list[key].name;//给X轴TEXT赋值
        chart.series[0].setData(json);//数据填充到highcharts上面


        var chart = new Highcharts.Chart({
            chart:{
                renderTo:'container',
                type:'column' //显示类型 柱形
            },
            title:{
                text:'年龄分布图' //图表的标题
            },
            xAxis:{
                categories:xtext
            },
            yAxis:{
                title:{
                    text:'年龄' //Y轴的名称
                },
            },
            series:[{
                name:"姓名"
            }]
        });
    })
</script>--%>
