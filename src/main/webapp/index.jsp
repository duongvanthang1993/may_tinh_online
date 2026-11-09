<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Simple Calculator</title>
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
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 6px;
            font-weight: bold;
            color: #555555;
        }
        input[type="number"], select {
            width: 100%;
            padding: 10px;
            border: 1px solid #cccccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 15px;
        }
        button {
            width: 100%;
            padding: 12px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 10px;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Simple Calculator</h2>
    <form action="calculate" method="post">
        <div class="form-group">
            <label for="firstOperand">First operand (Toán hạng 1):</label>
            <input type="number" step="any" id="firstOperand" name="firstOperand" required placeholder="Nhập số thứ nhất...">
        </div>

        <div class="form-group">
            <label for="operator">Operator (Phép tính):</label>
            <select id="operator" name="operator">
                <option value="+">Cộng (+)</option>
                <option value="-">Trừ (-)</option>
                <option value="*">Nhân (*)</option>
                <option value="/">Chia (/)</option>
            </select>
        </div>

        <div class="form-group">
            <label for="secondOperand">Second operand (Toán hạng 2):</label>
            <input type="number" step="any" id="secondOperand" name="secondOperand" required placeholder="Nhập số thứ hai...">
        </div>

        <button type="submit">Calculate (Tính toán)</button>
    </form>
</div>

</body>
</html>

