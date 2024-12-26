<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header/header.jsp"%>
<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" href="<c:url value="/css/signup/signup.css"/>" />
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="<c:url value="/js/signup/signup.js"/>"></script>
    <c:choose>
    	<c:when test="${param.requestType eq 'user'}">
    		<title>회원가입</title>
    	</c:when>
    	<c:when test="${param.requestType eq 'host'}">
    		<title>호스트 회원가입</title>
    	</c:when>
    </c:choose>
  </head>
  <body>
    <main>
	  <c:choose>
	      <c:when test="${param.requestType eq 'user'}">
	          <c:set var="actionUrl" value="/webPage/signup/SignupServlet?requestType=insertUserInfo" />
	      </c:when>
	      <c:when test="${param.requestType eq 'host'}">
	          <c:set var="actionUrl" value="/webPage/signup/SignupServlet?requestType=insertHostInfo" />
	      </c:when>
	  </c:choose>
	  <input type="hidden" id="requestType" name="requestType" value="${param.requestType}">
      <section id="sign_up_section">
        <div id="img">
          <img src="<c:url value="/images/logo.png"/>" alt="logo" />
        </div>
        <ul id="step">
          <li>01.회원 선택</li>
          <li>02.약관 동의</li>
          <li>03.회원 정보 입력</li>
          <li>04.가입 완료</li>
        </ul>
        <form name="sign_up" action="${actionUrl}" method="post">
          <!-- 회원가입 테이블 -->
          <table id="sign_up_table">
            <tbody>
              <!-- 아이디 -->
              <tr>
                <th>
                  <b>아이디</b>
                </th>
                <td>
                  <input type="text" name="id" id="id" class="user_info" placeholder="아이디" />
                </td>
              </tr>
              <!-- 비밀번호 -->
              <tr>
                <th><b>비밀번호</b></th>
                <td>
                  <input type="password" name="pw" id="pw" class="user_info" placeholder="비밀번호" />
                </td>
              </tr>
              <!-- 비밀번호 확인 -->
              <tr>
                <th><b>비밀번호 확인</b></th>
                <td>
                  <input type="password" name="pw_check" id="pw_check" class="user_info" placeholder="비밀번호 확인" />
                </td>
              </tr>
              <!-- 이름 -->
              <tr>
                <th><b>이름</b></th>
                <td>
                  <input type="text" name="name" id="name" class="user_info" placeholder="이름" />
                </td>
              </tr>
              <!-- 통신사 -->
              <tr>
                <th><b>통신사</b></th>
                <td id="agency_td">
                  <div class="clearfix" style="width:auto">
                    <input type="radio" name="news_agency" id="skt" value="SKT" />
                    <label for="skt" class="label1">SKT</label>
                    <input type="radio" name="news_agency" id="kt" value="KT" />
                    <label for="kt" class="label2">KT</label>
                    <input type="radio" name="news_agency" id="lg" value="LG" />
                    <label for="lg">LG</label>
                    <input type="radio" name="news_agency" id="aldeul_skt" value="aldeulSKT" />
                    <label for="aldeul_skt">알뜰폰SKT</label>
                    <input type="radio" name="news_agency" id="aldeul_kt" value="aldeulKT" />
                    <label for="aldeul_kt">알뜰폰KT</label>
                    <input type="radio" name="news_agency" id="aldeul_lg" value="aldeulLG" />
                    <label for="aldeul_lg">알뜰폰LG</label>                    
                  </div>
                </td>
              </tr>              
              <!-- 전화번호 -->
              <tr>
                <th><b>전화번호</b></th>
                <td>
                  <input type="text" name="phone" id="phone" class="user_info" placeholder='" - " 없이 숫자만 입력' maxlength="11" />
                </td>
              </tr>
              <!-- 이메일 -->
              <tr>
                <th><b>이메일</b></th>
                <td>
                  <input type="text" name="email" id="email" class="user_info" placeholder="이메일" /> &nbsp; <span>@</span> &nbsp;
                  <select id="email_address" name="email_address" class="user_info">
                  	<option value="0">선택하세요</option>
                    <option value="naver.com">naver.com</option>
                    <option value="daum.net">daum.net</option>
                    <option value="gmail.com">gmail.com</option>
                    <option value="nate.com">nate.com</option>
                  </select>
                </td>
              </tr>
              <!-- 사업자 등록번호 -->
              <c:choose>
              	<c:when test="${param.requestType eq 'host'}">
					<tr>
	                	<th><b>사업자 등록번호</b></th>
	                	<td>
	                  		<input type="text" id="business_num1" name="business_num1" class="business_num"> -
	                  		<input type="text" id="business_num2" name="business_num2" class="business_num"> -
	                  		<input type="text" id="business_num3" name="business_num3" class="business_num">
	                	</td>
	              	</tr>
              	</c:when>
              </c:choose>
              <!-- 생년월일 -->
              <tr>
                <th><b>생년월일</b></th>
                <td id="birth">
                  <select name="birth_year" id="birth_year" class="user_info">
                    <option value="" disabled selected>년</option>
                    <option value="2023">2023</option>
                    <option value="2022">2022</option>
                    <option value="2021">2021</option>
                    <option value="2020">2020</option>
                    <option value="2019">2019</option>
                    <option value="2018">2018</option>
                    <option value="2017">2017</option>
                    <option value="2016">2016</option>
                    <option value="2015">2015</option>
                    <option value="2014">2014</option>
                    <option value="2013">2013</option>
                    <option value="2012">2012</option>
                    <option value="2011">2011</option>
                    <option value="2010">2010</option>
                    <option value="2009">2009</option>
                    <option value="2008">2008</option>
                    <option value="2007">2007</option>
                    <option value="2006">2006</option>
                    <option value="2005">2005</option>
                    <option value="2004">2004</option>
                    <option value="2003">2003</option>
                    <option value="2002">2002</option>
                    <option value="2001">2001</option>
                    <option value="2000">2000</option>
                    <option value="1999">1999</option>
                    <option value="1998">1998</option>
                    <option value="1997">1997</option>
                    <option value="1996">1996</option>
                    <option value="1995">1995</option>
                    <option value="1994">1994</option>
                    <option value="1993">1993</option>
                    <option value="1992">1992</option>
                    <option value="1991">1991</option>
                    <option value="1990">1990</option>
                    <option value="1989">1989</option>
                    <option value="1988">1988</option>
                    <option value="1987">1987</option>
                    <option value="1986">1986</option>
                    <option value="1985">1985</option>
                    <option value="1984">1984</option>
                    <option value="1983">1983</option>
                    <option value="1982">1982</option>
                    <option value="1981">1981</option>
                    <option value="1980">1980</option>
                    <option value="1979">1979</option>
                    <option value="1978">1978</option>
                    <option value="1977">1977</option>
                    <option value="1976">1976</option>
                    <option value="1975">1975</option>
                    <option value="1974">1974</option>
                    <option value="1973">1973</option>
                    <option value="1972">1972</option>
                    <option value="1971">1971</option>
                    <option value="1970">1970</option>
                    <option value="1969">1969</option>
                    <option value="1968">1968</option>
                    <option value="1967">1967</option>
                    <option value="1966">1966</option>
                    <option value="1965">1965</option>
                    <option value="1964">1964</option>
                    <option value="1963">1963</option>
                    <option value="1962">1962</option>
                    <option value="1961">1961</option>
                    <option value="1960">1960</option>
                    <option value="1959">1959</option>
                    <option value="1958">1958</option>
                    <option value="1957">1957</option>
                    <option value="1956">1956</option>
                    <option value="1955">1955</option>
                    <option value="1954">1954</option>
                    <option value="1953">1953</option>
                    <option value="1952">1952</option>
                    <option value="1951">1951</option>
                    <option value="1950">1950</option>
                    <option value="1949">1949</option>
                    <option value="1948">1948</option>
                    <option value="1947">1947</option>
                    <option value="1946">1946</option>
                    <option value="1945">1945</option>
                    <option value="1944">1944</option>
                    <option value="1943">1943</option>
                    <option value="1942">1942</option>
                    <option value="1941">1941</option>
                    <option value="1940">1940</option>
                    <option value="1939">1939</option>
                    <option value="1938">1938</option>
                    <option value="1937">1937</option>
                    <option value="1936">1936</option>
                    <option value="1935">1935</option>
                    <option value="1934">1934</option>
                    <option value="1933">1933</option>
                    <option value="1932">1932</option>
                    <option value="1931">1931</option>
                    <option value="1930">1930</option>
                    <option value="1929">1929</option>
                    <option value="1928">1928</option>
                    <option value="1927">1927</option>
                    <option value="1926">1926</option>
                    <option value="1925">1925</option>
                    <option value="1924">1924</option>
                    <option value="1923">1923</option>
                    <option value="1922">1922</option>
                    <option value="1921">1921</option>
                    <option value="1920">1920</option>
                    <option value="1919">1919</option>
                    <option value="1918">1918</option>
                    <option value="1917">1917</option>
                    <option value="1916">1916</option>
                    <option value="1915">1915</option>
                    <option value="1914">1914</option>
                    <option value="1913">1913</option>
                    <option value="1912">1912</option>
                    <option value="1911">1911</option>
                    <option value="1910">1910</option>
                    <option value="1909">1909</option>
                    <option value="1908">1908</option>
                    <option value="1907">1907</option>
                    <option value="1906">1906</option>
                    <option value="1905">1905</option>
                    <option value="1904">1904</option>
                    <option value="1903">1903</option>
                    <option value="1902">1902</option>
                    <option value="1901">1901</option>
                    <option value="1900">1900</option>
                  </select>
                  <select name="birth_month" id="birth_month" class="user_info">
                    <option value="" disabled selected>월</option>
                    <option value="01">01</option>
                    <option value="02">02</option>
                    <option value="03">03</option>
                    <option value="04">04</option>
                    <option value="05">05</option>
                    <option value="06">06</option>
                    <option value="07">07</option>
                    <option value="08">08</option>
                    <option value="09">09</option>
                    <option value="10">10</option>
                    <option value="11">11</option>
                    <option value="12">12</option>
                  </select>
                  <select name="birth_day" id="birth_day" class="user_info">
                    <option value="" disabled selected>일</option>
                    <option value="01">01</option>
                    <option value="02">02</option>
                    <option value="03">03</option>
                    <option value="04">04</option>
                    <option value="05">05</option>
                    <option value="06">06</option>
                    <option value="07">07</option>
                    <option value="08">08</option>
                    <option value="09">09</option>
                    <option value="10">10</option>
                    <option value="11">11</option>
                    <option value="12">12</option>
                    <option value="13">13</option>
                    <option value="14">14</option>
                    <option value="15">15</option>
                    <option value="16">16</option>
                    <option value="17">17</option>
                    <option value="18">18</option>
                    <option value="19">19</option>
                    <option value="20">20</option>
                    <option value="21">21</option>
                    <option value="22">22</option>
                    <option value="23">23</option>
                    <option value="24">24</option>
                    <option value="25">25</option>
                    <option value="26">26</option>
                    <option value="27">27</option>
                    <option value="28">28</option>
                    <option value="29">29</option>
                    <option value="30">30</option>
                    <option value="31">31</option>
                  </select>
                </td>
              </tr>

              <!-- 성별 -->
              <tr>
                <th><b>성별</b></th>
                <td id="gender_td">
                  <input type="radio" name="gender" id="male" value="남자" checked/>
                  <label for="male">남자</label>
                  <input type="radio" name="gender" id="female" value="여자" />
                  <label for="female">여자</label>
                </td>
              </tr>

              <!-- 주소 -->
              <tr>
                <th rowspan="4"><b>주소</b></th>
                <td class="addr_td">
                  <input type="text" name="post_code" id="sample4_postcode" placeholder="우편번호" readonly="readonly" />
                  <input type="button" id="post_search_btn" onclick="sample4_execDaumPostcode()" value="주소 검색" />
                  <span id="guide" style="color: #999; display: none"></span>
                </td>
              </tr>
              <tr>
                <td class="addr_td">
                  <input type="text" name="road_addr" id="sample4_roadAddress" placeholder="도로명주소" readonly="readonly" />
                  <input type="text" name="jibun_addr" id="sample4_jibunAddress" placeholder="지번주소" readonly="readonly" />
                </td>
              </tr>
              <tr>
                <td class="addr_td last_addr_td">
                  <input type="text" id="sample4_detailAddress" name="detail_addr" placeholder="상세주소" />
                  <input type="text" id="sample4_extraAddress" name="reference_addr" placeholder="참고항목"/>
                </td>
              </tr>
            </tbody>
          </table>
          <!-- 회원 가입 버튼 -->
          <div id="btn">
            <input type="submit" id="sign_up_btn" name="sign_up" value="회원가입" />
            <input type="button" id="sign_up_cancel" name="sign_up_cancel" value="취소" onclick="location.href='agree.jsp'" />
          </div>
        </form>
      </section>
    </main>
    <%@ include file='../footer/footer.jsp'%>
  </body>
</html>
