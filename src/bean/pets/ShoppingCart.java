package bean.pets;

import javax.persistence.*;
import javax.persistence.Entity;
import java.io.Serializable;

/**
 * Created by gala on 2016/3/16.
 */
@Entity
@Table(name = "shopping_cart")
public class ShoppingCart implements Serializable {
    @Id
    private int id;
    private String productId;
    @Column(name = "item_id")
    @Id
    private String itemId;
    private String itemDes;
    @Column(name = "product_name")
    private String productName;//fish,dogs等
    private String price;
    private int stock;
    @Column(name = "quantity")
    private int quantity;
    private String productDess;
    private String productPicUrls;
    private String productHtmlNames;
    private String  order_id;

    public String getOrder_id() {
        return order_id;
    }

    public void setOrder_id(String order_id) {
        this.order_id = order_id;
    }

    //    新增加username属性
    private String userName;

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getProductName() {
        return productName;
    }

    public ShoppingCart(String itemId, String productName, int quantity,String userName) {
        this.itemId = itemId;
        this.productName = productName;
        this.quantity = quantity;
        this.userName = userName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductHtmlNames() {
        return productHtmlNames;
    }

    public void setProductHtmlNames(String productHtmlNames) {
        this.productHtmlNames = productHtmlNames;
    }

    public ShoppingCart(String productId, String itemId, String itemDes, String price, int stock, int quantity, String productName, String productDess, String productPicUrls, String productHtmlNames) {
        //
        this.productId = productId;
        this.itemId = itemId;
        this.itemDes = itemDes;

        this.price = price;
        this.stock = stock;
        this.quantity = quantity;
        this.productName = productName;
        this.productDess = productDess;
        this.productPicUrls = productPicUrls;
        this.productHtmlNames = productHtmlNames;
    }

    public ShoppingCart() {

    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public String getItemId() {
        return itemId;
    }

    public void setItemId(String itemId) {
        this.itemId = itemId;
    }

    public String getItemDes() {
        return itemDes;
    }

    public void setItemDes(String itemDes) {
        this.itemDes = itemDes;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }


    public String getProductDess() {
        return productDess;
    }

    public void setProductDess(String productDess) {
        this.productDess = productDess;
    }

    public String getProductPicUrls() {
        return productPicUrls;
    }

    public void setProductPicUrls(String productPicUrls) {
        this.productPicUrls = productPicUrls;
    }

    public String getproductName() {
        return productName;
    }

    public void setproductName(String productName) {
        this.productName = productName;
    }
}
