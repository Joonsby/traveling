package com.traveling.common;

import java.util.Arrays;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;

public class LayoutForward {

    private static final String USER_LAYOUT = "/webPage/layout/user_layout.jsp";
    private static final String HOST_LAYOUT = "/webPage/layout/host_layout.jsp";

    private LayoutForward() {
        // 유틸 클래스라 객체 생성 방지
    }

    public static void user(
            HttpServletRequest request,
            HttpServletResponse response,
            String pageTitle,
            String contentPage,
            String[] cssList,
            String[] jsList
    ) throws ServletException, IOException {

        forward(
            request,
            response,
            USER_LAYOUT,
            pageTitle,
            contentPage,
            cssList,
            jsList
        );
    }

    public static void host(
            HttpServletRequest request,
            HttpServletResponse response,
            String pageTitle,
            String contentPage,
            String[] cssList,
            String[] jsList
    ) throws ServletException, IOException {

        forward(
            request,
            response,
            HOST_LAYOUT,
            pageTitle,
            contentPage,
            cssList,
            jsList
        );
    }

    private static void forward(
            HttpServletRequest request,
            HttpServletResponse response,
            String layoutPage,
            String pageTitle,
            String contentPage,
            String[] cssList,
            String[] jsList
    ) throws ServletException, IOException {

        request.setAttribute("pageTitle", pageTitle);
        request.setAttribute("contentPage", contentPage);

        if (cssList != null) {
            List<String> pageCssList = Arrays.asList(cssList);
            request.setAttribute("pageCssList", pageCssList);
        }

        if (jsList != null) {
            List<String> pageJsList = Arrays.asList(jsList);
            request.setAttribute("pageJsList", pageJsList);
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher(layoutPage);
        dispatcher.forward(request, response);
    }
}