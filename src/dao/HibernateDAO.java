package dao;

import bean.pets.Entity;
import bean.pets.EntityItem;
import bean.pets.ShoppingCart;
import bean.user.Log;
import bean.user.Login;
import bean.user.Order;
import bean.user.Register;
import define_constant.Constants;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.hibernate.exception.ConstraintViolationException;
import org.hibernate.transform.AliasToBeanResultTransformer;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import util.Md5;

import java.math.BigInteger;
import java.util.*;

/**
 * Created by gala on 2016/5/7.
 */
public class HibernateDAO {
    private List dataList;


    public List QUERY_USER(String userName,String passWord){


        dataList = new ArrayList<>();
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Query query;
        if (passWord == "") {
            query = session.createQuery("from Login WHERE userName =?");
            query.setString(0,userName);
        }else{
            query = session.createQuery("from Login WHERE userName =? and passWord =? ");
            query.setString(0,userName);
            query.setString(1,passWord);
        }

        List list = query.list();//元素为Login对象

        Map<Integer,Boolean> map = new HashMap<>();
        if (list.size()==0) {
            map.put(Constants.IS_LOGIN_SUCCESS,false);
        }else {
            map.put(Constants.IS_LOGIN_SUCCESS,true);
        }
        dataList.add(map);

        session.getTransaction().commit();


        return dataList;

//        transaction.commit();
    }

    public void ADD_ACCOUNT(String userName,String passWord,String first_name, String last_name, String email,  String phone, String address1, String address2, String city, String state, String zip, String country, String language_preference, String favourite_category, String enable_myList, String enable_myBanner){
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Login login = new Login(userName, Md5.toMD5(passWord));
        Register register = new Register(first_name, last_name, email,  phone, address1, address2, city, state, zip, country, userName);

        Register register1 = new Register();
        Register.Profile profile = register1.new Profile(language_preference, favourite_category, enable_myList, enable_myBanner, userName);

        session.save(login);
        session.save(register);
        session.save(profile);
        session.getTransaction().commit();

    }

    public List QUERY_PRODUCT_OR_SEARCH(String tableName){
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Query query =  session.createSQLQuery("SELECT * FROM "+tableName);

        List<Object[]> list =query.list();
        dataList = new ArrayList<>();
        Entity entity;
        Object[] object;
        Iterator<Object[]> iterator = list.iterator();
        while (iterator.hasNext()){
            entity = new Entity();
            object = iterator.next();
            entity.setForm_key((int) object[0]);
            entity.setId(object[1].toString());
            entity.setName(object[2].toString());
            entity.setDes(object[3].toString());
            entity.setPic_url(object[4].toString());
//            又TM忘记New了！
            dataList.add(entity);
        }


        session.getTransaction().commit();


        return dataList;
    }

    public List QUERY_PRODECT_ITEM(String tableName,String id){
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Query query =  session.createSQLQuery("select * from " +tableName+"  where Product_ID ="+"'"+id+"'");

        List<Object[]> list =query.list();
        dataList = new ArrayList<>();
        EntityItem entityItem;
        Object[] object;
        Iterator<Object[]> iterator = list.iterator();
        while (iterator.hasNext()){
            entityItem = new EntityItem();
            object = iterator.next();
            entityItem.setItemId(object[1].toString());
            entityItem.setProductId(object[2].toString());
            entityItem.setItemDes(object[3].toString());
            entityItem.setPrice(object[4].toString());
            entityItem.setStock((int) object[5]);

//            又TM忘记New了！
            dataList.add(entityItem);
        }


        session.getTransaction().commit();


        return dataList;
    }

