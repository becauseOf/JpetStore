package action.pets;

import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by gala on 2016/4/8.
 */
public class PetsInfoAction extends ActionSupport {
    @Override
    public String execute() throws Exception {
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpServletResponse response = ServletActionContext.getResponse();


        request.setAttribute("itemId",request.getParameter("itemId"));
        request.setAttribute("stock",request.getParameter("stock"));
        request.setAttribute("itemPrice",request.getParameter("itemPrice"));
        request.setAttribute("num_item",request.getParameter("num_item"));

        return "PetsInfo";
    }
}
