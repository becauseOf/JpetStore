package action.pets;

import com.opensymphony.xwork2.ActionSupport;
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

public class PetsItemAction extends ActionSupport {
    private List message,productHtmlNames,productPicUrls;
    private String productId,productName;
    private int i;
    private HibernateDAO hibernateDAO;
    @Override
    public String execute() throws Exception {
        HttpServletRequest request = ServletActionContext.getRequest();
        productId = request.getParameter("productId");
        productName = request.getParameter("productName");
        productHtmlNames = (List) request.getSession().getAttribute("productHtmlNames");
        productPicUrls = (List) request.getSession().getAttribute("productPicUrls");
        i = Integer.parseInt(request.getParameter("num"));

        ApplicationContext context = new ClassPathXmlApplicationContext("spring.xml");
        hibernateDAO = (HibernateDAO) context.getBean("hibernateDAO");
        message = hibernateDAO.QUERY_PRODECT_ITEM(productName+"_item",productId);
        request.getSession().setAttribute("productName",productName);
        request.getSession().setAttribute("productHtmlNames",productHtmlNames);
        request.getSession().setAttribute("num",i);
        request.getSession().setAttribute("itemDatas",message);
        request.getSession().setAttribute("productPicUrls",productPicUrls);
        return "PetsItem";
    }

    public HibernateDAO getHibernateDAO() {
        return hibernateDAO;
    }

    public void setHibernateDAO(HibernateDAO hibernateDAO) {
        this.hibernateDAO = hibernateDAO;
    }
}
