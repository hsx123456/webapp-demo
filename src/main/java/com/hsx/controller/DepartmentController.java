package com.hsx.controller;

import com.hsx.model.Department;
import com.hsx.service.DepartmentService;
import com.hsx.util.MsgResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * Created by xing on 18/3/27.
 */
@Controller
@RequestMapping("/dept")
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    @RequestMapping("/getDeptById")
    public void getDeptById(){
        Department department=departmentService.getDeptById(1);
        System.out.println(department);
    }

    @ResponseBody
    @RequestMapping("/getDeptAll")
    public MsgResponse getDeptAll(){
        List<Department> departments=departmentService.getDeptAll();
        return MsgResponse.success().add("departments",departments);
    }



}
