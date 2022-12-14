package resources;
// Generated Jan 31, 2020 10:35:24 PM by Hibernate Tools 4.3.1



/**
 * PayEmployee generated by hbm2java
 */
public class PayEmployee  implements java.io.Serializable {


     private Integer idpayEmployee;
     private EmployeeAccount employeeAccount;
     private User user;
     private Double amount;
     private Integer status;
     private String addedDate;
     private String addedTime;
     private String remark;

    public PayEmployee() {
    }

	
    public PayEmployee(EmployeeAccount employeeAccount, User user) {
        this.employeeAccount = employeeAccount;
        this.user = user;
    }
    public PayEmployee(EmployeeAccount employeeAccount, User user, Double amount, Integer status, String addedDate, String addedTime, String remark) {
       this.employeeAccount = employeeAccount;
       this.user = user;
       this.amount = amount;
       this.status = status;
       this.addedDate = addedDate;
       this.addedTime = addedTime;
       this.remark = remark;
    }
   
    public Integer getIdpayEmployee() {
        return this.idpayEmployee;
    }
    
    public void setIdpayEmployee(Integer idpayEmployee) {
        this.idpayEmployee = idpayEmployee;
    }
    public EmployeeAccount getEmployeeAccount() {
        return this.employeeAccount;
    }
    
    public void setEmployeeAccount(EmployeeAccount employeeAccount) {
        this.employeeAccount = employeeAccount;
    }
    public User getUser() {
        return this.user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    public Double getAmount() {
        return this.amount;
    }
    
    public void setAmount(Double amount) {
        this.amount = amount;
    }
    public Integer getStatus() {
        return this.status;
    }
    
    public void setStatus(Integer status) {
        this.status = status;
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
    public String getRemark() {
        return this.remark;
    }
    
    public void setRemark(String remark) {
        this.remark = remark;
    }




}


