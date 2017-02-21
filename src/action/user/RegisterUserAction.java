package action.user;

import bean.user.Register;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

/**
 * Created by gala on 2016/4/12.
 */
public class RegisterUserAction extends ActionSupport {
    private String username;
    @Override
    public String execute() throws Exception {
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpServletResponse response = ServletActionContext.getResponse();
        username =request.getParameter("username");

        if (request.getParameter("code") == null) {
            if (username == null) {

                return "register";//简单页面跳转，实现跳转到注册页面
            }else {
                Register register = new Register();
                register.setUsername(username);

                response.setContentType("text/xml");
                PrintWriter out = response.getWriter();

                if (register.usernameIsExist()) {
                    out.println("<msg>exist</msg>");
                }else{
                    out.println("<msg>notexist</msg>");
                }
                out.flush();
                out.close();
                return SUCCESS;
            }
        }else {
            response.setContentType("text/xml");
            PrintWriter out = response.getWriter();
            if (!request.getSession().getAttribute("securityCode").toString().equals(request.getParameter("code"))) {
                out.println("<msg>not correct</msg>");
            }else{
                out.println("<msg>correct</msg>");
            }
            out.flush();
            out.close();
            return SUCCESS;
        }
    }
}
