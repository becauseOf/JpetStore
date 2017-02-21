package action.user;

import bean.pets.Entity;
import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;
import dao.DAO;
import dao.HibernateDAO;
import define_constant.Constants;
import org.apache.struts2.ServletActionContext;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by gala on 2016/4/8.
 */
public class SearchAction extends ActionSupport {
    private List message,resultMessage,ajaxMessage;
    private String searchStr,productName,isAjax,result;
    private DAO dao;
    private String[] productTables = {"fish","dogs","reptiles","cats","birds"};
    private Entity resultEntity;
    private HibernateDAO hibernateDAO;
    @Override
    public String execute() throws Exception {
        ApplicationContext context = new ClassPathXmlApplicationContext("spring.xml");
        hibernateDAO = (HibernateDAO) context.getBean("hibernateDAO");
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpServletResponse response = ServletActionContext.getResponse();
        resultMessage = new ArrayList<>();
        ajaxMessage = new ArrayList<>();//似乎是由于没有创建ajaxMessage对象，就直接进行add
        searchStr = request.getParameter("keyword");
        isAjax = request.getParameter("isAjax");//似乎有问题

        PrintWriter out  = response.getWriter();
        for (int i = 0; i < productTables.length; i++) {

            message = hibernateDAO.QUERY_PRODUCT_OR_SEARCH(productTables[i]);
            //有待测试
            for (int j = 0; j < message.size(); j++) {

                productName = ((Entity) message.get(j)).getName();

                if (isSearchOk(searchStr,productName,isAjax)) {
                    if (isAjax == null) {
                        resultEntity = new Entity(productName,((Entity) message.get(j)).getId(),
                                ((Entity) message.get(j)).getDes(),((Entity) message.get(j)).getPic_url());
                        resultEntity.form_key = ((Entity) message.get(j)).form_key;//?
                        resultMessage.add(resultEntity);
                        request.getSession().setAttribute("search_form_name",productTables[i]);
                    }else{
                        ajaxMessage.add(productName);

                    }
                }

            }
            message.clear();

        }


        if (isAjax != null) {
            Gson gson = new Gson();
            this.result = gson.toJson(ajaxMessage);
            return SUCCESS;
            //out.write(string);
//            out.print(string);
        }else{
            request.getSession().setAttribute("searchDatas",resultMessage);
            return "Search";
        }
        //return "";
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    private boolean isSearchOk(String str, String productName, String isAjax){
        boolean isok = false,isLarge=false;
        if (isAjax=="") {
            return false;
        }
        if (isAjax == null) {
            isok = false;//防止input事件出问题
            //似乎用string.contains()方法或者sql通配符也可以解决问题
            int k = 0;
            //全部转化为大写
            productName = productName.toUpperCase();
            str = str.toUpperCase();
            char[] charsName = productName.toCharArray();
            char[] charsStr = str.toCharArray();
            for (int i = 0; i <charsName.length ; i++) {
                if (charsStr[0] == charsName[i]) {
                    k = i;
                    isok = true;
                    for (int j = 1; j < charsStr.length; j++) {
                        k++;
                        if (k < charsName.length) {
                            if (charsStr[j] != charsName[k]) {
                                isok = false;break;
                            }
                        }
                        else {//超出name的界限
                            isok = false;
                            isLarge = true;
                        }
                    }
                    if (isok||isLarge) {
                        break;//如果已经匹配成功或超出界限
                    }
                }
            }

        }else{
            isok = true;
        }
        return isok;
    }
    public HibernateDAO getHibernateDAO() {
        return hibernateDAO;
    }

    public void setHibernateDAO(HibernateDAO hibernateDAO) {
        this.hibernateDAO = hibernateDAO;
    }
}
