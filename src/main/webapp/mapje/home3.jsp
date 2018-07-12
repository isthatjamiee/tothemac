<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=df8bb19db219b164017e5e5170474bfb&libraries=clusterer"></script>
	
	<title>PickPlace!</title>

</head>
<body>

<div id="map" style="width:100%;height:800px;"></div>
주소값
<p id="result"></p>

	<script>
	    var map = new daum.maps.Map(document.getElementById('map'), { // 지도를 표시할 div
	        center : new daum.maps.LatLng(36.2683, 127.6358), // 지도의 중심좌표 
	        level : 12 // 지도의 확대 레벨 
	    });
	    
	    // 마커 클러스터러 생성
	    var clusterer = new daum.maps.MarkerClusterer({
	        map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
	        averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
	        minLevel: 10 // 클러스터 할 최소 지도 레벨 
	    });
	 
	    $.get("resources/json/chicken.json", function(data) {	// JQuery로 getJSON, 마커 생성 및 클러스터러 객체에 넘겨줌. 
	        // 데이터에 근거한 마커 표시, 마커 클러스터러로 관리할 마커 객체는 생성할 때 지도 객체를 설정하지 않습니다
	        var markers = $(data.positions).map(function(i, position) {
	        	var marker = new daum.maps.Marker({
	                position : new daum.maps.LatLng(position.lat, position.lng)
	            });
	            
	        	var infoContent = document.createElement('div');
	        	infoContent.innerHTML = '위도 : ' + position.lat + ' 경도 : ' + position.lng + '<button type="button" id="btn">클릭</button>';
	        	
		    	infoRemovable = true; // 인포윈도우 X 버튼 생성 
		    
			    var infoWindow = new daum.maps.InfoWindow({
			    	content : infoContent,
			    	removable : infoRemovable
			    });
	        	
	            daum.maps.event.addListener(marker, 'click', function() {
	            	infoWindow.open(map, marker);
	            });
	            
	            return marker;
	            
	            clickable: true
	            
	            addEventHandle('#btn', 'click', onclick);
	            
	    	    // 마우스 이벤트 등록
	    	    /* addEventHandle(infoWinContent, 'click', onClick); */
	        });
	        clusterer.addMarkers(markers);
	    });
	    
	    function onclick(e)	{
	    	alert("클릭");
	    }
	    
	</script>
</body>
</html>
