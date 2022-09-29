package com.project.fitty.employee.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.project.fitty.common.model.vo.PageInfo;
import com.project.fitty.employee.model.vo.Employee;

public interface EmployeeService {
	
	
	
	// 직원 로그인 서비스 (select)
	Employee loginEmployee(Employee e);
	
	//attFlag (select)
	Employee attFlag(Employee e);

	// 다음 회원번호 미리 알아오기 (select)
	String selectNextEmpNo();
	
	// 신규직원 가입 서비스 (insert)
	int insertEmployee(Employee e);
	
	// 직원 퇴사 서비스 (update)
	int deleteEmployee(String empNo);
	
	// 프로필 이미지 변경 서비스 (update)
	int uploadProfileImg(Employee e);
	
	// 프로필 이미지 변경 서비스_마이페이지용 (update)
	int uploadProfileImg2(Employee e);
	
	// 전체 회원수 알아오기
	int selectVacEmpListCount();
	
	// sql에 해당하는 회원수 알아오기
	int selectVacSearchListCount(HashMap <String, Object> sqlMap);
	
	// 오늘근태 sql에 해당하는 회원수 알아보기
	int selectTodaySearchListCount(HashMap <String, Object> sqlMap);
	
	// 직원 전체조회 - 주소록용 레벨
	ArrayList<Employee> selectLevelEmployeeList();
	
	// 해당 회원번호에 해당하는 회원만 조회
	ArrayList<Employee> checkEmpNoList(String empNo);
	
	// 선택된 리스트에서 원하는 리스트 조회
	ArrayList<Employee> deleteEmpNoList(String empNo);

	// 직원 정보 수정 (update)
	int updateEmployee(Employee e);
	
	
	// 모달오픈용 empName 조회
	ArrayList<Employee> openVacModalSelectEmpName(String empNo);
	
	// 근무시간 수정용 empNo 조회
	Employee selectByEmpNo(String empNo);

	int selectEmpListCount(HashMap<String, Object> sqlMap);

	ArrayList<Employee> selectEmpList(PageInfo pi, HashMap<String, Object> sqlMap);
}
