package action.user;

import com.opensymphony.xwork2.ActionSupport;
import dao.DAO;
import dao.HibernateDAO;
import define_constant.Constants;
import org.apache.struts2.ServletActionContext;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by gala on 2016/4/11.
 */
public class LogAction extends ActionSupport{
    private List times;
    private List productsCounts;
    private List petsCounts;
    private Map logMap;

    private HibernateDAO hibernateDAO;
    @Override
    public String execute() throws Exception {
        HttpServletRequest request = ServletActionContext.getRequest();

        ApplicationContext context = new ClassPathXmlApplicationContext("spring.xml");
        hibernateDAO = (HibernateDAO) context.getBean("hibernateDAO");
        times = hibernateDAO.QUERY_LOG_TIME();
        productsCounts = hibernateDAO.QUERY_LOG_COUNT("log_view_product");
        petsCounts = hibernateDAO.QUERY_LOG_COUNT("log_view_pes_type");

        logMap = new HashMap<>();//差点忘记New了

        logMap.put("times",times);
        logMap.put("productsCounts",productsCounts);
        logMap.put("petsCounts",petsCounts);

        request.getSession().setAttribute("logMap",logMap);

        return "log";
    }
    public HibernateDAO getHibernateDAO() {
        return hibernateDAO;
    }

    public void setHibernateDAO(HibernateDAO hibernateDAO) {
        this.hibernateDAO = hibernateDAO;
    }
}
