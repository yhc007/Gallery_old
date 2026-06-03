package com.gallery.app.cstmr.controller;

import java.io.PrintWriter;
import java.util.Calendar;
import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gallery.app.cstmr.domain.CstmrVo;
import com.gallery.app.cstmr.service.CstmrService;
import com.gallery.web.common.domain.CommonCode;
import com.gallery.web.mail.domain.MailVo;
import com.gallery.web.sale.domain.SaleVo;
import com.gallery.web.shop.domain.ShopVo;
import com.gallery.web.shop.service.ShopService;

/**
 * Handles requests for the application home page.
 */
@RequestMapping(value = "/cstmr")
@Controller
public class CstmrController {

	private static final Logger logger = LoggerFactory
			.getLogger(CstmrController.class);

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@Autowired
	private CstmrService cstmrService;
	
	@Autowired
	private ShopService shopService;

	@RequestMapping(value = "newCstmr")
	public String newCstmr(HttpServletRequest request,
			HttpServletResponse response, CstmrVo cstmrVo) throws Exception {
		logger.error("run newCstmr cstmrVo" + cstmrVo);
		
		/*
		 * make cstmrCd.
		 * m+shopCode(3digit)+yyyyMMdd+count(3digit) = 15 digit.
		 */
		
		TimeZone jst = TimeZone.getTimeZone ("JST");
		Calendar cal = Calendar.getInstance ( jst );
		String today = ""+cal.get ( Calendar.YEAR )+cal.get ( Calendar.MONTH +1 )+cal.get ( Calendar.DATE );
		String cstmrCd="m"
				+CommonCode.SHOP_CODE_MOBILE
				+today;

		
		ShopVo shopVo = new ShopVo();
		shopVo.setShopId(Integer.parseInt(CommonCode.SHOP_CODE_MOBILE));
		cstmrVo.setRegShopId(Integer.parseInt(CommonCode.SHOP_CODE_MOBILE));
		shopVo.setJoinDate(today);
		Integer countJoin = shopService.countShopJoin(shopVo);
		if(countJoin.intValue() == 0)
		{
			logger.error("countJoin is 0");
			countJoin++;
			shopVo.setJoinCount(countJoin);
			shopService.addShopJoin(shopVo);
			
		}else{
			logger.debug("countJoin is not 0");
			shopVo=shopService.selectShopJoin(shopVo);
			countJoin = shopVo.getJoinCount();
			countJoin++;
			shopVo.setJoinCount(countJoin);
			shopService.modifyShopJoin(shopVo);
		}
		String suffix = String.format("%03d", countJoin.intValue()); 
		
		cstmrCd=cstmrCd.concat(suffix);

		cstmrVo.setCstmrCd(cstmrCd);
		try {
			cstmrService.addCstmr(cstmrVo, response);
		} catch (Exception e) {
			e.printStackTrace();
			response.setCharacterEncoding("UTF-8");
			PrintWriter writer = response.getWriter();
			writer.write("ERROR 500");
			writer.flush();
			writer.close();
		}
		return "home";
	}

	@RequestMapping(value = "idDupleCheck")
	public String idDupleCheck(HttpServletResponse response, CstmrVo cstmrVo)
			throws Exception {
		logger.debug("idDupleCheck " + cstmrVo.toString());
		try {
			cstmrService.idDupleCheck(cstmrVo, response);
		} catch (Exception e) {
			e.printStackTrace();
			response.setCharacterEncoding("UTF-8");
			PrintWriter writer = response.getWriter();
			writer.write("ERROR 500");
			writer.flush();
			writer.close();

		}

		return "home";
	}

	@RequestMapping(value = "login")
	public String login(HttpServletResponse response, CstmrVo cstmrVo)
			throws Exception {
		logger.debug("login " + cstmrVo.toString());
		try {
			cstmrService.login(cstmrVo, response);
		} catch (Exception e) {
			e.printStackTrace();
			response.setCharacterEncoding("UTF-8");
			PrintWriter writer = response.getWriter();
			writer.write("ERROR 500");
			writer.flush();
			writer.close();
		}
		return "home";
	}

