package com.ez.gw.dept.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.ez.gw.dept.model.DeptAllVO;
import com.ez.gw.dept.model.DeptService;
import com.ez.gw.dept.model.DeptVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class DeptController {
    private static final Logger logger = LoggerFactory.getLogger(DeptController.class);
    private final DeptService deptService;

    @GetMapping("/mypage/organizationChart")
    public String deptList(@ModelAttribute DeptVO deptVo, Model model) {
        logger.info("조직도 화면 보여주기");

        List<DeptAllVO> list = deptService.selectAllDept2(deptVo);
        logger.info("부서 조회 결과 list.size()={}, list={}", list.size(), list);
        model.addAttribute("list", list);

        return "mypage/organizationChart";
    }    
 
}
	
