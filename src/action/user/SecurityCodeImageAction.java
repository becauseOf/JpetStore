package action.user;

import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.ServletActionContext;
import util.SecurityCode;
import util.SecurityImage;

import javax.servlet.http.HttpServletRequest;
import java.io.ByteArrayInputStream;

/**
 * Created by gala on 2016/4/10.
 */
public class SecurityCodeImageAction extends ActionSupport {

    //
    public ByteArrayInputStream getImageStream() {
        return imageStream;
    }

    public void setImageStream(ByteArrayInputStream imageStream) {
        /*String securityCode = SecurityCode.getSecurityCode();
        imageStream = SecurityImage.getImageAsInputStream(securityCode);*/
        this.imageStream = imageStream;
    }

    //图片流
    private ByteArrayInputStream imageStream;

    @Override
    public String execute() throws Exception {
        HttpServletRequest request = ServletActionContext.getRequest();
        //获取默认难度和长度的验证码
        String securityCode = SecurityCode.getSecurityCode();
        imageStream = SecurityImage.getImageAsInputStream(securityCode);
        //放入session中
        request.getSession().setAttribute("securityCode", securityCode);
        return SUCCESS;
    }
}
