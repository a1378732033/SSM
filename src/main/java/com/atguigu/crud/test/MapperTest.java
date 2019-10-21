package com.atguigu.crud.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.atguigu.crud.ben.Department;
import com.atguigu.crud.ben.Emplovee;
import com.atguigu.crud.dao.DepartmentMapper;
import com.atguigu.crud.dao.EmploveeMapper;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"} )
public class MapperTest {
	@Autowired
	DepartmentMapper departmentMapper;
	@Autowired
	EmploveeMapper  emploveeMapper;
	@Autowired
	SqlSession sqlsession;
@Test
	public void testCRUD() {
//		System.out.println(departmentMapper);
//		departmentMapper.insertSelective(new Department(null,"开发部") );
//		departmentMapper.insertSelective(new Department(null,"测试部") );
		//emploveeMapper.insertSelective(new Emplovee(null,"Jerry","M","Jerry@atguigu.com",1));
		//批量插入，使用可以批量插入的sqlsession
//		 for() {
//			 emploveeMapper.insertSelective(new Emplovee(null,"Jerry","M","Jerry@atguigu.com",1)); 
//		 }
		EmploveeMapper mapper = sqlsession.getMapper(EmploveeMapper.class);
		for(int i=0;i<1000;i++) {
		String	uid=UUID.randomUUID().toString().substring(0,5)+i;
			mapper.insertSelective(new Emplovee(null,uid,"M",uid+"@atgugui.com",1));
		}
		System.out.println("加入完成");
	}
}
