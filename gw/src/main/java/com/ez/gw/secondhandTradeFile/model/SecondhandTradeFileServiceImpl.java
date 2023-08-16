package com.ez.gw.secondhandTradeFile.model;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class SecondhandTradeFileServiceImpl implements SecondhandTradeFileService{
	private final SecondhandTradeFileDAO secondhandTradeFileDao;
	
	@Override
	public int insertFile(SecondhandTradeFileVO secondFileVo) {
		return secondhandTradeFileDao.insertFile(secondFileVo);
	}

	@Override
	public List<SecondhandTradeFileVO> showThumbnail() {
		return secondhandTradeFileDao.showThumbnail();
	}
	
	
}
