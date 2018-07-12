package com.project.pickplace.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.pickplace.dto.MapInfoDTO;

@Repository
public class MapDAOImplXML implements MapDAO {
	
	//mybatis 구별 위한 변수
	private static final String NAMESPACE = "mapinfo.";
	
	@Autowired
	private SqlSession sqlSession;

	//기록 생성하기
	@Override
	public void write(MapInfoDTO mapdto) {
		sqlSession.insert(NAMESPACE + "write", mapdto);
	}

	//기록 수정하기
	@Override
	public void update(MapInfoDTO mapdto) {
		sqlSession.update(NAMESPACE + "update", mapdto);
	}

	//기록 삭제하기
	@Override
	public void delete(Integer mnum) {
		sqlSession.delete(NAMESPACE + "delete", mnum);
	}
	
	//기록 리스트 불러오기
	@Override
	public List<MapInfoDTO> maplist() {
		return sqlSession.selectList(NAMESPACE + "maplist");
	}

}
