<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<body>
<main>
  <div class="find_container">

    <!-- STEP 1 : 이메일 방식 -->
    <div id="pw_email_method" class="find_method_section active">
      <table class="find_table">
        <thead>
        <tr>
          <th>비밀번호 찾기</th>
        </tr>
        </thead>

        <tbody>

        <!-- 탭 -->
        <tr>
          <td>
            <div class="find_method_tabs">
              <button type="button"
                      class="find_tab_btn active"
                      onclick="switchPwMethod('email')">
                이메일
              </button>

              <button type="button"
                      class="find_tab_btn"
                      onclick="switchPwMethod('sms')">
                휴대폰 번호
              </button>
            </div>
          </td>
        </tr>

        <!-- 아이디 -->
        <tr>
          <td>
            <input type="text"
                   id="pw_email_id"
                   placeholder="아이디를 입력하세요." />
          </td>
        </tr>

        <!-- 이름 -->
        <tr>
          <td>
            <input type="text"
                   id="pw_email_name"
                   placeholder="이름을 입력하세요." />
          </td>
        </tr>

        <!-- 이메일 -->
        <tr>
          <td>
            <input type="email"
                   id="pw_email_contact"
                   placeholder="이메일을 입력하세요." />
          </td>
        </tr>

        <!-- 인증코드 -->
        <tr id="pw_email_code_input_row" style="display:none;">
          <td>
            <div class="code_input_wrapper">
              <input type="text"
                     id="pw_email_code_input"
                     placeholder="인증코드를 입력하세요."
                     maxlength="6" />

              <button type="button"
                      class="verify_code_btn"
                      onclick="verifyPwCode('email')">
                인증
              </button>
            </div>
          </td>
        </tr>

        <!-- 인증코드 발송 -->
        <tr>
          <td class="button_group">
            <button type="button"
                    class="find_btn"
                    id="pw_email_send_btn"
                    onclick="sendPwCode('email')">
              인증코드 발송
            </button>
          </td>
        </tr>

        <!-- 하단 링크 -->
        <tr>
          <td class="find_link">
            <div class="find_link_left">
              <a href="/login/select">로그인</a>
              <a href="/login/find-id">아이디 찾기</a>
            </div>

            <div class="find_link_right">
              <a href="/signup/select">회원가입</a>
            </div>
          </td>
        </tr>

        </tbody>
      </table>
    </div>

    <!-- STEP 1 : SMS 방식 -->
    <div id="pw_sms_method" class="find_method_section">
      <table class="find_table">
        <thead>
        <tr>
          <th>비밀번호 찾기</th>
        </tr>
        </thead>

        <tbody>

        <!-- 탭 -->
        <tr>
          <td>
            <div class="find_method_tabs">
              <button type="button"
                      class="find_tab_btn"
                      onclick="switchPwMethod('email')">
                이메일
              </button>

              <button type="button"
                      class="find_tab_btn active"
                      onclick="switchPwMethod('sms')">
                휴대폰 번호
              </button>
            </div>
          </td>
        </tr>

        <!-- 아이디 -->
        <tr>
          <td>
            <input type="text"
                   id="pw_sms_id"
                   placeholder="아이디를 입력하세요." />
          </td>
        </tr>

        <!-- 이름 -->
        <tr>
          <td>
            <input type="text"
                   id="pw_sms_name"
                   placeholder="이름을 입력하세요." />
          </td>
        </tr>

        <!-- 휴대폰 -->
        <tr>
          <td>
            <input type="tel"
                   id="pw_sms_contact"
                   placeholder="휴대폰 번호를 입력하세요. (하이픈 제외)" />
          </td>
        </tr>

        <!-- 인증코드 -->
        <tr id="pw_sms_code_input_row" style="display:none;">
          <td>
            <div class="code_input_wrapper">
              <input type="text"
                     id="pw_sms_code_input"
                     placeholder="인증코드를 입력하세요."
                     maxlength="6" />

              <button type="button"
                      class="verify_code_btn"
                      onclick="verifyPwCode('sms')">
                인증
              </button>
            </div>
          </td>
        </tr>

        <!-- 인증코드 발송 -->
        <tr>
          <td class="button_group">
            <button type="button"
                    class="find_btn"
                    id="pw_sms_send_btn"
                    onclick="sendPwCode('sms')">
              인증코드 발송
            </button>
          </td>
        </tr>

        <!-- 하단 링크 -->
        <tr>
          <td class="find_link">
            <div class="find_link_left">
              <a href="/login/select">로그인</a>
              <a href="/login/find-id">아이디 찾기</a>
            </div>

            <div class="find_link_right">
              <a href="/signup/select">회원가입</a>
            </div>
          </td>
        </tr>

        </tbody>
      </table>
    </div>

    <!-- STEP 2 : 비밀번호 변경 -->
    <div id="step2_section"
         class="find_step_section"
         style="display:none;">

      <table class="find_table">
        <thead>
        <tr>
          <th>새 비밀번호 설정</th>
        </tr>
        </thead>

        <tbody>

        <tr>
          <td>
            <input type="password"
                   id="new_password"
                   placeholder="새 비밀번호를 입력하세요." />
          </td>
        </tr>

        <tr>
          <td>
            <input type="password"
                   id="confirm_password"
                   placeholder="비밀번호를 다시 입력하세요." />
          </td>
        </tr>

        <tr>
          <td class="pw_strength_indicator">
            <div id="pw_strength_bar" class="strength_bar"></div>
            <span id="pw_strength_text">강도: 약</span>
          </td>
        </tr>

        <tr>
          <td class="button_group">
            <button type="button"
                    class="find_btn"
                    onclick="resetPassword()">
              비밀번호 변경
            </button>
          </td>
        </tr>

        <!-- 하단 링크 -->
        <tr>
          <td class="find_link">
            <div class="find_link_left">
              <a href="/login/select">로그인</a>
              <a href="/login/find-id">아이디 찾기</a>
            </div>

            <div class="find_link_right">
              <a href="/signup/select">회원가입</a>
            </div>
          </td>
        </tr>

        </tbody>
      </table>
    </div>

    <!-- STEP 3 : 완료 -->
    <div id="step3_section"
         class="find_step_section"
         style="display:none;">

      <table class="find_table">
        <thead>
        <tr>
          <th>비밀번호 변경 완료</th>
        </tr>
        </thead>

        <tbody>

        <tr>
          <td class="result_message">
            <p>비밀번호가 성공적으로 변경되었습니다.</p>
            <p>새로운 비밀번호로 로그인해주세요.</p>
          </td>
        </tr>

        <tr>
          <td class="button_group">
            <button type="button"
                    class="find_btn"
                    onclick="location.href='/login/select'">
              로그인
            </button>
          </td>
        </tr>

        </tbody>
      </table>
    </div>

  </div>

  <!-- 메시지 -->
  <div id="pw_message_box"
       class="message_box"
       style="display:none;">
    <p id="pw_message_text"></p>
  </div>

</main>
</body>