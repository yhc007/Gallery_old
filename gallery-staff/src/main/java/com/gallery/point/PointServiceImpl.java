package com.gallery.point;

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
public class PointServiceImpl implements PointService {

    private final PointMapper pointMapper;
//	@Deprecated
//	@Override
//	@Transactional
//	public String addBalancePoint()  {
//
//
//		List <PointVo> listPoint = sqlSession.selectList(namespace+"listFamilyCd");
//
//		PointVo inputPoinVo = new PointVo();
//		String cstmrCd;
//		for(int i=0,size =listPoint.size();i<size;i++)
//		{
//			logger.info("loop:"+i);
//			cstmrCd = listPoint.get(i).toString();
//			inputPoinVo.setFmlyCd(cstmrCd);
//			sqlSession.insert(namespace+"calcBalancePoint", inputPoinVo);
//		}
//		return "success";
//
//	}

    @Override
    @Transactional
    public String addPointHist(PointVo pointVo) {
        pointMapper.addPointHist(pointVo);
        return "success";
    }

    //	@Deprecated
//	@Override
//	public PointVo selectPointByFmlyCd(PointVo pointVo)  {
//
//
//
//		pointVo = (PointVo) sqlSession.selectOne(namespace+"pointByFmlyCd", pointVo);
//
//		return pointVo;
//	}
    @Override
    @Transactional
    public PointVo selectPointByCstmrCd(PointVo pointVo) {
        if (null == pointVo.getFmlyCd() || pointVo.getFmlyCd().equals("")) {
            pointVo = pointMapper.selectFmlyCdbyPointCd(pointVo);
            CstmrVo cstmrVo = new CstmrVo();
            cstmrVo.setCstmrCd(pointVo.getCstmrCd());
            cstmrVo.setFmlyCd(pointVo.getFmlyCd());
            pointMapper.modifyFmlyCdbyCstmrCd(cstmrVo);
        }
        return pointMapper.pointByFmlyCd(pointVo);
    }

    @Override
    public Map listPointHistory(PointVo pointVo) {
        Map resultMap = new HashMap();
        List<PointVo> listPointHist = pointMapper.listPointHist(pointVo);
        resultMap.put("listPointHist", listPointHist);

        return resultMap;
    }

    @Override
    @Transactional
    public String removePointHist(PointVo pointVo) {
        pointMapper.removePointHist(pointVo);
        return "success";
    }

