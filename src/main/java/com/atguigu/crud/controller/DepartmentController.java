package com.atguigu.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.crud.ben.Department;
import com.atguigu.crud.ben.Msg;
import com.atguigu.crud.service.DepartmentService;

/**
 * 处理和部门有关的信息
 * @author Administrator
 *
 */
@Controller
public class DepartmentController {
	@Autowired
DepartmentService  departmentService;
	@RequestMapping("/depts")
	@ResponseBody
	public Msg getDepts() {
	List<Department> list=departmentService.getDepts();
		
		return Msg.sucess().add("depts",list);
		
	}
}
