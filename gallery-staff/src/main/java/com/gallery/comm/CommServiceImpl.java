package com.gallery.comm;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

@Deprecated
@Service
@Repository
@RequiredArgsConstructor
public class CommServiceImpl implements CommService {
    private static final String CSTMR_SPACE = "com.gallery.gallerystaff.cstmr.";
    private static final String NAME_SPACE = "com.gallery.gallerystaff.comm.";
    private final CommMapper commMapper;

//    @Transactional
//    public void registId(CommVo commVo){
//        CommVo regist = commMapper.getRegistInfo(commVo);
//        if (regist == null) {
//            commMapper.addRegist(commVo);
//            try {
//                Thread.sleep(1000);
//            } catch (Exception e) {
//            }
//            regist = commMapper.getRegistInfo(commVo);
//            if (regist == null) {
//                return;
//            }
//        } else {
//            commMapper.updateRegist(commVo);
//        }
//        checkVersion(regist);
//    }
//
//    public void checkVersion(CommVo commVo) {
//        System.out.println("CALL checkVersion " + commVo.toString());
//    }
//
//    @Transactional
//    public void unregistId(CommVo commVo) {
//
//        //System.out.println("CALL UNREG ->"+commVo.toString());
//        SqlSession sqlSession = getSqlSession();
//
//        CommVo regist = (CommVo) sqlSession.selectOne(NAME_SPACE + "getRegistInfo", commVo);
//
//        sqlSession.update("removeRegist", commVo);
//
//    }
//
//    @Override
//    public void visitShop(CommVo commVo) {
//
//        SqlSession sqlSession = getSqlSession();
//        CstmrVo cstmrVo = new CstmrVo();
//        cstmrVo.setCstmrLoginId(commVo.getUsrId());
//        cstmrVo = (CstmrVo) sqlSession.selectOne(CSTMR_SPACE + "getCstmrByLoginId", cstmrVo);
//
//        List<CommVo> commList = sqlSession.selectList(NAME_SPACE + "getUserListInShop", commVo);
//
//        for (int i = 0; i < commList.size(); i++) {
//            System.out.println(commList.get(i).toString());
//            sendMsg(commList.get(i).getRegId(), cstmrVo);
//        }
//    }
//
//    private boolean sendMsg(String regid, CstmrVo cstmrVo) {
//        Result result = null;
//        try {
//            Sender sender = new Sender(CommonCode.myApiKey);
//
//
//            Map resultMap = new HashMap();
//            resultMap.put("cstmrId", cstmrVo.getCstmrId());
//            resultMap.put("cstmrName", cstmrVo.getCstmrName());
//
//            ObjectMapper om = new ObjectMapper();
//
//            String str = om.writerWithDefaultPrettyPrinter().writeValueAsString(resultMap);
//
//            System.out.println(str);
//            Message message = new Message.Builder()
//                    //.addData("message", cstmrVo.toString())
//                    .addData("message", str)
//                    .build();
//
//
//            result = sender.send(message, regid, 5);
//        } catch (IOException e) {
//            // TODO Auto-generated catch block
//            e.printStackTrace();
//        }
//
//        System.out.println("======= Send ======");
//
//        if (result.getMessageId() != null) {
//            logger.debug("result.getMessageId() != null");
//            String canonicalRegId = result.getCanonicalRegistrationId();
//            logger.debug("canonicalRegId : " + canonicalRegId);
//            if (canonicalRegId != null) {
//                // same device has more than on registration ID: update database
//                logger.debug("same device has more than on registration ID: update database");
//            } else {
//                //
//            }
//        } else {
//            String error = result.getErrorCodeName();
//            logger.debug("[ERROR]" + error);
//
//            if (error.equals(Constants.ERROR_NOT_REGISTERED)) {
//                // application has been removed from device - unregister
//                // database
//            }
//        }
//
//        return true;
//    }

}
