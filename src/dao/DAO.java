package dao;

import bean.pets.Entity;
import bean.pets.EntityItem;
import bean.pets.ShoppingCart;
import bean.user.Log;
import bean.user.Order;
import bean.user.Register;
import define_constant.Constants;

import java.sql.*;
import java.lang.Class;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by gala on 2016/3/14.
 */
public  class DAO {
//    进行所有的CRUD操作
    private ResultSet resultSet,resultSetCart,resultSetCartItem,resultSet_loc;
    private int result;
    public List dataList = new ArrayList<>();
    public List connect(String sql, int operateType,int operateName) throws ClassNotFoundException, SQLException {
        return dataList;
    }



    public List connectTest(String sql, int operateType,int operateName) throws ClassNotFoundException, SQLException {

        Class.forName("com.mysql.jdbc.Driver");
        Connection connection = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/my_pet_store",
                "root", "1234");
        Statement statement = connection.createStatement();
        Statement statement1 = connection.createStatement();
        Statement statement2 = connection.createStatement();//购物车相关查询

        if (operateType == Constants.QUERY) {
            resultSet = statement.executeQuery(sql);
        }else{
            result = statement.executeUpdate(sql);
        }

        switch (operateName){
            case Constants.QUERY_USER_IS_EXIST:
                Map<Integer,Boolean> map1 = new HashMap<>();
                if (!resultSet.next()) {
                    map1.put(Constants.IS_LOGIN_SUCCESS,false);
                }else {
                    map1.put(Constants.IS_LOGIN_SUCCESS,true);
                }
                dataList.add(map1);
                break;
            case Constants.QUERY_USER:
                Map<Integer,Boolean> map = new HashMap<>();
                if (!resultSet.next()) {
                    map.put(Constants.IS_LOGIN_SUCCESS,false);
                }else {
                    map.put(Constants.IS_LOGIN_SUCCESS,true);
                }
                dataList.add(map);
                /*resultSet.next();//必须写上.next()
                String userName = resultSet.getString("username");
                String passWord = resultSet.getString(3);//列号从1开始*/
                break;
            case Constants.ADD_ACCOUNT://注册需要往三个表添加信息
                dataList.add(result);//注册是否成功
                break;
            case Constants.QUERY_PRODUCT_OR_SEARCH:
                Entity entity;
                //产品不会为空
                while (resultSet.next()){
                    entity = new Entity();
                    entity.form_key = resultSet.getInt(1);
                    entity.setId(resultSet.getString(2));
                    entity.setName(resultSet.getString(3));
                    entity.setDes(resultSet.getString(4));
                    entity.setPic_url(resultSet.getString(5));
                    dataList.add(entity);
                }
                break;
            case Constants.QUERY_PRODECT_ITEM:
                EntityItem entityItem;
                //这里没有添加库存量
                while (resultSet.next()){
                    entityItem = new EntityItem();
                    entityItem.setItemId(resultSet.getString(2));
                    entityItem.setProductId(resultSet.getString(3));
                    entityItem.setItemDes(resultSet.getString(4));
                    entityItem.setPrice(resultSet.getString(5));
                    entityItem.setStock(resultSet.getInt(6));
                    dataList.add(entityItem);
                }
                break;
            /*case Constants.QUERY_SEARCH:

                break;*/
            case Constants.QUERY_SHOPPING_CART:
                ShoppingCart shoppingCart;
                Entity entity1;
                EntityItem entityItem1;
                String itemName,sqlCart="",sqlCartItem="";
                while (resultSet.next()){
                    shoppingCart = new ShoppingCart();
                    shoppingCart.setItemId(resultSet.getString(2));
                    shoppingCart.setproductName(resultSet.getString(3));
                    shoppingCart.setQuantity(resultSet.getInt(4));
                    itemName = shoppingCart.getproductName();
                    //item_id才是唯一的
                    sqlCart = "SELECT * FROM "+itemName+"  where Item_ID ="+"'"+shoppingCart.getItemId()+"'";
                    resultSetCart = statement1.executeQuery(sqlCart);
                    while (resultSetCart.next()){
                        entityItem1 = new EntityItem();
//                        entityItem1.setItemId(resultSet.getString(2));
                        entityItem1.setProductId(resultSetCart.getString(3));

                        //获取pets_item的信息
                        sqlCartItem = "SELECT * FROM "+itemName.substring(0,itemName.indexOf("_"))+"  where Product_ID ="+"'"+resultSetCart.getString(3)+"'";
                        resultSetCartItem = statement2.executeQuery(sqlCartItem);
                        while (resultSetCartItem.next()){
                            entity1 = new Entity();
                            entity1.setName(resultSetCartItem.getString(3));
                            entity1.setDes(resultSetCartItem.getString(4));
                            entity1.setPic_url(resultSetCartItem.getString(5));
                            shoppingCart.setProductHtmlNames(entity1.getName());
                            shoppingCart.setProductPicUrls(entity1.getPic_url());
                            shoppingCart.setProductDess(entity1.getDes());
                        }

                        entityItem1.setItemDes(resultSetCart.getString(4));
                        entityItem1.setPrice(resultSetCart.getString(5));
                        entityItem1.setStock(resultSetCart.getInt(6));
                        shoppingCart.setProductId(entityItem1.getProductId());
                        shoppingCart.setStock(entityItem1.getStock());
                        shoppingCart.setPrice(entityItem1.getPrice());
                        shoppingCart.setItemDes(entityItem1.getItemDes());
                    }



                    dataList.add(shoppingCart);
                }
                break;
            case Constants.ADD_SHOPPINGCART:
                dataList.add(result);//添加是否成功
                break;
            case Constants.QUERY_PROFILE:
                Register register = new Register();
                Register.Profile profile = register.new Profile();
                while (resultSet.next()){
                    profile.setBannerOption(resultSet.getString(5));
                    profile.setFavouriteCategoryId(resultSet.getString(3));
                    profile.setLanguagePreference(resultSet.getString(2));
                    profile.setListOption(resultSet.getString(4));
                    profile.setUsername(resultSet.getString(6));
                    dataList.add(profile);
                }
                break;
            case Constants.QUERY_ACCOUNT:
                Register register2 = new Register();
                while (resultSet.next()){
                    register2.setAddress1(resultSet.getString(5));
                    register2.setAddress2(resultSet.getString(6));
                    register2.setCity(resultSet.getString(7));
                    register2.setCountry(resultSet.getString(10));
                    register2.setEmail(resultSet.getString(4));
                    register2.setFirst_name(resultSet.getString(2));
                    register2.setLast_name(resultSet.getString(3));
                    register2.setState(resultSet.getString(8));
                    register2.setZip(resultSet.getString(9));
                    register2.setUsername(resultSet.getString(11));
                    register2.setPhone(resultSet.getString(12));

                    dataList.add(register2);
                }
                break;
            case Constants.UPDATE_SHOPPINGCART:
                dataList.add(result);//更新是否成功
                break;
            case Constants.QUERY_ORDER_ID:
                resultSet.next();
                dataList.add(resultSet.getInt(1));
                break;
            case Constants.QUERY_ORDER_LOCA_INFO:
                Register register3 = new Register();
                Register register4 = new Register();
                while (resultSet.next()){
                    register3.setFirst_name(resultSet.getString(5));
                    register3.setLast_name(resultSet.getString(6));
                    register3.setAddress1(resultSet.getString(7));
                    register3.setAddress2(resultSet.getString(8));
                    register3.setCity(resultSet.getString(9));
                    register3.setState(resultSet.getString(10));
                    register3.setZip(resultSet.getString(11));
                    register3.setCountry(resultSet.getString(12));

                    register4.setFirst_name(resultSet.getString(13));
                    register4.setLast_name(resultSet.getString(14));
                    register4.setAddress1(resultSet.getString(15));
                    register4.setAddress2(resultSet.getString(16));
                    register4.setCity(resultSet.getString(17));
                    register4.setState(resultSet.getString(18));
                    register4.setZip(resultSet.getString(19));
                    register4.setCountry(resultSet.getString(20));


                    dataList.add(register3);
                    dataList.add(register4);
                }

                /*//错误原因，调用了同一个resultSet
                Register register4 = new Register();
                while (resultSet_loc.next()){
                    register4.setFirst_name(resultSet_loc.getString(13));
                    register4.setLast_name(resultSet_loc.getString(14));
                    register4.setAddress1(resultSet_loc.getString(15));
                    register4.setAddress2(resultSet_loc.getString(16));
                    register4.setCity(resultSet_loc.getString(17));
                    register4.setState(resultSet_loc.getString(18));
                    register4.setZip(resultSet_loc.getString(19));
                    register4.setCountry(resultSet_loc.getString(20));

                    dataList.add(register4);
                }*/

                break;
            case Constants.QUERY_ORDER_0UTLINE_INFO:
                Order order = new Order();
                while (resultSet.next()){
//                    order.setId(resultSet.getString(1));
                    order.setDate(resultSet.getString(22));
                    order.setTotal_pri(resultSet.getString(23));//也可以指定列名来获取该值

                    dataList.add(order);
                }

                break;
            case Constants.QUERY_LOG_TIME:
//                Log log = new Log();这样会导致只添加了一个log对象
                Log log;
                while (resultSet.next()){
                    log = new Log();
                    log.setTime(resultSet.getString(2));
                    dataList.add(log);
                }
                break;

            case Constants.QUERY_LOG_COUNT:
//                Log log1 = new Log();
                Log log1;
                while (resultSet.next()){
                    log1 = new Log();
                    log1.setName(resultSet.getString(2));
                    log1.setCount(resultSet.getString(3));
                    dataList.add(log1);
                }
                break;
            case Constants.ADD_LOG:
                dataList.add(result);//添加是否成功
                break;

        }



        if (resultSet != null) {
            resultSet.close();
        }
        if (statement != null) {
            statement.close();
        }
        if (connection != null) {
            connection.close();
        }
        return dataList;
    }
}
