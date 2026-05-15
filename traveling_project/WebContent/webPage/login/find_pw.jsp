<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<body>
  <main>
    <form action="/login/find-pw" method="post">
      <table class="find_table">
        <thead>
          <tr>
            <th>비밀번호 찾기</th>
          </tr>
        </thead>

        <tbody>
          <tr>
            <td>
              <input type="text" name="id" placeholder="아이디를 입력하세요." />
            </td>
          </tr>

          <tr>
            <td>
              <input type="text" name="name" placeholder="이름을 입력하세요." />
            </td>
          </tr>

          <tr>
            <td>
              <input type="email" name="email" placeholder="이메일을 입력하세요." />
            </td>
          </tr>

          <tr>
            <td>
              <input type="submit" class="find_btn" value="비밀번호 재설정" />
            </td>
          </tr>

          <tr>
            <td class="find_link">
              <a href="/login/select">로그인</a>
              <a href="/login/find-id/page">아이디 찾기</a>
              <a href="/signup/select">회원가입</a>
            </td>
          </tr>
        </tbody>
      </table>
    </form>
  </main>
</body>