package action.user;

import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by gala on 2016/4/10.
 */
public class ChangeLanguageAction extends ActionSupport {
    @Override
    public String execute() throws Exception {
        HttpServletRequest request = ServletActionContext.getRequest();
        if ( request.getParameter("login")== null) {
            return "register";
        }else{
            return "login";
        }
    }
}
