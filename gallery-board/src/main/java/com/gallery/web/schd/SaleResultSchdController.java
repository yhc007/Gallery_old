package com.gallery.web.schd;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;

import com.gallery.web.sale.controller.SaleController;
import com.gallery.web.sale.service.SaleService;


@Controller
public class SaleResultSchdController {
	private static final Logger logger = LoggerFactory.getLogger(SaleResultSchdController.class);
	@Autowired
	SaleService saleService;
	
	
	@Scheduled(cron="0 59 23 * * *")
	//@Scheduled(fixedRate=1000*60*10) // 1초마다 한번씩 실행
	public void saleResultSchd() {
		
		logger.info("run saleResultSchd");
		try{
			saleService.timeExceed();
		}catch(Exception e){
			e.printStackTrace();
		}
		
	    //dbCopyExcutor.runRealTimeCopy();
	     
	}
}
