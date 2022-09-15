package com.project.fitty.vacation.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.project.fitty.attendance.model.vo.Attendance;
import com.project.fitty.vacation.model.vo.Vacation;

@Repository
public class VacationDao {
	
	public ArrayList<Vacation> selectEmpVacList(SqlSessionTemplate sqlSession, Attendance a){
		return (ArrayList) sqlSession.selectList("vacationMapper.selectEmpVacList", a);
	}
	

}