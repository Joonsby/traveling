package com.traveling.common;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ViewUtil {

    public static void forwardError(HttpServletRequest req, HttpServletResponse res, String message) throws ServletException, IOException {
        req.setAttribute("errorMessage", message);
        // Forward directly to error page (do not use LayoutForward)
        req.getRequestDispatcher("/webPage/error/error.jsp").forward(req, res);
    }
}