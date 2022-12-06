package com.project.fitty.approval.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.project.fitty.approval.model.service.ApprovalService;
import com.project.fitty.approval.model.vo.ApprExpDetail;
import com.project.fitty.approval.model.vo.ApprExpense;
import com.project.fitty.approval.model.vo.ApprOvertime;
import com.project.fitty.approval.model.vo.ApprVacation;
import com.project.fitty.approval.model.vo.Approval;
import com.project.fitty.approval.model.vo.ApprovalMember;
import com.project.fitty.approval.model.vo.File;
import com.project.fitty.common.model.vo.PageInfo;
import com.project.fitty.common.template.FileUpload;
import com.project.fitty.common.template.Pagination;
import com.project.fitty.employee.model.vo.Employee;

@Controller
public class ApprovalController {
	
	@Autowired
	private ApprovalService aService;
	
	@RequestMapping(value="apprMain.ap", produces="application/json; charset=utf-8")
	public ModelAndView goApproval(String empNo, ModelAndView mv) {
		
		ArrayList<Approval> dlist = aService.selectMainDraftList(empNo);
		ArrayList<Approval> clist = aService.selectMainCompleteList(empNo);
		
		mv.addObject("dlist", dlist).addObject("clist", clist).setViewName("approval/approvalMainView");
		
		return mv;
	}
	
	@RequestMapping(value="vacation.ap", produces="application/json; charset=utf-8")
	public ModelAndView goVacation(ModelAndView mv) {
		ArrayList<Employee> list = aService.selectEmpList();
		mv.addObject("list", list).setViewName("approval/vacationEnrollForm");
		
		return mv;
	}
	
	@RequestMapping(value="overtime.ap", produces="application/json; charset=utf-8")
	public ModelAndView goOvertime(ModelAndView mv) {
		ArrayList<Employee> list = aService.selectEmpList();
		mv.addObject("list", list).setViewName("approval/overtimeEnrollForm");
		return mv;
	}
	
	@RequestMapping(value="expense.ap", produces="application/json; charset=utf-8")
	public ModelAndView goExpense(ModelAndView mv) {
		ArrayList<Employee> list = aService.selectEmpList();
		mv.addObject("list", list).setViewName("approval/expenseEnrollForm");
		return mv;
	}
	
	// 기안문서함
	@RequestMapping(value="draftList.ap", produces="application/json; charset=utf-8")
	public ModelAndView selectList(@RequestParam(value="cpage", defaultValue="1") int currentPage, String empNo, ModelAndView mv) {
		int listCount = aService.selectListCount(empNo);
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 5, 5);
		ArrayList<Approval> list = aService.selectList(pi, empNo);
		
		mv.addObject("pi", pi).addObject("list", list).setViewName("approval/draftListView");
		
