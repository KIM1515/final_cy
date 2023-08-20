package com.ez.gw.confirm.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ez.gw.common.ConstUtil;
import com.ez.gw.common.FileUploadUtil;
import com.ez.gw.common.PaginationInfo;
import com.ez.gw.confirm.model.ConfirmService;
import com.ez.gw.confirm.model.ConfirmVO;
import com.ez.gw.confirmFile.model.ConfirmFileService;
import com.ez.gw.confirmLine.model.ConfirmLineService;
import com.ez.gw.dept.model.DeptService;
import com.ez.gw.dept.model.DeptVO;
import com.ez.gw.deptagree.model.DeptagreeVO;
import com.ez.gw.documentform.model.DocumentFormService;
import com.ez.gw.documentform.model.DocumentFormVO;
import com.ez.gw.employee.model.EmployeeService;
import com.ez.gw.employee.model.EmployeeVO;
import com.ez.gw.position.model.PositionService;
import com.ez.gw.position.model.PositionVO;
import com.ez.gw.refer.model.ReferService;
import com.ez.gw.state.model.StateService;
import com.ez.gw.state.model.StateVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/approval")
@RequiredArgsConstructor
public class ConfirmController {
	private static final Logger logger = LoggerFactory.getLogger(ConfirmController.class);
    private final ConfirmService confirmService; 
    private final ConfirmFileService confirmFileService; 
    private final DocumentFormService documentFormService; 
    private final DeptService deptService;
    private final PositionService positionService; 
    private final EmployeeService employeeService; 
    private final ReferService referService; 
    private final ConfirmLineService confirmLineService;
    private final FileUploadUtil fileUploadUtil;
    private final StateService StateService;
    
    
    
    
    @GetMapping("/approvalWrite")
    public String approvalWrite_get(Model model,HttpSession session ) {
    	//1
    	logger.info("결재 작성 페이지");
    	
    	//2
    	int empNo=(int)session.getAttribute("empNo");
    	List<DocumentFormVO> formList = documentFormService.selectAllForm();
    	List<DeptVO> deptList = deptService.selectAllDept();
    	EmployeeVO empVo = employeeService.selectByEmpNo(empNo);
    	DeptVO deptVo = deptService.deptByNo(empVo.getDeptNo());
    	PositionVO positionVo = positionService.positionByNo(empVo.getPositionNo());
    	
    	//3
    	model.addAttribute("formList",formList);
    	model.addAttribute("deptList",deptList);
    	model.addAttribute("empVo",empVo);
    	model.addAttribute("deptVo",deptVo);
    	model.addAttribute("positonVo",positionVo);
    	logger.info("결재 양식 리스트 formList.size={}",formList.size());
    	
    	return "approval/approvalWrite";
    }
    
    @PostMapping("/approvalWrite")
    public String approvalWrite_post(HttpSession session,HttpServletRequest request, @ModelAttribute ConfirmVO confirmVo,
    		@ModelAttribute DeptagreeVO deptAgreeVo,@RequestParam(required = false) int[] referEmpNo, Model model) {
    	//1
    	int empNo=(int)session.getAttribute("empNo");
    	logger.info("결재 작성 처리 파라미터 empNo={},confirmVo={}",empNo,confirmVo);
    	logger.info("결재 작성 처리 파라미터 합의부서 deptAgreeVo={}",deptAgreeVo);
    	logger.info("결재 작성 처리 파라미터 참조자 reperEmpNo={}",referEmpNo);
    	
    	//2
    	//첨부파일 처리
    	List<Map<String, Object>> fileList = new ArrayList<>();
    	try {
    		fileList = fileUploadUtil.fileupload(request,ConstUtil.CONFIRMFILE_FLAG);
    	} catch (IllegalStateException e) {
    		e.printStackTrace();
    	} catch (IOException e) {
    		e.printStackTrace();
    	}
    	
    	confirmVo.setEmpNo(empNo);
    	int cnt=confirmService.insertConfirm(confirmVo,deptAgreeVo,referEmpNo,fileList);
    	logger.info("결재 처리 결과 cnt={}",cnt);
    	
    	
    	String msg="결재 작성 처리 중 에러가 발생했습니다.", url="/approval/approvalWrite";
    	if(cnt>0) {
    		msg="결재 작성 처리가 완료되었습니다.";
    	}
    	
    	//3
    	model.addAttribute("msg",msg);
    	model.addAttribute("url",url);
    	
    	return "common/message";
    }
    
