# HƯỚNG DẪN CHI TIẾT CÁCH HOẠT ĐỘNG CỦA DỰ ÁN CALCULATOR APP

Dự án **Calculator App** được xây dựng theo mô hình kiến trúc chuẩn **MVC (Model - View - Controller)** trong môi trường Java Web (Jakarta Servlet 5.0 + JSP trên Apache Tomcat 10+).

---

## 1. TỔNG QUAN KIẾN TRÚC VÀ CÁC THÀNH PHẦN

```
                (1) HTTP GET: Truy cập trang chủ
   Browser -----------------------------------------> index.jsp (View)
     |
     |          (2) HTTP POST: Gửi form /calculate
     +---------------------------------------------> CalculatorServlet (Controller)
                                                            |
                                                            | (3) Gọi tính toán calculate()
                                                            v
                                                     Calculator (Model)
                                                            |
                                                            | (4) Trả kết quả / ném Ngoại lệ
                                                            v
                (5) Forward kèm kết quả/lỗi
   Browser <---------------------------------------- result.jsp (View)
```

| Thành phần | Đường dẫn file | Vai trò trong mô hình MVC |
| :--- | :--- | :--- |
| **Model** | `src/main/java/com/codegym/model/Calculator.java` | Chứa logic tính toán và quy tắc nghiệp vụ (Business Logic). |
| **Controller** | `src/main/java/com/codegym/controller/CalculatorServlet.java` | Tiếp nhận request từ người dùng, kiểm tra dữ liệu, điều phối xử lý và chọn view phản hồi. |
| **View (Input)** | `src/main/webapp/index.jsp` | Hiển thị form nhập liệu cho người dùng. |
| **View (Output)**| `src/main/webapp/result.jsp` | Hiển thị kết quả tính toán hoặc thông báo lỗi nếu có ngoại lệ. |
| **Configuration**| `pom.xml`, `web.xml` | Khai báo thư viện và cấu hình ứng dụng cho Tomcat. |

---

## 2. QUY TRÌNH HOẠT ĐỘNG TỪNG BƯỚC (STEP-BY-STEP)

### Bước 1: Người dùng truy cập ứng dụng
- **Hành động:** Người dùng gõ địa chỉ `http://localhost:8080/calculator-app/` trên trình duyệt.
- **Xử lý:**
  - Máy chủ Tomcat đọc file cấu hình `web.xml`.
  - Nhờ thẻ `<welcome-file-list><welcome-file>index.jsp</welcome-file></welcome-file-list>`, Tomcat tự động phục vụ file `index.jsp` về trình duyệt.
- **Hiển thị:** Màn hình xuất hiện form gồm 2 ô nhập số (`firstOperand`, `secondOperand`) và 1 ô chọn phép tính (`+`, `-`, `*`, `/`).

---

### Bước 2: Người dùng nhập dữ liệu và bấm "Calculate"
- **Hành động:** 
  - Người dùng nhập số thứ nhất (ví dụ: `10`), chọn phép chia `/`, nhập số thứ hai (ví dụ: `2` hoặc `0`).
  - Bấm nút **Calculate (Tính toán)**.
- **Xử lý:** 
  - Form HTML trong `index.jsp` có thuộc tính:
    ```html
    <form action="calculate" method="post">
    ```
  - Trình duyệt sẽ đóng gói các tham số thành một **HTTP POST Request** gửi tới URL `/calculate`.

---

### Bước 3: Controller (CalculatorServlet) tiếp nhận và xử lý dữ liệu
- **Ánh xạ Route:** Servlet được chú thích bằng `@WebServlet(name = "CalculatorServlet", urlPatterns = "/calculate")`, nên mọi yêu cầu gửi đến `/calculate` đều được chuyển vào hàm `doPost(...)`.
- **Đọc tham số:**
  ```java
  String firstOperandStr = request.getParameter("firstOperand");
  String secondOperandStr = request.getParameter("secondOperand");
  String operatorStr = request.getParameter("operator");
  ```
