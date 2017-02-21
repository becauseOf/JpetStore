package bean.pets;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Created by gala on 2016/3/15.
 */
@javax.persistence.Entity
//@Table(name = "")
public class Entity {
    @Column(name = "Name")
    private String name;
    @Column(name = "Product_ID")
    private String id;
    @Column(name = "Product_Des")
    private String des;
    @Column(name = "Product_Pic_Url")
    private String pic_url;
    @Id
    public int form_key;

    public Entity(String name, String id, String des, String pic_url) {
        this.name = name;
        this.id = id;
        this.des = des;
        this.pic_url = pic_url;
    }

    public Entity() {
    }

    public int getForm_key() {
        return form_key;
    }

    public void setForm_key(int form_key) {
        this.form_key = form_key;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDes() {
        return des;
    }

    public void setDes(String des) {
        this.des = des;
    }

    public String getPic_url() {
        return pic_url;
    }

    public void setPic_url(String pic_url) {
        this.pic_url = pic_url;
    }
}
