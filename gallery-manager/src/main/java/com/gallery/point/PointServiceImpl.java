package com.gallery.point;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
@RequiredArgsConstructor
public class PointServiceImpl implements PointService {

    private final PointMapper pointMapper;

    @Deprecated
    @Override
    @Transactional
    public String addBalancePoint() {
        List<PointVo> listPoint = pointMapper.listFamilyCd();

        PointVo inputPoinVo = new PointVo();
        String cstmrCd;
        for (int i = 0, size = listPoint.size(); i < size; i++) {
            cstmrCd = listPoint.get(i).toString();
            inputPoinVo.setFmlyCd(cstmrCd);
            pointMapper.calcBalancePoint(inputPoinVo);
        }
        return "success";
    }

    @Override
    @Transactional
    public String addPointHist(PointVo pointVo) {
        pointMapper.addPointHist(pointVo);
        return "success";
    }

    @Deprecated
    @Override
    public Map listPointHistory(PointVo pointVo) {
        Map resultMap = new HashMap();
        List<PointVo> listPointHist = pointMapper.listPointHist(pointVo);
        resultMap.put("listPointHist", listPointHist);

        return resultMap;
    }

    @Override
    public Map listShopMPointHistMonth(PointVo pointVo) {
        Map resultMap = new HashMap();
        //매장별 사용 포인트 추출
        pointMapper.removePointMonthly();
        pointMapper.removePointTrade();
        pointMapper.createPointMonthly(pointVo);

        List<PointVo> listShopPointHist = pointMapper.listPointM(pointVo);
        PointVo monthlyPointVo = new PointVo();
        PointVo userPointVo = new PointVo();

        List<PointVo> listRecPointVo = new ArrayList<PointVo>();
        PointVo recPointVo = new PointVo();

        List<PointVo> listUserPointHist = pointMapper.listPointHistMonthly();

        int sizeI = listShopPointHist.size();
        int k = 0;
        for (int i = 0; i < sizeI; i++) {
            monthlyPointVo = listShopPointHist.get(i);
            //이번달 이전에 사용한 포인트 내역만 추출.

            //고객 현재 포인트 가져옴.
            int crntPoint = (int) monthlyPointVo.getTotalPoint();

            //고객 이번달 사용 포인트 가져옴.
            int totalUsingPoint = monthlyPointVo.getMPoint();
            int tmpTotalPoint = crntPoint;

            //총 포인트에서 고객 고유 포인트 뺌.
            tmpTotalPoint -= monthlyPointVo.getCstmrPoint();

            //아래 루프에서 사용할 총 사용 포인트.
            int tmpTotalUsingPoint = 0;
            Queue<PointVo> queueUsingPoint = new LinkedList();

            //기존에 있던 루프 제거를 위해...
            //fmly_cd=#{fmlyCd}
            //and left(date_time,7) &lt;= left(#{dateTime},7)
            //listUserPointHist = sqlSession.selectList(namespace+"listPointUser", monthlyPointVo);

            PointVo usingPointVo = null;
            PointVo earnPointVo = null;
            int sumDiffPoint = 0;
            int sizeJ = listUserPointHist.size();

            int jackpot = 0;
            for (int j = k; j < sizeJ; j++) {
                userPointVo = listUserPointHist.get(j);

                //가족 코드 일치하면서 이번달(포함) 이전일 경우...
                if (monthlyPointVo.getFmlyCd().equals(userPointVo.getFmlyCd())
                    && -1 < monthlyPointVo.getDateTime().compareTo(userPointVo.getDateTime())) {

                    jackpot = 1;
                    int diffPoint = 0;
                    if (userPointVo.getPointStatus().equals("P")) {

                        //임시 전체 포인트 = 포인트 합 - 유저 포인트.
                        tmpTotalPoint = tmpTotalPoint - userPointVo.getPoint();
                        //사용된 포인트 합이 남은 포인트 합 보다 클 경우.

                        if ((tmpTotalUsingPoint - tmpTotalPoint > 0) && !queueUsingPoint.isEmpty()) {

                            //M이 클 경우.
                            //usingPointVo 가 비었을 경우..(최초, 혹은 M이 소진.)
                            if ((queueUsingPoint.peek() == null) || (userPointVo.getPoint() < queueUsingPoint.peek().getPoint())) {

//								//Queue에서 pointVo를 참조만 한다.
                                if (usingPointVo == null) {
                                    usingPointVo = queueUsingPoint.peek();
                                }
                                earnPointVo = userPointVo;
                                diffPoint = usingPointVo.getPoint() - earnPointVo.getPoint();
                                recPointVo.setPointId(usingPointVo.getPointId());
                                recPointVo.setSaleId(usingPointVo.getSaleId());
                                recPointVo.setUsingShopId(usingPointVo.getShopId());
                                recPointVo.setPoint(earnPointVo.getPoint());
                                recPointVo.setEarnShopId(earnPointVo.getShopId());

                                tmpTotalUsingPoint -= earnPointVo.getPoint();
                                listRecPointVo.add(recPointVo);
                                recPointVo = new PointVo();
                                usingPointVo = null;
                                earnPointVo = null;
                                queueUsingPoint.peek().setPoint(diffPoint);

                                //P가 클 경우.
                            } else {

//								logger.info("Bigger P case");
                                while (!queueUsingPoint.isEmpty()) {
                                    //두번째 바퀴에 M이 더 커질 경우 loop 탈출
                                    if (userPointVo.getPoint() < queueUsingPoint.peek().getPoint()) {
                                        k = j;
                                        break;
                                    }

                                    //Queue에서 pointVo 를 꺼낸다.
                                    usingPointVo = queueUsingPoint.poll();
                                    earnPointVo = userPointVo;

                                    diffPoint = earnPointVo.getPoint() - usingPointVo.getPoint();

                                    recPointVo.setPointId(usingPointVo.getPointId());
                                    recPointVo.setSaleId(usingPointVo.getSaleId());
                                    recPointVo.setUsingShopId(usingPointVo.getShopId());
                                    recPointVo.setPoint(usingPointVo.getPoint());
                                    recPointVo.setEarnShopId(userPointVo.getShopId());


                                    listRecPointVo.add(recPointVo);

                                    recPointVo = new PointVo();
                                    earnPointVo = null;
                                    userPointVo.setPoint(diffPoint);

                                }
                            }
                            sumDiffPoint += diffPoint;
                            if (sumDiffPoint == totalUsingPoint) {
                                k = j;
                                break;
                            }
                        }

                    } else if (userPointVo.getPointStatus().equals("M")) {
                        tmpTotalUsingPoint = tmpTotalUsingPoint + userPointVo.getPoint();
                        tmpTotalPoint = tmpTotalPoint + userPointVo.getPoint();
                        //기간 만료된 포인트는 큐에서 처리 안함.
                        if (userPointVo.getDateTime().substring(0, 7).equals(monthlyPointVo.getDateTime().substring(0, 7)) && !userPointVo.getCstmrCd().equals("expired")) {
                            queueUsingPoint.offer(userPointVo);
                        }
                    }
                    k = j;
                } else {
                    if (jackpot == 1) {
                        jackpot = 0;
                        break;
                    }
                }

            }
        }
        HashMap pointMap = new HashMap();

        pointMap.put("listRecPoint", listRecPointVo);

        pointMapper.tradePointShop(pointMap);
        pointMapper.modifyUShopId();
        pointMapper.modifyEShopId();
        pointMapper.cleanPointTrade();


        return resultMap;
    }

    public Map listPointEuTable() {
        Map resultMap = new HashMap();
        List<PointVo> listEuTable = pointMapper.getEuTable();
        resultMap.put("listEuTable", listEuTable);

        return resultMap;
    }

    public Map listPointESumTable() {
        List<PointVo> listETable = pointMapper.getESumTable();
        Map resultMap = new HashMap();
        resultMap.put("listESumTable", listETable);
        return resultMap;
    }

    public Map listPointUeTable() {
        Map resultMap = new HashMap();
        List<PointVo> listUTable = pointMapper.getUeTable();
        resultMap.put("listUeTable", listUTable);
        return resultMap;
    }

    public Map listPointUSumTable() {
        Map resultMap = new HashMap();
        List<PointVo> listUSumTable = pointMapper.getUSumTable();
        resultMap.put("listUSumTable", listUSumTable);
        return resultMap;
    }

    @Override
    @Transactional
    public String expirePoint(PointVo inputVo) {
        pointMapper.removePointYear();
        pointMapper.calcExpirePoint(inputVo);
        pointMapper.expirePoint(inputVo);
        pointMapper.removePointYear();

        return "OK";
    }

}