	@RequestMapping(value = "findCstmrId")
	public String findCstmrId(HttpServletResponse response, CstmrVo cstmrVo)
			throws Exception {
		logger.debug("findCstmrId " + cstmrVo.toString());
		try {
			cstmrService.findCstmrId(cstmrVo, response);
		} catch (Exception e) {
			e.printStackTrace();
			response.setCharacterEncoding("UTF-8");
			PrintWriter writer = response.getWriter();
			writer.write("ERROR 500");
			writer.flush();
			writer.close();
		}
		return "home";
	}

	@RequestMapping(value = "findCstmrPw")
	public String findCstmrPw(HttpServletResponse response, CstmrVo cstmrVo)
			throws Exception {
		logger.debug("findCstmrId " + cstmrVo.toString());
		try {
			cstmrService.findCstmrPw(cstmrVo, response);
		} catch (Exception e) {
			e.printStackTrace();
			response.setCharacterEncoding("UTF-8");
			PrintWriter writer = response.getWriter();
			writer.write("fail");
			writer.flush();
			writer.close();
		}
		return "home";
	}

	@RequestMapping(value = "changePwForm")
	public String changePwForm(ModelMap model, MailVo mailVo) throws Exception {
		logger.debug("changePw " + mailVo.toString());

		CstmrVo cstmrVo = cstmrService.selectCstmrKey(mailVo);

		model.addAttribute("cstmrId", cstmrVo.getCstmrId());
		return "cstmr/changePwForm";
	}

	@RequestMapping(value = "updatePwAction")
	@ResponseBody
	public String updatePwAction(HttpServletResponse response, CstmrVo cstmrVo)
			throws Exception {
		logger.info("updatePwAction " + cstmrVo.toString());

		try {
			return cstmrService.updatePw(cstmrVo);
		} catch (Exception e) {
			e.printStackTrace();
			return "fail";
		}
	}

	@RequestMapping(value = "mlistCstmrData")
	public void listCartData(CstmrVo cstmrVo, ModelMap model,
			HttpServletResponse response) {

		logger.debug("modify " + cstmrVo.toString());
		try {
			cstmrService.responseCstmrData(cstmrVo, response);
		} catch (Exception e) {
			e.printStackTrace();

			response.setContentType("text/html;charset=utf-8"); // 한글깨짐방지
			PrintWriter writer = null;
			try {
				response.getWriter();
				writer.write("fail");
				writer.flush();
				writer.close();
			} catch (Exception e2) {

			}
		}
	}

	@RequestMapping(value = "cstmrInfoUpdate")
	@ResponseBody
	public void cstmrInfoUpdate(HttpServletResponse response, CstmrVo cstmrVo)
			throws Exception {
		logger.error("modify " + cstmrVo.toString());
		response.setCharacterEncoding("UTF-8");
		try {
			cstmrService.updateInfo(cstmrVo, response);
		} catch (Exception e) {

			e.printStackTrace();
			response.setContentType("text/html;charset=utf-8"); // 한글깨짐방지
			PrintWriter writer = null;
			try {
				response.getWriter();
				writer.write("fail");
				writer.flush();
				writer.close();
			} catch (Exception e2) {

			}
		}
	}
	@RequestMapping(value = "cstmrBuyList")
	@ResponseBody
	public void cstmrBuyList(HttpServletResponse response, SaleVo saleVo)
			throws Exception {
		//logger.error("List " + saleVo.toString());
		response.setCharacterEncoding("UTF-8");
		try {
			cstmrService.buyList(saleVo, response);
		} catch (Exception e) {

			e.printStackTrace();
			response.setContentType("text/html;charset=utf-8"); // 한글깨짐방지
			PrintWriter writer = null;
			try {
				response.getWriter();
				writer.write("fail");
				writer.flush();
				writer.close();
			} catch (Exception e2) {

			}
		} 
		
	}
		@RequestMapping(value = "myCoupon")
		@ResponseBody
		public void getCoupon(HttpServletResponse response, CstmrVo cstmrVo)
				throws Exception {
			//logger.error("List " + saleVo.toString());
			response.setCharacterEncoding("UTF-8");
			try {
				cstmrService.myCoupon(cstmrVo, response);
			} catch (Exception e) {

				e.printStackTrace();
				response.setContentType("text/html;charset=utf-8"); // 한글깨짐방지
				PrintWriter writer = null;
				try {
					response.getWriter();
					writer.write("fail");
					writer.flush();
					writer.close();
				} catch (Exception e2) {

				}
			}
	}
}
