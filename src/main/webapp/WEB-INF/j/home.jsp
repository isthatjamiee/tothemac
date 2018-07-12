<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="header2.jsp"></jsp:include>

<!-- <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script> -->
<div class="loader">
	<div class="loader-outter"></div>
	<div class="loader-inner"></div>
</div>

<!--=================== content body ====================-->
<div class="col-lg-10 col-md-9 col-12 body_block  align-content-center">
	<jsp:include page="nav2.jsp"></jsp:include>
	<!--=================== content body ====================-->

	<div id="map" style="width: 90%; height: 800px;"></div>


	<div style="text-align: end;">
		<button class="btn btn-outline-info" onclick="selectOverlay('MARKER')">Marker</button>
		<button class="btn btn-outline-info"
			onclick="selectOverlay('POLYLINE')">Line</button>
		<div>
			<ul>
				<li>.</li>
				<li>.</li>
			</ul>
		</div>
	</div>
	<p>
		<!-- <em>지도 중심좌표가 변경되면 지도 정보가 표출됩니다</em> -->
	</p>
	<p id="result"></p>

	<script>
		var map = new daum.maps.Map(document.getElementById('map'), { // 지도를 표시할 div
			center : new daum.maps.LatLng(36.2683, 127.6358), // 지도의 중심좌표 
			level : 6 // 지도의 확대 레벨 
		});
	
		// 마커 클러스터러를 생성합니다 
		var clusterer = new daum.maps.MarkerClusterer({
			map : map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
			averageCenter : true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
			minLevel : 10, // 클러스터 할 최소 지도 레벨 
			calculator : [ 10, 30, 50 ], // 클러스터의 크기 구분 값, 각 사이값마다 설정된 text나 style이 적용된다
			texts : getTexts, // texts는 ['삐약', '꼬꼬', '꼬끼오', '치멘'] 이렇게 배열로도 설정할 수 있다 
			styles : [ { // calculator 각 사이 값 마다 적용될 스타일을 지정한다
				width : '30px',
				height : '30px',
				background : 'rgba(51, 204, 255, .8)',
				borderRadius : '15px',
				color : '#000',
				textAlign : 'center',
				fontWeight : 'bold',
				lineHeight : '31px'
			},
				{
					width : '40px',
					height : '40px',
					background : 'rgba(255, 153, 0, .8)',
					borderRadius : '20px',
					color : '#000',
					textAlign : 'center',
					fontWeight : 'bold',
					lineHeight : '41px'
				},
				{
					width : '50px',
					height : '50px',
					background : 'rgba(255, 51, 204, .8)',
					borderRadius : '25px',
					color : '#000',
					textAlign : 'center',
					fontWeight : 'bold',
					lineHeight : '51px'
				},
				{
					width : '60px',
					height : '60px',
					background : 'rgba(255, 80, 80, .8)',
					borderRadius : '30px',
					color : '#000',
					textAlign : 'center',
					fontWeight : 'bold',
					lineHeight : '61px'
				}
			]
		});
	
		// 클러스터 내부에 삽입할 문자열 생성 함수입니다 
		function getTexts(count) {
			// 한 클러스터 객체가 포함하는 마커의 개수에 따라 다른 텍스트 값을 표시합니다 
			if (count < 10) {
				return '삐약';
			} else if (count < 30) {
				return '꼬꼬';
			} else if (count < 50) {
				return '꼬끼오';
			} else {
				return '치멘';
			}
		}
	
		// 데이터를 가져오기 위해 jQuery를 사용합니다
		// 데이터를 가져와 마커를 생성하고 클러스터러 객체에 넘겨줍니다
		$.getJSON("resources/json/chicken.json", function(data) {
			// 데이터에서 좌표 값을 가지고 마커를 표시합니다
			// 마커 클러스터러로 관리할 마커 객체는 생성할 때 지도 객체를 설정하지 않습니다
			var markers = $(data.positions).map(function(i, position) {
				return new daum.maps.Marker({
					position : new daum.maps.LatLng(position.lat, position.lng)
				});
			});
	
			// 클러스터러에 마커들을 추가합니다
			clusterer.addMarkers(markers);
		});
	
		var imageSrc = 'http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png', // 마커이미지의 주소입니다    
			imageSize = new daum.maps.Size(64, 69), // 마커이미지의 크기입니다
			imageOption = {
				offset : new daum.maps.Point(27, 69)
			}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
	
		//마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
		var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, imageOption),
			markerPosition = new daum.maps.LatLng(37.54699, 127.09598); // 마커가 표시될 위치입니다
	
		//마커를 생성합니다
		var marker = new daum.maps.Marker({
			position : markerPosition,
			image : markerImage // 마커이미지 설정 
		});
	
		//마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);
		clusterer.addMarkers(marker);
	
	
		//마커가 드래그 가능하도록 설정합니다 
		marker.setDraggable(true);
	
		//커스텀 오버레이에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
		var content = '<div class="customoverlay">' +
			'  <a href="http://map.daum.net/link/map/11394059" target="_blank">' +
			'    <span class="title">구의야구공원</span>' +
			'  </a>' +
			'</div>';
	
		//커스텀 오버레이가 표시될 위치입니다 
		var position = new daum.maps.LatLng(37.54699, 127.09598);
	
		//커스텀 오버레이를 생성합니다
		var customOverlay = new daum.maps.CustomOverlay({
			map : map,
			position : position,
			content : content,
			yAnchor : 1
		});
	
		var options = { // Drawing Manager를 생성할 때 사용할 옵션입니다
			map : map, // Drawing Manager로 그리기 요소를 그릴 map 객체입니다
			drawingMode : [ // drawing manager로 제공할 그리기 요소 모드입니다
				daum.maps.drawing.OverlayType.MARKER,
				daum.maps.drawing.OverlayType.POLYLINE,
			],
			// 사용자에게 제공할 그리기 가이드 툴팁입니다
			// 사용자에게 도형을 그릴때, 드래그할때, 수정할때 가이드 툴팁을 표시하도록 설정합니다
			guideTooltip : [ 'draw', 'drag', 'edit' ],
			markerOptions : { // 마커 옵션입니다 
				draggable : true, // 마커를 그리고 나서 드래그 가능하게 합니다 
				removable : true // 마커를 삭제 할 수 있도록 x 버튼이 표시됩니다  
			},
			polylineOptions : { // 선 옵션입니다
				draggable : true, // 그린 후 드래그가 가능하도록 설정합니다
				removable : true, // 그린 후 삭제 할 수 있도록 x 버튼이 표시됩니다
				editable : true, // 그린 후 수정할 수 있도록 설정합니다 
				strokeColor : '#39f', // 선 색
				hintStrokeStyle : 'dash', // 그리중 마우스를 따라다니는 보조선의 선 스타일
				hintStrokeOpacity : 0.5 // 그리중 마우스를 따라다니는 보조선의 투명도
			}
		};
	
		// 위에 작성한 옵션으로 Drawing Manager를 생성합니다
		var manager = new daum.maps.drawing.DrawingManager(options);
	
		// 버튼 클릭 시 호출되는 핸들러 입니다
		function selectOverlay(type) {
			// 그리기 중이면 그리기를 취소합니다
			manager.cancel();
	
			// 클릭한 그리기 요소 타입을 선택합니다
			manager.select(daum.maps.drawing.OverlayType[type]);
		}
	
		// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
		var mapTypeControl = new daum.maps.MapTypeControl();
	
		// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
		// daum.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
		map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT);
	
		// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
		var zoomControl = new daum.maps.ZoomControl();
		map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);
	
		// 지도가 이동, 확대, 축소로 인해 중심좌표가 변경되면 마지막 파라미터로 넘어온 함수를 호출하도록 이벤트를 등록합니다
		daum.maps.event.addListener(map, 'center_changed', function() {
	
			// 지도의  레벨을 얻어옵니다
			var level = map.getLevel();
	
			// 지도의 중심좌표를 얻어옵니다 
			var latlng = map.getCenter();
	
			var message = '<p>지도 레벨은 ' + level + ' 이고</p>';
			message += '<p>중심 좌표는 위도 ' + latlng.getLat() + ', 경도 ' + latlng.getLng() + '입니다</p>';
	
			var resultDiv = document.getElementById('result');
			resultDiv.innerHTML = message;
	
		});
		
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new daum.maps.services.Geocoder();

		var marker = new daum.maps.Marker(), // 클릭한 위치를 표시할 마커입니다
		    infowindow = new daum.maps.InfoWindow({zindex:1}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다

		// 현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
		searchAddrFromCoords(map.getCenter(), displayCenterInfo);

		// 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
		daum.maps.event.addListener(map, 'click', function(mouseEvent) {
		    searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
		        if (status === daum.maps.services.Status.OK) {
		            var detailAddr = !!result[0].road_address ? '<div>도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
		            detailAddr += '<div>지번 주소 : ' + result[0].address.address_name + '</div>';
		            
		            var content = '<div class="bAddr">' +
		                            '<span class="title">주소정보</span>' + 
		                            detailAddr + 
		                        '</div>';

		            // 마커를 클릭한 위치에 표시합니다 
		            marker.setPosition(mouseEvent.latLng);
		            marker.setMap(map);

		            // 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
		            infowindow.setContent(content);
		            infowindow.open(map, marker);
		        }   
		    });
		});

		// 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
		daum.maps.event.addListener(map, 'idle', function() {
		    searchAddrFromCoords(map.getCenter(), displayCenterInfo);
		});

		function searchAddrFromCoords(coords, callback) {
		    // 좌표로 행정동 주소 정보를 요청합니다
		    geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
		}

		function searchDetailAddrFromCoords(coords, callback) {
		    // 좌표로 법정동 상세 주소 정보를 요청합니다
		    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
		}

		// 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
		function displayCenterInfo(result, status) {
		    if (status === daum.maps.services.Status.OK) {
		        var infoDiv = document.getElementById('centerAddr');

		        for(var i = 0; i < result.length; i++) {
		            // 행정동의 region_type 값은 'H' 이므로
		            if (result[i].region_type === 'H') {
		                infoDiv.innerHTML = result[i].address_name;
		                break;
		            }
		        }
		    }    
		}
	</script>



</div>
<!--=================== masaonry portfolio end====================-->



<jsp:include page="header2.jsp"></jsp:include>

</body>
</html>
