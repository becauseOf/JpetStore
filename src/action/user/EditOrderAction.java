package action.user;

import com.opensymphony.xwork2.ActionSupport;

/**
 * Created by gala on 2016/4/8.
 */
public class EditOrderAction extends ActionSupport {
    @Override
    public String execute() throws Exception {
        return "OrderForm";
    }
}