    @Override
    @Transactional
    public String removePointAllSale(PointVo pointVo) {
        pointMapper.removePointAllSale(pointVo);
        return "success";
    }

//    @Deprecated
//	@Override
//	public Map listShopMPointHistMonth(PointVo pointVo)  {
//
//
//		Map resultMap = new HashMap();
//		List <PointVo> listShopPointHist = sqlSession.selectList(namespace+"listPointM", pointVo);
//
//		PointVo monthlyPointVo = new PointVo();
//		PointVo userPointVo = new PointVo();
//		List <PointVo> listUserPointHist = new ArrayList<PointVo>();
//
//		List <PointVo> listRecPointVo = new ArrayList<PointVo>();
//		PointVo recPointVo = new PointVo();
//		for(int i = 0, size=listShopPointHist.size();i<size;i++){
//			monthlyPointVo= listShopPointHist.get(i);
//			listUserPointHist = sqlSession.selectList(namespace+"listPointUser", monthlyPointVo);
//			int totalPoint = (int) monthlyPointVo.getTotalPoint();
//
//			int totalUsingPoint = monthlyPointVo.getMPoint();
//			int tmpTotalPoint = totalPoint;
//			tmpTotalPoint -= monthlyPointVo.getCstmrPoint();
//			int tmpTotalUsingPoint = 0;
//
//			Queue <PointVo> queueUsingPoint = new LinkedList();
//
//			PointVo usingPointVo = null;
//			PointVo earnPointVo = null;
//			int sumDiffPoint = 0;
//			for(int j = 0, sizeJ=listUserPointHist.size(); j<sizeJ;j++){
//				logger.info("["+i+"]["+j+"]");
//				logger.info(monthlyPointVo.getPointId()+", "+monthlyPointVo.getSaleId()+", "
//						+monthlyPointVo.getFmlyCd()+", "+monthlyPointVo.getDateTime()+", "
//						+"totalPoint:"+monthlyPointVo.getTotalPoint()+", MPoint:"+monthlyPointVo.getMPoint()+", "
//						+"cstmrPoint:"+monthlyPointVo.getCstmrPoint());
//				 userPointVo = listUserPointHist.get(j);
//				 int diffPoint = 0;
//				 if(userPointVo.getPointStatus().equals("P")){
//					 //임시 전체 포인트 = 포인트 합 - 유저 포인트.
//					 logger.info("case P");
//					 logger.info("tmpTotalPoint = tmpTotalPoint - userPointVo.getPoint()");
//					 logger.info((tmpTotalPoint - userPointVo.getPoint())+"="+tmpTotalPoint+"-"+userPointVo.getPoint());
//
//					 tmpTotalPoint = tmpTotalPoint - userPointVo.getPoint();
//
//					 //int diffPoint = queueUsingPoint.peek().getPoint() - tmpTotalPoint;
//					 //사용된 포인트 합이 남은 포인트 합 보다 클 경우.
//
//
//					 logger.info("tmpTotalUsingPoint:"+tmpTotalUsingPoint);
//					 logger.info("tmpTotalPoint:"+tmpTotalPoint);
//					 if((tmpTotalUsingPoint - tmpTotalPoint > 0) && !queueUsingPoint.isEmpty()){
//
//						//M이 클 경우.
//						//usingPointVo 가 비었을 경우..(최초, 혹은 M이 소진.)
//						if( (queueUsingPoint.peek() == null) || (userPointVo.getPoint() < queueUsingPoint.peek().getPoint())){
//							logger.info("Bigger M case");
//							//Queue에서 pointVo를 참조만 한다.
//							logger.info("tmpTotalPoint:"+tmpTotalPoint);
//							logger.info("tmpTotalUsingPoint:"+tmpTotalUsingPoint);
//							logger.info("queueUsingPoint.peek():"+queueUsingPoint.peek());
//							if(usingPointVo == null){
//								usingPointVo = queueUsingPoint.peek();
//							}
//							logger.info("earnPointVo:"+earnPointVo);
//							logger.info("usingPointVo:"+usingPointVo);
//
//							earnPointVo = userPointVo;
//							diffPoint = usingPointVo.getPoint() - earnPointVo.getPoint();
//
//							logger.info("@@@Start RecPoint");
//							recPointVo.setUsingShopId(usingPointVo.getShopId());
//							logger.info("usingShopId:"+usingPointVo.getShopId());
//							recPointVo.setPoint(earnPointVo.getPoint());
//							logger.info("point:"+earnPointVo.getPoint());
//							recPointVo.setEarnShopId(earnPointVo.getShopId());
//							logger.info("setEarnShopId:"+earnPointVo.getShopId());
//
//							tmpTotalUsingPoint -= earnPointVo.getPoint();
//							listRecPointVo.add(recPointVo);
//							recPointVo=new PointVo();
//							usingPointVo = null;
//							earnPointVo = null;
//							queueUsingPoint.peek().setPoint(diffPoint);
//
//							//P가 클 경우.
//							}else{
//							logger.info("Bigger P case");
//							 while(!queueUsingPoint.isEmpty()){
//								 //두번째 바퀴에 M이 더 커질 경우 loop 탈출
//								if(userPointVo.getPoint()<queueUsingPoint.peek().getPoint()){
//									break;
//								}
//
//								//Queue에서 pointVo 를 꺼낸다.
//								usingPointVo = queueUsingPoint.poll();
//								logger.info("usingPointVo:"+usingPointVo);
//								earnPointVo = userPointVo;
//								logger.info("userPointVo:"+userPointVo);
//
//								diffPoint = earnPointVo.getPoint() - usingPointVo.getPoint();
//
//								logger.info("@@@Start RecPoint");
//								recPointVo.setUsingShopId(usingPointVo.getShopId());
//								logger.info("setUsingShopId:"+usingPointVo.getShopId());
//								recPointVo.setPoint(usingPointVo.getPoint());
//								logger.info("setPoint:"+usingPointVo.getPoint());
//								recPointVo.setEarnShopId(userPointVo.getShopId());
//								logger.info("setEarnShopId:"+userPointVo.getShopId());
//
//								listRecPointVo.add(recPointVo);
//								recPointVo= new PointVo();
//								//usingPointVo = null;
//								earnPointVo = null;
//								userPointVo.setPoint(diffPoint);
//								//queueUsingPoint.peek().setPoint(diffPoint);
//
//							 }
//						 }
//						sumDiffPoint +=diffPoint;
//						if(sumDiffPoint==totalUsingPoint){
//							//logger.info("nomal case. fmly_cd : "+userPointVo.getFmlyCd() );
//							break;
//						}
//					 }
//
//				 }else if(userPointVo.getPointStatus().equals("M")){
//					 logger.info("case M");
//					 logger.info("tmpTotalUsingPoint = tmpTotalUsingPoint + userPointVo.getPoint();");
//					 logger.info((tmpTotalUsingPoint + userPointVo.getPoint())+"="+tmpTotalUsingPoint+"+"+userPointVo.getPoint());
//					 tmpTotalUsingPoint = tmpTotalUsingPoint + userPointVo.getPoint();
//
//					 logger.info("tmpTotalPoint = tmpTotalPoint + userPointVo.getPoint();");
//					 logger.info((tmpTotalPoint + userPointVo.getPoint())+"="+tmpTotalPoint+"+"+userPointVo.getPoint());
//					 tmpTotalPoint = tmpTotalPoint + userPointVo.getPoint();
//					 logger.info("userPointVo.getDateTime().substring(0, 7):"+userPointVo.getDateTime().substring(0, 7) );
//					 if(userPointVo.getDateTime().substring(0, 7).equals(monthlyPointVo.getDateTime().substring(0,7)) ){
//						 logger.info("enQueue 2014.01");
//						 queueUsingPoint.offer(userPointVo);
//					 }
//
//				 }else{
//					 logger.error("error!! pointStatus is :"+userPointVo.getPointStatus()+", fmly_cd:"+userPointVo.getFmlyCd());
//				 }
//			}
//			//logger.info("index["+i+"]"+monthlyPointVo.toString());
//		}
//
//		//resultMap.put("listPointHist", listPointHist);
//
//		Map pointMap = new HashMap();
//
//		pointMap.put("listRecPoint", listRecPointVo);
//
//		sqlSession.insert(namespace + "tradePointShop", pointMap);
//
//		return resultMap;
//	}


    @Override
    @Transactional
    public String editMPointCstmrHst(PointVo pointVo) {
        int cnt = pointMapper.checkPoint(pointVo);
        if (cnt < 1) {
            pointMapper.addPointCstmrHst(pointVo);
        } else {
            pointVo.setPointId(pointMapper.getPointCstmrHst(pointVo));
            pointMapper.removePointCstmrHstAllStat(pointVo);
            pointMapper.modifyPointCstmrHst(pointVo);
        }
        return "success";
    }

    @Override
    @Transactional
    public String editPPointCstmrHst(PointVo pointVo) {
        int cnt = pointMapper.checkPoint(pointVo);
        if (cnt < 1) {
            pointMapper.addPointCstmrHst(pointVo);
        } else {
            pointVo.setPointId(pointMapper.getPointCstmrHst(pointVo));
            pointMapper.removePointCstmrHst(pointVo);
            pointMapper.modifyPointCstmrHst(pointVo);
        }
        return "success";
    }

    @Override
    @Transactional
    public String mergePoint2FmlyCd(PointVo pointVo) {
        pointMapper.mergePoint2FmlyCd(pointVo);
        return "success";
    }

}
