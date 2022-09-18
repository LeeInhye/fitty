package com.project.fitty.employee.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.fitty.common.model.vo.PageInfo;
import com.project.fitty.employee.model.dao.EmployeeDao;
import com.project.fitty.employee.model.vo.Employee;

@Service
public class EmployeeServiceImpl implements EmployeeService {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private EmployeeDao eDao;

	@Override
	public Employee loginEmployee(Employee e) {
		return eDao.loginEmployee(sqlSession, e);
	}
	
	
	@Override
	public Employee attFlag(Employee e) {
		return eDao.attFlag(sqlSession, e);
	}

	

	@Override
	public String selectNextEmpNo() {
		return eDao.selectNextEmpNo(sqlSession);
		
	}
	
	@Override
	public int insertEmployee(Employee e) {
		return eDao.insertEmployee(e, sqlSession);
	}
	
	@Override
	public ArrayList<Employee> selectEmpList(PageInfo pi) {
		return eDao.selectEmpList(sqlSession, pi);
	}
	
	@Override
	public ArrayList<Employee> selectEmpList() {
		return eDao.selectEmpList(sqlSession);
	}
	
	@Override
	public int selectEmpListCount() {
		return eDao.selectEmpListCount(sqlSession);
	}
	
	@Override
	public int selectVacSearchListCount(HashMap <String, Object> sqlMap) {
		return eDao.selectVacSearchListCount(sqlSession, sqlMap);
	}


	@Override
	public int deleteEmployee(String empNo) {
		return eDao.deleteEmployee(sqlSession, empNo);
	}

	@Override
	public int uploadProfileImg(Employee e) {
		return eDao.uploadProfileImg(sqlSession, e);
	}


	@Override
	public ArrayList<Employee> selectLevelEmployeeList() {
		return  eDao.selectLevelEmployeeList(sqlSession);
	}


	@Override
	public ArrayList<Employee> checkEmpNoList(String empNo) {
		return eDao.checkEmpNoList(sqlSession, empNo);
	}


	@Override
	public ArrayList<Employee> deleteEmpNoList(String empNo) {
		return eDao.deleteEmpNoList(sqlSession, empNo);
	}


	@Override
	public int updateEmployee(Employee e) {
		return eDao.updateEmployee(sqlSession, e);
	}


	@Override
	public ArrayList<Employee> openVacModalSelectEmpName(String empNo) {
		return eDao.openVacModalSelectEmpName(sqlSession, empNo);
	}


	@Override
	public Employee selectByEmpNo(String empNo) {
		return eDao.selectByEmpNo(sqlSession, empNo);
	}
}