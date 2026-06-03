package com.gallery.web.fileUpload.service;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.apache.taglibs.standard.tag.common.core.CatchTag;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gallery.web.brand.domain.BrandVo;
import com.gallery.web.common.domain.CommonCode;
import com.gallery.web.common.domain.PagingVo;
import com.gallery.web.company.domain.CompanyVo;
import com.gallery.web.fileUpload.domain.FileVo;
import com.gallery.web.prdct.domain.PrdctVo;
import com.gallery.web.shop.domain.ShopVo;

@Service
@Repository
public class FileServiceImpl extends SqlSessionDaoSupport implements FileService {
	private final static String namespace= "com.gallery.board.";

	@Override
	public String upLoad(FileVo fileVo) throws Exception {
		SqlSession sql = getSqlSession();
		String result = "";
		try{
			if(fileVo.getMultiFile().equals("none")){
				sql.insert(namespace + "writeBeForeUpload", fileVo);
				sql.insert(namespace + "uploadFile", fileVo);
				result = fileVo.getNo().toString();
			}else{
				fileVo.setNo(fileVo.getFileNo());
				sql.insert(namespace + "uploadFile", fileVo);
				result = fileVo.getNo().toString();
			}
			
		}catch(Exception e){
			e.printStackTrace();
			result = "fail";
		}
		return result;
	}

	@Override
	public String modifyFile(FileVo fileVo) throws Exception {
		SqlSession sql = getSqlSession();
		String result = "";
		try{
			sql.update(namespace +"modifyFileData", fileVo);
			result = "success";
		}catch(Exception e){
			e.printStackTrace();
			result = "fail";
		}
		
		return result;
	}
	
	
}