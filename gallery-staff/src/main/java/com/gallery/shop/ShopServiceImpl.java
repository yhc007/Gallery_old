package com.gallery.shop;

import com.gallery.cstmr.CstmrVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Repository
@RequiredArgsConstructor
public class ShopServiceImpl implements ShopService {

    private final ShopMapper shopMapper;
//	@Override
//	@Transactional
//	public String addShop(ShopVo shopVo)  {
//
//
//		int cnt=(Integer)sqlSession.selectOne(namespace+"countShop", shopVo);
//		if(cnt==0){
//			sqlSession.insert(namespace+"addShop", shopVo);
//			return "addsuccess";
//		}else{
//			return "duple";
//		}
//	}
//
//	@Override
//	@Transactional
//	public void modifyShop(ShopVo shopVo)  {
//
//
//		sqlSession.insert(namespace+"modifyShop", shopVo);
//
//	}

    @Override
    public Map listShopData(ShopVo shopVo) {
        Map resultMap = new HashMap();
        List<ShopVo> shopList = shopMapper.listShop(shopVo);
        resultMap.put("listShop", shopList);
        return resultMap;
    }

    @Override
    public ShopVo selectShop(ShopVo shopVo) {
        return shopMapper.getShop(shopVo);
    }

//	@Override
//	public ShopVo removeShop(ShopVo shopVo)  {
//
//
//		sqlSession.delete(namespace+"removeShop", shopVo);
//		return null;
//	}
//
//	@Override
//	public void mListShopData(HttpServletResponse response,ShopVo shopVo)  {
//
//
//		String str="";
//
//		//response.setCharacterEncoding("UTF-8");
//		response.setContentType("text/html;charset=utf-8"); //한글깨짐방지
//		PrintWriter writer=response.getWriter();
//
//		Map resultMap=new HashMap();
//		List shopList=sqlSession.selectList(namespace+"mlistShop",shopVo);
//
//		List list=new ArrayList();
//		for(int i=0;i<shopList.size();i++){
//			Map map=new HashMap();
//			map.put("shopId", ((ShopVo)shopList.get(i)).getShopId());
//			map.put("shopName", ((ShopVo)shopList.get(i)).getShopName());
//			map.put("telephone", ((ShopVo)shopList.get(i)).getTelephone());
//			map.put("shopNum", ((ShopVo)shopList.get(i)).getShopNum());
//			map.put("shopStatTyCd", ((ShopVo)shopList.get(i)).getShopStatTyCd());
//			map.put("lat", ((ShopVo)shopList.get(i)).getLat());
//			map.put("lot", ((ShopVo)shopList.get(i)).getLot());
//			map.put("dstns", ((ShopVo)shopList.get(i)).getDstns());
//			list.add(map);
//		}
//
//		resultMap.put("listShop", list);
//
//		ObjectMapper om = new ObjectMapper();
//		str=om.writerWithDefaultPrettyPrinter().writeValueAsString(resultMap);
//
//
//		writer.write(str);
//		writer.flush();
//		writer.close();
//
//	}
//
//	public Integer countShopJoin(ShopVo shopVo)  {
//
//
//		return (Integer) sqlSession.selectOne(namespace+"countShopJoin", shopVo);
//	}
//	@Override
//	@Transactional
//	public String addShopJoin(ShopVo shopVo)  {
//
//
//		sqlSession.insert(namespace+"addShopJoin", shopVo);
//		return "success";
//	}
//
//	@Override
//	public ShopVo selectShopJoin(ShopVo shopVo)  {
//
//
//		return (ShopVo)sqlSession.selectOne(namespace+"getShopJoin", shopVo);
//	}
//
//
//	@Override
//	@Transactional
//	public String modifyShopJoin(ShopVo shopVo)  {
//
//
//		sqlSession.update(namespace+"modifyShopJoin", shopVo);
//		return "success";
//	}

    @Override
    public String getShopPwd(ShopVo shopVo) {
        try {
            String shop = shopMapper.shopLogin(shopVo);
            if (shop != null) {
                return "success";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "fail";
    }

    //	@Override
//	public void recIP(String IPaddr)  {
//		SqlSession sql = getSqlSession();
//		String exist = (String) sql.selectOne(namespace + "getAddr", IPaddr);
//		if(exist!=null){
//			sql.update(namespace + "addCntIP", IPaddr);
//		}else{
//			sql.insert(namespace + "recIP", IPaddr);
//		}
//
//	}
    @Override
    @Transactional
    public void recCstmrHstry(ShopVo shopVo) {
        Integer exist = shopMapper.countCstmrShopHstry(shopVo);
        if (exist.intValue() == 0) {
            shopMapper.addCstmrHstry(shopVo);
        }
    }

    @Override
    public Map listCstmrShopHstry(ShopVo shopVo) {
        Map resultMap = new HashMap();
        List<CstmrVo> cstmrList = shopMapper.listCstmrShopHstry(shopVo);
        resultMap.put("listCstmrHstry", cstmrList);

        return resultMap;
    }

    @Override
    @Transactional
    public String rmvCstmrShopHstry(ShopVo shopVo) {
        shopMapper.removeCstmrShopHstry(shopVo);
        return "success";
    }

    @Override
    public ShopVo getShopInfo(ShopVo shopVo) {
        return shopMapper.getShopInfo(shopVo);
    }
//	@Override
//	public String connectIp(ShopVo shopVo)  {
//		SqlSession sql = getSqlSession();
//		Integer ipCount=(Integer)sql.selectOne(namespace + "connectIp",shopVo);
//
//		if(ipCount==null||ipCount<=0) {
//			sql.insert(namespace+"addConnectIp",shopVo);
//		}else {
//			sql.update(namespace+"updateConnectIp",shopVo);
//		}
//		return "";
//	}
}
