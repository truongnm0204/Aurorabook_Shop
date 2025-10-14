-- Create VoucherStatus table
CREATE TABLE VoucherStatus (
    status_code VARCHAR(20) PRIMARY KEY,
    status_name NVARCHAR(50) NOT NULL,
    description NVARCHAR(255)
);

-- Insert default voucher statuses
INSERT INTO VoucherStatus (status_code, status_name, description) 
VALUES
('ACTIVE', N'Active', N'Voucher is currently active and can be used'),
('PENDING', N'Pending', N'Voucher is created but not yet active'),
('EXPIRED', N'Expired', N'Voucher has passed its end date'),
('DISABLED', N'Disabled', N'Voucher has been manually disabled');

-- Check if there's a status column in Voucher table
-- If not, let's make sure the Voucher table has a status field that references VoucherStatus
IF NOT EXISTS (
    SELECT 1 
    FROM sys.columns 
    WHERE Name = 'status' 
    AND Object_ID = Object_ID('Voucher')
)
BEGIN
    ALTER TABLE Voucher
    ADD status VARCHAR(20) DEFAULT 'PENDING' 
    CONSTRAINT FK_Voucher_Status FOREIGN KEY (status) REFERENCES VoucherStatus(status_code);
END
