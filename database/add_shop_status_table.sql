-- =============================================
-- Migration Script: Add ShopStatus Table
-- Description: Creates ShopStatus lookup table and adds foreign key constraint
-- =============================================

-- Step 1: Create ShopStatus table
CREATE TABLE ShopStatus
(
    StatusCode NVARCHAR(20) NOT NULL PRIMARY KEY,
    StatusName NVARCHAR(100) NOT NULL
);
GO

-- Step 2: Insert status values
INSERT INTO ShopStatus (StatusCode, StatusName)
VALUES
    (N'PENDING', N'Chờ duyệt'),
    (N'APPROVED', N'Đã duyệt'),
    (N'REJECTED', N'Đã từ chối'),
    (N'SUSPENDED', N'Tạm ngưng'),
    (N'BANNED', N'Cấm vĩnh viễn');
GO

-- Step 3: Update any invalid status values in existing Shops table
-- (Set to PENDING if status doesn't match any valid value)
UPDATE Shops 
SET [Status] = 'PENDING' 
WHERE [Status] NOT IN ('PENDING', 'APPROVED', 'REJECTED', 'SUSPENDED', 'BANNED');
GO

-- Step 4: Add foreign key constraint to Shops table
ALTER TABLE Shops
ADD CONSTRAINT FK_Shops_Status 
FOREIGN KEY ([Status]) REFERENCES ShopStatus(StatusCode);
GO

PRINT 'ShopStatus table created successfully!';
PRINT 'Foreign key constraint FK_Shops_Status added successfully!';

