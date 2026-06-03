package com.gallerytalk.mobile.talkgroup.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.gallerytalk.mobile.common.domain.PagingVo;
import com.gallerytalk.mobile.prdct.domain.PrdctVo;
import com.gallerytalk.mobile.prdct.service.PrdctService;
import com.gallerytalk.mobile.shop.domain.ShopVo;
import com.gallerytalk.mobile.staff.domain.StaffVo;
import com.gallerytalk.mobile.talkgroup.domain.TalkGroupVo;

@Service
@Repository
public class TalkGroupServiceImpl extends SqlSessionDaoSupport implements TalkGroupService{

	private final static String staffspace= "com.gallerytalk.staff.";
	private final static String shopspace= "com.gallerytalk.shop.";
	private final static String groupspace= "com.gallerytalk.talkgroup.";
	
	@Override
	public Map responseShopData(HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Map groupMap=new HashMap();
		
		TalkGroupVo preObj=null;
		
		List list=new ArrayList();
		List <TalkGroupVo> groupList=sqlSession.selectList(groupspace+"listShop");
		logger.info("shopList:"+groupList.toString());
		String model="";
		
		List objList=new ArrayList();
		for(int i=0;i<groupList.size();i++){
			TalkGroupVo obj=(TalkGroupVo)groupList.get(i);
			if(!model.equals(obj.getShopName())){
					Map objMap=new HashMap();
					objMap.put("id", groupList.get(i).getShopId());
					objMap.put("name", groupList.get(i).getShopName());
					
					list.add(objMap);
			}
		}
		groupMap.put("shopList", list);
		
		return groupMap;
	}
	
	@Override
	public Map responseCompData(HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
				SqlSession sqlSession=getSqlSession();
				Map groupMap=new HashMap();
				
				TalkGroupVo preObj=null;
				
				List list=new ArrayList();
				List <TalkGroupVo> groupList=sqlSession.selectList(groupspace+"listComp");
				logger.info("compList:"+groupList.toString());
				String model="";
				
				List objList=new ArrayList();
				for(int i=0;i<groupList.size();i++){
					TalkGroupVo obj=(TalkGroupVo)groupList.get(i);
					if(!model.equals(obj.getShopName())){
							Map objMap=new HashMap();
							objMap.put("id", groupList.get(i).getINum());
							objMap.put("name", groupList.get(i).getCName());
							
							list.add(objMap);
					}
				}
				
				groupMap.put("shopList", list);
				
				return groupMap;
	}
	
	@Override
	public List <TalkGroupVo> getListStaffGid(TalkGroupVo talkGroupVo) throws Exception {
		// TODO Auto-generated method stub
		logger.info("run getListStaffGid:"+talkGroupVo);
		SqlSession sqlSession=getSqlSession();
		String result="";
		int cnt;
		List <TalkGroupVo> listStaff = new ArrayList<TalkGroupVo>();
		//logger.info("step 15");
		if(talkGroupVo.getGroupId().substring(0, 1).equals("S")){
			talkGroupVo.setShopId(Integer.parseInt(talkGroupVo.getGroupId().substring(1)));
			logger.info("shopId:"+talkGroupVo.getShopId());
			cnt = (Integer) sqlSession.selectOne(groupspace+"cntStaffByShop", talkGroupVo);
			//logger.info("step 16");
			
//			if(1>cnt){
//				logger.info("step 17");
//				throw new Exception("no");
//			}else{
				//logger.info("step 18");
				//logger.info("run else case.");
				listStaff = sqlSession.selectList(groupspace+"listStaffByShop", talkGroupVo);
				//logger.info("listStaff:"+listStaff);
			//}
			
		}else if(talkGroupVo.getGroupId().substring(0, 1).equals("C")){
			//logger.info("step 19");
			talkGroupVo.setComId(Integer.parseInt(talkGroupVo.getGroupId().substring(1)));
			//logger.info("comId:"+talkGroupVo.getComId());
			cnt = (Integer) sqlSession.selectOne(groupspace+"cntStaffByComp", talkGroupVo);
			//logger.info("step 20");
//			if(1>cnt){
//				logger.info("step 21");
//				throw new Exception("no");
//			}else{
				//logger.info("step 22");
				//logger.info("run else case.");
				listStaff = sqlSession.selectList(groupspace+"listStaffByComp", talkGroupVo);
				//logger.info("listStaff:"+listStaff);
			//}
		}
		//logger.info("step 23");
		return listStaff;
	}

}
