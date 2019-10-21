package com.atguigu.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.crud.ben.Emplovee;
import com.atguigu.crud.ben.Msg;
import com.atguigu.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mysql.fabric.xmlrpc.base.Array;

@Controller
public class EmployeeController {
	@Autowired
	EmployeeService employeeService;
	/**
	 * 删除员工
	 */
	@RequestMapping(value="emp/{empIds}",method=RequestMethod.DELETE)
	@ResponseBody
	public Msg deleteEmp(@PathVariable("empIds")String empIds) {
		if(empIds.contains("-")) {
			List<Integer> del_ids=new ArrayList();
		  String [] str_ids=empIds.split("-");
		  for(String string:str_ids) {
			  del_ids.add(Integer.parseInt(string));
		  }
		employeeService.deleteBath(del_ids);
		}else {
			Integer empId=Integer.parseInt(empIds);
			employeeService.deleteEmp(empId);
		}
	return Msg.sucess();	
	}
	/**
	 * 保存更改后的员工
	 */
	@RequestMapping(value="emp/{empId}",method=RequestMethod.PUT)
	@ResponseBody
	
	public Msg saveemp(Emplovee emplovee){
		System.out.println(emplovee);
		employeeService.updateEmp(emplovee);
		return Msg.sucess();
	}
	/**
	 * 查询员工 数据
	 */
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id") Integer id) {
		Emplovee emplvee=employeeService.getemp(id);
		return Msg.sucess().add("emp", emplvee);
		
	}
	/**
	 * 检查用户名
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/checkuse")
	public Msg checkuse(@RequestParam("empName")String empName) {
		String regex="(^[a-zA-Z0-9_-]{3,16}$|(^[\\u2E80-\\u9FFF]{2,5}$))";
		if(!empName.matches(regex)) {
			return Msg.fail().add("va_msg","用户名格式不正确");
		}
	boolean	b=employeeService.checkuse(empName);
	if(b) {
		return Msg.sucess();
	}else {
		return Msg.fail().add("va_msg","用户名以存在");
	}
		
	}
	/**
	 * 员工保存
	 * @return
	 */
	@RequestMapping(value="/emp",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Emplovee employee,BindingResult result) {
		if(result.hasErrors()) {
			//校验失败在模态框中显示失败的错误信息
			Map <String,Object> map=new HashMap();
			List<FieldError> fieldErrors = result.getFieldErrors();
			for(FieldError errors:fieldErrors) {
				System.out.println(errors.getField());
				System.out.println(errors.getDefaultMessage());
				map.put(errors.getField(),errors.getDefaultMessage());
				
			}	
			return  Msg.fail().add("errorFields", map);
		}else {
			employeeService.saveEmp(employee);
			return Msg.sucess();	
		}		
	}
	
	
	
@RequestMapping("/emps")	
@ResponseBody
public Msg getEmpsWithJson(@RequestParam(value="pn",defaultValue = "1") Integer pn,Model model) {
	
	 PageHelper.startPage(pn, 5);
	 List<Emplovee> emps= employeeService.getAll();
	 //使用PageInfo包装查询出来的结果,以及连续显示的页数
	 PageInfo page = new PageInfo(emps,5);
	 model.addAttribute("pageInfo", page);
	return Msg.sucess().add("pageInfo",page);
	
}
  //@RequestMapping("/emps")
  public String getEmps(@RequestParam(value="pn",defaultValue = "1") Integer pn,Model model) {
	  //分页 传入页码 以及每页数据个数
	 PageHelper.startPage(pn, 5);
	 List<Emplovee> emps= employeeService.getAll();
	 //使用PageInfo包装查询出来的结果,以及连续显示的页数
	 PageInfo page = new PageInfo(emps,5);
	 model.addAttribute("pageInfo", page);
	 
	 return "list";
  }
}
