
<%@page import="com.LSM.dto.BoardDto"%>
<%@page import="java.util.List"%>
<%@page import="com.LSM.dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>   
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %> 
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>회사 게시판</title>
  <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="css/boardstyle.css" />
  
  <!-- Material Icons 추가 -->
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />
</head>
<body>
  <header>
  
  <a href="index.jsp" class="home-icon" title="홈으로 이동">
    <span class="material-icons">home</span>
  </a>
    <h1>회사 게시판</h1>
    <p>중요 공지 및 사내 소식을 확인하세요</p>
    <span style="color:white;">
    <c:if test="${not empty sessionScope.sessionId }">
    <b>${sessionScope.sessionId }</b>님 접속중
    </c:if>
    </span>
  </header>
<%--
	BoardDao bDao = new BoardDao();
	List<BoardDto> bDtos = bDao.boardList();
	request.setAttribute("bDtos", bDtos);
	--%>
  <main>
    <section class="board-wrapper">

      <!-- 글쓰기 버튼 -->
      <!-- 게시판 상단 액션 영역 (글쓰기 + 검색) -->
<div class="board-top-actions">
  <!-- 글쓰기 버튼 -->
  <div class="write-button-wrap">
    <button class="write-button" onclick="location.href='write.do'">글쓰기</button>
  </div>

  <!-- 검색 폼 -->
   <form action="list.do" method="get">
    	<select name="searchType">
    		<option value="btitle" ${searchType == 'btitle' ? 'selected' : '' }>제목</option>
    		<option value="bcontent" ${searchType == 'bcontent' ? 'selected' : '' }>내용</option>
    		<option value="b.memberid" ${searchType == 'b.memberid' ? 'selected' : '' }>작성자</option>    		
    	</select>
    	<input type="text" name="searchKeyword" value="${searchKeyword != null ? searchKeyword : ''}" placeholder="검색어 입력">
    	<input type="submit" value="검색">
    </form>
</div>

      <!-- 게시판 테이블 -->
      <table class="board-table">
        <thead>
          <tr>
            <th>글번호</th>
            <th>글제목</th>
            <th>작성자</th>
            <th>이메일</th>
            <th>작성일</th>
            <th>조회수</th>
          </tr>
        </thead>
         <tbody>
        <c:forEach items="${bDtos}" var="bDt">
        <tr>
          <td>${bDt.bno}</td>
          <td>
          <c:choose>
          	<c:when test="${fn:length(bDt.btitle) > 35}">
          		<a href="content.do?bnum=${bDt.bnum }">${fn:substring(bDt.btitle, 0, 35)}...</a>
          	</c:when>
          	<c:otherwise>
            			<a href="content.do?bnum=${bDt.bnum }">${bDt.btitle}</a>
            		</c:otherwise>
            	</c:choose>
            </td>
            <td>${bDt.memberid}</td>
            <td>${bDt.memberDto.memberemail}</td>
            <td>${fn:substring(bDt.bdate,0,10)}</td>
            <td>${bDt.bhit}</td>
          </tr>
         </c:forEach>
        </tbody>
      </table>
      <br>
    <!-- 1 페이지로 이동 화살표  -->
    <c:if test="${currentPage > 1}">
    <a href="list.do?page=1&searchType=${searchType}&searchKeyword=${searchKeyword}"> ◀◀ </a>
    </c:if>
    <!-- 이전 페이지 그룹으로 이동 화살표  -->
    <c:if test="${startPage > 1 }">
    <a href="list.do?page=${startPage-1}&searchType=${searchType}&searchKeyword=${searchKeyword}"> ◀ </a>
    </c:if>
    <!-- 페이지 번호 그룹 출력 -->
    <span>
	    <c:forEach begin="${startPage }" end="${endPage }" var="i">
	    	<c:choose>
	    		<c:when test="${i == currentPage }">
	    			<span><a href="list.do?page=${i}&searchType=${searchType}&searchKeyword=${searchKeyword }"><b style="color:red;">[${i}]</b> </a></span>
	    		</c:when>
	    		<c:otherwise>
	    			<span><a href="list.do?page=${i}&searchType=${searchType}&searchKeyword=${searchKeyword }"> [${i}] </a></span>
	    		</c:otherwise>
	    	</c:choose>
	    </c:forEach>
    </span>
    
    <!-- 다음 페이지 그룹으로 이동 화살표  -->
    <c:if test="${endPage < totalPage }">
    <a href="list.do?page=${endPage + 1 }&searchType=${searchType}&searchKeyword=${searchKeyword}"> ▶ </a>
    </c:if>
    <!-- 마지막 페이지로 이동 화살표  -->
    <c:if test="${currentPage < totalPage }">
    <a href="list.do?page=${totalPage}&searchType=${searchType}&searchKeyword=${searchKeyword}"> ▶▶ </a>
    </c:if>
      
    </section>
  </main>
</body>
</html>