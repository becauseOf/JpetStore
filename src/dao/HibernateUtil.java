package dao;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 * Created by gala on 2016/5/7.
 */
public class HibernateUtil {
    private static final SessionFactory sessionFactory = buildSessionFactory();

    private static SessionFactory buildSessionFactory(){
        /*try {
            return new Configuration().configure().buildSessionFactory();
        }catch (Throwable ex){
            System.out.println(ex);
            throw new ExceptionInInitializerError(ex);
        }*/
        ApplicationContext context= new ClassPathXmlApplicationContext("/spring.xml");
        SessionFactory sessionFactory =(SessionFactory) context.getBean("sessionFactory");
        return sessionFactory;
    }


    public static SessionFactory getSessionFactory(){
        /*ApplicationContext context= new ClassPathXmlApplicationContext("/spring.xml");
        SessionFactory sessionFactory =(SessionFactory) context.getBean("sessionFactory");*/
        return sessionFactory;
    }
}
