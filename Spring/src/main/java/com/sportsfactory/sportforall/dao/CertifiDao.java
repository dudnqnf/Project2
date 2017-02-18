package com.sportsfactory.sportforall.dao;

import com.sportsfactory.sportforall.dto.CertificationDto;

public interface CertifiDao {
	public void insertCertificationKey(CertificationDto dto);
	public String getTempKey(CertificationDto dto);
	public void deleteTempKey(CertificationDto dto);
}
