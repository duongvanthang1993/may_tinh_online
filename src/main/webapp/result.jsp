<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Kết quả tính toán</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
            margin: 40px;
        }
        .container {
            max-width: 450px;
            margin: 0 auto;
            background: #ffffff;
            padding: 24px 30px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            color: #333333;
            margin-bottom: 20px;
        }
        .result-box {
            background-color: #e8f5e9;
            color: #2e7d32;
            padding: 15px;
            border-radius: 5px;
            font-size: 18px;
            margin-bottom: 20px;
            border-left: 5px solid #4caf50;
        }
        .error-box {
            background-color: #ffebee;
            color: #c62828;
            padding: 15px;
            border-radius: 5px;
            font-size: 16px;
            margin-bottom: 20px;
            border-left: 5px solid #f44336;
        }
        .back-link {
            display: block;
            text-align: center;
            padding: 10px;
            background-color: #6c757d;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            font-weight: bold;
        }
        .back-link:hover {
            background-color: #5a6268;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Kết quả tính toán</h2>

    <%
        String errorMessage = (String) request.getAttribute("errorMessage");
        if (errorMessage != null && !errorMessage.isEmpty()) {
    %>
        <div class="error-box">
            <strong>Đã xảy ra lỗi:</strong><br/>
            <%= errorMessage %>
        </div>
    <%
        } else {
            Object firstOp = request.getAttribute("firstOperand");
            Object secondOp = request.getAttribute("secondOperand");
            Object op = request.getAttribute("operator");
            Object res = request.getAttribute("result");
    %>
        <div class="result-box">
            <strong>Biểu thức:</strong>
            <%= firstOp %> <%= op %> <%= secondOp %> = <strong><%= res %></strong>
        </div>
    <%
        }
    %>

    <a href="index.jsp" class="back-link">&larr; Quay lại trang tính</a>
</div>

</body>
</html>
