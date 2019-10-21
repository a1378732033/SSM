package com.atguigu.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.crud.ben.Emplovee;
import com.atguigu.crud.ben.EmploveeExample;
import com.atguigu.crud.ben.EmploveeExample.Criteria;
import com.atguigu.crud.dao.EmploveeMapper;
@Service
public class EmployeeService {
	@Autowired
	EmploveeMapper emploveeMapper;
	//查询所有员工
	public List<Emplovee> getAll() {
		
		return emploveeMapper.selectByExampleWithDept(null);
	}
	/**
	 * 保存员工方法
	 * @param employee
	 */
	public void saveEmp(Emplovee employee) {
		emploveeMapper.insertSelective(employee);
	}
	public boolean checkuse(String employee) {
		EmploveeExample example=new EmploveeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpNameEqualTo(employee);
		long count = emploveeMapper.countByExample(example);
		return count==0;
		
	}
	public Emplovee getemp(Integer id) {
		Emplovee emplovee = emploveeMapper.selectByPrimaryKey(id);
		return emplovee;
	}
	public void updateEmp(Emplovee emplovee) {
		emploveeMapper.updateByPrimaryKeySelective(emplovee);
		
	}
	public void deleteEmp(Integer empId) {
		
		emploveeMapper.deleteByPrimaryKey(empId);
	}
	public void deleteBath(List<Integer> empIds) {
		EmploveeExample example=new EmploveeExample();
		Criteria createa = example.createCriteria();
		createa.andEmpIdIn(empIds);
		emploveeMapper.deleteByExample(example);
	}
	

}
