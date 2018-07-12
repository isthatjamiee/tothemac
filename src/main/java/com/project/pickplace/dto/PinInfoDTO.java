package com.project.pickplace.dto;

import javax.validation.constraints.NotNull;

import lombok.Data;
import lombok.NoArgsConstructor;

/*
PNUM		NUMBER(13,0)		No		1	지도번호
MNUM		NUMBER(13,0)		No		2	게시글번호
PMEMO		VARCHAR2(20 BYTE)	Yes		3	게시글메모
PTHEME		VARCHAR2(20 BYTE)	No		4	핀테마
BEGIN_LAT	VARCHAR2(30 BYTE)	No		5	시작위도
BEGIN_LNG	VARCHAR2(30 BYTE)	No		6	시작경도
PIN_LAT		VARCHAR2(30 BYTE)	No		7	핀위도
PIN_LNG		VARCHAR2(30 BYTE)	No		8	핀경도
RATE		NUMBER(10,0)		Yes		9	평점(RATE/2)
*/


/**
 * 선택된 PIN 저장 데이터베이스(PinInfo)
 */
@Data // getter, setter, toString, requiredArgsConstructor(Notnull 파라미터만 생성자에 포함)
@NoArgsConstructor	// 기본 생성자
public class PinInfoDTO {

	@NotNull
	private Integer pnum;	 // 지도번호
	@NotNull
	private Integer mnum;	 // 게시글번호 
	private String pmemo;	 // 게시글메모
	@NotNull
	private String ptheme;	 // 핀테마
	@NotNull
	private String pinLat;	 // 핀위도 
	@NotNull
	private String pinLng;	 // 핀경도 
	private Integer rate;	 // 평점 
	
	/**
	 * RequiredConstructor 하면 원래 자동 생성 되어야 하는데 안 돼서 수동 생성..
	 * pnum을 제외한 모든 값 입력 생성자 
	 */
	public PinInfoDTO(@NotNull Integer mnum, String pmemo, @NotNull String ptheme, 
					  @NotNull String pinLat, @NotNull String pinLng, Integer rate) {
		super();
		this.mnum = mnum;
		this.pmemo = pmemo;
		this.ptheme = ptheme;
		this.pinLat = pinLat;
		this.pinLng = pinLng;
		this.rate = rate;
	}
	
	/**
	 * Notnull값만 생성하는 생성자
	 */
	public PinInfoDTO(@NotNull Integer mnum, @NotNull String ptheme, 
					  @NotNull String pinLat, @NotNull String pinLng) {
		super();
		this.mnum = mnum;
		this.ptheme = ptheme;
		this.pinLat = pinLat;
		this.pinLng = pinLng;
	}
}
