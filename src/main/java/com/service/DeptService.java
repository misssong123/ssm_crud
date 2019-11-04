package com.service;

import com.bean.Dept;
import com.dao.DeptMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DeptService {
    @Autowired
    DeptMapper deptMapper;

    public List<Dept> getDeptALL() {
        List<Dept> depts=deptMapper.selectByExample(null);
        return depts;
    }
}

