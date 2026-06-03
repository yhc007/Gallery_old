package com.gallery.web.prdctType.service.copy;

import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.gallery.web.event.domain.EventPrdctVo;
import com.gallery.web.event.domain.EventVo;


public interface PrdctTypeService {
	public void mListPrdctTypeData(HttpServletResponse response) throws Exception;
}