    public List QUERY_SHOPPING_CART(String userName,String orderId){
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        String name;
        String id;
        ShoppingCart shoppingCart;
        List list1=new ArrayList<>();
        List list2=new ArrayList<>();
        Entity entity;
        EntityItem entityItem;

        //List list = session.createSQLQuery("select * from " +"shopping_cart where username = '"+userName+"' and order_id is null").addEntity(ShoppingCart.class).list();
        Query query1;
        if (orderId == "") {
            query1 = session.createQuery("from ShoppingCart where order_id is null and userName = ?");
            query1.setString(0,userName);
        }else{
            query1 = session.createQuery("from ShoppingCart where order_id =? and userName = ?");
            query1.setInteger(0,Integer.parseInt(orderId));
            query1.setString(1,userName);
        }


        List list =query1.list();


        Iterator<ShoppingCart> iterator = list.iterator();
        Iterator<EntityItem> iterator1;
        Iterator<Entity> iterator2;
        while (iterator.hasNext()){
            shoppingCart = iterator.next();
            id = shoppingCart.getItemId();
            name = shoppingCart.getproductName();
            //list1 = session.createSQLQuery("SELECT * FROM "+name+"  where Item_ID ="+"'"+id+"'").addEntity(EntityItem.class).list();


            Query query =  session.createSQLQuery("SELECT * FROM "+name+"  where Item_ID ="+"'"+id+"'");

            List<Object[]> listTemp =query.list();
            //dataList = new ArrayList<>();
            Object[] object;
            Iterator<Object[]> iteratorTemp = listTemp.iterator();
            while (iteratorTemp.hasNext()){
                entityItem = new EntityItem();
                object = iteratorTemp.next();
                entityItem.setItemId(object[1].toString());
                entityItem.setProductId(object[2].toString());
                entityItem.setItemDes(object[3].toString());
                entityItem.setPrice(object[4].toString());
                entityItem.setStock((int) object[5]);

//            又TM忘记New了！
                list1.add(entityItem);
            }


            iterator1 = list1.iterator();
            while (iterator1.hasNext()){
                entityItem = iterator1.next();
                shoppingCart.setProductId(entityItem.getProductId());
                shoppingCart.setStock(entityItem.getStock());
                shoppingCart.setPrice(entityItem.getPrice());
                shoppingCart.setItemDes(entityItem.getItemDes());

                //list2 = session.createSQLQuery("SELECT * FROM "+name.substring(0,name.indexOf("_"))+"  where Product_ID ="+"'"+entityItem.getProductId()+"'").addEntity(Entity.class).list();

                Query query2 =  session.createSQLQuery("SELECT * FROM "+name.substring(0,name.indexOf("_"))+"  where Product_ID ="+"'"+entityItem.getProductId()+"'");

                List<Object[]> listTemp2 =query2.list();
                //dataList = new ArrayList<>();
                Object[] object2;
                Iterator<Object[]> iteratorTemp2 = listTemp2.iterator();
                while (iteratorTemp2.hasNext()){
                    entity = new Entity();
                    object2 = iteratorTemp2.next();
                    entity.setForm_key((int) object2[0]);
                    entity.setId(object2[1].toString());
                    entity.setName(object2[2].toString());
                    entity.setPic_url(object2[4].toString());
                    entity.setDes(object2[3].toString());

//            又TM忘记New了！
                    list2.add(entity);
                }

                iterator2 = list2.iterator();
                while (iterator2.hasNext()){
                    entity = iterator2.next();
                    shoppingCart.setProductHtmlNames(entity.getName());
                    shoppingCart.setProductPicUrls(entity.getPic_url());
                    shoppingCart.setProductDess(entity.getDes());
                }
            }
        }

        try {
            session.getTransaction().commit();
        }catch (ConstraintViolationException e){
            System.out.print(e+"sssssssssssssssss");
        }

        /*
        * 这里存在一个疑惑，使用迭代器遍历之后里面存储的对象改变了吗？还是要重新放入List才行呢？*/
        return list;
    }

    public void ADD_SHOPPINGCART(String item_id, String product_name,int quantity,String username){
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        ShoppingCart shoppingCart = new ShoppingCart(item_id, product_name, quantity,username);

        session.save(shoppingCart);
        session.getTransaction().commit();
    }


    public List QUERY_PROFILE(String userName){
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Query query = session.createQuery("from a WHERE username =? ");
        query.setString(0,userName);
        dataList = query.list();

        session.getTransaction().commit();

        return dataList;
    }

    public List QUERY_ACCOUNT(String userName){
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Query query = session.createQuery("from Register WHERE username =? ");
        query.setString(0,userName);
        dataList = query.list();

        session.getTransaction().commit();

        return dataList;
    }

    public void UPDATE_SHOPPINGCART(int quantity,String itemId,String type){
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        ShoppingCart shoppingCart = new ShoppingCart();

        if (type == "update") {
            Query query = session.createQuery("update ShoppingCart set quantity=? where itemId=?");
            query.setInteger(0,quantity);
            query.setString(1,itemId);
            /*shoppingCart = session.get(ShoppingCart.class,itemId);
            shoppingCart.setItemId(itemId);
            shoppingCart.setQuantity(quantity);*/
            query.executeUpdate();
        }else{
            Query query = session.createQuery("delete from ShoppingCart where itemId=?");
            query.setString(0,itemId);
            query.executeUpdate();
        }
//        session.update(shoppingCart);
        session.getTransaction().commit();
    }

