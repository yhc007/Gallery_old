package com.gallery.staff;

import com.amazonaws.services.s3.AmazonS3Client;
import com.gallery.shop.ShopMapper;
import com.gallery.shop.ShopVo;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.net.URL;
import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Repository
@RequiredArgsConstructor
public class StaffServiceImpl implements StaffService {

    private final StaffMapper staffMapper;
    private final ShopMapper shopMapper;
    private final AmazonS3Client s3;
    @Value("${env.BUCKET}")
    private String bucket;
/*	@Override
	@Transactional
	public String addStaffPhotos(StaffVo staffVo,FileUploadForm uploadForm) {



		MultipartFile ufile=uploadForm.getFiles();
		String root = "/usr/local/tomcat7.0/webapps/media";
	    String dpath =null;

	    dpath = File.separator+"staff"+File.separator+staffVo.getStaffId();


	    File dir=new File(root+dpath);
	    if(! dir.exists())
	     dir.mkdirs();
	    String fpath=File.separator+ufile.getOriginalFilename();
	    if(!ufile.isEmpty()){
		     try{
			     byte[] bytes=ufile.getBytes();
			     FileOutputStream fos = new FileOutputStream(root+dpath+fpath);
			     fos.write(bytes);
			     fos.close();
		     }catch(Exception e){
		    	 e.printStackTrace();
		    	 return "fail";
		     }

	    }

	    staffVo.setImgPath(dpath+fpath);

    	sqlSession.update(namespace+"updateImgPath", staffVo);

		return "addsuccess";
	}*/

    @Override
    @Transactional
    public String addStaff(StaffVo staffVo) {
        staffMapper.addStaff(staffVo);
        return staffVo.getStaffId().toString();
    }

//	@Override
//	@Transactional
//	public void modifyStaff(StaffVo staffVo) {
//
//
//		sqlSession.insert(namespace+"modifyStaff", staffVo);
//
//	}
//
//
//	@Override
//	public Map pagedListStaffData(StaffVo staffVo) {
//
//
//		Map resultMap=new HashMap();
//
//		int pageCount=(Integer)sqlSession.selectOne(namespace+"pagedListStaffCount", staffVo);
//		List staffList=sqlSession.selectList(namespace+"pagedListStaff", staffVo);
//		PagingVo paging=new PagingVo();
//		paging.setCurrentPage(staffVo.getCurrentPage());
//		paging.setPageSize(staffVo.getPageSize());
//		paging.setTotalSize(pageCount);
//
//		resultMap.put("pv", paging);
//		resultMap.put("listStaff", staffList);
//		return resultMap;
//	}

    @Override
    public Map listStaffShop(StaffVo staffVo) {
        Map resultMap = new HashMap();

        ShopVo shopVo = new ShopVo();
        shopVo.setShopId(staffVo.getShopId());
        shopVo = shopMapper.getShop(shopVo);
        resultMap.put("shopVo", shopVo);

        Date expirationDate = Date.from(Instant.now().plus(5L, ChronoUnit.MINUTES)); // 5분동안 다운받을 수 있도록 지정

        List<StaffVo> staffList = staffMapper.listStaffShop(staffVo);
         for(StaffVo staff : staffList){
                String key = staff.getImgPath();
                URL url = s3.generatePresignedUrl(bucket, key, expirationDate);
                staff.setImgPath(url.toString());
            }
        resultMap.put("listStaffShop", staffList);

        return resultMap;
    }

    @Override
    public List<StaffVo> listStaff(StaffVo staffVo) {
        ShopVo shopVo = new ShopVo();
        shopVo.setShopId(staffVo.getShopId());
        List<StaffVo> staffList = staffMapper.listStaffShop(staffVo);
        return staffList;
    }

//	@Override
//	public Map listStaffData(StaffVo staffVo) {
//
//
//		Map resultMap=new HashMap();
//		List staffList=sqlSession.selectList(namespace+"listStaff", staffVo);
//		resultMap.put("listStaff", staffList);
//
//		return resultMap;
//	}


    @Override
    public StaffVo selectStaff(StaffVo staffVo) {
        return staffMapper.getStaff(staffVo);
    }

//	@Override
//	public StaffVo selectCStaff(StaffVo staffVo) {
//
//
//		return (StaffVo)sqlSession.selectOne(namespace+"getCStaff", staffVo);
//	}
//
//	@Override
//	public Integer getCStaffCnt(StaffVo staffVo) {
//
//
//		return (Integer)sqlSession.selectOne(namespace+"getCStaffCnt", staffVo);
//	}
//
//
//
//
//	@Override
//	public String removeStaff(StaffVo staffVo) {
//
//
//		sqlSession.delete(namespace+"removeStaff", staffVo);
//		return "success";
//	}
//
//	@Override
//	public String removeStaffPhoto(StaffVo staffVo) {
//
//
//		sqlSession.update(namespace+"removeImgPath", staffVo);
//		return "success";
//	}
//
//
//	@Override
//	public void mListStaffData(StaffVo staffVo,HttpServletResponse response) {
//
//
//		String str="";
//		//response.setCharacterEncoding("UTF-8");
//		response.setContentType("text/html;charset=utf-8"); //한글깨짐방지
//		PrintWriter writer=response.getWriter();
//
//		Map resultMap=new HashMap();
//		List staffList=sqlSession.selectList(namespace+"mlistStaff",staffVo);
//		resultMap.put("listStaff", staffList);
//
//		ObjectMapper om = new ObjectMapper();
//		str=om.writerWithDefaultPrettyPrinter().writeValueAsString(resultMap);
//
//
//		writer.write(str);
//		writer.flush();
//		writer.close();
//	}
//
//	@Override
//	public void mListStaffDataForDsply(StaffVo staffVo,HttpServletResponse response) {
//
//
//		String str="";
//		//response.setCharacterEncoding("UTF-8");
//		response.setContentType("text/html;charset=utf-8"); //한글깨짐방지
//		PrintWriter writer=response.getWriter();
//
//		Map resultMap=new HashMap();
//		List staffList=sqlSession.selectList(namespace+"mlistStaffForDsply",staffVo);
//		resultMap.put("listStaff", staffList);
//
//		ObjectMapper om = new ObjectMapper();
//		str=om.writerWithDefaultPrettyPrinter().writeValueAsString(resultMap);
//
//
//		writer.write(str);
//		writer.flush();
//		writer.close();
//	}

}
