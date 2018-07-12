package com.project.pickplace.controller;

import static org.springframework.web.bind.annotation.RequestMethod.*;

import java.util.List;

import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.pickplace.dao.MapDAO;
import com.project.pickplace.dto.MapInfoDTO;

@Controller
@RequestMapping("/map") 
public class MapController {
	private static final Logger logger = LoggerFactory.getLogger(MapController.class);
	
	@Autowired
	@Qualifier("mapDAOImplXML")
	MapDAO mapdao;
	
	//내 지도 만들기 페이지
	@RequestMapping(value="/write")
	public void write(Model model)
	{
		logger.info("write GET...");
	}
	
	//내 지도 작성 로직
	@RequestMapping(value="/write", method=POST)
	public String write(@Valid MapInfoDTO mapdto, BindingResult reseult)
	{
		logger.info("write POST..." + mapdto.toString());
		mapdao.write(mapdto);
		
		return "redirect:/map/list";	// 글 작성 후 리스트 페이지 이동
	}
	
	//내 지도 수정하기
	@RequestMapping(value="update", method=GET)
	public String update(MapInfoDTO mapdto, Model model)
	{
		logger.info("update GET..." + mapdto.toString());
		mapdao.update(mapdto);
		model.addAttribute("mapdto", mapdto);
		
		return "redirect:/map/list";
	}
	
	//내 지도 삭제하기
	@RequestMapping(value="/delete", method=GET)
	public String delte(@RequestParam("mnum") Integer mnum)
	{
		mapdao.delete(mnum);
		return "redirect:/map/list";
	}
	
	//내 지도 리스트
	@RequestMapping(value="/list", method=GET)
	public void list(Model model)
	{
		List<MapInfoDTO> list = mapdao.maplist();
		logger.info("list GET..." + list.toString());
		model.addAttribute("maplist", list);
	}
}
