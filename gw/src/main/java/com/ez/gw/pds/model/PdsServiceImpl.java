package com.ez.gw.pds.model;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ez.gw.board.model.BoardVO;
import com.ez.gw.common.SearchVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class PdsServiceImpl implements PdsService {
	private final PdsDAO pdsDao;

	@Override
	public int insertPds(BoardVO vo) {
		return pdsDao.insertPds(vo);
	}

	@Override
	public List<Map<String, Object>> selectPdsAll(SearchVO vo) {
		return pdsDao.selectPdsAll(vo);
	}

	@Override
	public Map<String, Object> selectPds(int boardNo) {
		return pdsDao.selectPds(boardNo);
	}
	
	@Override
	public int updatePds(BoardVO vo) {
		return pdsDao.updatePds(vo);
	}

	@Override
	public int deletePds(int boardNo) {
		return pdsDao.deletePds(boardNo);
	}

	@Override
	public int insertFiles(PdsVO vo) {
		return pdsDao.insertFiles(vo);
	}

	@Override
	public List<PdsVO> selectFilesByBoardNo(int boardNo) {
		return pdsDao.selectFilesByBoardNo(boardNo);
	}

	@Override
	public int updateDownloadCount(int boardNo) {
		return pdsDao.updateDownloadCount(boardNo);
	}

	@Override
	public int getTotalRecord(SearchVO vo) {
		return pdsDao.getTotalRecord(vo);
	}

	@Override
	public int selectIsFile(int boardNo) {
		return pdsDao.selectIsFile(boardNo);
	}





	
	
}
