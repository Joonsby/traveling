<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <ul id="step">
   <li>01.회원 선택</li>
   <li>02.약관 동의</li>
   <li>03.회원 정보 입력</li>
   <li>04.가입 완료</li>
 </ul>
 <div id="content1">
   <h2><span>Traveling</span> 에 오신 것을 환영합니다!</h2>
   <p>
     회원님께서 해당되는 회원 종류를 선택해주세요.<br />
     선택하신 회원 종류에 따라 가입 절차에 차이가 있으니,<br />
     반드시 회원님께 해당하는 경우를 선택해 주시기 바랍니다.
   </p>
 </div>
 <ul id="join">
   <li>
     <h3>개인 회원</h3>
     <p>individual</p>
     <a href="/signup/agree?requestType=user"><input type="button" value="가입하기" /></a>
   </li>
   <li>
     <h3>호스트</h3>
     <p>host</p>
     <a href="/signup/agree?requestType=host"><input type="button" value="가입하기" /></a>
   </li>
 </ul>
