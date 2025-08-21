<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>글쓰기 - 회사 게시판</title>
  <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="css/write.css" />
</head>
<body>
  <header>
    <h1>회사 게시판</h1>
    <p>새 글을 작성해주세요</p>
  </header>

  <main>
    <section class="write-wrapper">
      <form action="writeOk.do" method="post" class="write-form">
        <div class="form-group">
          <label for="title">제목</label>
          <input type="text" id="title" name="title" placeholder="제목을 입력하세요" required />
        </div>

        <div class="form-group">
          <label for="author">작성자</label>
          <input type="text" id="author" name="author" value="${ sessionScope.sessionId}" placeholder="작성자를 입력하세요" required readonly />
        </div>

        <div class="form-group">
          <label for="content">내용</label>
          <textarea id="content" name="content" rows="10" placeholder="내용을 입력하세요" required></textarea>
        </div>

        <div class="form-actions">
          <button type="submit" class="btn-primary">작성 완료</button>
          <button type="button" class="btn-secondary" onclick="history.back()">취소</button>
        </div>
      </form>
    </section>
  </main>
</body>
</html>