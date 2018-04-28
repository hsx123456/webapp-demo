package com.hsx.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hsx.model.Department;
import com.hsx.model.Employee;
import com.hsx.service.EmployeeService;
import com.hsx.type.EmpType;
import com.hsx.util.MsgResponse;
import org.omg.CORBA.Request;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by xing on 18/3/29.
 */
@Controller()
@RequestMapping("/employee")
public class EmployeeController {

    @Autowired
    private EmployeeService employeeService;

    /**
     * 员工保存
     */
    @ResponseBody
    @RequestMapping(value = "/addEmployee",method = RequestMethod.POST)
    public MsgResponse addEmployee(Employee employee) {
            employee.setPassword("123456");
            employee=employeeService.addEmployee(employee);
            return MsgResponse.success();

    }

    @ResponseBody
    @RequestMapping(value = "/getEmpById/{id}",method = RequestMethod.GET)
    public MsgResponse getEmpById(@PathVariable("id") Integer id){

        Employee employee=employeeService.getEmpById(id);
        return MsgResponse.success().add("employee",employee);
    }

    @RequestMapping("/getEmpAll")
    public void getEmpAll(){
        List<Employee> employees=employeeService.getEmpAll();

        System.out.println(employees);
    }

    @ResponseBody
    @RequestMapping(value = "/getEmpsBydeptId/{did}",method = RequestMethod.GET)
    public MsgResponse getEmpsBydeptId(@PathVariable("did") Integer did){
        List<Employee> employees=employeeService.getEmpsBydeptId(did);
        return MsgResponse.success().add("employees",employees);
    }


    //用ajax替换上面的逻辑
    @RequestMapping("/emps")
    @ResponseBody
    public MsgResponse getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1",required = false)Integer pn){
        PageInfo<Employee> pageInfo=employeeService.getEmpByPage(pn);
        return MsgResponse.success().add("pageInfo",pageInfo);
    }

    //修改员工
    @ResponseBody
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.PUT)
    public MsgResponse updateEmp(Employee employee){
        employeeService.updateEmp(employee);
        return MsgResponse.success();
    }

    /**
     * 单个和批量删除二合一
     * 批量删除:1-2-3
     * 单个删除:1
     * @param ids
     * @return
     */
    //根据ids删除员工
    @ResponseBody
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    public MsgResponse deleteEmpById(@PathVariable("ids")String ids){
        if (ids.contains("-")){
            List<Integer> del_ids=new ArrayList<Integer>();
            String[] str_ids=ids.split("-");
            //组装id的集合
            for (String string :str_ids){
                del_ids.add(Integer.parseInt(string));
            }
            employeeService.deleteBatch(del_ids);
        }else{

            employeeService.deleteEmpById(Integer.parseInt(ids));
        }

        return MsgResponse.success();
    }


    //检查手机号是否可用
    @ResponseBody
    @RequestMapping(value = "/checkmobile",method = RequestMethod.POST)
    public MsgResponse checkmobile(@RequestParam("mobile") String mobile){
        String regmobile="^((1[3,5,8][0-9])|(14[5,7])|(17[0,6,7,8])|(19[7]))\\d{8}$";
        if (!mobile.matches(regmobile)){
            return MsgResponse.fail().add("va_msg","手机号格式不正确");
        }
        //数据库重复校验
        Employee employee=employeeService.getEmpsByMobile(mobile);
        if (employee==null){
            return MsgResponse.success();
        }else {
            return MsgResponse.fail().add("va_msg","手机号不可用");
        }
    }

    //员工登录
    @RequestMapping(value = "/doLogin",method = RequestMethod.POST)
    public String doLogin(@RequestParam("mobile") String mobile,
                          @RequestParam("password") String password,
                          @RequestParam("validateCode") String validateCode,
                          @RequestParam("mark") Integer mark,
                          HttpServletRequest request,
                          Map<String,Object> map){
        if (StringUtils.isEmpty(mobile)){
            map.put("msg","手机号不能为空");
            return "/index";
        }
        if (StringUtils.isEmpty(password)){
            map.put("msg","密码不能为空");
            return "/index";
        }
        if (StringUtils.isEmpty(validateCode)){
            map.put("msg","验证码不能为空");
            return "/index";
        }

        if (!ValidateCodeController.validate(request,validateCode)){
            map.put("msg","验证码错误");
            return "/index";
        }

        Employee employee=employeeService.getEmpsByMobile(mobile);
        if (null==employee){
            map.put("msg","用户名不存在");
            return "/index";
        }

        if (!password.equals(employee.getPassword())){
            map.put("msg","密码错误");
            return "/index";
        }

        if (mark.intValue()==1){
            request.getSession().setAttribute("empType",employee.getEmpType());
            request.getSession().setAttribute("empName",employee.getName());
            request.getSession().setAttribute("emp",employee);
            return "redirect:/views/main_front.jsp";
        }

        if (employee.getEmpType().intValue()==1){
            map.put("msg","您没有权限登录");
            return "/index";
        }
        request.getSession().setAttribute("empName",employee.getName());
        return "redirect:/views/list_json_after.jsp";

    }



    @ResponseBody
    @RequestMapping(value = "/updatePasswd",method = RequestMethod.POST)
    public MsgResponse updatePasswd(@RequestParam(value = "password",required = true,defaultValue = "") String password,
                                    @RequestParam(value = "rpassword",required = true,defaultValue = "")String rpassword,
                                    HttpServletRequest request){

        Employee employee=(Employee) request.getSession().getAttribute("emp");
        if (null==employee){
            return MsgResponse.fail().add("msg","您还没有登录!");
        }

        password=password.trim();
        rpassword=rpassword.trim();
        if (StringUtils.isEmpty(password)||StringUtils.isEmpty(rpassword)){
            return MsgResponse.fail().add("msg","密码不允许为空");
        }

        if (!password.equals(rpassword)){
            return MsgResponse.fail().add("msg","前后密码不一致");
        }

        employee.setPassword(password);
        employeeService.updatePasswd(employee);

        return MsgResponse.success();
    }


}
