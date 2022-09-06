package com.project.fitty.attendance.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.project.fitty.attendance.model.vo.Attendance;
import com.project.fitty.employee.model.vo.Employee;

@Repository
public class AttendanceDao {

	public ArrayList<Attendance> selectAllAttList(SqlSessionTemplate sqlSession, Employee e) {
	
		return (ArrayList)sqlSession.selectList("attendanceMapper.selectAllAttList", e);
		
	}
	
}
