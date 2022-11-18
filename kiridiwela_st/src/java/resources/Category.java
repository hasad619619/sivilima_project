package resources;
// Generated Jan 31, 2020 10:35:24 PM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * Category generated by hbm2java
 */
public class Category  implements java.io.Serializable {


     private Integer idcategory;
     private String name;
     private Integer status;
     private Set subCategories = new HashSet(0);
     private Set itemses = new HashSet(0);

    public Category() {
    }

    public Category(String name, Integer status, Set subCategories, Set itemses) {
       this.name = name;
       this.status = status;
       this.subCategories = subCategories;
       this.itemses = itemses;
    }
   
    public Integer getIdcategory() {
        return this.idcategory;
    }
    
    public void setIdcategory(Integer idcategory) {
        this.idcategory = idcategory;
    }
    public String getName() {
        return this.name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    public Integer getStatus() {
        return this.status;
    }
    
    public void setStatus(Integer status) {
        this.status = status;
    }
    public Set getSubCategories() {
        return this.subCategories;
    }
    
    public void setSubCategories(Set subCategories) {
        this.subCategories = subCategories;
    }
    public Set getItemses() {
        return this.itemses;
    }
    
    public void setItemses(Set itemses) {
        this.itemses = itemses;
    }




}


