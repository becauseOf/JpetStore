package bean.pets;

/**
 * Created by gala on 2016/3/15.
 */
public class EntityItem {
    private String productId;
    private String itemId;
    private String itemDes;
    private String price;
    private int stock;

    public EntityItem(String productId, String itemId, String itemDes, String price,int stock) {
        this.productId = productId;
        this.itemId = itemId;
        this.itemDes = itemDes;
        this.price = price;
        this.stock = stock;
    }

    public EntityItem() {
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
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

}