- **Chuyển đổi kiểu dữ liệu:**
  - Chuyển `firstOperandStr` và `secondOperandStr` từ `String` sang kiểu số thực `double`.
  - Lấy ký tự phép tính `operator = operatorStr.charAt(0)`.
  - Khối `try-catch` sẵn sàng bắt lỗi nếu người dùng cố ý nhập chữ cái hoặc dữ liệu không hợp lệ (`NumberFormatException`).

---

### Bước 4: Gọi Model (Calculator.java) thực hiện tính toán
- Servlet gọi phương thức tính toán:
  ```java
  double result = Calculator.calculate(firstOperand, secondOperand, operator);
  ```
- Trong `Calculator.java`, cấu trúc `switch-case` thực hiện:
  - Nếu là `+`: `firstOperand + secondOperand`
  - Nếu là `-`: `firstOperand - secondOperand`
  - Nếu là `*`: `firstOperand * secondOperand`
  - Nếu là `/`:
    - **Kiểm tra ngoại lệ chia cho 0:**
      ```java
      if (secondOperand == 0) {
          throw new ArithmeticException("Không thể chia cho 0 (Divide by zero)");
      }
      ```
    - Nếu `secondOperand != 0`, thực hiện chia bình thường.

---

### Bước 5: Đóng gói dữ liệu và chuyển tiếp (Forward) sang View
Trong `CalculatorServlet`, luồng được phân chia theo 2 kịch bản:

#### Trường hợp A: Tính toán thành công (Ví dụ 10 / 2 = 5)
- Servlet lưu dữ liệu vào đối tượng `request`:
  ```java
  request.setAttribute("firstOperand", firstOperand);
  request.setAttribute("secondOperand", secondOperand);
  request.setAttribute("operator", operator);
  request.setAttribute("result", result);
  ```
- Chuyển tiếp sang `result.jsp`:
  ```java
  request.getRequestDispatcher("/result.jsp").forward(request, response);
  ```

#### Trường hợp B: Xảy ra lỗi (Chia cho 0 hoặc nhập sai)
- Khối `catch (Exception e)` bắt ngoại lệ từ `Calculator` ném ra.
- Servlet lưu thông báo lỗi vào `request`:
  ```java
  request.setAttribute("errorMessage", "Lỗi: " + e.getMessage());
  ```
- Chuyển tiếp sang `result.jsp`:
  ```java
  request.getRequestDispatcher("/result.jsp").forward(request, response);
  ```

---

### Bước 6: View (result.jsp) hiển thị kết quả ra màn hình
`result.jsp` nhận dữ liệu từ `request` và kiểm tra:
- **Nếu có `errorMessage`:**
  - Hiển thị khung viền đỏ nổi bật thông báo lỗi:
    > **Đã xảy ra lỗi:**
    > Lỗi: Không thể chia cho 0 (Divide by zero)
- **Nếu không có lỗi:**
  - Hiển thị khung viền xanh biểu thức tính:
    > **Biểu thức:**
    > 10.0 / 2.0 = **5.0**
- Trang cung cấp sẵn nút **"← Quay lại trang tính"** dẫn về `index.jsp` để tiếp tục phép tính mới.

---

## 3. CÁC ĐIỂM KỸ THUẬT QUAN TRỌNG TRONG DỰ ÁN

1. **Chuẩn Jakarta EE 10 / Tomcat 10+:**
   - Sử dụng package `jakarta.servlet.*` thay vì `javax.servlet.*` (chuẩn cũ của Tomcat 9 trở về trước).
   - `web.xml` khai báo version `5.0` tương thích chuẩn Jakarta.
2. **Cơ chế ném và bắt ngoại lệ (Exception Handling):**
   - Lớp `Calculator` chỉ tập trung xử lý thuật toán, ném ra ngoại lệ khi gặp dữ liệu phi logic (`ArithmeticException`).
   - `CalculatorServlet` đóng vai trò tầng trung gian bảo vệ ứng dụng, bắt toàn bộ ngoại lệ để trang web không bị sập hay hiển thị màn hình trắng/lỗi mã nguồn thô cho người dùng.
3. **Cơ chế RequestDispatcher.forward():**
   - Giữ nguyên dữ liệu trong `request` từ Servlet sang file JSP để hiển thị mà không làm thay đổi URL trên trình duyệt.

