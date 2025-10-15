# Hướng dẫn thêm bảng ShopStatus

## 📋 Mô tả
Bảng `ShopStatus` lưu trữ các trạng thái hợp lệ của Shop, đảm bảo tính toàn vẹn dữ liệu.

## 🔧 Cách thực hiện

### Trường hợp 1: Database mới (chưa có dữ liệu)
✅ Chạy file `aurora.sql` - đã bao gồm bảng ShopStatus

### Trường hợp 2: Database đã tồn tại (migration)
✅ Chạy file `add_shop_status_table.sql`

## 📝 Chi tiết các bước trong migration

### Bước 1: Tạo bảng ShopStatus
```sql
CREATE TABLE ShopStatus
(
    StatusCode NVARCHAR(20) NOT NULL PRIMARY KEY,
    StatusName NVARCHAR(100) NOT NULL
);
```

### Bước 2: Insert dữ liệu mặc định
```sql
INSERT INTO ShopStatus (StatusCode, StatusName)
VALUES
    (N'PENDING', N'Chờ duyệt'),
    (N'APPROVED', N'Đã duyệt'),
    (N'REJECTED', N'Đã từ chối'),
    (N'SUSPENDED', N'Tạm ngưng'),
    (N'BANNED', N'Cấm vĩnh viễn');
```

### Bước 3: Cập nhật dữ liệu cũ (nếu cần)
```sql
UPDATE Shops 
SET [Status] = 'PENDING' 
WHERE [Status] NOT IN ('PENDING', 'APPROVED', 'REJECTED', 'SUSPENDED', 'BANNED');
```

### Bước 4: Thêm Foreign Key
```sql
ALTER TABLE Shops
ADD CONSTRAINT FK_Shops_Status 
FOREIGN KEY ([Status]) REFERENCES ShopStatus(StatusCode);
```

## ✅ Kiểm tra sau khi chạy

```sql
-- Xem các status có sẵn
SELECT * FROM ShopStatus;

-- Kiểm tra Foreign Key
SELECT name FROM sys.foreign_keys WHERE name = 'FK_Shops_Status';
```

## 🎯 Lợi ích
- ✅ Đảm bảo chỉ có các status hợp lệ được lưu vào database
- ✅ Dễ dàng quản lý và thêm status mới
- ✅ Hỗ trợ đa ngôn ngữ (StatusCode + StatusName)
- ✅ Tự động load danh sách status cho dropdown trong giao diện

