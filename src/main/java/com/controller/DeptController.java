package com.controller;

import com.bean.Dept;
import com.bean.Msg;
import com.service.DeptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class DeptController {
    @Autowired
    DeptService deptService;
    @ResponseBody
    @RequestMapping("/depts")
    public Msg getDepts(){
        List<Dept> depts= deptService.getDeptALL();
        return  Msg.success().add("depts",depts);
    }
}
