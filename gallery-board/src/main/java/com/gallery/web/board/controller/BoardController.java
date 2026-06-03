package com.gallery.web.board.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gallery.web.board.domain.BoardVo;
import com.gallery.web.board.service.BoardService;

/**
 * Handles requests for the application home page.
 */
@RequestMapping(value = "/board")
@Controller
public class BoardController {
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@Autowired
	private BoardService boardService;
	

	@RequestMapping(value="main")
	public String main(BoardVo boardVo, HttpSession session){
			session.setAttribute("shopTy", boardVo.getShopTy());
			session.setAttribute("shopId", boardVo.getShopId());
		try {
			boardVo = boardService.checkUsr(boardVo);
			session.setAttribute("usr", boardVo.getUsr());
			session.setAttribute("writer", boardVo.getWriter());
			session.setAttribute("id", boardVo.getShopLoginId());
			session.setAttribute("pwd", boardVo.getPwd());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "board/main";
	}
	
	@RequestMapping(value="getBoardList")
	public String getBoardList(BoardVo boardVo, ModelMap model){
		try {
			Map map = boardService.getBoardList(boardVo);
			model.addAllAttributes(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "board/listBoardData";
	}
	
	@RequestMapping(value="write")
	@ResponseBody
	public String write(BoardVo boardVo){
		String result = "";
		try {
			result = boardService.write(boardVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	@RequestMapping(value="viewContent")
	@ResponseBody
	public BoardVo viewContent(BoardVo boardVo){
		try {
			boardVo = boardService.viewContent(boardVo);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return boardVo;
	}
	
	@RequestMapping(value="writeReply")
	@ResponseBody
	public String writeReply(BoardVo boardVo){
		String result = "";
		try {
			result = boardService.writeReply(boardVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	@RequestMapping(value="getReplyList")
	public String getReplyList(BoardVo boardVo, ModelMap model){
		try {
			Map map = boardService.getReplyList(boardVo);
			model.addAllAttributes(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		
		return "board/listReplyData";
	}
	
	@RequestMapping(value="delBoard")
	@ResponseBody
	public String delBoard(BoardVo boardVo){
		String result = "";
		try {
			result = boardService.delBoard(boardVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	@RequestMapping(value="delReply")
	@ResponseBody
	public String delReply(BoardVo boardVo){
		String result = "";
		try {
			result = boardService.delReply(boardVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	@RequestMapping(value="modifyWrite")
	@ResponseBody
	public String modifyWrite(BoardVo boardVo){
		String result = "";
		try {
			result = boardService.modifyWrite(boardVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	@RequestMapping(value="modifyWirteAfterFilUpload")
	@ResponseBody
	public String modifyWirteAfterFilUpload(BoardVo boardVo){
		String result = "";
		try {
			result = boardService.modifyWirteAfterFilUpload(boardVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	@RequestMapping(value="getFile")
	public String getFile(BoardVo boardVo, ModelMap model){
		try {
			Map map = boardService.getFile(boardVo);
			model.addAllAttributes(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "board/listFileData";
	}
	
	@RequestMapping(value="checkReader")
	@ResponseBody
	public String checkReader(BoardVo boardVo){
		String result = "";
		try {
			result = boardService.checkReader(boardVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	@RequestMapping(value="showReader")
	public String showReader(BoardVo boardVo, ModelMap model){
		try {
			Map map = boardService.showReader(boardVo);
			model.addAllAttributes(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "board/listReaderData";
	};
	
	@RequestMapping(value="setComplete")
	@ResponseBody
	public String setComplete(BoardVo boardVo){
		String result = "";
		try {
			result = boardService.setComplete(boardVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		};
		return result;
	};
}

