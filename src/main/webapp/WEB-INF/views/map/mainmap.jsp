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
   <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=df8bb19db219b164017e5e5170474bfb&libraries=services,clusterer,drawing"></script>
   
   <title>PickPlace!</title>

<style>
    .map_wrap {position:relative;width:100%;height:350px;}
    .title {font-weight:bold;display:block;}
    .hAddr {position:absolute;left:10px;top:10px;border-radius: 2px;background:#fff;background:rgba(255,255,255,0.8);z-index:1;padding:5px;}
    #centerAddr {display:block;margin-top:2px;font-weight: normal;}
    .bAddr {padding:5px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
</style>

</head>
<body>
<div class="map_wrap">
   <div id="map" style="width:100%;height:800px;position:relative;overflow:hidden;">
   </div>
   <div class="hAddr">
       <span class="title">지도중심기준 행정동 주소정보</span>
       <span id="centerAddr"></span>
   </div>
</div>
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
       
       // 주소-좌표 변환 객체 생성 
       var geocoder = new daum.maps.services.Geocoder();
       
       // 현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시 
       searchAddrFromCoords(map.getCenter(), displayCenterInfo);  
    
       // JQuery로 getJSON, 마커 생성 및 클러스터러 객체에 넘겨줌. 
       // 데이터에 근거한 마커 표시, 마커 클러스터러로 관리할 마커 객체는 생성할 때 지도 객체를 설정하지 않습니다
       $.get("resources/json/ulsanlist2.json", function(data) {   
           var markers = $(data.item).map(function(i, position) {
              var marker = new daum.maps.Marker({
                   position : new daum.maps.LatLng(position.lat, position.lng)
               });
               
              var infoContent = document.createElement('div');
              
               var btn = document.createElement('button');
               btn.innerHTML = '버튼';
               
               btn.addEventListener('click', function() { 
                 insertPin(marker.getPosition());
              });  
              
              infoContent.innerHTML = '위도 : ' + position.lat + ' 경도 : ' + position.lng; + '<br>';
              infoContent.appendChild(btn); 
              
             infoRemovable = true; // 인포윈도우 X 버튼 생성 
             
             // 인포윈도우 객체 생성
             var infoWindow = new daum.maps.InfoWindow({
                content : infoContent,  
                removable : infoRemovable
             });
             
             // 마커 클릭 시 인포윈도우 생성 이벤트 
             daum.maps.event.addListener(marker, 'click', function(mouseEvent) {
                  searchDetailAddrFromCoords(marker.getPosition(), function(result, status) {
                    if(status == daum.maps.services.Status.OK) {
                       var detailAddress = !!result[0].road_address ? '<div>도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
                             detailAddress += '<div>지번 주소 : ' + result[0].address.address_name + '</div>';
                           
                          var addContent = '<div class="bAddr">' +
                                           '<span class="title">법정동 주소정보</span>' + 
                                           detailAddress + '</div>';
                    }
                     
                     // 받아온 도로명 주소 인포윈도우에 띄우기
                     /* infoWindow.setContent(addContent);   */
                     
                     // 기본 인포윈도우 띄우기
                     infoWindow.open(map, marker);
                   }); 
              }); 
               
               return marker;
               
               clickable: true;              
           });   // var markers 끝.
           
           clusterer.addMarkers(markers);
       }); // $.get() 끝.
       
       
       // 핀 등록 메서드 
       function insertPin(positions){
          alert('인서트핀');
         $.ajax
         ({
            type:"POST",
            url:"/pin/insert",
            headers:{
               "Content-Type" : "application/json; charset=utf-8",
               "X-HTTP-Method-Override" : "POST"
            },
            dataType: "text",
            data: JSON.stringify({
               mnum:"2", 
               pmemo: "test...",
               ptheme:"blue2",
               pinLat: positions.lat,
               pinLng: positions.lng,
               rate:"1"
            }),
            success:function(result){
               console.log(result);
            },
            error:function(data){
               console.log(data);
            }
         });
       }
      
       // =================================== ▼ 좌표를 통해 주소 표시 메서드 ▼ ============================== 
       // ===================================== 아직 반영하지 않음 ==========================================
       
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
</body>
</html>