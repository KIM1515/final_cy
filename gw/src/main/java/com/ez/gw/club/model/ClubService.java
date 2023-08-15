package com.ez.gw.club.model;

import java.util.List;

import com.ez.gw.common.SearchVO;

public interface ClubService {
	int insertClub(ClubVO vo);
	List<ClubVO> selectClub(SearchVO searchVo);
	ClubVO selectByClubNo(int clubNo);
	int updateClub(ClubVO vo);
	int deleteClub(int clubNo);
}
