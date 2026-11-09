package com.codegym.controller;

import com.codegym.model.Calculator;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "CalculatorServlet", urlPatterns = "/calculate")
public class CalculatorServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String firstOperandStr = request.getParameter("firstOperand");
        String secondOperandStr = request.getParameter("secondOperand");
        String operatorStr = request.getParameter("operator");

        try {
            if (firstOperandStr == null || secondOperandStr == null || operatorStr == null ||
                    firstOperandStr.trim().isEmpty() || secondOperandStr.trim().isEmpty()) {
                throw new IllegalArgumentException("Vui lòng nhập đầy đủ hai toán hạng.");
            }

            double firstOperand = Double.parseDouble(firstOperandStr.trim());
            double secondOperand = Double.parseDouble(secondOperandStr.trim());
            char operator = operatorStr.charAt(0);

            double result = Calculator.calculate(firstOperand, secondOperand, operator);

            request.setAttribute("firstOperand", firstOperand);
            request.setAttribute("secondOperand", secondOperand);
            request.setAttribute("operator", operator);
            request.setAttribute("result", result);

            request.getRequestDispatcher("/result.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Lỗi: Giá trị nhập vào phải là số hợp lệ.");
            request.setAttribute("firstOperand", firstOperandStr);
            request.setAttribute("secondOperand", secondOperandStr);
            request.setAttribute("operator", operatorStr);
            request.getRequestDispatcher("/result.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Lỗi: " + e.getMessage());
            request.setAttribute("firstOperand", firstOperandStr);
            request.setAttribute("secondOperand", secondOperandStr);
            request.setAttribute("operator", operatorStr);
            request.getRequestDispatcher("/result.jsp").forward(request, response);
        }
    }
}

