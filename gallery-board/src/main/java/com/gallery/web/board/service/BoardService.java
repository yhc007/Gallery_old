package com.gallery.web.board.service;

import java.util.Map;

import com.gallery.web.board.domain.BoardVo;




public interface BoardService {
	public Map getBoardList(BoardVo boardVo)throws Exception;
	public String write(BoardVo boardVo)throws Exception;
	public BoardVo viewContent(BoardVo boardVo)throws Exception;
	public String writeReply(BoardVo boardVo)throws Exception;
	public Map getReplyList(BoardVo boardVo)throws Exception;
	public BoardVo checkUsr(BoardVo boardVo)throws Exception;
	public String delBoard(BoardVo boardVo)throws Exception;
	public String delReply(BoardVo boardVo)throws Exception;
	public String modifyWrite(BoardVo boardVo)throws Exception;
	public String modifyWirteAfterFilUpload(BoardVo boardVo)throws Exception;
	public Map getFile(BoardVo boardVo)throws Exception;
	public String checkReader(BoardVo boardVo)throws Exception;
	public Map showReader(BoardVo boardVo)throws Exception;
	public String setComplete(BoardVo boardVo)throws Exception;
}