    public void UPDATE_SHOPPINGCART_ORDER(String orderId,String itemId,String userName){
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        ShoppingCart shoppingCart = new ShoppingCart();

        Query query = session.createQuery("update ShoppingCart set order_id=? where itemId=? and userName=?");
        query.setString(0,orderId);
        query.setString(1,itemId);
        query.setString(2,userName);

        query.executeUpdate();
        session.getTransaction().commit();
    }

    public List QUERY_ORDER_ID(){
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Query query =  session.createSQLQuery("select count(*) from `order`");

        List<BigInteger> list =query.list();
        dataList = new ArrayList<>();
        Object[] object;
        BigInteger  integer;
        Iterator<BigInteger > iterator = list.iterator();
        while (iterator.hasNext()){
//            object = iterator.next();
            integer = iterator.next();
//            又TM忘记New了！
            dataList.add(integer);
        }


        session.getTransaction().commit();


        return dataList;
    }

    public List QUERY_ORDER_LOCA_INFO(int id,String username){
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Query query =  session.createQuery("from Order where id =? and username =?");
        query.setInteger(0,id);
        query.setString(1,username);
        List list = query.list();

        session.getTransaction().commit();
        Order order = (Order) list.get(0);

        Register register3 = new Register(order.getBillToFirstName(),order.getBillToLastName(),"",order.getBillAddress1(),order.getBillAddress2(),order.getBillCity(),order.getBillState(),order.getBillZip(),order.getBillCountry(),"","");
        Register register4 = new Register(order.getShipToFirstName(),order.getShipToLastName(),"",order.getShipAddress1(),order.getShipAddress2(),order.getShipCity(),order.getShipState(),order.getShipZip(),order.getShipCountry(),"","");

        dataList = new ArrayList<>();
        dataList.add(register3);
        dataList.add(register4);

        return dataList;
    }

    public void ADD_ORDER(int id, String date, String total_pri, String shipToFirstName, String shipToLastName, String shipAddress1, String shipAddress2, String shipCity, String shipState, String shipZip, String shipCountry, String billToFirstName, String billToLastName, String billAddress1, String billAddress2, String billCity, String billState, String billZip, String billCountry, String creditCard, String expiryDate, String cardType, String username){
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Order order = new Order( id,  date,  total_pri,  shipToFirstName,  shipToLastName,  shipAddress1,  shipAddress2,  shipCity,  shipState,  shipZip,  shipCountry,  billToFirstName,  billToLastName,  billAddress1,  billAddress2,  billCity,  billState,  billZip,  billCountry,  creditCard,  expiryDate,  cardType,  username);

        session.save(order);
        session.getTransaction().commit();
    }

    public List QUERY_ORDER_0UTLINE_INFO(String username){
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Query query =  session.createQuery("from Order where username =?");
        query.setString(0,username);
        dataList = query.list();

        session.getTransaction().commit();


        return dataList;
    }

    public List QUERY_LOG_TIME(){
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Query query =  session.createSQLQuery("select * from log_view_time");

        List<Object[]> list =query.list();
        dataList = new ArrayList<>();
        Log log;
        Object[] object;
        Iterator<Object[]> iterator = list.iterator();
        while (iterator.hasNext()){
            log = new Log();
            object = iterator.next();
            log.setTime(object[1].toString());

//            又TM忘记New了！
            dataList.add(log);
        }


        session.getTransaction().commit();


        return dataList;
    }

    public List QUERY_LOG_COUNT(String tableName){
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Query query =  session.createSQLQuery("select * from " +tableName);

        List<Object[]> list =query.list();
        dataList = new ArrayList<>();
        Log log;
        Object[] object;
        Iterator<Object[]> iterator = list.iterator();
        while (iterator.hasNext()){
            log = new Log();
            object = iterator.next();
            log.setName(object[1].toString());
            log.setCount(object[2].toString());

//            又TM忘记New了！
            dataList.add(log);
        }


        session.getTransaction().commit();


        return dataList;
    }

//    此功能需要进一步实现
    public List ADD_LOG(){
        return dataList;
    }







}
