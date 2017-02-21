package action.user;

import bean.user.Login;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import dao.DAO;
import dao.HibernateDAO;
import define_constant.Constants;
import org.apache.struts2.ServletActionContext;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import util.Md5;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

/**
 * Created by gala on 2016/4/8.
 */
public class LoginAction extends ActionSupport implements ModelDriven<Login>{
    private List message;
    private Login login = new Login();
    private DAO dao;
    private HibernateDAO hibernateDAO;
    @Override
    public String execute() throws Exception {
        HttpServletRequest request = ServletActionContext.getRequest();
        if (request.getMethod() == "POST") {
            ApplicationContext context = new ClassPathXmlApplicationContext("spring.xml");
            hibernateDAO = (HibernateDAO) context.getBean("hibernateDAO");
            message = hibernateDAO.QUERY_USER(login.getUserName(), Md5.toMD5(login.getPassWord()));
//session值即使sendredirct之后也不会消失，而request.setAttribute则会消失
            if ( (boolean)((Map) message.get(0)).get(Constants.IS_LOGIN_SUCCESS)) {
                String href = "success";
                request.getSession().setAttribute("href",href);

                request.getSession().setAttribute("username",login.getUserName());

                request.getSession().removeAttribute("error_login");
                return "success";
            }else {
                String error = "用户名或密码错误，请重新登录";
                request.setAttribute("error",error);
                return "login";
            }

        }else{
            if (request.getParameter("signIn") == null) {
                return "LoginOut";
            }else
                return "login";
        }
    }

    @Override
    public Login getModel() {
        return login;
    }
    public HibernateDAO getHibernateDAO() {
        return hibernateDAO;
    }

    public void setHibernateDAO(HibernateDAO hibernateDAO) {
        this.hibernateDAO = hibernateDAO;
    }
}