		return mv;
	}
	
	// 기안문서함 ajax
	@ResponseBody
	@RequestMapping(value="changeDraft.ap", produces="application/json; charset=utf-8")
	public String ajaxChangeDraft(@RequestParam(value="cpage", defaultValue="1") int currentPage, String empNo, String apprStatus) {
		Approval ap = new Approval();
		
		if(!apprStatus.isEmpty()) {
			ap.setEmpNo(empNo);
			ap.setApprStatus(apprStatus);
			
			int listCount = aService.ajaxSelectListCount(ap);
			
			PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 5, 5);
			ArrayList<Approval> list = aService.ajaxSelectList(pi, ap);
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("pi", pi);
			map.put("list", list);
			
			return new Gson().toJson(map);
		}else {
			
			int listCount = aService.selectListCount(empNo);
			PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 5);
			ArrayList<Approval> list = aService.selectList(pi, empNo);
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("pi", pi);
			map.put("list", list);
			return new Gson().toJson(map);
		}
		
	}
	
	// 임시저장함
	@RequestMapping(value="storageList.ap", produces="application/json; charset=utf-8")
	public ModelAndView selectstorageList(@RequestParam(value="cpage", defaultValue="1") int currentPage, String empNo, ModelAndView mv) {
		int listCount = aService.selectStorageListCount(empNo);
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 5, 5);
		ArrayList<Approval> list = aService.selectStorageList(pi, empNo);
		
		mv.addObject("pi", pi).addObject("list", list).setViewName("approval/storageListView");
		
		return mv;
	}
	
	// 결재문서함
	@RequestMapping(value="signList.ap", produces="application/json; charset=utf-8")
	public ModelAndView selectSignList(@RequestParam(value="cpage", defaultValue="1") int currentPage, String empNo, ModelAndView mv) {
		int listCount = aService.selectSignListCount(empNo);
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 5, 5);
		ArrayList<Approval> list = aService.selectSignList(pi, empNo);
		
		mv.addObject("pi", pi).addObject("list", list).setViewName("approval/signListView");
		
		return mv;
	}
	
	// 결재문서함 ajax
	@ResponseBody
	@RequestMapping(value="changeSign.ap", produces="application/json; charset=utf-8")
	public String ChangeSign(@RequestParam(value="cpage", defaultValue="1") int currentPage, String empNo, String apprStatus) {
		Approval ap = new Approval();
		
		if(!apprStatus.isEmpty()) {
			ap.setEmpNo(empNo);
			ap.setApprStatus(apprStatus);
			
			int listCount = aService.ajaxSelectListCount(ap);
			
			PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 5, 5);
			ArrayList<Approval> list = aService.ajaxSelectSignList(pi, ap);
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("pi", pi);
			map.put("list", list);
			
			return new Gson().toJson(map);
		}else {
			int listCount = aService.selectListCount(empNo);
			PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 5, 5);
			ArrayList<Approval> list = aService.selectSignList(pi, empNo);
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("pi", pi);
			map.put("list", list);
			return new Gson().toJson(map);
		}
	}
	
	// 휴가신청서 기안
	@RequestMapping("insertVct.ap")
	public String insertApprVct(Approval ap, ApprovalMember am, ApprVacation vct, HttpSession session, Model model) {
		ArrayList<ApprovalMember> list = am.getMlist();
		
		for(int i=0; i<am.getMlist().size(); i++) {
			list.get(i).setApprLevel(i+1);
		}
		
		int result1 = aService.insertApproval(ap);
		int result2 = aService.insertApprMember(list);
		int result3 = aService.insertApprVct(vct);
		
		if(result1>0 && result2>0 && result3>0) {
			session.setAttribute("alertMsg", "결재가 요청되었습니다.");
			return "redirect:draftList.ap?empNo=" + ap.getEmpNo();
		}else {
			model.addAttribute("errorMsg", "결재 요청 실패");
			return "common/errorPage";
		}
	}
	
	// 연장근무신청서 기안
	@RequestMapping("insertOvt.ap")
	public String insertApprOvt(Approval ap, ApprovalMember am, ApprOvertime ovt, HttpSession session, Model model) {
		ArrayList<ApprovalMember> list = am.getMlist();
		
		for(int i=0; i<am.getMlist().size(); i++) {
			list.get(i).setApprLevel(i+1);
		}
		
		int result1 = aService.insertApproval(ap);
		int result2 = aService.insertApprMember(list);
		int result3 = aService.insertApprOvt(ovt);
		
		if(result1>0 && result2>0 && result3>0) {
			session.setAttribute("alertMsg", "결재가 요청되었습니다.");
			return "redirect:draftList.ap?empNo=" + ap.getEmpNo();
		}else {
			model.addAttribute("errorMsg", "결재 요청 실패");
			return "common/errorPage";
		}
	}
	
	// 지출결의서 기안
	@RequestMapping("insertExp.ap")
	public String insertApprExp(Approval ap, ApprovalMember am, ApprExpense exp, ApprExpDetail expd, MultipartFile[] upfile, HttpSession session, Model model) {
		ArrayList<ApprovalMember> list = am.getMlist();
		ArrayList<ApprExpDetail> dlist = expd.getDlist();
		ArrayList<File> flist = new ArrayList<>();
		
		for(int i=0; i<am.getMlist().size(); i++) {
			list.get(i).setApprLevel(i+1);
		}
		
		if(upfile.length != 0) {
			for(int i=0; i<upfile.length; i++) {
				
				String saveFilePath = FileUpload.saveFile(upfile[i], session, "resources/approval_images/");
				
				File f = new File();
				f.setOriginName(upfile[i].getOriginalFilename());
				f.setChangeName(saveFilePath);
				f.setFileReNo(ap.getApprNo());
				
				flist.add(f);
			}
			
		}
		int sum = 0;
		for(int i=0; i<dlist.size(); i++) {
			sum += dlist.get(i).getExpAmount();
			exp.setExpTotalAmount(sum);
		}
		
		int result1 = aService.insertApproval(ap);
		int result2 = aService.insertApprMember(list);
		int result3 = aService.insertApprExp(exp);
		int result4 = aService.insertApprExpDetail(dlist);
		int result5 = aService.insertApprFile(flist);
		
		if(result1>0 && result2>0 && result3>0 && result4>0 && result5>0) {
			session.setAttribute("alertMsg", "결재가 요청되었습니다.");
			return "redirect:draftList.ap?empNo=" + ap.getEmpNo();
		}else {
			model.addAttribute("errorMsg", "결재 요청 실패");
			return "common/errorPage";
		}
	}
	
	// 임시저장
	@RequestMapping("insertStorage.ap")
	public String insertStorage(Approval ap, ApprVacation vct, ApprOvertime ovt, ApprExpense exp, ApprExpDetail expd, File f, MultipartFile[] upfile, HttpSession session, Model model) {
		ArrayList<ApprExpDetail> dlist = expd.getDlist();
		ArrayList<File> flist = new ArrayList<>();
		
		
		int result1 = aService.insertStorage(ap);
		
		if(ap.getApprDocType().equals("1")) {
			int result2 = aService.insertApprVct(vct);
			if(result1>0 && result2>0) {
				session.setAttribute("alertMsg", "내용이 저장되었습니다.");
				return "redirect:storageList.ap?empNo=" + vct.getEmpNo();
			}else {
				model.addAttribute("errorMsg", "임시저장 실패");
				return "common/errorPage";
			}
			
		}else if(ap.getApprDocType().equals("2")) {
			int result3 = aService.insertApprOvt(ovt);
			
			if(result1>0 && result3>0) {
				session.setAttribute("alertMsg", "내용이 저장되었습니다.");
				return "redirect:storageList.ap?empNo=" + ovt.getEmpNo();
			}else {
				model.addAttribute("errorMsg", "임시저장 실패");
				return "common/errorPage";
			}
		}else {

			if(upfile.length != 0) {
				for(int i=0; i<upfile.length; i++) {
					flist.add(f);
					String saveFilePath = FileUpload.saveFile(upfile[i], session, "resources/approval_images/");
					flist.get(i).setOriginName(upfile[i].getOriginalFilename());
					flist.get(i).setChangeName(saveFilePath);
					flist.get(i).setFileReNo(ap.getApprNo());
				}
				
				int sum = 0;
				for(int i=0; i<dlist.size(); i++) {
					sum += dlist.get(i).getExpAmount();
					exp.setExpTotalAmount(sum);
				}
			}
			
			int result4 = aService.insertApprExp(exp);
			int result5 = aService.insertApprExpDetail(dlist);
			int result6 = aService.insertApprFile(flist);
			
			if(result1>0 && result4>0 && result5>0 && result6>0) {
				session.setAttribute("alertMsg", "내용이 저장되었습니다.");
				return "redirect:storageList.ap?empNo=" + exp.getEmpNo();
			}else {
				model.addAttribute("errorMsg", "임시저장 실패");
				return "common/errorPage";
			}
			
		}
	}
	
	// 결재예정문서
	@RequestMapping(value="duleList.ap", produces="application/json; charset=utf-8")
	public ModelAndView scheduleList(@RequestParam(value="cpage", defaultValue="1") int currentPage, String empNo, ModelAndView mv) {
		int listCount = aService.selectScheduleListCount(empNo);
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 5, 5);
		ArrayList<Approval> list = aService.selectScheduleList(pi, empNo);
		
		mv.addObject("pi", pi).addObject("list", list).setViewName("approval/apprScheduleListView");
		
		return mv;
	}
	
	// 결재대기문서
	@RequestMapping(value="waitingList.ap", produces="application/json; charset=utf-8")
	public ModelAndView waitingList(@RequestParam(value="cpage", defaultValue="1") int currentPage, String empNo, ModelAndView mv) {
		int listCount = aService.selectWaitingListCount(empNo);
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 5, 5);
		ArrayList<Approval> list = aService.selectWaitingList(pi, empNo);
		
		mv.addObject("pi", pi).addObject("list", list).setViewName("approval/apprWaitingListView");
		
		return mv;
		
	}
	
	// 결재대기문서상세
	@RequestMapping(value="apprDetail.ap", produces="application/json; charset=utf-8")
	public ModelAndView selectDetail(String apprNo, String apprDocType, ModelAndView mv) {
		
		ArrayList<ApprovalMember> mlist = aService.selectMember(apprNo);
		
		if(apprDocType.equals("1")) {
			ApprVacation vct = aService.selectVacation(apprNo);
			vct.setApprDocType(apprDocType);
			mv.addObject("mlist", mlist).addObject("vct", vct).setViewName("approval/vacationDetailView");
		}else if(apprDocType.equals("2")) {
			ApprOvertime ovt = aService.selectOvertime(apprNo);
			ovt.setApprDocType(apprDocType);
			mv.addObject("mlist", mlist).addObject("ovt", ovt).setViewName("approval/overtimeDetailView");
		}else {
			ApprExpense exp = aService.selectExpense(apprNo);
			ArrayList<ApprExpDetail> elist = aService.selectExpDetail(apprNo); 
			mv.addObject("mlist", mlist).addObject("exp", exp).addObject("elist", elist).setViewName("approval/expenseDetailView");

		}
		
		return mv;
		
	}
	
	// 결재승인
	@RequestMapping("approve.ap")
	public String updateStatus(ApprovalMember am, ApprVacation vct, ApprOvertime ovt, String apprDocType, HttpSession session, Model model) {
		if(am.getApprLevel() == am.getApprMemCount()) {
			// 최종승인
			am.setApprStatus("3");
			int result1 = aService.updateApproval(am);
			int result2 = aService.updateApprovalMem(am);
			
			if(apprDocType.equals("1")) {
				int result3 = aService.updateAtt1(vct);
				int result4 = aService.insertVacation(vct);
				if(result1>0 && result2>0 && result3>0 && result4>0) {
					session.setAttribute("alertMsg", "결재가 승인되었습니다.");
					return "redirect:signList.ap";
				}else {
					model.addAttribute("errorMsg", "결재실패");
					return "common/errorPage";
				}
			}else if(apprDocType.equals("2")){
				int result3 = aService.updateAtt2(ovt);
				
				if(result1>0 && result2>0&&result3>0) {
					session.setAttribute("alertMsg", "결재가 승인되었습니다.");
					return "redirect:signList.ap";
				}else {
					model.addAttribute("errorMsg", "결재실패");
					return "common/errorPage";
				}
			}else {
				if(result1>0 && result2>0) {
					session.setAttribute("alertMsg", "결재가 승인되었습니다.");
					return "redirect:signList.ap";
				}else {
					model.addAttribute("errorMsg", "결재실패");
					return "common/errorPage";
				}
			}
			
			
			
			
		}else {
			// 일반승인
			am.setApprStatus("2");
			int result1 = aService.updateApproval(am);
			int result2 = aService.updateApprovalMem(am);
			if(result1>0 && result2>0) {
				session.setAttribute("alertMsg", "결재가 승인되었습니다.");
				return "redirect:signList.ap";
			}else {
				model.addAttribute("errorMsg", "결재실패");
				return "common/errorPage";
			}
		}
	}
	
	// 반려
	@RequestMapping("return.ap")
	public String updateReturnAppr(ApprovalMember am, String insertEmpNo, HttpSession session, Model model) {
		am.setEmpNo(insertEmpNo);
		int result1 = aService.updateReturnAppr(am);
		int result2 = aService.updateReturnApprMem(am);
		
		if(result1>0 && result2>0) {
			session.setAttribute("alertMsg", "문서를 반려하였습니다.");
			return "redirect:signList.ap?empNo=" + am.getEmpNo();
		}else {
			model.addAttribute("errorMsg", "반려실패");
			return "common/errorPage";
		}
	}
	
	// 기안문서함상세
	@RequestMapping(value="draftDetail.ap", produces="application/json; charset=utf-8" )
	public ModelAndView selectDraftDetail(String apprNo, String apprDocType, ModelAndView mv) {
		
		ArrayList<ApprovalMember> mlist = aService.selectMember(apprNo);
		
		if(apprDocType.equals("1")) {
			ApprVacation vct = aService.selectVacation(apprNo);
			mv.addObject("mlist", mlist).addObject("vct", vct).setViewName("approval/draftVctDetailView");
		}else if(apprDocType.equals("2")) {
			ApprOvertime ovt = aService.selectOvertime(apprNo);
			mv.addObject("mlist", mlist).addObject("ovt", ovt).setViewName("approval/draftOvtDetailView");
		}else {
			ApprExpense exp = aService.selectExpense(apprNo);
			ArrayList<ApprExpDetail> elist = aService.selectExpDetail(apprNo); 
			mv.addObject("mlist", mlist).addObject("exp", exp).addObject("elist", elist).setViewName("approval/draftExpDetailView");

		}
		
		return mv;
		
	}
	
	// 임시저장상세
	@RequestMapping(value="storageDetail.ap", produces="application/json; charset=utf-8")
	public ModelAndView selectStorageDetail(String apprNo, String apprDocType, ModelAndView mv) {
		ArrayList<Employee> list = aService.selectEmpList();
		ArrayList<ApprovalMember> mlist = aService.selectMember(apprNo);
		
		if(apprDocType.equals("1")) {
			ApprVacation vct = aService.selectVacation(apprNo);
			mv.addObject("list", list).addObject("mlist", mlist).addObject("vct", vct).setViewName("approval/vacationStorageForm");
		}else if(apprDocType.equals("2")) {
			ApprOvertime ovt = aService.selectOvertime(apprNo);
			mv.addObject("list", list).addObject("mlist", mlist).addObject("ovt", ovt).setViewName("approval/overtimeStorageForm");
		}else {
			ApprExpense exp = aService.selectExpense(apprNo);
			ArrayList<ApprExpDetail> elist = aService.selectExpDetail(apprNo); 
			mv.addObject("list", list).addObject("mlist", mlist).addObject("exp", exp).addObject("elist", elist).setViewName("approval/expenseStorageForm");

		}
		
		return mv;
	}
	
	// 임시저장문서삭제
	@RequestMapping(value="deleteAppr.ap")
	public String deleteApproval(String apprNo,String empNo, String apprDocType, HttpSession session, Model model) {
		
		if(apprDocType.equals("1")) {
			int result2 = aService.deleteVacation(apprNo);
			int result1 = aService.deleteApproval(apprNo);
			
			if(result1>0 && result2>0) {
				session.setAttribute("alertMsg","문서를 성공적으로 삭제했습니다.");
				return "redirect:storageList.ap?empNo=" + empNo;
			}else {
				model.addAttribute("errorMsg", "문서 삭제 실패");
				return "common/errorPage";
			}
		}else if(apprDocType.equals("2")) {
			int result2 = aService.deleteOvertime(apprNo);
			int result1 = aService.deleteApproval(apprNo);
			
			if(result1>0 && result2>0) {
				session.setAttribute("alertMsg","문서를 성공적으로 삭제했습니다.");
				return "redirect:storageList.ap?empNo=" + empNo;
			}else {
				model.addAttribute("errorMsg", "문서 삭제 실패");
				return "common/errorPage";
			}
		}else {
			int result3 = aService.deleteExpDetail(apprNo);
			int result2 = aService.deleteExpense(apprNo);
			int result1 = aService.deleteApproval(apprNo);
			
			if(result1>0 && result2>0 && result3>0) {
				session.setAttribute("alertMsg","문서를 성공적으로 삭제했습니다.");
				return "redirect:storageList.ap?empNo=" + empNo;
			}else {
				model.addAttribute("errorMsg", "문서 삭제 실패");
				return "common/errorPage";
			}

		}
	}
	
	// 임시저장문서기안
	@RequestMapping("updateStorage.ap")
	public String updateStorage(Approval ap, ApprovalMember am, ApprVacation vct, ApprOvertime ovt, ApprExpense exp, ApprExpDetail expd, File f, MultipartFile[] upfile, HttpSession session, Model model) {
		ArrayList<ApprovalMember> list = am.getMlist();
		ArrayList<ApprExpDetail> dlist = expd.getDlist();
		ArrayList<File> flist = new ArrayList<>();
		
		
		int result1 = aService.updateStorage(ap);
		int result2 = aService.insertApprMember(list);
		
		if(ap.getApprDocType().equals("1")) {
			int result3 = aService.updateStorageVct(vct);
			
			if(result1>0 && result2>0 && result3>0) {
				session.setAttribute("alertMsg", "결재요청에 성공했습니다.");
				return "redirect:draftList.ap?empNo=" + ap.getEmpNo();
			}else {
				model.addAttribute("errorMsg", "문서 삭제 실패");
				return "common/errorPage";
			}
		}else if(ap.getApprDocType().equals("2")) {
			int result4 = aService.updateStorageOvt(ovt);
			
			if(result1>0 && result2>0 && result4>0) {
				session.setAttribute("alertMsg", "결재요청에 성공했습니다.");
				return "redirect:draftList.ap?empNo=" + ap.getEmpNo();
			}else {
				model.addAttribute("errorMsg", "문서 삭제 실패");
				return "common/errorPage";
			}
		}else {
			int result5 = aService.updateStorageExp(exp);
			int result6 = aService.updateStorageExpDetail(dlist);
			int result7 = aService.updateStorageFile(flist);
			
			if(result1>0 && result2>0 && result5>0 && result6>0 && result7>0) {
				session.setAttribute("alertMsg", "결재요청에 성공했습니다.");
				return "redirect:draftList.ap?empNo=" + ap.getEmpNo();
			}else {
				model.addAttribute("errorMsg", "문서 삭제 실패");
				return "common/errorPage";
			}
		}
	}
	
	// 기안문서함 검색
	@ResponseBody
	@RequestMapping("search.ap")
	public ModelAndView searchList(ModelAndView mv, @RequestParam(value="cpage", defaultValue="1") int currentPage, String empNo, String keyword, String category) {
		int listCount = aService.selectSearchCount(empNo, keyword, category);
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 5, 5);
		
		ArrayList<Approval> list = aService.selectSearchList(pi, empNo, category, keyword);
		
		mv.addObject("pi", pi)
		  .addObject("list", list)
		  .addObject("category", category)
		  .addObject("keyword", keyword)
		  .setViewName("approval/draftListView");
		
		return mv;
	}
	
	// 임시저장함 검색
	@ResponseBody
	@RequestMapping("searchStorage.ap")
	public ModelAndView searchStorageList(ModelAndView mv, @RequestParam(value="cpage", defaultValue="1") int currentPage, String empNo, String keyword, String category) {
		int listCount = aService.selectStorageSearchCount(empNo, keyword, category);
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 5, 5);
		
		ArrayList<Approval> list = aService.selectStorageSearchList(pi, empNo, category, keyword);
		
		mv.addObject("pi", pi)
		  .addObject("list", list)
		  .addObject("category", category)
		  .addObject("keyword", keyword)
		  .setViewName("approval/storageListView");
		
		return mv;
	}
	
	// 결재문서함 검색
	@ResponseBody
	@RequestMapping("searchSign.ap")
	public ModelAndView searchSignList(ModelAndView mv, @RequestParam(value="cpage", defaultValue="1") int currentPage, String empNo, String keyword, String category) {
		int listCount = aService.selectSignSearchCount(empNo, keyword, category);
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 5, 5);
		
		ArrayList<Approval> list = aService.selectSignSearchList(pi, empNo, category, keyword);
		
		mv.addObject("pi", pi)
		  .addObject("list", list)
		  .addObject("category", category)
		  .addObject("keyword", keyword)
		  .setViewName("approval/signListView");
		
		return mv;
	}
}
