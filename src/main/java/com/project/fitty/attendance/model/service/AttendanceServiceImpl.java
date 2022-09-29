package com.project.fitty.attendance.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.fitty.attendance.model.dao.AttendanceDao;
import com.project.fitty.attendance.model.vo.Attendance;
import com.project.fitty.attendance.model.vo.ModifyAtt;
import com.project.fitty.common.model.vo.PageInfo;
import com.project.fitty.employee.model.vo.Employee;
import com.project.fitty.vacation.model.vo.Vacation;

@Service
public class AttendanceServiceImpl implements AttendanceService{
	
	
	

	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private AttendanceDao aDao;
	
	@Override
	public int updateWorkIn(Attendance a) {
		return aDao.updateWorkIn(sqlSession, a);
	}
	
	@Override
	public Attendance selectInAttendance(Attendance a) {
		return aDao.selectInAttendance(sqlSession, a);
	}


	@Override
	public int updateWorkOutLogOut(Attendance a) {
		return aDao.updateWorkOutLogOut(sqlSession, a);
	}

	@Override
	public Attendance selectMyAttendance(Attendance a) {
		return aDao.selectMyAttendance(sqlSession, a);
	}

	@Override
	public Attendance selectLastWorkTime(Attendance a) {
		return aDao.selectLastWorkTime(sqlSession, a);
	}
	
	
	@Override
	public ArrayList<Attendance> selectAllAttList(Employee e) {
		//System.out.println(e);
		ArrayList<Attendance> attList = aDao.selectAllAttList(sqlSession, e);
		for(Attendance a : attList) {
			//System.out.println(a);
			switch(a.getAttStatus()) {
			case "X" : a.setAttStatus("#E74C3C"); ; break; //결석
			case "L" : a.setAttStatus("#F1C40F"); ; break; // 지각
			case "E" : a.setAttStatus("#BF5BC7"); ; break; // 조퇴
			case "Q" : a.setAttStatus("green"); ; break; // 오전반차
			case "Z" : a.setAttStatus("green"); ; break; // 오후반차
			case "V" : a.setAttStatus("#29CCF9"); ; break; // 휴가
			case "Y" : a.setAttStatus("green"); ; break; // 연월차
			case "B" : a.setAttStatus("#FFFFFF"); ; break; // 베이직
			case "O" : a.setAttStatus("#DCDADA"); ; break; // 정상출근
			case "P" : a.setAttStatus("#686BFF"); ; break; // 정상출근
			default : a.setAttStatus("#E74C3C"); break;  // 무단
			}
		}
		return attList;
	}
	
	@Override
	public ArrayList<Attendance> selectOtherAttList(Employee e) {
		
		ArrayList<Attendance> attList = aDao.selectOtherAttList(sqlSession, e);
		for(Attendance a : attList) {
			switch(a.getAttStatus()) {
			case "X" : a.setAttStatus("#E74C3C"); ; break; //결석
			case "L" : a.setAttStatus("#F1C40F"); ; break; // 지각
			case "E" : a.setAttStatus("#BF5BC7"); ; break; // 조퇴
			case "Q" : a.setAttStatus("green"); ; break; // 오전반차
			case "Z" : a.setAttStatus("green"); ; break; // 오후반차
			case "V" : a.setAttStatus("#29CCF9"); ; break; // 휴가
			case "Y" : a.setAttStatus("green"); ; break; // 연월차
			case "B" : a.setAttStatus("#FFFFFF"); ; break; // 베이직
			case "O" : a.setAttStatus("#DCDADA"); ; break; // 정상출근
			case "P" : a.setAttStatus("#686BFF"); ; break; // 정상출근
			default : a.setAttStatus("#E74C3C"); break;  // 무단
			}
		}
		return attList;
	}

	
	@Override
	public ArrayList<Attendance> selectCountList(Employee e) {
		return aDao.selectCountList(sqlSession, e);
	}
	
	@Override
	public ArrayList<Attendance> selectOtherCountList(Employee e) {
		return aDao.selectOtherCountList(sqlSession, e);
	}
	
	@Override
	public ArrayList<Attendance> selectTodaySearchList(PageInfo pi, HashMap<String, Object> sqlMap) {
		return aDao.selectTodaySearchList(sqlSession, pi, sqlMap);
	}

	@Override
	public int insertAttendance(String empNo, String thisYear) {
		Attendance a = new Attendance();
		a.setEmpNo(empNo);
		a.setThisYear(thisYear);
		//System.out.println(a.getEmpNo());
		//System.out.println(a.getThisYear());
		return aDao.insertAttendance(sqlSession, a);
	}

	@Override
	public int updateAttendanceStatus(String empNo, String thisYear) {
		Attendance a = new Attendance();
		a.setEmpNo(empNo);
		a.setThisYear(thisYear);
		return aDao.updateAttendanceStatus(sqlSession, a);
	}

	@Override
	public ArrayList<Attendance> selectVacList(PageInfo pi, HashMap <String, Object> sqlMap) {
		return aDao.selectVacList(sqlSession, pi, sqlMap );
	}

	@Override
	public ArrayList<Attendance> selectPerYearMonthList(Attendance a) {
		return aDao.selectPerYearMonthList(sqlSession, a);
	}

	@Override
	public int selectAttNo(ModifyAtt m) {
		System.out.println(m.getAttDate());
		System.out.println(m.getEmpNo());
		return aDao.selectAttNo(sqlSession, m);
	}

	@Override
	public int AdminUpdateAttInStatus(Attendance a) {
		return aDao.AdminUpdateAttInStatus(sqlSession, a);
	}

	@Override
	public int AdminUpdateAttOutStatus(Attendance a) {
		return aDao.AdminUpdateAttOutStatus(sqlSession, a);
	}

	@Override
	public ArrayList<Attendance> selectMyMonthAttList(String empNo) {
		return aDao.selectmyMonthAttList(sqlSession, empNo);
	}


	

	

	
	

	
}
