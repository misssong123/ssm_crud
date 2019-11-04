package com.service;

import com.bean.Emp;
import com.bean.EmpExample;
import com.dao.EmpMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmpService {
    @Autowired
    EmpMapper empMapper;
    public List<Emp> getAll() {
        List<Emp> list=empMapper.selectByExampleWithDept(null);
        return list;
    }
    /**
     * 员工保存
     * @param employee
     */
    public void saveEmp(Emp employee) {
        // TODO Auto-generated method stub
        empMapper.insertSelective(employee);
    }

    /**
     * 检验用户名是否可用
     *
     * @param empName
     * @return  true：代表当前姓名可用   fasle：不可用
     */
    public boolean checkUser(String empName) {
        // TODO Auto-generated method stub
        EmpExample example = new EmpExample();
        EmpExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = empMapper.countByExample(example);
        return count == 0;
    }

    /**
     * 按照员工id查询员工
     * @param id
     * @return
     */
    public Emp getEmp(Integer id) {
        // TODO Auto-generated method stub
        Emp employee = empMapper.selectByPrimaryKey(id);
        return employee;
    }

    /**
     * 员工更新
     * @param employee
     */
    public void updateEmp(Emp employee) {
        // TODO Auto-generated method stub
        empMapper.updateByPrimaryKeySelective(employee);
    }

    /**
     * 员工删除
     * @param id
     */
    public void deleteEmp(Integer id) {
        // TODO Auto-generated method stub
        empMapper.deleteByPrimaryKey(id);
    }

    public void deleteBatch(List<Integer> ids) {
        // TODO Auto-generated method stub
        EmpExample example = new EmpExample();
        EmpExample.Criteria criteria = example.createCriteria();
        //delete from xxx where emp_id in(1,2,3)
        criteria.andEmpIdIn(ids);
        empMapper.deleteByExample(example);
    }

}
