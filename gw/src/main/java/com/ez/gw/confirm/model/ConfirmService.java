package com.ez.gw.confirm.model;

import java.util.List;
import java.util.Map;

import com.ez.gw.deptagree.model.DeptagreeVO;

public interface ConfirmService {
	int insertConfirm(ConfirmVO vo,DeptagreeVO deptAgreeVo,int[] reperEmpNo,List<Map<String, Object>> fileList);
	List<Map<String, Object>> selectAllByEmpNo(ConfirmVO vo);
	int getTotalRecord(ConfirmVO vo);
	List<Map<String, Object>> selectAllConfirmDocument(ConfirmVO vo);
	int getTotalConfirmRecord(ConfirmVO vo);
	Map<String, Object> selectConfirmDocument(String confirmDocumentNo);
	Map<String, Object> selectDeptAgree(String confirmDocumentNo);
	int updateConfirmState(ConfirmVO vo);
	int updateConfirmStateByClick(ConfirmVO vo);
	List<Map<String, Object>> selectAllDeptAgree(ConfirmVO vo);
	int getTotalAgreeRecord (ConfirmVO vo);
	List<Map<String, Object>> selectAllCompleteDocument(ConfirmVO vo);
	int getTotalComplteRecord (ConfirmVO vo);
	List<Map<String, Object>> selectAllRefer (ConfirmVO vo);
	int getTotalReferRecord (ConfirmVO vo);
	List<Map<String, Object>> selectAllReturn (ConfirmVO vo);
	int getTotalReturnRecord (ConfirmVO vo);
	int getTotalAgreeRecordMain (ConfirmVO vo);
	int returnConfirmAndDept(ConfirmVO vo);
}
