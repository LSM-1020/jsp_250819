<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%	
    if(request.getParameter("error") != null) {
		out.println("<script>alert('수정 또는 삭제 권한이 없는 글입니다');window.location.href='list.do';</script>");	
     }
    %>
    
    
<%@ taglib prefix="c" uri="jakarta.tags.core" %>   
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %> 
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>게시글 수정</title>
  <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="css/boardindex.css" />
  <link rel="stylesheet" href="css/edit.css" />
</head>
<body>
  <header>
    <h1>회사 게시판</h1>
    <p>게시글 수정 페이지</p>
  </header>

  <main>
    <section class="edit-wrapper">
     <form action="editOk.do" method="post" class="edit-form">
        <!-- 게시글 번호는 hidden으로 전달 -->
        <input type="hidden" name="bnum" value="${boardDto.bnum}" />

        <div class="form-group">
          <label for="title">제목</label>
          <input type="text" id="title" name="title" value="${boardDto.btitle}" required />
        </div>

        <div class="form-group">
          <label for="author">작성자</label>
          <input type="text" id="author" name="author" value="${boardDto.memberid}" required />
        </div>

        <div class="form-group">
          <label for="content">내용</label>
          <textarea id="content" name="content" rows="10" required>${boardDto.bcontent}</textarea>
        </div>

        <div class="form-actions">
          <button type="submit" class="btn-primary" >수정 완료</button>
          <button type="button" class="btn-secondary" onclick="history.back()">취소</button>
        </div>
      </form>
    </section>
  </main>

  
</body>
</html>