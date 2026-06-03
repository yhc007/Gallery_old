package com.gallery.web.board.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.gallery.web.board.domain.BoardVo;

@Service
public class BoardServiceImpl extends SqlSessionDaoSupport implements BoardService{

	private final static String namespace= "com.gallery.board.";

	@Override
	public Map getBoardList(BoardVo boardVo) throws Exception {
		SqlSession sql = getSqlSession();
		
		List boardList=sql.selectList(namespace+"getBoardList", boardVo);
		Map resultMap = new HashMap();
		resultMap.put("boardList", boardList);
		return resultMap;
	}

	@Override
	public String write(BoardVo boardVo) throws Exception {
		SqlSession sql = getSqlSession();
		String result = "";
		try{
			sql.insert(namespace + "write", boardVo);
			result = "success";
		}catch(Exception e){
			e.printStackTrace();
			result = "fail";
		}
		return result;
	}

	@Override
	public BoardVo viewContent(BoardVo boardVo) throws Exception {
		SqlSession sql = getSqlSession();
		boardVo = (BoardVo)sql.selectOne(namespace + "viewContent", boardVo);
		return boardVo;
	}

	@Override
	public String writeReply(BoardVo boardVo) throws Exception {
		SqlSession sql = getSqlSession();
		String result = "";
		try{
			sql.insert(namespace + "writeReply", boardVo);
			result = "success";
		}catch(Exception e){
			e.printStackTrace();
			result = "fail";
		}
		return result;
	}

	@Override
	public Map getReplyList(BoardVo boardVo) throws Exception {
		SqlSession sql = getSqlSession();
		List replyList = sql.selectList(namespace + "getReplyList", boardVo);
		Map resultMap = new HashMap();
		resultMap.put("replyList", replyList);
		return resultMap;
	}

	@Override
	public BoardVo checkUsr(BoardVo boardVo) throws Exception {
		SqlSession sql = getSqlSession();
		boardVo = (BoardVo) sql.selectOne(namespace + "checkUsr", boardVo);
		return boardVo;
	}

	@Override
	public String delBoard(BoardVo boardVo) throws Exception {
		SqlSession sql = getSqlSession();
		String result = "";
		try{
			sql.delete(namespace + "delBoard", boardVo);
			result = "success";
		}catch(Exception e){
			e.printStackTrace();
			result = "fail";
		}
		return result;
	}
	
	@Override
	public String delReply(BoardVo boardVo) throws Exception {
		SqlSession sql = getSqlSession();
		String result = "";
		try{
			sql.delete(namespace + "delReply", boardVo);
			result = "success";
		}catch(Exception e){
			e.printStackTrace();
			result = "fail";
		}
		return result;
	}

	@Override
	public String modifyWrite(BoardVo boardVo) throws Exception {
		SqlSession sql = getSqlSession();
		String result = "";
		try{
			sql.update(namespace + "modifyWrite", boardVo);
			if(!boardVo.getFileName().equals("null")){
				logger.info(boardVo);
				/*sql.update(namespace + "modifyFile", boardVo);*/
			}
			result = "modified";
		}catch(Exception e){
			e.printStackTrace();
			result = "fail";
		}
		return result;
	}

	@Override
	public String modifyWirteAfterFilUpload(BoardVo boardVo) throws Exception {
		SqlSession sql = getSqlSession();
		String result = "";
		try{
			sql.update(namespace + "modifyWirteAfterFilUpload", boardVo);
			result = "success";
		}catch(Exception e){
			e.printStackTrace();
			result = "fail";
		}
		return result;
	}

	@Override
	public Map getFile(BoardVo boardVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List fileList = sql.selectList(namespace + "getFile", boardVo);
		resultMap.put("fileList",fileList);
		return resultMap;
	}

	@Override
	public String checkReader(BoardVo boardVo) throws Exception {
		SqlSession sql = getSqlSession();
		String result = "";
		try{
			String reader = (String) sql.selectOne(namespace + "checkShopTy", boardVo);
			boardVo.setReader(reader);
			
			String exist = (String) sql.selectOne(namespace + "checkExist", boardVo);
			if(exist==null){
				sql.insert(namespace + "checkReader", boardVo);
			}
			
			result = "success";
		}catch(Exception e){
			e.printStackTrace();
			result = "fail";
		}
		
		return result;
	}

	@Override
	public Map showReader(BoardVo boardVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List readerList = sql.selectList(namespace + "showReader", boardVo);
		resultMap.put("readerList", readerList);
		return resultMap;
	}

	@Override
	public String setComplete(BoardVo boardVo) throws Exception {
		SqlSession sql = getSqlSession();
		String result = "";
		try{
			sql.update(namespace + "setComplete", boardVo);
			result = "success";
		}catch(Exception e){
			e.printStackTrace();
			result = "fail";
		};
		return result;
	}

}
