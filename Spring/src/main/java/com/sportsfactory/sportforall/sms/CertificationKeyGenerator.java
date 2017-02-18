package com.sportsfactory.sportforall.sms;

import java.util.HashMap;

import org.apache.log4j.Logger;

import com.sportsfactory.sportforall.dao.CertifiDao;
import com.sportsfactory.sportforall.dto.CertificationDto;
import com.sportsfactory.sportforall.service.AccountService;


/**
 * @author lee
 * sms인증시 전화번호에대한 키 제네레이터
 */
public class CertificationKeyGenerator {
	
	private static Logger log = Logger.getLogger(CertificationKeyGenerator.class);
	
	public static CertificationKeyGenerator newInstance(){
		return new CertificationKeyGenerator();
	}
	
	private CertificationKeyGenerator(){}
	
	/**
	 * 인증키 생성 유틸
	 * 인증키는 아래와 같이 시간을 전번 뒤에 섞고 끝에서 6자리를 서브스트링한다.
	 * @param Number
	 * @return
	 */
	public String tempKeyGenarator(String Number){
		String lastNumberString = null;
		String numberArray[] = Number.split("-");
		if(numberArray[2].charAt(0) == '0'){
			lastNumberString = "1"+numberArray[2].substring(1, numberArray[2].length());
		}else{
			lastNumberString = numberArray[2];
		}
		String last = Long.toString((Integer.parseInt(lastNumberString) * System.currentTimeMillis()));
		return last.substring(last.length()-6, last.length());
	}
}
