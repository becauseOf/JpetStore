package bean.user;

import dao.DAO;
import dao.HibernateDAO;
import define_constant.Constants;

import javax.persistence.*;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

/**
 * Created by gala on 2016/3/15.
 */
@Entity
@Table(name="account")
public class Register {
    private String first_name;
    private String last_name;
    private String email;
    private String address1;
    private String address2;
    private String city;
    private String state;
    private String zip;//邮编
    private String country;
    private String username;
    private String phone;
    @Id
    private long id;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    @Entity(name = "a")
    @Table(name = "profile")
    public class Profile {
        @Column(name = "language_preference")
        private String languagePreference;
        @Column(name = "favourite_category")
        private String favouriteCategoryId;
        @Column(name = "enable_myList")
        private String listOption;
        @Column(name = "enable_myBanner")
        private String bannerOption;
        private String username;
        @Id
        private long id;

        public long getId() {
            return id;
        }

        public void setId(long id) {
            this.id = id;
        }

        public Profile() {

        }


        public void setProfileInfo(String username){
            DAO dao = new DAO();
            List messages;
            Profile mProfile;


            HibernateDAO hibernateDAO = new HibernateDAO();
//            messages = dao.connect("SELECT * FROM account  where username ="+"'"+username+"'", Constants.QUERY,Constants.QUERY_ACCOUNT);
            messages = hibernateDAO.QUERY_PROFILE(username);

            mProfile = (Profile) messages.get(0);
            this.username = mProfile.username;
            this.bannerOption = mProfile.bannerOption;
            this.favouriteCategoryId = mProfile.favouriteCategoryId;
            this.languagePreference = mProfile.languagePreference;
            this.listOption = mProfile.listOption;

        }

        public String getUsername() {
            return username;
        }

        public void setUsername(String username) {
            this.username = username;
        }

        public String getBannerOption() {
            return bannerOption;
        }

        public void setBannerOption(String bannerOption) {
            this.bannerOption = bannerOption;
        }

        public String getLanguagePreference() {
            return languagePreference;
        }

        public void setLanguagePreference(String languagePreference) {
            this.languagePreference = languagePreference;
        }

        public String getFavouriteCategoryId() {
            return favouriteCategoryId;
        }

        public void setFavouriteCategoryId(String favouriteCategoryId) {
            this.favouriteCategoryId = favouriteCategoryId;
        }

        public String getListOption() {
            return listOption;
        }

        public void setListOption(String listOption) {
            this.listOption = listOption;
        }

        public Profile(String languagePreference, String favouriteCategoryId, String listOption, String bannerOption,String username) {
            this.languagePreference = languagePreference;
            this.favouriteCategoryId = favouriteCategoryId;
            this.listOption = listOption;
            this.bannerOption = bannerOption;
            this.username = username;
        }

    }

    public class Payment {
        private String order_cardType;
        private String order_creditCard;
        private String order_expiryDate;

        public Payment() {
        }

        public Payment(String order_cardType, String order_creditCard, String order_expiryDate) {
            this.order_cardType = order_cardType;
            this.order_creditCard = order_creditCard;
            this.order_expiryDate = order_expiryDate;
        }

        public String getOrder_cardType() {
            return order_cardType;
        }

        public void setOrder_cardType(String order_cardType) {
            this.order_cardType = order_cardType;
        }

        public String getOrder_creditCard() {
            return order_creditCard;
        }

        public void setOrder_creditCard(String order_creditCard) {
            this.order_creditCard = order_creditCard;
        }

        public String getOrder_expiryDate() {
            return order_expiryDate;
        }

        public void setOrder_expiryDate(String order_expiryDate) {
            this.order_expiryDate = order_expiryDate;
        }
    }


    public Register() {
    }

    public Register(String first_name, String last_name, String email, String address1, String address2, String city, String state, String zip, String country,String phone,String username) {
        this.first_name = first_name;
        this.last_name = last_name;
        this.email = email;
        this.address1 = address1;
        this.address2 = address2;
        this.city = city;
        this.state = state;
        this.zip = zip;
        this.country = country;
        this.phone = phone;
        this.username = username;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getFirst_name() {
        return first_name;
    }

    public void setFirst_name(String first_name) {
        this.first_name = first_name;
    }

    public String getLast_name() {
        return last_name;
    }

    public void setLast_name(String last_name) {
        this.last_name = last_name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress1() {
        return address1;
    }

    public void setAddress1(String address1) {
        this.address1 = address1;
    }

    public String getAddress2() {
        return address2;
    }

    public void setAddress2(String address2) {
        this.address2 = address2;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getZip() {
        return zip;
    }

    public void setZip(String zip) {
        this.zip = zip;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }



    public void setAccountInfo(String username){
        DAO dao = new DAO();
        List messages;
        Register account;
        HibernateDAO hibernateDAO = new HibernateDAO();
//            messages = dao.connect("SELECT * FROM account  where username ="+"'"+username+"'", Constants.QUERY,Constants.QUERY_ACCOUNT);
        messages = hibernateDAO.QUERY_ACCOUNT(username);
        account = (Register) messages.get(0);
        this.first_name = account.first_name;
        this.last_name = account.last_name;
        this.email = account.email;
        this.address1 = account.address1;
        this.address2 = account.address2;
        this.city = account.city;
        this.state =account. state;
        this.zip = account.zip;
        this.country = account.country;
    }

    public boolean usernameIsExist(){
        boolean isExist = true;
        DAO dao = new DAO();
        HibernateDAO hibernateDAO = new HibernateDAO();
        List message=null;
        /*try {
            message = dao.connect("select * from user where username= "+"'"+username+"'",
                    Constants.QUERY,Constants.QUERY_USER);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }*/
        message = hibernateDAO.QUERY_USER(username,"");

        return (boolean)((Map) message.get(0)).get(Constants.IS_LOGIN_SUCCESS);
    }
}
