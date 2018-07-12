package com.project.pickplace.dto;

import java.util.Date;

import javax.validation.constraints.NotNull;

import lombok.Data;
import lombok.NoArgsConstructor;

/*
MNUM 		NUMBER(13,0)		No				1	글번호
KAKAOEMAIL	VARCHAR2(20 BYTE)	No				2	글쓴이
MTITLE		VARCHAR2(30 BYTE)	No				3	제목
MLOCAL		VARCHAR2(20 BYTE)	No				4	지역
MCONTENT	VARCHAR2(40 BYTE)	Yes				5	메모
MCDATE		DATE				No	SYSDATE 	6	등록날짜
MUDATE		DATE				No	SYSDATE 	7	수정날짜
BEGINLAT	VARCHAR2(30 BYTE)	No				8	시작위도
BEGINLNG	VARCHAR2(30 BYTE)	No				9	시작경도
*/

@Data // getter, setter, toString, requiredArgsConstructor(Notnull 파라미터 생성자)
@NoArgsConstructor	// 기본 생성자
public class MapInfoDTO {
	@NotNull
	private Integer mnum;	 // 글번호
	
	@NotNull
	private String kakaoEmail; // 글쓴이
	
	@NotNull
	private String mtitle; 	 // 제목
	
	@NotNull
	private String mlocal;	 // 지역
	
	private String mcontent; // 메모 
	private Date mcdate;	 // 등록날짜
	private Date mudate;	 // 수정날짜
	
	@NotNull 
	private String beginLat; // 시작위도
	
	@NotNull
	private String beginLng; // 시작경도 
}
