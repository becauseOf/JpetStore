package action.user;

import bean.pets.ShoppingCart;
import bean.user.Register;
import com.opensymphony.xwork2.ActionSupport;
import dao.DAO;
import dao.HibernateDAO;
import define_constant.Constants;
import org.apache.struts2.ServletActionContext;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 * Created by gala on 2016/4/8.
 */
public class ShoppingCartAction extends ActionSupport {
    private List datas_cart;
    private String itemId,is_add,productName,productHtmlNames,isUpdate,item_str,item_remove;
    private int quantity;
    private HibernateDAO hibernateDAO;


    @Override
    public String execute() throws Exception {
        ApplicationContext context = new ClassPathXmlApplicationContext("spring.xml");
        hibernateDAO = (HibernateDAO) context.getBean("hibernateDAO");
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpServletResponse response = ServletActionContext.getResponse();
        if (request.getMethod() == "POST") {
            //isupdate属性似乎不需要
            isUpdate = request.getParameter("Update_Cart");

            //将所有的物品的个数进行保存到数据库，并进行界面的更新


            List datas_cart = (List) request.getSession().getAttribute("datas_cart");
            DAO dao;
            for (int i = 0; i <datas_cart.size() ; i++) {
                dao = new DAO();
                item_str =((ShoppingCart) datas_cart.get(i)).getItemId();
                quantity = Integer.parseInt(request.getParameter(item_str));


                hibernateDAO.UPDATE_SHOPPINGCART(quantity,item_str,"update");

            }

            return get(request, response);
        }else{
            return get(request, response);
        }
    }

    private String get(HttpServletRequest request,HttpServletResponse response){
        ApplicationContext context = new ClassPathXmlApplicationContext("spring.xml");
        hibernateDAO = (HibernateDAO) context.getBean("hibernateDAO");
        String islogin = (String) request.getSession().getAttribute("href");
        Register register=new Register();
        if (islogin==null) {
            request.getSession().setAttribute("error_login","You must sign on before attempting to check out.  Please sign on and try checking out again.");
            return "login";
        }
        else{
            is_add = request.getParameter("is_add");
            if (request.getParameter("is_remove") != null) {//进行移除

                item_remove = request.getParameter("item_remove");



                hibernateDAO.UPDATE_SHOPPINGCART(1,item_remove,"remove");
                datas_cart = hibernateDAO.QUERY_SHOPPING_CART(request.getSession().getAttribute("username").toString(),"");
            }else{
                if (is_add != null) {//进行添加购物车信息

                    productHtmlNames = (String)   ((List) request.getSession().getAttribute("productHtmlNames")).get((int)request.getSession().getAttribute("num"));//Integer.parseInt((String) request.getSession().getAttribute("num"))
                    //productName = request.getParameter("productName");
                    productName = (String) request.getSession().getAttribute("petsName")+"_item";
                    itemId = request.getParameter("itemId");
                    quantity = 1;

                    hibernateDAO.ADD_SHOPPINGCART(itemId,productName,quantity,request.getSession().getAttribute("username").toString());


                    datas_cart = hibernateDAO.QUERY_SHOPPING_CART(request.getSession().getAttribute("username").toString(),"");
                }else {//进行查询购物车

                    datas_cart = hibernateDAO.QUERY_SHOPPING_CART(request.getSession().getAttribute("username").toString(),"");

                }
            }
            request.getSession().setAttribute("datas_cart",datas_cart);
            return "AddCart";
        }
    }

    public List getDatas_cart() {
        return datas_cart;
    }

    public void setDatas_cart(List datas_cart) {
        this.datas_cart = datas_cart;
    }
    public HibernateDAO getHibernateDAO() {
        return hibernateDAO;
    }

    public void setHibernateDAO(HibernateDAO hibernateDAO) {
        this.hibernateDAO = hibernateDAO;
    }
}
