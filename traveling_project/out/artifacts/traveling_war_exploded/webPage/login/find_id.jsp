<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<body>
  <main>
    <div class="find_container">
      <div id="email_method" class="find_method_section active">
        <table class="find_table">
          <thead>
          <tr>
            <th>이메일로 아이디 찾기</th>
          </tr>
          </thead>

          <tbody>
          <tr>
            <td>
              <div class="find_method_tabs">
                <button type="button" class="find_tab_btn active" onclick="switchMethod('email')">이메일</button>
                <button type="button" class="find_tab_btn" onclick="switchMethod('sms')">휴대폰 번호</button>
              </div>
            </td>
          </tr>

          <tr>
            <td><input type="text" id="email_name" placeholder="이름을 입력하세요." /></td>
          </tr>
          <tr>
            <td><input type="email" id="email_contact" placeholder="이메일을 입력하세요." /></td>
          </tr>
          <tr id="email_code_input_row" style="display:none;">
            <td>
              <div class="code_input_wrapper">
                <input type="text" id="email_code_input" placeholder="인증코드를 입력하세요." maxlength="6" />
                <button type="button" class="verify_code_btn" onclick="verifyCode('email')">인증</button>
              </div>
            </td>
          </tr>
          <tr>
            <td class="button_group">
              <button type="button" class="find_btn" id="email_send_btn" onclick="sendCode('email')">인증코드 발송</button>
            </td>
          </tr>
          <tr>
            <td class="find_link">
              <div class="find_link_left">
                <a href="/login/select">로그인</a>
                <a href="/login/find-pw">비밀번호 찾기</a>
              </div>
              <div class="find_link_right">
                <a href="/signup/select">회원가입</a>
              </div>
            </td>
          </tr>
          </tbody>
        </table>
      </div>

      <div id="sms_method" class="find_method_section">
        <table class="find_table">
          <thead>
          <tr>
            <th>휴대폰 번호로 아이디 찾기</th>
          </tr>
          </thead>

          <tbody>
          <tr>
            <td>
              <div class="find_method_tabs">
                <button type="button" class="find_tab_btn" onclick="switchMethod('email')">이메일</button>
                <button type="button" class="find_tab_btn active" onclick="switchMethod('sms')">휴대폰 번호</button>
              </div>
            </td>
          </tr>

          <tr>
            <td><input type="text" id="sms_name" placeholder="이름을 입력하세요." /></td>
          </tr>
          <tr>
            <td><input type="tel" id="sms_contact" placeholder="휴대폰 번호를 입력하세요. (하이픈 제외)" /></td>
          </tr>
          <tr id="sms_code_input_row" style="display:none;">
            <td>
              <div class="code_input_wrapper">
                <input type="text" id="sms_code_input" placeholder="인증코드를 입력하세요." maxlength="6" />
                <button type="button" class="verify_code_btn" onclick="verifyCode('sms')">인증</button>
              </div>
            </td>
          </tr>
          <tr>
            <td class="button_group">
              <button type="button" class="find_btn" id="sms_send_btn" onclick="sendCode('sms')">인증코드 발송</button>
            </td>
          </tr>
          <tr>
            <td class="find_link">
              <div class="find_link_left">
                <a href="/login/select">로그인</a>
                <a href="/login/find-pw">비밀번호 찾기</a>
              </div>
              <div class="find_link_right">
                <a href="/signup/select">회원가입</a>
              </div>
            </td>
          </tr>
          </tbody>
        </table>
      </div>

      <div id="result_section" class="result_section" style="display:none;">
        <table class="find_table">
          <thead>
          <tr>
            <th>아이디 찾기 결과</th>
          </tr>
          </thead>
          <tbody>
          <tr>
            <td class="result_message">
              <p>회원님의 아이디는 <span id="result_user_id"></span>입니다.</p>
            </td>
          </tr>
          <tr>
            <td class="button_group">
              <button type="button" class="find_btn" onclick="location.href='/login/select'">로그인</button>
              <button type="button" class="find_btn secondary" onclick="location.href='/login/find-pw'">비밀번호 찾기</button>
            </td>
          </tr>
          </tbody>
        </table>
      </div>

    </div>

    <!-- 메시지 표시 (숨김) -->
    <div id="message_box" class="message_box" style="display: none;">
      <p id="message_text"></p>
    </div>
  </main>
</body>

