package bean.user;

import dao.DAO;
import dao.HibernateDAO;
import define_constant.Constants;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.sql.SQLException;

/**
 * Created by gala on 2016/3/29.
 */
@Entity
@Table(name = "`order`")
public class Order {

    @Id
    private int id;
    private String date;
    @Column(name="sum_money")
    private String total_pri;


    @Column(name="sh_first_name")
    private String shipToFirstName;
    @Column(name="sh_last_name")
    private String shipToLastName;
    @Column(name="sh_address1")
    private String shipAddress1;
    @Column(name="sh_address2")
    private String shipAddress2;
    @Column(name="sh_city")
    private String shipCity;
    @Column(name="sh_state")
    private String shipState;
    @Column(name="sh_zip")
    private String shipZip;
    @Column(name="sh_country")
    private String shipCountry;

    @Column(name="first_name")
    private String billToFirstName;
    @Column(name="last_name")
    private String billToLastName;
    @Column(name="address1")
    private String billAddress1;
    @Column(name="address2")
    private String billAddress2;
    @Column(name="city")
    private String billCity;
    @Column(name="state")
    private String billState;
    @Column(name="zip")
    private String billZip;
    @Column(name="country")
    private String billCountry;

    @Column(name="card_number")
    private String creditCard;
    @Column(name="expiry_date")
    private String expiryDate;
    @Column(name="card_type")
    private String cardType;

    private String username;

    public Order(int id, String date, String total_pri, String shipToFirstName, String shipToLastName, String shipAddress1, String shipAddress2, String shipCity, String shipState, String shipZip, String shipCountry, String billToFirstName, String billToLastName, String billAddress1, String billAddress2, String billCity, String billState, String billZip, String billCountry, String creditCard, String expiryDate, String cardType, String username) {
        this.id = id;
        this.date = date;
        this.total_pri = total_pri;
        this.shipToFirstName = shipToFirstName;
        this.shipToLastName = shipToLastName;
        this.shipAddress1 = shipAddress1;
        this.shipAddress2 = shipAddress2;
        this.shipCity = shipCity;
        this.shipState = shipState;
        this.shipZip = shipZip;
        this.shipCountry = shipCountry;
        this.billToFirstName = billToFirstName;
        this.billToLastName = billToLastName;
        this.billAddress1 = billAddress1;
        this.billAddress2 = billAddress2;
        this.billCity = billCity;
        this.billState = billState;
        this.billZip = billZip;
        this.billCountry = billCountry;
        this.creditCard = creditCard;
        this.expiryDate = expiryDate;
        this.cardType = cardType;
        this.username = username;
    }

    public Order() {
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getTotal_pri() {
        return total_pri;
    }

    public void setTotal_pri(String total_pri) {
        this.total_pri = total_pri;
    }

    public String getShipToFirstName() {
        return shipToFirstName;
    }

    public void setShipToFirstName(String shipToFirstName) {
        this.shipToFirstName = shipToFirstName;
    }

    public String getShipToLastName() {
        return shipToLastName;
    }

    public void setShipToLastName(String shipToLastName) {
        this.shipToLastName = shipToLastName;
    }

    public String getShipAddress1() {
        return shipAddress1;
    }

    public void setShipAddress1(String shipAddress1) {
        this.shipAddress1 = shipAddress1;
    }

    public String getShipAddress2() {
        return shipAddress2;
    }

    public void setShipAddress2(String shipAddress2) {
        this.shipAddress2 = shipAddress2;
    }

    public String getShipCity() {
        return shipCity;
    }

    public void setShipCity(String shipCity) {
        this.shipCity = shipCity;
    }

    public String getShipState() {
        return shipState;
    }

    public void setShipState(String shipState) {
        this.shipState = shipState;
    }

    public String getShipZip() {
        return shipZip;
    }

    public void setShipZip(String shipZip) {
        this.shipZip = shipZip;
    }

    public String getShipCountry() {
        return shipCountry;
    }

    public void setShipCountry(String shipCountry) {
        this.shipCountry = shipCountry;
    }

    public String getBillToFirstName() {
        return billToFirstName;
    }

    public void setBillToFirstName(String billToFirstName) {
        this.billToFirstName = billToFirstName;
    }

    public String getBillToLastName() {
        return billToLastName;
    }

    public void setBillToLastName(String billToLastName) {
        this.billToLastName = billToLastName;
    }

    public String getBillAddress1() {
        return billAddress1;
    }

    public void setBillAddress1(String billAddress1) {
        this.billAddress1 = billAddress1;
    }

    public String getBillAddress2() {
        return billAddress2;
    }

    public void setBillAddress2(String billAddress2) {
        this.billAddress2 = billAddress2;
    }

    public String getBillCity() {
        return billCity;
    }

    public void setBillCity(String billCity) {
        this.billCity = billCity;
    }

    public String getBillState() {
        return billState;
    }

    public void setBillState(String billState) {
        this.billState = billState;
    }

    public String getBillZip() {
        return billZip;
    }

    public void setBillZip(String billZip) {
        this.billZip = billZip;
    }

    public String getBillCountry() {
        return billCountry;
    }

    public void setBillCountry(String billCountry) {
        this.billCountry = billCountry;
    }

    public String getCreditCard() {
        return creditCard;
    }

    public void setCreditCard(String creditCard) {
        this.creditCard = creditCard;
    }

    public String getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(String expiryDate) {
        this.expiryDate = expiryDate;
    }

    public String getCardType() {
        return cardType;
    }

    public void setCardType(String cardType) {
        this.cardType = cardType;
    }

    public static  String getOrderId(){
        HibernateDAO hibernateDAO = new HibernateDAO();
        String str;
        /*DAO dao = new DAO();
        try {
            str = dao.connect("select count(*) from `order`", Constants.QUERY,Constants.QUERY_ORDER_ID).get(0).toString();
            int i = Integer.parseInt(str)+1;
            str = String.valueOf(i);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }*/

        str = hibernateDAO.QUERY_ORDER_ID().get(0).toString();
        int i = Integer.parseInt(str)+1;
        str = String.valueOf(i);
        return str;
    }

}
