package com.ez.gw.report.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ez.gw.common.SearchVO;

@Mapper
public interface ReportDAO {
	int insertReport(ReportVO reportVo); //동호회 신고
	List<Map<String, Object>> selectReportClub(SearchVO searchVo); //관리자 동호회 신고함
	int anonymousBoardReport(ReportVO reportVo);
	int searchEmpNo(ReportVO reportVo);
	int dupClubBoardReport(ReportVO reportVo); //동호회 
	int anonymousCommentReport(ReportVO reportVo);
	int searchAnonymousBoardReport(ReportVO reportVo);
	int searchAnonymousCommentReport(ReportVO reportVo);
	List<Map<String, Object>> anonymousReportList(ReportVO reportVo);
	int getTotalAnonymousReport(ReportVO reportVo);
	Map<String, Object> selectByReportNo(int reportNo);
	int updateAnonymousReport(int reportNo);
	int updateAnonymousReportPostpone(int reportNo);
	Map<String, Object> clubByReportNo(int reportNo);
	int anonymousReportCount();
	int warningMarket(ReportVO reportVo);
}
