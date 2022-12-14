package resources;
// Generated Jan 31, 2020 10:35:24 PM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * ExpencessAccount generated by hbm2java
 */
public class ExpencessAccount  implements java.io.Serializable {


     private Integer idexpencessAccount;
     private Branch branch;
     private User user;
     private String name;
     private String addedDate;
     private String addedTime;
     private Integer status;
     private Set payExpencesses = new HashSet(0);

    public ExpencessAccount() {
    }

	
    public ExpencessAccount(Branch branch, User user) {
        this.branch = branch;
        this.user = user;
    }
    public ExpencessAccount(Branch branch, User user, String name, String addedDate, String addedTime, Integer status, Set payExpencesses) {
       this.branch = branch;
       this.user = user;
       this.name = name;
       this.addedDate = addedDate;
       this.addedTime = addedTime;
       this.status = status;
       this.payExpencesses = payExpencesses;
    }
   
    public Integer getIdexpencessAccount() {
        return this.idexpencessAccount;
    }
    
    public void setIdexpencessAccount(Integer idexpencessAccount) {
        this.idexpencessAccount = idexpencessAccount;
    }
    public Branch getBranch() {
        return this.branch;
    }
    
    public void setBranch(Branch branch) {
        this.branch = branch;
    }
    public User getUser() {
        return this.user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    public String getName() {
        return this.name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    public String getAddedDate() {
        return this.addedDate;
    }
    
    public void setAddedDate(String addedDate) {
        this.addedDate = addedDate;
    }
    public String getAddedTime() {
        return this.addedTime;
    }
    
    public void setAddedTime(String addedTime) {
        this.addedTime = addedTime;
    }
    public Integer getStatus() {
        return this.status;
    }
    
    public void setStatus(Integer status) {
        this.status = status;
    }
    public Set getPayExpencesses() {
        return this.payExpencesses;
    }
    
    public void setPayExpencesses(Set payExpencesses) {
        this.payExpencesses = payExpencesses;
    }




}


