package com.traveling.common;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public abstract class BaseController extends HttpServlet{
	
    /**
     * 공통 요청 로그 출력
     */
    protected void printRequestLog(HttpServletRequest req, String controllerName, String action) {
        System.out.println(
                "[" + controllerName + "] "
                + req.getMethod()
                + " "
                + req.getRequestURI()
                + " action=" + action
                + " ip=" + req.getRemoteAddr()
            );
    }
    
    /**
     * 실패 로그 출력
     */
    protected void printFailLog(Exception e) {
        System.out.println("[" + this.getClass().getSimpleName() + "] Request Fail");
        e.printStackTrace();
    }
    
    /**
     * action 추출
     * 예:
     * /webPage/stay/detail → detail
     * /webPage/login/logout → logout
     */
    protected String getAction(HttpServletRequest req, String basePath) {
        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();
        String path = uri.substring(contextPath.length());
        return path.substring(basePath.length());
    }
    
    /**
     * 에러 페이지 이동
     */
    protected void forwardError(HttpServletRequest req, HttpServletResponse res, String message) throws ServletException, IOException {
        req.setAttribute("errorMessage", message);
        // Forward directly using RequestDispatcher (do not use LayoutForward for error pages)
        req.getRequestDispatcher("/webPage/error/error.jsp").forward(req, res);
    }
    
    /**
     * Controller Exception 처리
     */
    protected void handleControllerException(HttpServletRequest req,HttpServletResponse res,Exception e,String controllerName,String action) throws ServletException, IOException {
        printFailLog(e);
        System.out.println("[" + controllerName + " ERROR]");
        System.out.println("action = " + action);
        System.out.println("uri = " + req.getRequestURI());
        ViewUtil.forwardError(req,res,"처리 중 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
    }
}
