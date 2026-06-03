package com.gallery.secu;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

@Service
@Repository
@RequiredArgsConstructor
public class SecuServiceImpl implements SecuService {

    private final SecuMapper secuMapper;

//	@Override
//	public void test(SecuVo secuVo, HttpServletResponse response)
//			throws Exception {
//		// TODO Auto-generated method stub
//		// response.setCharacterEncoding("UTF-8");
//		response.setContentType("text/html;charset=utf-8"); // 한글깨짐방지
//		PrintWriter writer = response.getWriter();
//		String str = secuVo.getSn();
//
//		if(str.equals("abcd")){
//			str = "ok";
//		}
//		writer.write(str);
//
//		writer.flush();
//		writer.close();
//	}
//
//	@Override
//	@Transactional
//	public String checkSn(SecuVo secuVo) throws Exception {
//		// TODO Auto-generated method stub
//
//		SqlSession sqlSession=getSqlSession();
//		int cnt=(Integer)sqlSession.selectOne(namespace+"countReg", secuVo);
//		if(1==cnt){
//			return "success";
//		}else{
//			return "fail";
//		}
//	}
//
//	@Override
//	@Transactional
//	public String regMac(SecuVo secuVo) throws Exception {
//		// TODO Auto-generated method stub
//
//		SqlSession sqlSession=getSqlSession();
//		sqlSession.update(namespace+"modifyMac", secuVo);
//		return "success";
//
//	}

    @Override
    public String checkMac(SecuVo secuVo) {
        int cnt = secuMapper.countAuth(secuVo);
        return (cnt == 1) ? "success" : "fail";
    }

    @Override
    public String checkDvc(SecuVo secuVo) {
        int cnt = secuMapper.countDvc(secuVo);
        return (cnt == 1) ? "success" : "fail";
    }

}
