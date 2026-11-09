package com.codegym.model;

public class Calculator {

    public static double calculate(double firstOperand, double secondOperand, char operator) {
        switch (operator) {
            case '+':
                return firstOperand + secondOperand;
            case '-':
                return firstOperand - secondOperand;
            case '*':
                return firstOperand * secondOperand;
            case '/':
                if (secondOperand == 0) {
                    throw new ArithmeticException("Không thể chia cho 0 (Divide by zero)");
                }
                return firstOperand / secondOperand;
            default:
                throw new IllegalArgumentException("Phép toán không hợp lệ: " + operator);
        }
    }
}

