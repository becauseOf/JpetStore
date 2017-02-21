<%@ page import="bean.user.Register" %>
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
    <script src="js/jquery-1.10.2.js"></script>
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


    <script type="text/javascript">
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

        function handleStateChange(){//处理结果
            if(xmlHttp.readyState == 4){
                if (xmlHttp.status == 200 || xmlHttp.status == 0){
                    var responseInfo = xmlHttp.responseXML.getElementsByTagName("msg")[0].firstChild.data;
                    var div1 = document.getElementById("usernameMsg");
                    var div2 = document.getElementById("passwordMsg1");
                    var str= "用户名已存在",str1 = "用户名可用",str2="验证码不正确!",str3="验证码正确!";
                    if(responseInfo == "exist"){
                        div1.innerHTML = "<font color='red'>"+str+"</font>";
                    }else if(responseInfo == "notexist") {
                        div1.innerHTML = "<font color='green'>"+str1+"</font>";
                    }
                    else if(responseInfo == "not correct"){
                        div2.innerHTML = "<font color='red'>"+str2+"</font>";
                    }else{
                        div2.innerHTML = "<font color='green'>"+str3+"</font>";
                    }
                }
            }
        }
        function usernameIsExist(){
            var username = document.registerForm.username.value;
            submit("RegisterUserAction?username="+username);
        }

        function isSecurityCorrect(){
            var code = document.registerForm.code.value;
            submit("RegisterUserAction?code="+code);
        }

        function isPasswordSame(){
            var password = document.registerForm.password.value;
            var repeatedPassword = document.registerForm.repeatedPassword.value;
            var div2 = document.getElementById("passwordMsg");
            var str= "not same",str1 = "same";
            if(password != repeatedPassword){
                div2.innerHTML = "<font color='red'>"+str+"</font>";
            }/*else{
             div2.innerHTML = "<font color='green'>"+str1+"</font>";
             }*/
        }
        /**
         * 请求提交
         */
        function submit(url){
            //发送请求
            createXMLHttpRequest();
            try{
                xmlHttp.open("GET", url, true);
                xmlHttp.onreadystatechange = handleStateChange;
                xmlHttp.send(null);
            }catch(exception){
                alert("您要访问的资源不存在!");
            }
            //$("sideToggleRight").attr("checked","checked");//无作用

        }
    </script>


    <script type="text/javascript">

        $(document).ready(function(){


            $(function () {
                //点击图片更换验证码
                $("#Verify").click(function(){
                    $(this).attr("src","SecurityCodeImageAction?timestamp="+new Date().getTime());
                });
            });

            $("#ajaxsearch").bind('input',function(){
                var data = $('#successData').val();
                var data = JSON.parse(data);
                $( "#ajaxsearch" ).autocomplete({
                    source:data,
                });
            });



        });

    </script>

    <script>

        //var availableTags='';
        function get(){
            $.ajax({
                type: "get",
                url: "SearchAction?isAjax="+$("#ajaxsearch").val(),
                //dataType: "json",
                success: function(data){
                    //$("#showMsg").html(data.msg);//修改id为showMsg标签的html
                    //alert("Data: " + data + "\nStatus: " + status);

                    /*availableTags = data;
                     alert(availableTags+"aaaviai");*/
                    $('#successData').val(data);
//                    alert(data.toString());
                    /*$( "#ajaxsearch" ).autocomplete({
                     source: $('#successData').val()
                     });*/
//                    alert($('#successData').val());
                    //$('#successData').val("ssa");

                }, error: function(){
                    //这里进行了异常屏蔽
                    //alert("请求出错");
                }
            })
            //alert(availableTags+"aa");
            //return availableTags;
        }


        //        这里进行调用函数
        get();




    </script>




    <script>
        // HTML document is loaded. DOM is ready.
        $(function() {

            $('#hotelCarTabs a').click(function (e) {
                e.preventDefault()
                $(this).tab('show')
            })

            $('.date').datetimepicker({
                format: 'MM/DD/YYYY'
            });
            $('.date-time').datetimepicker();

            // https://css-tricks.com/snippets/jquery/smooth-scrolling/
            $('a[href*=#]:not([href=#])').click(function() {
                if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
                    var target = $(this.hash);
                    target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
                    if (target.length) {
                        $('html,body').animate({
                            scrollTop: target.offset().top
                        }, 1000);
                        return false;
                    }
                }
            });
        });

        $(window).load(function() {
            $('.flexslider').flexslider({
                controlNav: false
            });
//            get;

        });
    </script>
    <script>
        $(document).ready(function(){
            var i;
            var petsName = ["birds", "fish", "dogs", "reptiles", "cats","birds1"];
//            get();
            $("#" + petsName[0]).hover(function () {
                $.ajax({
                    type: "get",
                    url: "PetsCatalogAction?name=" + petsName[0] + "&isAjax=true",
                    success: function (data) {
//                    $('#successData').val(data);
                        var data = JSON.parse(data);
                        $("#" + petsName[0]).attr("title", data);
                    }, error: function () {
                        //alert("error");
                    }
                })
//            $("#birds").attr("title","ajsdfd");

//                get();
            })
            $("#" + petsName[1]).hover(function () {
                $.ajax({
                    type: "get",
                    url: "PetsCatalogAction?name=" + petsName[1] + "&isAjax=true",
                    success: function (data) {
//                    $('#successData').val(data);
                        var data = JSON.parse(data);
                        $("#" + petsName[1]).attr("title", data);
                    }, error: function () {
                        //alert("error");
                    }
                })
//            $("#birds").attr("title","ajsdfd");
            })
            $("#" + petsName[2]).hover(function () {
                $.ajax({
                    type: "get",
                    url: "PetsCatalogAction?name=" + petsName[2] + "&isAjax=true",
                    success: function (data) {
//                    $('#successData').val(data);
                        var data = JSON.parse(data);
                        $("#" + petsName[2]).attr("title", data);
                    }, error: function () {
                        //alert("error");
                    }
                })
//            $("#birds").attr("title","ajsdfd");
            })
            $("#" + petsName[3]).hover(function () {
                $.ajax({
                    type: "get",
                    url: "PetsCatalogAction?name=" + petsName[3] + "&isAjax=true",
                    success: function (data) {
//                    $('#successData').val(data);
                        var data = JSON.parse(data);
                        $("#" + petsName[3]).attr("title", data);
                    }, error: function () {
                        //alert("error");
                    }
                })
//            $("#birds").attr("title","ajsdfd");
            })
            $("#" + petsName[4]).hover(function () {
                $.ajax({
                    type: "get",
                    url: "PetsCatalogAction?name=" + petsName[4] + "&isAjax=true",
                    success: function (data) {
//                    $('#successData').val(data);
                        var data = JSON.parse(data);
                        $("#" + petsName[4]).attr("title", data);
                    }, error: function () {
                        //alert("error");
                    }
                })
//            $("#birds").attr("title","ajsdfd");
            })
            $("#" + petsName[5]).hover(function () {
                $.ajax({
                    type: "get",
                    url: "PetsCatalogAction?name=" + petsName[0] + "&isAjax=true",
                    success: function (data) {
//                    $('#successData').val(data);
                        var data = JSON.parse(data);
                        $("#" + petsName[5]).attr("title", data);
                    }, error: function () {
                        //alert("error");
                    }
                })
            })
        });
    </script>


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