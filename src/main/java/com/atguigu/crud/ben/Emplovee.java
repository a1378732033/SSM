package com.atguigu.crud.ben;

import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.Email;

public class Emplovee {
	public Emplovee() {
		
	}
	
    public Emplovee(Integer empId, String empName, String gender, String email, Integer dId) {
		super();
		this.empId = empId;
		this.empName = empName;
		this.gender = gender;
		this.email = email;
		this.dId = dId;
		
	}

	private Integer empId;

    public Department getDepartment() {
		return department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}
    @Pattern(regexp = ("(^[a-zA-Z0-9_-]{3,16}$|(^[\\u2E80-\\u9FFF]{2,5}$))"),message="用户名格式不正确")
	private String empName;

    private String gender;
    @Pattern(regexp = ("^w{3}\\.\\w+\\@\\w+\\.com$"),message="邮箱格式不正确")
    private String email;

    private Integer dId;
    private Department department;
    public Integer getEmpId() {
        return empId;
    }

    public void setEmpId(Integer empId) {
        this.empId = empId;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName == null ? null : empName.trim();
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender == null ? null : gender.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public Integer getdId() {
        return dId;
    }

    public void setdId(Integer dId) {
        this.dId = dId;
    }
}