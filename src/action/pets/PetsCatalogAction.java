package action.pets;

import bean.pets.Entity;
import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;
import dao.DAO;
import dao.HibernateDAO;
import define_constant.Constants;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.xml.XmlBeanFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by gala on 2016/4/8.
 */
public class PetsCatalogAction extends ActionSupport {
    private List message,ajaxPetInfo;
    private String petsName,result;
    private HibernateDAO hibernateDAO;
    @Override
    public String execute() throws Exception {
        HttpServletRequest request = ServletActionContext.getRequest();
        ajaxPetInfo = new ArrayList<>();
        petsName = request.getParameter("name");

        ApplicationContext context = new ClassPathXmlApplicationContext("spring.xml");
        hibernateDAO = (HibernateDAO) context.getBean("hibernateDAO");

        message = hibernateDAO.QUERY_PRODUCT_OR_SEARCH(petsName);
        for (int i = 0; i < message.size(); i++) {
            ajaxPetInfo.add(((Entity) message.get(i)).getName());
        }
        if (request.getParameter("isAjax") == null) {
            request.getSession().setAttribute("petsName",petsName);
            request.getSession().setAttribute("datas",message);
            return "PetsCatalog";
        }else{
            //获取本类目的所有动物名字
            Gson gson = new Gson();
            this.result = gson.toJson(ajaxPetInfo);
            return SUCCESS;
            //out.print(string);
        }
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public HibernateDAO getHibernateDAO() {
        return hibernateDAO;
    }

    public void setHibernateDAO(HibernateDAO hibernateDAO) {
        this.hibernateDAO = hibernateDAO;
    }
}
