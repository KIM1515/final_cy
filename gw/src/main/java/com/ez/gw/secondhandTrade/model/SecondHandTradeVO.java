package com.ez.gw.secondhandTrade.model;

import java.security.Timestamp;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data 
public class SecondHandTradeVO { //사내중고거래
	private int tradeNo; //중고거래번호
	private int empNo; //사원번호
	private String title; //거래글제목
	private String product; //상품명
	private int price; //상품가격
	private String discription; //상품설명
	private Timestamp regdate; //등록일
	private int readCount; //조회수
	private int boardListNo; //게시판번호
}