    @GetMapping("/selectEmp/selectEmp")
    public String selecEmp_get(Model model,@RequestParam(required = false) int[] referEmpNo ) {
    	//1
    	logger.info("참조자 선택 페이지 파라미터 referEmpNo={}",referEmpNo);
    	
    	//2
    	List<EmployeeVO> empList = employeeService.selectAllEmp();
    	List<DeptVO> deptList = deptService.selectAllDept();
    	List<EmployeeVO> referEmpList = new ArrayList<>();
    	if(referEmpNo!=null) {
	    	for(int i=0;i<referEmpNo.length;i++) {
	    		EmployeeVO vo = employeeService.selectByEmpNo(referEmpNo[i]);
	    		referEmpList.add(vo);
	    	}
    	}
    	
    	//3
    	model.addAttribute("empList",empList);
    	model.addAttribute("deptList",deptList);
    	model.addAttribute("referEmpList",referEmpList);
    	
    	return "approval/selectEmp/selectEmp";
    }
    
    @GetMapping("/selectEmp/createConfirmLine")
    public String createConfirmLine_get(Model model ) {
    	//1
    	logger.info("결재라인 생성 페이지");
    	
    	//2
    	List<EmployeeVO> empList = employeeService.selectAllEmp();
    	List<DeptVO> deptList = deptService.selectAllDept();
    	
    	//3
    	model.addAttribute("empList",empList);
    	model.addAttribute("deptList",deptList);
    	
    	return "approval/selectEmp/confirmLine";
    }
    
    @GetMapping("/selectEmp/selectConfirmLine")
    public String selectConfirmLine_get(HttpSession session, Model model ) {
    	//1
    	int empNo=(int)session.getAttribute("empNo");
    	logger.info("결재라인 선택 페이지 empNo={}",empNo);
    	
    	//2
    	List<Map<String, Object>> lineList = confirmLineService.selectByEmpNo(empNo);
    	logger.info("결재라인 조회 lineList={}",lineList.size());
    	
    	//3
    	model.addAttribute("lineList",lineList);
    	
    	//4
    	return "approval/selectEmp/selectConfirmLine";
    }
    
    @RequestMapping("/confirmList")
    public String confirmList(@ModelAttribute ConfirmVO vo, HttpSession session, Model model) {
    	//1
    	int empNo=(int)session.getAttribute("empNo");
    	logger.info("결재 리스트 페이지 파라미터 empNo={}",empNo);
    	
    	//2
    	List<DocumentFormVO> formList = documentFormService.selectAllForm();
    	List<StateVO> stateList = StateService.selectAllState();
    	
    	PaginationInfo pagingInfo=new PaginationInfo();
    	pagingInfo.setBlockSize(ConstUtil.BLOCK_SIZE);
   		pagingInfo.setCurrentPage(vo.getCurrentPage());
    	pagingInfo.setRecordCountPerPage(ConstUtil.CONFIRM_RECORD_COUNT);
    			
    	vo.setRecordCountPerPage(ConstUtil.CONFIRM_RECORD_COUNT);
    	vo.setFirstRecordIndex(pagingInfo.getFirstRecordIndex());
    	
    	vo.setEmpNo(empNo);
    	List<Map<String, Object>> list = confirmService.selectAllByEmpNo(vo);
    	logger.info("결재문서 조회결과, list.size={}",list.size());
    	
    	int totalRecord = confirmService.getTotalRecord(vo);
		logger.info("결재문서 조회결과, totalRecord={}",totalRecord);
		pagingInfo.setTotalRecord(totalRecord);
    	
    	//3
		model.addAttribute("formList",formList);
		model.addAttribute("stateList",stateList);
    	model.addAttribute("list",list);
    	model.addAttribute("pagingInfo",pagingInfo);
    	model.addAttribute("title","0");

    	//4
    	return "approval/confirmList";
    }
    
