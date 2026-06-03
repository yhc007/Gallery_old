package com.gallery.secu;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class SecuServiceImpl implements SecuService{

	private final SecuMapper secuMapper;

    @Deprecated
	@Override
	@Transactional
	public String checkSn(SecuVo secuVo) {
       Integer cnt = secuMapper.countReg(secuVo);
       return (cnt==1) ? "success" : "fail";
	}

    @Deprecated
	@Override
	@Transactional
	public String regMac(SecuVo secuVo){
        secuMapper.modifyMac(secuVo);
		return "success";
	}

	@Override
	public String checkMac(SecuVo secuVo) {
        Integer cnt=secuMapper.countAuth(secuVo);
        return (cnt==1) ? "success" : "fail";
	}

	@Override
	public String checkDvc(SecuVo secuVo) {
        Integer cnt=secuMapper.countDvc(secuVo);
        return (cnt==1) ? "success" : "fail";
	}

}
