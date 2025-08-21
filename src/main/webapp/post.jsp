<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%	
    if(request.getParameter("msg") != null) {
		out.println("<script>alert('해당 글은 존재하지 않는 글입니다!');window.location.href='list.do';</script>");	
     }
    %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>  
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>게시글 상세 보기</title>
  <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="css/boardindex.css" />
  <link rel="stylesheet" href="css/post.css" />
</head>
<body>
  <header>
    <h1>회사 게시판</h1>
    <p>중요 공지 및 사내 소식을 확인하세요</p>
  </header>

  <main>
    <section class="post-wrapper">
      <article class="post-content">
        <h2 class="post-title">${boardDto.btitle }</h2>

        <div class="post-meta">
          <span>작성자: ${boardDto.memberid }</span> |
          <span>이메일: ${boardDto.memberDto.memberemail}</span> |
          <span>작성일: ${boardDto.bdate}</span> |
          <span>조회수: ${boardDto.bhit }</span>
        </div>

        <hr />

        <div class="post-body">
         ${boardDto.bcontent }
        </div>

        <div class="post-actions">
        <c:if test="${ sessionScope.sessionId == boardDto.memberid }">
          <button class="btn-edit" onclick="location.href='edit.do?bnum=${boardDto.bnum}'">수정</button>
          <button class="btn-delete" onclick="location.href='delete.do?bnum=${boardDto.bnum}'">삭제</button>
         </c:if>
          <button class="btn-secondary" onclick="location.href='list.do'">목록으로</button>
        </div>
      </article>
    </section>
  </main>
</body>
</html>