    @RequestMapping("/confirm/confirmList")
    public String confirmList_confirm(@ModelAttribute ConfirmVO vo, HttpSession session, Model model) {
    	//1
    	int empNo=(int)session.getAttribute("empNo");
    	logger.info("결재 리스트 페이지 파라미터 empNo={},vo={}",empNo,vo);
    	
    	//2
    	List<DocumentFormVO> formList = documentFormService.selectAllForm();
    	List<StateVO> stateList = StateService.selectAllState();
    	
    	PaginationInfo pagingInfo=new PaginationInfo();
    	pagingInfo.setBlockSize(ConstUtil.BLOCK_SIZE);
   		pagingInfo.setCurrentPage(vo.getCurrentPage());
    	pagingInfo.setRecordCountPerPage(ConstUtil.CONFIRM_RECORD_COUNT);
    			
    	vo.setRecordCountPerPage(ConstUtil.CONFIRM_RECORD_COUNT);
    	vo.setFirstRecordIndex(pagingInfo.getFirstRecordIndex());
    	
    	vo.setEmpNo(empNo);
    	List<Map<String, Object>> list = confirmService.selectAllConfirmDocument(vo);
    	logger.info("결재문서 조회결과, list.size={}",list.size());
    	
    	int totalRecord = confirmService.getTotalConfirmRecord(vo);
		logger.info("결재문서 조회결과, totalRecord={}",totalRecord);
		pagingInfo.setTotalRecord(totalRecord);
    	
    	//3
		model.addAttribute("formList",formList);
		model.addAttribute("stateList",stateList);
    	model.addAttribute("list",list);
    	model.addAttribute("pagingInfo",pagingInfo);
    	model.addAttribute("title","1");

    	//4
    	return "approval/confirmList";
    }
    
    @RequestMapping("/approvalDetail")
    public String approvalDetail(@RequestParam(required = true) String confirmDocumentNo,Model model) {
    	//1
    	logger.info("문서 상세정보 파라미터 confirmDocumentNo={}",confirmDocumentNo);
    	
    	//2
    	Map<String, Object> confirmMap=confirmService.selectConfirmDocument(confirmDocumentNo);
    	logger.info("문서 상세정보 선택 결과 confirmMap={}",confirmMap);
    	
    	Object obj=confirmMap.get("EMP_NO");
    	int empNo = ((BigDecimal) obj).intValue();
    	Map<String, Object> empMap=employeeService.organiationChartViewByEmpNo(empNo);
    	logger.info("기안자 정보 조회 결과 empMap={}",empMap);
    	
    	List<EmployeeVO> referEmpList = employeeService.selectByReferEmpNo(confirmDocumentNo);
    	logger.info("참조자 조회 결과 referList={}",referEmpList.size());
    	
    	Map<String, Object> deptAgreeMap=confirmService.selectDeptAgree(confirmDocumentNo);
    	logger.info("참조자 조회 결과 deptAgreeMap={}",deptAgreeMap);
    	

    	//3
    	model.addAttribute("confirmMap",confirmMap);
    	model.addAttribute("empMap",empMap);
    	model.addAttribute("referEmpList",referEmpList);
    	model.addAttribute("deptAgreeMap",deptAgreeMap);
    	
    	//4
    	return "approval/approvalView";
    }
    
    @ResponseBody
    @RequestMapping("/updateStateAjax")
    public Object updateStateAjax(@ModelAttribute ConfirmVO vo,HttpSession session) {
    	//1
    	int empNo=(int)session.getAttribute("empNo");
    	logger.info("결재상태 업데이트 파라미터 empNo={},vo={}",empNo,vo);
    	
    	//2
    	vo.setEmpNo(empNo);
    	int cnt = confirmService.updateConfirmState(vo);
    	logger.info("결재상태 업데이트 결과 cnt={}",cnt);
    	
    	Map<String, Object> confirmMap=confirmService.selectConfirmDocument(vo.getConfirmDocumentNo());
    	
    	//3
    	return confirmMap.get("STATE");
    }
    
    @ResponseBody
    @RequestMapping("/updateConfirmAjax")
    public Map updateConfirmAjax(@ModelAttribute ConfirmVO vo) {
    	//1
    	logger.info("결재상태 업데이트 파라미터 vo={}",vo);
    	
    	//2
    	int cnt = confirmService.updateConfirmStateByClick(vo);
    	logger.info("클릭 결재상태 업데이트 결과 cnt={}",cnt);
    	
    	Map<String, Object> confirmMap=confirmService.selectConfirmDocument(vo.getConfirmDocumentNo());
    	
    	//3
    	return confirmMap;
    }
}