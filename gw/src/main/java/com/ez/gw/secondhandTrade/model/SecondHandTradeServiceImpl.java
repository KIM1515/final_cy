package com.ez.gw.secondhandTrade.model;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ez.gw.common.SearchVO;
import com.ez.gw.secondhandTradeFile.model.SecondhandTradeFileVO;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class SecondHandTradeServiceImpl implements SecondHandTradeService{
	private final SecondHandTradeDAO secondHandTradeDao;
	
	@Override
	public int insertMarket(SecondHandTradeVO secondVo) {
		return secondHandTradeDao.insertMarket(secondVo);
	}

	@Override
	public List<SecondHandTradeVO> selectAllMarket(SearchVO searchVo) {
		return secondHandTradeDao.selectAllMarket(searchVo);
	}

	@Override
	public SecondHandTradeVO selectMarketByNo(int tradeNo) {
		return secondHandTradeDao.selectMarketByNo(tradeNo);
	}

	@Override
	public int updateReadCount(int tradeNo) {
		return secondHandTradeDao.updateReadCount(tradeNo);
	}

	@Override
	public int getTotalRecord(SearchVO searchVo) {
		return secondHandTradeDao.getTotalRecord(searchVo);
	}

	@Override
	public int deleteMarket(int tradeNo) {
		return secondHandTradeDao.deleteMarket(tradeNo);
	}

	@Override
	public int updateMarket(SecondHandTradeVO secondVo) {
		return secondHandTradeDao.updateMarket(secondVo);
	}

	
}
