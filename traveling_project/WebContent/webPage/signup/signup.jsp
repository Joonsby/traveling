<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="requestType" value="${param.requestType}" />
<c:choose>
    <c:when test="${requestType eq 'host'}">
        <c:set var="actionUrl" value="/signup/host-create" />
    </c:when>
    <c:otherwise>
        <c:set var="actionUrl" value="/signup/user-create" />
    </c:otherwise>
</c:choose>

<section id="sign_up_section">
    <div id="img">
        <img src="<c:url value='/images/logo.png'/>" alt="logo" />
    </div>

    <ul id="step">
        <li>01.회원 선택</li>
        <li>02.약관 동의</li>
        <li>03.회원 정보 입력</li>
        <li>04.가입 완료</li>
    </ul>

    <form name="sign_up" action="${actionUrl}" method="post">
        <input type="hidden" id="requestType" name="requestType" value="${requestType}" />

        <table id="sign_up_table">
            <tbody>
                <tr>
                    <th><b>아이디</b></th>
                    <td><input type="text" name="id" id="id" class="user_info" placeholder="아이디" /></td>
                </tr>

                <tr>
                    <th><b>비밀번호</b></th>
                    <td><input type="password" name="pw" id="pw" class="user_info" placeholder="비밀번호" /></td>
                </tr>

                <tr>
                    <th><b>비밀번호 확인</b></th>
                    <td><input type="password" name="pw_check" id="pw_check" class="user_info" placeholder="비밀번호 확인" /></td>
                </tr>

                <tr>
                    <th><b>이름</b></th>
                    <td><input type="text" name="name" id="name" class="user_info" placeholder="이름" /></td>
                </tr>

				<tr>
				    <th><b>통신사</b></th>
				    <td id="agency_td">
				        <select name="news_agency" id="news_agency" class="user_info">
				            <option value="">통신사를 선택하세요</option>
				            <option value="SKT">SKT</option>
				            <option value="KT">KT</option>
				            <option value="LG">LG</option>
				            <option value="aldeulSKT">알뜰폰 SKT</option>
				            <option value="aldeulKT">알뜰폰 KT</option>
				            <option value="aldeulLG">알뜰폰 LG</option>
				        </select>
				    </td>
				</tr>

                <tr>
                    <th><b>전화번호</b></th>
                    <td>
                        <input type="text" name="phone" id="phone" class="user_info" placeholder='" - " 없이 숫자만 입력' maxlength="11" />
                    </td>
                </tr>

				<tr>
				    <th><b>이메일</b></th>
				    <td>
				        <input type="text" name="email" id="email" class="user_info" placeholder="example@gmail.com" />
				    </td>
				</tr>

                <c:if test="${requestType eq 'host'}">
                    <tr>
                        <th><b>사업자 등록번호</b></th>
                        <td>
                            <input type="text" id="business_num1" name="business_num1" class="business_num" /> -
                            <input type="text" id="business_num2" name="business_num2" class="business_num" /> -
                            <input type="text" id="business_num3" name="business_num3" class="business_num" />
                        </td>
                    </tr>
                </c:if>

				<tr>
				    <th><b>생년월일</b></th>
				    <td id="birth">
				        <input type="text" id="birth_raw" class="user_info" placeholder="예: 980922" maxlength="6" inputmode="numeric" />
				        <input type="hidden" name="birth" id="birth" />
				    </td>
				</tr>

                <tr>
                    <th><b>성별</b></th>
                    <td id="gender_td">
                        <input type="radio" name="gender" id="male" value="남자" checked />
                        <label for="male">남자</label>
                        <input type="radio" name="gender" id="female" value="여자" />
                        <label for="female">여자</label>
                    </td>
                </tr>

                <tr>
                    <th rowspan="3"><b>주소</b></th>
                    <td class="addr_td">
                        <input type="text" name="post_code" id="sample4_postcode" placeholder="우편번호" readonly />
                        <input type="button" id="post_search_btn" value="주소 검색" />
                        <span id="guide" class="hidden-guide"></span>
                    </td>
                </tr>

                <tr>
                    <td class="addr_td">
                        <input type="text" name="road_addr" id="sample4_roadAddress" placeholder="도로명주소" readonly />
                        <input type="text" name="jibun_addr" id="sample4_jibunAddress" placeholder="지번주소" readonly />
                    </td>
                </tr>

                <tr>
                    <td class="addr_td last_addr_td">
                        <input type="text" id="sample4_detailAddress" name="detail_addr" placeholder="상세주소" />
                        <input type="text" id="sample4_extraAddress" name="reference_addr" placeholder="참고항목" />
                    </td>
                </tr>
            </tbody>
        </table>

        <div id="btn">
            <input type="submit" id="sign_up_btn" name="sign_up" value="회원가입" />
            <input type="button" id="sign_up_cancel" name="sign_up_cancel" value="취소" />
        </div>
    </form>
</section>