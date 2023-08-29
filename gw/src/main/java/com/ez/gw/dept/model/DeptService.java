package com.ez.gw.dept.model;

import java.util.List;
import java.util.Map;

public interface DeptService {
	DeptVO deptByNo(int empNo);
	List<DeptVO> selectAllDept();
	List<Map<String, Object>> selectEmpByDeptNo(int deptVo);
	List<DeptAllVO> selectAllDept2(DeptVO deptVo);
	int insertDept(DeptVO deptVo); //부서 추가
	List<Map<String, Object>> selectManager(); //부서장 자격 임직원 조회
	String checkDeptName(String name); //부서 이름 중복확인
}
