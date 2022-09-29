package com.project.fitty.employee.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;


import com.google.gson.Gson;
import com.project.fitty.attendance.model.service.AttendanceService;
import com.project.fitty.common.template.FileUpload;
import com.project.fitty.employee.model.service.EmployeeService;
import com.project.fitty.employee.model.vo.Employee;
import com.project.fitty.user.model.vo.User;

@Controller
public class EmployeeController {
	
	@Autowired	
	private EmployeeService eService;
	
	@Autowired
	private AttendanceService aService;
	
	
	
	@RequestMapping("login.emp")
	public String loginEmployee(Employee e, HttpSession session) {
		
		Employee loginUser = eService.loginEmployee(e);
		
		
		if(loginUser == null) {
			// 애초에 사번부터 틀렸을 경우
			session.setAttribute("alertMsg", "사번을 다시 확인해주세요.");
			return "main";
		} else {
			// 사번이 맞은 경우 출퇴근 여부 확인
			Employee attFlag = eService.attFlag(e);
			
			loginUser.setAttIn(attFlag.getAttIn());
			loginUser.setAttOut(attFlag.getAttOut());
			session.setAttribute("loginUser", loginUser);
			return "common/mainPage";
		}
		
	}
		

	@ResponseBody
	@RequestMapping("nextEmpNo.emp")
	public String selectNextEmpNo() {
		
		return eService.selectNextEmpNo();
	}
	
	@ResponseBody
	@RequestMapping("uploadProfile.emp")
	public Employee ajaxUploadProfile(MultipartFile uploadFile, Employee e, String originalFile, HttpSession session) {
		
		
		if(uploadFile != null) {
			
			if(!originalFile.equals("")) {
				// 기존의 프사가 있었을경우 해당 파일 삭제
				new File(session.getServletContext().getRealPath(originalFile)).delete();
			} 
			// 넘어온 파일이 있을 경우
			String saveFilePath = FileUpload.saveFile(uploadFile, session, "resources/profile_images/");
			e.setEmpPhoto(saveFilePath);
			// session 에 profileImg 가 업데이트된 새 로그인객체 담기!
			session.setAttribute("e", e);
			}
		return e;
				
		}
	
	@ResponseBody
	@RequestMapping("uploadProfile2.emp")
	public void ajaxUploadProfile2(MultipartFile uploadFile, Employee e, String originalFile, HttpSession session) {

	

		if (uploadFile != null) { // 넘어온 파일이 있을 경우

			String saveFilePath = FileUpload.saveFile(uploadFile, session, "resources/profile_images/");
			e.setEmpPhoto(saveFilePath);

			int result = eService.uploadProfileImg2(e);

			if (result > 0) { // db에 update 성공시

				session.setAttribute("loginUser", eService.loginEmployee(e));

				if (!originalFile.equals("")) {
					new File(session.getServletContext().getRealPath(originalFile)).delete();
				}

			}

		}

	}
	
	@RequestMapping("insert.emp")
	public String insertMember(Employee e, HttpSession session) {
		
		if (e.getEmpGrade().equals("T")) {
			e.setGradeString("TRN");
		} else {
			e.setGradeString("ADM");
		}
		
		int result = eService.insertEmployee(e);
		if(result > 0) {
			// 인서트 되고 1행이 넘어온 상태
			session.setAttribute("alertMsg", "✔ 신규 직원 등록 성공! ✔");
			return "redirect:centerAtt.att";
		} else {
			session.setAttribute("alertMsg", "❌ 직원 등록에 실패했습니다! ❌");
			return "redirect:enrollForm.emp";
		}
	}
	
	
	@RequestMapping("delete.emp")
	public String deleteEmployee(String strDeleteListEmpNo, HttpSession session) {
		
		if(strDeleteListEmpNo.length() == 0) {
			session.setAttribute("alertMsg", "❌ 선택한 직원이 없습니다. 다시 선택해주세요! ❌");
			return "redirect:centerAtt.att";
		} else {
			int result = eService.deleteEmployee(strDeleteListEmpNo);
			
			if(result > 0) {
				session.setAttribute("alertMsg", "✔ " + strDeleteListEmpNo + " 님 퇴사 완료 ✔");
				return "redirect:centerAtt.att";
			} else {
				session.setAttribute("alertMsg", "❌ 직원 퇴사에 실패했습니다! ❌");
				return "redirect:centerAtt.att";
			}
		}
		}
	

	@RequestMapping("select.emp")
	public String selectEmployee() {
		
		return "employee/empMyPage";
	}
	
	@RequestMapping("update.emp")
	public String updateEmployee(Employee e, Model model, HttpSession session) {
		
		int result = eService.updateEmployee(e);
		
		if(result > 0) { // 수정 성공
			
			// db로부터 갱신된 회원 정보를 다시 조회해와서 session에 담기
			session.setAttribute("loginUser", eService.loginEmployee(e));
			session.setAttribute("alertMsg", "성공적으로 회원정보 변경되었습니다.");
			
			// 마이페이지 url재요청
			return "redirect:select.emp";
			
		}else { // 수정 실패
			model.addAttribute("errorMsg", "회원정보 변경 실패");
			return "common/errorPage";
		}	
	
	}
	
	@ResponseBody
	@RequestMapping(value="openVacModal.emp", produces="application/json; charset=utf-8")
	public String openVacModalSelectEmpName(String empNo, HttpSession session) {
		ArrayList<Employee> empList = eService.openVacModalSelectEmpName(empNo);
		return new Gson().toJson(empList);
		
	}
	
}

