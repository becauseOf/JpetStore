package myinterceptor;


import bean.user.Log;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;
import dao.DAO;
import dao.HibernateDAO;
import define_constant.Constants;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletRequest;
import java.sql.SQLException;
import java.util.List;

/**
 * Created by gala on 2016/4/11.
 */
public class ProductInterceptor implements Interceptor {
    private HibernateDAO hibernateDAO = new HibernateDAO();

    @Override
    public void destroy() {

    }

    @Override
    public void init() {

    }

    @Override
    public String intercept(ActionInvocation actionInvocation) throws Exception {

        HttpServletRequest request = ServletActionContext.getRequest();

        String result = actionInvocation.invoke();
//        System.out.print(request.getParameter("name")+"aa");
        /*
        * 进行插入数据库操作
        * 首先查看数据库中有没有该记录，没有的就进行插入，次数为1
        * 如果如果数据库中已经有该记录，则更新次数值（先获取次数值，然后+1后更新数据库值）*/
        DAO dao = new DAO();
        List list = null;
        try {
            list = dao.connect("select * from log_view_pes_type where type = '"+request.getParameter("name")+"'", Constants.QUERY,Constants.QUERY_LOG_COUNT);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        if (list.size() == 0) {
            dao = new DAO();
            try {
                dao.connect("insert into log_view_pes_type ( type, count ) values ( '"+request.getParameter("name")+"', 1 )", Constants.OTHER_OPERATE,Constants.ADD_LOG);
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }else{
            dao = new DAO();
            try {
                int count = Integer.parseInt(((Log) list.get(0)).getCount())+1;
                dao.connect("update log_view_pes_type SET count = "+count+" where type = '"+request.getParameter("name")+" '", Constants.OTHER_OPERATE,Constants.ADD_LOG);
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return result;
    }
}
