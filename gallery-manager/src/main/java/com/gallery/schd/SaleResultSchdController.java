package com.gallery.schd;

import com.gallery.sale.SaleService;
import lombok.RequiredArgsConstructor;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.web.bind.annotation.RestController;

@Deprecated
@RestController
@RequiredArgsConstructor
public class SaleResultSchdController {
	private final SaleService saleService;

	@Scheduled(cron="0 59 23 * * *")
	//@Scheduled(fixedRate=1000*60*10) // 1초마다 한번씩 실행
	public void saleResultSchd() {
		try{
			saleService.timeExceed();
		}catch(Exception e){
			e.printStackTrace();
		}
	    //dbCopyExcutor.runRealTimeCopy();
	}
}
