package com.project.pickplace.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.project.pickplace.dto.PinInfoDTO;

@Repository
public class PinDAOImplXML implements PinDAO {
	
	// Mybatis 구별을 위한 namespace 변수
	private final String NAMESPACE = "pininfo.";
	
	@Autowired
	SqlSession sqlsession;
	
	@Override
	public void insert(PinInfoDTO pindto) {
		sqlsession.insert(NAMESPACE + "insert", pindto);
	}

	@Override
	public List<PinInfoDTO> pinList() {
		return null;
	}

	@Override
	public List<PinInfoDTO> pinList(String kakaoEmail, String mnum) {
		return null;
	}

}
