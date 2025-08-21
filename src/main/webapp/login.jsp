<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="jakarta.tags.core" %>
    
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>로그인</title>
  <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="css/login.css" />
</head>
<body>
  <header>
    <h1>회원 로그인</h1>
    <p>계정 정보를 입력하세요</p>
  </header>

  <main>
    <section class="login-wrapper">
      <form action="loginOk.do" method="post" class="login-form">
        <div class="form-group">
          <label for="userid">아이디</label>
          <input type="text" id="userid" name="userid" required autocomplete="username" />
        </div>

        <div class="form-group">
          <label for="password">비밀번호</label>
          <input type="password" id="password" name="password" required autocomplete="current-password" />
        </div>

        <div class="form-actions">
          <button type="submit" class="btn-primary">로그인</button>
        </div>
        <div class="form-actions">
        <c:if test="${param.msg ==1}">
        <p style="color:red;">
          		아이디 또는 비밀번호가 잘못되었습니다.</p>
        </c:if>
         <c:if test="${param.msg ==2}">
        <p style="color:red;">
          		로그인한 유저만 글을쓸수 있습니다.</p>
        </c:if>
        </div>
        
        
      </form>
    </section>
  </main>
</body>
</html>
