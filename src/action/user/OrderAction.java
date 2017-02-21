package action.user;

import bean.pets.ShoppingCart;
import bean.user.Order;
import bean.user.Register;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import dao.DAO;
import dao.HibernateDAO;
import define_constant.Constants;
import org.apache.struts2.ServletActionContext;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;

/**
 * Created by gala on 2016/4/8.
 */
public class OrderAction extends ActionSupport implements ModelDriven<Order>{

    Order order=new Order();
    DAO dao,dao1;
    List message_cart,message_order,message_order_outline;
    Register register,register1,register_payment;
    Register.Payment payment;

    private HibernateDAO hibernateDAO;
    @Override
    public String execute() throws Exception {
        ApplicationContext context = new ClassPathXmlApplicationContext("spring.xml");
        hibernateDAO = (HibernateDAO) context.getBean("hibernateDAO");
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpServletResponse response = ServletActionContext.getResponse();
        if (request.getMethod() == "POST") {

            String shippingAddressRequired = request.getParameter("shippingAddressRequired");

            if (request.getParameter("is_confirm") == null) {//执行正常操作

                if (request.getParameter("is_shipping") == null) {

                    //进行Payment Details以及Billing Address信息的保存

                    register_payment = new Register();
                    payment = register_payment.new Payment(order.getCardType(),order.getCreditCard(),order.getExpiryDate());
                    request.getSession().setAttribute("payment",payment);

                    request.getSession().removeAttribute("shipping");

                    if (shippingAddressRequired != null) {//跳转到设置Shipping Address的界面

                        register = new Register(order.getBillToFirstName(),order.getBillToLastName(),""
                                ,order.getBillAddress1(),order.getBillAddress2(),order.getBillCity(),order.getBillState(),order.getBillZip(),
                                order.getBillCountry(),"","");
                        request.getSession().setAttribute("register_",register);
                        return "OrderShipingAddress";
                    }else{//直接跳转到确认订单界面,Shipping Address默认为Billing Address

                        register = new Register(order.getBillToFirstName(),order.getBillToLastName(),""
                                ,order.getBillAddress1(),order.getBillAddress2(),order.getBillCity(),order.getBillState(),order.getBillZip(),
                                order.getBillCountry(),"","");

                        request.getSession().setAttribute("register_",register);
                        return "OrderFormOk";
                    }
                }else{//进行Shipping Address的信息的保存，然后跳转到确认订单的界面
                    register1 = new Register(order.getShipToFirstName(),order.getShipToLastName(),""
                            ,order.getShipAddress1(),order.getShipAddress2(),order.getShipCity(),order.getShipState(),order.getShipZip(),
                            order.getShipCountry(),"","");
                    //request.getSession().removeAttribute("shipping");
                    request.getSession().setAttribute("shipping",register1);

                    return "OrderFormOk";
                }

            }else{//将订单的所有信息保存到数据库
            /*
            * 保存的信息有Payment Details以及Billing Address，Shipping Address，订单号，订单时间。
            * 订单内容()直接获取当前购物车的信息
            * 除此之外，还得做好清空购物车的操作，在购物车数据库中修改相关数据
            * */
            /*//清空购物车,清空购物车的数据库信息
            request.getSession().removeAttribute("datas_cart");*/

                List myShoppingData =(List) request.getSession().getAttribute("datas_cart");
                for (int i = 0; i < myShoppingData.size(); i++) {

                    hibernateDAO.UPDATE_SHOPPINGCART_ORDER(request.getParameter("order_id"),((ShoppingCart)myShoppingData.get(i)).getItemId(),request.getSession().getAttribute("username").toString());
                }


                register = (Register) request.getSession().getAttribute("register_order");
                register1 = (Register) request.getSession().getAttribute("register1_order");


                Register.Payment payment_info = (Register.Payment)request.getSession().getAttribute("payment");



                hibernateDAO.ADD_ORDER(Integer.parseInt(request.getParameter("order_id")),request.getParameter("date"),request.getSession().getAttribute("sum_cart").toString(),register1.getFirst_name(),
                        register1.getLast_name(),register1.getAddress1(),
                        register1.getAddress2(),register1.getCity(),register1.getState(),
                        register1.getZip(),register1.getCountry(),register.getFirst_name(),
                        register.getLast_name(),register.getAddress1(),
                        register.getAddress2(),register.getCity(),
                        register.getState(),register.getZip(),
                        register.getCountry(),payment_info.getOrder_creditCard(),payment_info.getOrder_expiryDate(),
                        payment_info.getOrder_cardType(),request.getSession().getAttribute("username").toString());

                return "OrderFormFinal";
            }

        }else{

            //涉及两个查询，一个是订单页面的查询，另外一个则是订单详情页的查询
            //需要设置订单等信息以及设置订单商品（购物车）的信息

            //订单号似乎存在问题
            dao = new DAO();
            dao1 = new DAO();

        /*
        * 错误原因所在，运用了同一个dao的对象，导致数据重叠
        * */

            if (request.getParameter("order_id") == null) {


                message_order_outline = hibernateDAO.QUERY_ORDER_0UTLINE_INFO(request.getSession().getAttribute("username").toString());

                request.getSession().setAttribute("message_order_outline",message_order_outline);
                return "ShowOrder";
            }else{



                message_order = hibernateDAO.QUERY_ORDER_LOCA_INFO(Integer.parseInt(request.getParameter("order_id")),request.getSession().getAttribute("username").toString());
                message_cart = hibernateDAO.QUERY_SHOPPING_CART(request.getSession().getAttribute("username").toString(),request.getParameter("order_id"));


                request.getSession().setAttribute("datas_cart",message_cart);

//                这里需要重新设置，因为message_order中存储的不再是register对象！！！！

                request.getSession().setAttribute("register_order_ser",message_order.get(0));//设置两个地址的信息
                request.getSession().setAttribute("register1_order_ser",message_order.get(1));//为shipping地址

                return "OrderFormFinal";
            }

        }
    }

    @Override
    public Order getModel() {
        return order;
    }
    public HibernateDAO getHibernateDAO() {
        return hibernateDAO;
    }

    public void setHibernateDAO(HibernateDAO hibernateDAO) {
        this.hibernateDAO = hibernateDAO;
    }
}
