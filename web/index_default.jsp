<%--
  Created by IntelliJ IDEA.
  User: gala
  Date: 2016/3/17
  Time: 20:05
  To change this template use File | Settings | File Templates.
--%>

<%@include file="commontop.jsp"%>
<div id="Welcome">
    <div id="WelcomeContent"></div>
</div>

<script>
    $(document).ready(function(){
        var i;
        var petsName = ["birds", "fish", "dogs", "reptiles", "cats","birds1"];

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



<div id="Main">
    <div id="Sidebar">
        <div id="SidebarContent"><a href="PetsCatalogAction?&name=fish"><img src="/images/fish_icon.gif" /></a> <br />
            Saltwater, Freshwater <br />
            <a href="PetsCatalogAction?&name=dogs" title="SSSSS"><img src="/images/dogs_icon.gif" /></a> <br />
            Various Breeds <br />
            <a href="PetsCatalogAction?&name=cats"><img src="/images/cats_icon.gif" /></a> <br />
            Various Breeds, Exotic Varieties <br />
            <a href="PetsCatalogAction?&name=reptiles"><img src="images/reptiles_icon.gif" /></a> <br />
            Lizards, Turtles, Snakes <br />
            <a href="PetsCatalogAction?&name=birds"><img src="images/birds_icon.gif" /></a> <br />
            Exotic Varieties</div>
    </div>

    <div id="MainImage">
        <div id="MainImageContent">
            <map name="estoremap">
                <area alt="Birds" coords="72,2,280,250" id="birds"
                      href="PetsCatalogAction?&name=birds" shape="RECT" title="" />
                <area alt="Fish" coords="2,180,72,250" id="fish"
                      href="PetsCatalogAction?&name=fish" shape="RECT" title=""/>
                <area alt="Dogs" coords="60,250,130,320" id="dogs"
                      href="PetsCatalogAction?&name=dogs" shape="RECT" title=""/>
                <area alt="Reptiles" coords="140,270,210,340" id="reptiles"
                      href="PetsCatalogAction?&name=reptiles" shape="RECT" title=""/>
                <area alt="Cats" coords="225,240,295,310" id="cats"
                      href="PetsCatalogAction?&name=cats" shape="RECT" title=""/>
                <area alt="Birds" coords="280,180,350,250" id="birds1"
                      href="PetsCatalogAction?&name=birds" shape="RECT" title=""/>
            </map>
            <img height="355" src="images/splash.gif" align="middle"
                 usemap="#estoremap" width="350" /></div>
    </div>

    <div id="Separator">&nbsp;</div>
</div>
<%@include file="commonbottom.jsp"%>
