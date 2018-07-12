<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../../header.jsp" flush="true"/>

<body>
<div class="loader">
    <div class="loader-outter"></div>
    <div class="loader-inner"></div>
</div>

<!-- 움직이는 컨테이너 클래스 시작 -->
<div class="body-container container-fluid">
	<!-- 모바일화면일 때 나타나는 메뉴 버튼 -->
    <a class="menu-btn" href="javascript:void(0)">
        <i class="ion ion-grid"></i>
    </a>
    
    <div class="row justify-content-center">
		<jsp:include page="../../nav.jsp" flush="true"/>
		
        <!--=================== content 시작 ====================-->
        <div class="col-lg-10 col-md-9 col-12 body_block align-content-center">
            <div class="portfolio">
                <div class="container-fluid">
                    <!--=================== 작품집 시작 ====================-->
                    <div class="grid img-container justify-content-center no-gutters">
                        <div class="grid-sizer col-sm-12 col-md-6 col-lg-3"></div>
                        
                        <c:forEach items="${maplist}" var="mapdto">
                        <div class="grid-item  design col-sm-12 col-md-6 col-lg-3">
                            <a href="#" data-toggle="modal" data-target="#myModal" title="${mapdto.mtitle}">
                                <div class="project_box_one">
                                	<!-- 나의 기록 박스 -->
                                	<div style="height: 360px;">${mapdto.mtitle}</div>
                                    <div class="product_info">
                                        <div class="product_info_text">
                                            <div class="product_info_text_inner">
                                                <i class="ion ion-plus"></i>
                                                <h4><b>${mapdto.mtitle}</b><br>${mapdto.mcontent}</h4>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 나의 기록 박스 끝 -->
                                </div>
                            </a>
                        </div>
                        </c:forEach>
                    <!--=================== 작품집 끝 ====================-->
                </div>
            </div>
        </div>
        <!--=================== content 끝 ====================-->
    </div>
</div>
</div>
<!-- 움직이는 컨테이너 클래스 끝 -->
 
<!-- 기록 클릭했을 때 뜨는 모달 창 시작 -->
  <div class="modal fade" id="myModal">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">Modal Heading</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
          Modal body..
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>
<!-- 기록 클릭했을 때 뜨는 모달 창 끝 -->

<!-- 스크립트 모음 -->
<jsp:include page="../../footer.jsp" flush="true"/>

</body>
</html>