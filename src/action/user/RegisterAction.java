package action.user;

import bean.user.Login;
import bean.user.Register;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import dao.DAO;
import dao.HibernateDAO;
import define_constant.Constants;
import org.apache.struts2.ServletActionContext;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import util.SecurityCode;
import util.SecurityImage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayInputStream;
import java.io.PrintWriter;
import java.sql.SQLException;

/**
 * Created by gala on 2016/4/8.
 */
public class RegisterAction extends ActionSupport implements ModelDriven<Register>{

    private Register register = new Register();
    private Register.Profile profile = register.new Profile();

    private String error;
    private String error1;
    private HibernateDAO hibernateDAO;


    @Override
    public String execute() throws Exception {
        ApplicationContext context = new ClassPathXmlApplicationContext("spring.xml");
        hibernateDAO = (HibernateDAO) context.getBean("hibernateDAO");
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpServletResponse response = ServletActionContext.getResponse();
        String username;
        if (request.getMethod() == "POST") {

            //对于checkbox的值，选中为true，否则为null
            username =request.getParameter("username");
            String password = request.getParameter("password");
            String repeatedPassword = request.getParameter("repeatedPassword");

            if (!password.equals(repeatedPassword)) {
                error1 ="两次密码不一致";
            }

            if (error1 == null&&!password.equals("")&&!username.equals("")) {

                hibernateDAO.ADD_ACCOUNT(username,password,register.getFirst_name() , register.getLast_name(), register.getEmail(), register.getPhone(),register.getAddress1()
                        ,register.getAddress2()
                        , register.getCity()
                        , register.getState()
                        , register.getZip()
                        ,register.getCountry(),profile.getLanguagePreference() ,profile.getFavouriteCategoryId() ,profile.getListOption()
                                ,profile.getBannerOption());
                return "success";
            }else{
                request.getSession().setAttribute("error",error);
                request.getSession().setAttribute("error1",error1);
                return "register";
            }
        }else{
            return SUCCESS;
        }
    }

    @Override
    public Register getModel() {
        return register;
    }

    public Register getRegister() {
        return register;
    }

    public void setRegister(Register register) {
        this.register = register;
    }
    public HibernateDAO getHibernateDAO() {
        return hibernateDAO;
    }

    public void setHibernateDAO(HibernateDAO hibernateDAO) {
        this.hibernateDAO = hibernateDAO;
    }
}
