USE [master]
GO
/****** Object:  Database [online-bookstore-dbserver]    Script Date: 10/15/2025 1:53:43 AM ******/
--CREATE DATABASE [online-bookstore-dbserver]
 
USE [online-bookstore-dbserver]
GO
/****** Object:  Table [dbo].[AccountBalances]    Script Date: 10/15/2025 1:53:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountBalances](
	[AccountID] [bigint] IDENTITY(1,1) NOT NULL,
	[OwnerType] [nvarchar](20) NOT NULL,
	[OwnerID] [bigint] NULL,
	[Balance] [decimal](18, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AccountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Addresses]    Script Date: 10/15/2025 1:53:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Addresses](
	[AddressID] [bigint] IDENTITY(1,1) NOT NULL,
	[RecipientName] [nvarchar](150) NOT NULL,
	[Phone] [nvarchar](20) NOT NULL,
	[City] [nvarchar](100) NOT NULL,
	[District] [nvarchar](100) NOT NULL,
	[DistrictID] [int] NULL,
	[Ward] [nvarchar](100) NOT NULL,
	[WardCode] [nvarchar](20) NULL,
	[Description] [nvarchar](255) NOT NULL,
	[CreatedAt] [datetime2](6) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AddressID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Authors]    Script Date: 10/15/2025 1:53:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Authors](
	[AuthorID] [bigint] IDENTITY(1,1) NOT NULL,
	[AuthorName] [nvarchar](200) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AuthorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BalanceChanges]    Script Date: 10/15/2025 1:53:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BalanceChanges](
	[ChangeID] [bigint] IDENTITY(1,1) NOT NULL,
	[AccountID] [bigint] NOT NULL,
	[ChangeAmount] [decimal](18, 2) NOT NULL,
	[ActionType] [nvarchar](50) NOT NULL,
	[OrderID] [bigint] NULL,
	[TransactionRef] [nvarchar](100) NOT NULL,
	[CreatedAt] [datetime2](6) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ChangeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BookAuthors]    Script Date: 10/15/2025 1:53:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookAuthors](
	[ProductID] [bigint] NOT NULL,
	[AuthorID] [bigint] NOT NULL,
 CONSTRAINT [PK_BookAuthors] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC,
	[AuthorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BookDetails]    Script Date: 10/15/2025 1:53:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookDetails](
	[ProductID] [bigint] NOT NULL,
	[Translator] [nvarchar](200) NULL,
	[Version] [nvarchar](50) NOT NULL,
	[CoverType] [nvarchar](50) NOT NULL,
	[Pages] [int] NOT NULL,
	[LanguageCode] [nvarchar](20) NOT NULL,
	[Size] [nvarchar](50) NOT NULL,
	[ISBN] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CartItems]    Script Date: 10/15/2025 1:53:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CartItems](
	[CartItemID] [bigint] IDENTITY(1,1) NOT NULL,
	[UserID] [bigint] NOT NULL,
	[ProductID] [bigint] NOT NULL,
	[Quantity] [int] NOT NULL,
	[UnitPrice] [decimal](12, 2) NOT NULL,
	[Subtotal]  AS (CONVERT([decimal](12,2),[Quantity])*[UnitPrice]) PERSISTED,
	[IsChecked] [bit] NOT NULL,
	[CreatedAt] [datetime2](6) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CartItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 10/15/2025 1:53:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](120) NOT NULL,
	[VATCode] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FlashSaleItemApprovalStatus]    Script Date: 10/15/2025 1:53:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FlashSaleItemApprovalStatus](
	[StatusCode] [nvarchar](20) NOT NULL,
	[StatusName] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[StatusCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FlashSaleItems]    Script Date: 10/15/2025 1:53:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FlashSaleItems](
	[FlashSaleItemID] [bigint] IDENTITY(1,1) NOT NULL,
	[FlashSaleID] [bigint] NOT NULL,
	[ProductID] [bigint] NOT NULL,
	[ShopID] [bigint] NOT NULL,
	[FlashPrice] [decimal](12, 2) NOT NULL,
	[FsStock] [int] NOT NULL,
	[PerUserLimit] [int] NULL,
	[ApprovalStatus] [nvarchar](20) NOT NULL,
	[CreatedAt] [datetime2](6) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[FlashSaleItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FlashSales]    Script Date: 10/15/2025 1:53:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FlashSales](
	[FlashSaleID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](150) NOT NULL,
	[StartAt] [datetime2](6) NOT NULL,
	[EndAt] [datetime2](6) NOT NULL,
	[Status] [nvarchar](20) NOT NULL,
	[CreatedAt] [datetime2](6) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[FlashSaleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FlashSaleStatus]    Script Date: 10/15/2025 1:53:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FlashSaleStatus](
	[StatusCode] [varchar](20) NOT NULL,
	[StatusName] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[StatusCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Languages]    Script Date: 10/15/2025 1:53:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Languages](
	[LanguageCode] [nvarchar](20) NOT NULL,
	[LanguageName] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[LanguageCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderItems]    Script Date: 10/15/2025 1:53:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderItems](
	[OrderItemID] [bigint] IDENTITY(1,1) NOT NULL,
	[OrderShopID] [bigint] NOT NULL,
	[ProductID] [bigint] NOT NULL,
	[FlashSaleItemID] [bigint] NULL,
	[Quantity] [int] NOT NULL,
	[OriginalPrice] [decimal](12, 2) NOT NULL,
	[SalePrice] [decimal](12, 2) NOT NULL,
	[Subtotal] [decimal](12, 2) NULL,
	[VATRate] [decimal](5, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 10/15/2025 1:53:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [bigint] IDENTITY(1,1) NOT NULL,
	[UserID] [bigint] NOT NULL,
	[AddressID] [bigint] NOT NULL,
	[VoucherDiscountID] [bigint] NULL,
	[VoucherShipID] [bigint] NULL,
	[TotalAmount] [decimal](12, 2) NOT NULL,
	[DiscountAmount] [decimal](12, 2) NOT NULL,
	[ShippingFee] [decimal](12, 2) NOT NULL,
	[ShippingDiscount] [decimal](12, 2) NOT NULL,
	[FinalAmount] [decimal](12, 2) NOT NULL,
	[OrderStatus] [nvarchar](20) NOT NULL,
	[CreatedAt] [datetime2](6) NOT NULL,
	[DeliveredAt] [datetime2](6) NULL,
	[CancelReason] [nvarchar](255) NULL,
	[ReturnReason] [nvarchar](255) NULL,
	[CancelledAt] [datetime2](6) NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderShops]    Script Date: 10/15/2025 1:53:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderShops](
	[OrderShopID] [bigint] IDENTITY(1,1) NOT NULL,
	[OrderID] [bigint] NOT NULL,
	[ShopID] [bigint] NOT NULL,
	[VoucherID] [bigint] NULL,
	[Subtotal] [decimal](12, 2) NOT NULL,
	[Discount] [decimal](12, 2) NOT NULL,
	[ShippingFee] [decimal](12, 2) NOT NULL,
	[FinalAmount] [decimal](12, 2) NOT NULL,
	[Status] [nvarchar](20) NOT NULL,
	[CreatedAt] [datetime2](6) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderShopID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payments]    Script Date: 10/15/2025 1:53:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payments](
	[PaymentID] [bigint] IDENTITY(1,1) NOT NULL,
	[OrderID] [bigint] NOT NULL,
	[Amount] [decimal](12, 2) NOT NULL,
	[TransactionRef] [nvarchar](100) NOT NULL,
	[CreatedAt] [datetime2](6) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PaymentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductCategory]    Script Date: 10/15/2025 1:53:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductCategory](
	[ProductID] [bigint] NOT NULL,
	[CategoryID] [bigint] NOT NULL,
 CONSTRAINT [PK_ProductCategory] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC,
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductImages]    Script Date: 10/15/2025 1:53:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductImages](
	[ImageID] [bigint] IDENTITY(1,1) NOT NULL,
	[ProductID] [bigint] NOT NULL,
	[Url] [nvarchar](2000) NOT NULL,
	[IsPrimary] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ImageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 10/15/2025 1:53:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductID] [bigint] IDENTITY(1,1) NOT NULL,
	[ShopID] [bigint] NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[OriginalPrice] [decimal](12, 2) NOT NULL,
	[SalePrice] [decimal](12, 2) NOT NULL,
	[SoldCount] [bigint] NOT NULL,
	[Quantity] [int] NOT NULL,
	[PublisherID] [bigint] NULL,
	[Status] [nvarchar](20) NOT NULL,
	[PublishedDate] [date] NULL,
	[Weight] [decimal](10, 2) NOT NULL,
	[RejectReason] [nvarchar](255) NULL,
	[CreatedAt] [datetime2](6) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Publishers]    Script Date: 10/15/2025 1:53:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Publishers](
	[PublisherID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](150) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PublisherID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReviewImages]    Script Date: 10/15/2025 1:53:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReviewImages](
	[ReviewImageID] [bigint] IDENTITY(1,1) NOT NULL,
	[ReviewID] [bigint] NOT NULL,
	[Url] [nvarchar](2000) NOT NULL,
	[Caption] [nvarchar](255) NULL,
	[IsPrimary] [bit] NOT NULL,
	[CreatedAt] [datetime2](6) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ReviewImageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reviews]    Script Date: 10/15/2025 1:53:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reviews](
	[ReviewID] [bigint] IDENTITY(1,1) NOT NULL,
	[OrderItemID] [bigint] NOT NULL,
	[UserID] [bigint] NOT NULL,
	[Rating] [tinyint] NOT NULL,
	[Comment] [nvarchar](255) NULL,
	[CreatedAt] [datetime2](6) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ReviewID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 10/15/2025 1:53:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleCode] [nvarchar](20) NOT NULL,
	[RoleName] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Shops]    Script Date: 10/15/2025 1:53:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shops](
	[ShopID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](150) NOT NULL,
	[Description] [nvarchar](255) NULL,
	[RatingAvg] [decimal](3, 2) NOT NULL,
	[Status] [nvarchar](20) NOT NULL,
	[OwnerUserID] [bigint] NOT NULL,
	[CreatedAt] [datetime2](6) NOT NULL,
	[PickupAddressID] [bigint] NOT NULL,
	[InvoiceEmail] [nvarchar](255) NOT NULL,
	[AvatarUrl] [nvarchar](2000) NULL,
	[RejectReason] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[ShopID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ShopStatus]    Script Date: 10/15/2025 1:53:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShopStatus](
	[StatusCode] [nvarchar](20) NOT NULL,
	[StatusName] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[StatusCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRoles]    Script Date: 10/15/2025 1:53:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRoles](
	[UserID] [bigint] NOT NULL,
	[RoleCode] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_UserRoles] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[RoleCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 10/15/2025 1:53:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [bigint] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](255) NOT NULL,
	[Password] [nvarchar](255) NOT NULL,
	[FullName] [nvarchar](150) NOT NULL,
	[AvatarUrl] [nvarchar](2000) NULL,
	[Status] [nvarchar](20) NULL,
	[CreatedAt] [datetime2](6) NOT NULL,
	[AuthProvider] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users_Addresses]    Script Date: 10/15/2025 1:53:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users_Addresses](
	[UserID] [bigint] NOT NULL,
	[AddressID] [bigint] NOT NULL,
	[IsDefault] [bit] NOT NULL,
 CONSTRAINT [PK_Users_Addresses] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[AddressID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserVouchers]    Script Date: 10/15/2025 1:53:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserVouchers](
	[UserVoucherID] [bigint] IDENTITY(1,1) NOT NULL,
	[VoucherID] [bigint] NOT NULL,
	[UserID] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserVoucherID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VAT]    Script Date: 10/15/2025 1:53:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VAT](
	[VATCode] [nvarchar](50) NOT NULL,
	[VATRate] [decimal](5, 2) NOT NULL,
	[Description] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[VATCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vouchers]    Script Date: 10/15/2025 1:53:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vouchers](
	[VoucherID] [bigint] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](40) NOT NULL,
	[DiscountType] [nvarchar](20) NOT NULL,
	[Value] [decimal](12, 2) NOT NULL,
	[MaxAmount] [decimal](12, 2) NULL,
	[MinOrderAmount] [decimal](12, 2) NOT NULL,
	[StartAt] [datetime2](6) NOT NULL,
	[EndAt] [datetime2](6) NOT NULL,
	[UsageLimit] [int] NOT NULL,
	[PerUserLimit] [int] NULL,
	[Status] [nvarchar](20) NOT NULL,
	[UsageCount] [int] NOT NULL,
	[IsShopVoucher] [bit] NOT NULL,
	[ShopID] [bigint] NULL,
	[Description] [nvarchar](255) NULL,
	[CreatedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[VoucherID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[AccountBalances] ON 

INSERT [dbo].[AccountBalances] ([AccountID], [OwnerType], [OwnerID], [Balance]) VALUES (1, N'ADMIN', NULL, CAST(10000000.00 AS Decimal(18, 2)))
INSERT [dbo].[AccountBalances] ([AccountID], [OwnerType], [OwnerID], [Balance]) VALUES (2, N'ADMIN', NULL, CAST(10000000.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[AccountBalances] OFF
GO
SET IDENTITY_INSERT [dbo].[Addresses] ON 

INSERT [dbo].[Addresses] ([AddressID], [RecipientName], [Phone], [City], [District], [DistrictID], [Ward], [WardCode], [Description], [CreatedAt]) VALUES (1, N'Chủ shop A', N'0909123456', N'Hà Nội', N'Đống Đa', NULL, N'Phường Trung Liệt', NULL, N'123 Nguyễn Lương Bằng', CAST(N'2025-10-14T15:29:55.9533040' AS DateTime2))
INSERT [dbo].[Addresses] ([AddressID], [RecipientName], [Phone], [City], [District], [DistrictID], [Ward], [WardCode], [Description], [CreatedAt]) VALUES (2, N'Chủ shop B', N'0987123456', N'Hồ Chí Minh', N'Quận 1', NULL, N'Phường Bến Nghé', NULL, N'45 Lê Lợi', CAST(N'2025-10-14T15:29:55.9533040' AS DateTime2))
INSERT [dbo].[Addresses] ([AddressID], [RecipientName], [Phone], [City], [District], [DistrictID], [Ward], [WardCode], [Description], [CreatedAt]) VALUES (3, N'Nguyễn Văn A', N'0909999999', N'Hà Nội', N'Cầu Giấy', NULL, N'Dịch Vọng', NULL, N'123 Cầu Giấy', CAST(N'2025-10-14T15:29:55.9616560' AS DateTime2))
INSERT [dbo].[Addresses] ([AddressID], [RecipientName], [Phone], [City], [District], [DistrictID], [Ward], [WardCode], [Description], [CreatedAt]) VALUES (4, N'Chủ shop A', N'0909123456', N'Hà Nội', N'Đống Đa', NULL, N'Trung Liệt', NULL, N'123 Nguyễn Lương Bằng', CAST(N'2025-10-14T15:33:17.6871370' AS DateTime2))
INSERT [dbo].[Addresses] ([AddressID], [RecipientName], [Phone], [City], [District], [DistrictID], [Ward], [WardCode], [Description], [CreatedAt]) VALUES (5, N'Chủ shop B', N'0987123456', N'Hồ Chí Minh', N'Quận 1', NULL, N'Bến Nghé', NULL, N'45 Lê Lợi', CAST(N'2025-10-14T15:33:17.6871370' AS DateTime2))
INSERT [dbo].[Addresses] ([AddressID], [RecipientName], [Phone], [City], [District], [DistrictID], [Ward], [WardCode], [Description], [CreatedAt]) VALUES (6, N'Nguyễn Văn A', N'0909999999', N'Hà Nội', N'Cầu Giấy', NULL, N'Dịch Vọng', NULL, N'123 Cầu Giấy', CAST(N'2025-10-14T15:33:17.6958520' AS DateTime2))
SET IDENTITY_INSERT [dbo].[Addresses] OFF
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([CategoryID], [Name], [VATCode]) VALUES (1, N'Tiểu thuyết', N'VAT5')
INSERT [dbo].[Category] ([CategoryID], [Name], [VATCode]) VALUES (2, N'Truyện ngắn', N'VAT5')
INSERT [dbo].[Category] ([CategoryID], [Name], [VATCode]) VALUES (3, N'Thơ ca', N'VAT5')
INSERT [dbo].[Category] ([CategoryID], [Name], [VATCode]) VALUES (4, N'Văn học', N'VAT5')
INSERT [dbo].[Category] ([CategoryID], [Name], [VATCode]) VALUES (5, N'Truyện tranh', N'VAT5')
INSERT [dbo].[Category] ([CategoryID], [Name], [VATCode]) VALUES (6, N'Light Novel', N'VAT5')
INSERT [dbo].[Category] ([CategoryID], [Name], [VATCode]) VALUES (7, N'Sách giáo khoa', N'VAT5')
INSERT [dbo].[Category] ([CategoryID], [Name], [VATCode]) VALUES (8, N'Sách tham khảo', N'VAT5')
INSERT [dbo].[Category] ([CategoryID], [Name], [VATCode]) VALUES (9, N'Kinh tế', N'VAT10')
INSERT [dbo].[Category] ([CategoryID], [Name], [VATCode]) VALUES (10, N'Tài chính', N'VAT10')
INSERT [dbo].[Category] ([CategoryID], [Name], [VATCode]) VALUES (11, N'Phát triển bản thân', N'VAT10')
INSERT [dbo].[Category] ([CategoryID], [Name], [VATCode]) VALUES (12, N'Lịch sử', N'VAT5')
INSERT [dbo].[Category] ([CategoryID], [Name], [VATCode]) VALUES (13, N'Chính trị', N'VAT5')
INSERT [dbo].[Category] ([CategoryID], [Name], [VATCode]) VALUES (14, N'Pháp luật', N'VAT5')
INSERT [dbo].[Category] ([CategoryID], [Name], [VATCode]) VALUES (15, N'Khoa học', N'VAT5')
INSERT [dbo].[Category] ([CategoryID], [Name], [VATCode]) VALUES (16, N'Tâm lý', N'VAT5')
INSERT [dbo].[Category] ([CategoryID], [Name], [VATCode]) VALUES (17, N'Y học', N'VAT5')
INSERT [dbo].[Category] ([CategoryID], [Name], [VATCode]) VALUES (18, N'Ẩm thực', N'VAT10')
INSERT [dbo].[Category] ([CategoryID], [Name], [VATCode]) VALUES (19, N'Nuôi dạy con', N'VAT10')
INSERT [dbo].[Category] ([CategoryID], [Name], [VATCode]) VALUES (20, N'Du lịch', N'VAT10')
INSERT [dbo].[Category] ([CategoryID], [Name], [VATCode]) VALUES (21, N'Thời trang', N'VAT10')
INSERT [dbo].[Category] ([CategoryID], [Name], [VATCode]) VALUES (22, N'Nhà cửa', N'VAT10')
INSERT [dbo].[Category] ([CategoryID], [Name], [VATCode]) VALUES (23, N'Nghệ thuật', N'VAT10')
INSERT [dbo].[Category] ([CategoryID], [Name], [VATCode]) VALUES (24, N'Tôn giáo', N'VAT5')
INSERT [dbo].[Category] ([CategoryID], [Name], [VATCode]) VALUES (25, N'Trinh Thám', N'VAT5')
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
INSERT [dbo].[FlashSaleItemApprovalStatus] ([StatusCode], [StatusName], [Description]) VALUES (N'APPROVED', N'Đã duyệt', N'Đơn đăng ký sản phẩm vào Flash Sale đã được chấp thuận')
INSERT [dbo].[FlashSaleItemApprovalStatus] ([StatusCode], [StatusName], [Description]) VALUES (N'PENDING', N'Chờ duyệt', N'Đơn đăng ký sản phẩm vào Flash Sale đang chờ duyệt')
INSERT [dbo].[FlashSaleItemApprovalStatus] ([StatusCode], [StatusName], [Description]) VALUES (N'REJECTED', N'Đã từ chối', N'Đơn đăng ký sản phẩm vào Flash Sale đã bị từ chối')
GO
SET IDENTITY_INSERT [dbo].[FlashSaleItems] ON 

INSERT [dbo].[FlashSaleItems] ([FlashSaleItemID], [FlashSaleID], [ProductID], [ShopID], [FlashPrice], [FsStock], [PerUserLimit], [ApprovalStatus], [CreatedAt]) VALUES (2, 2, 2, 2, CAST(59000.00 AS Decimal(12, 2)), 30, NULL, N'APPROVED', CAST(N'2025-10-14T15:33:17.6871370' AS DateTime2))
INSERT [dbo].[FlashSaleItems] ([FlashSaleItemID], [FlashSaleID], [ProductID], [ShopID], [FlashPrice], [FsStock], [PerUserLimit], [ApprovalStatus], [CreatedAt]) VALUES (3, 2, 3, 3, CAST(79000.00 AS Decimal(12, 2)), 20, NULL, N'APPROVED', CAST(N'2025-10-14T15:33:17.6871370' AS DateTime2))
SET IDENTITY_INSERT [dbo].[FlashSaleItems] OFF
GO
SET IDENTITY_INSERT [dbo].[FlashSales] ON 

INSERT [dbo].[FlashSales] ([FlashSaleID], [Name], [StartAt], [EndAt], [Status], [CreatedAt]) VALUES (1, N'Flash Sale Mùa Thu', CAST(N'2025-10-13T15:29:55.9616560' AS DateTime2), CAST(N'2025-10-16T15:29:55.9616560' AS DateTime2), N'ACTIVE', CAST(N'2025-10-14T15:29:55.9616560' AS DateTime2))
INSERT [dbo].[FlashSales] ([FlashSaleID], [Name], [StartAt], [EndAt], [Status], [CreatedAt]) VALUES (2, N'Flash Sale Mùa Thu', CAST(N'2025-10-13T15:33:00.0000000' AS DateTime2), CAST(N'2025-10-16T15:33:00.0000000' AS DateTime2), N'COMPLETED', CAST(N'2025-10-14T15:33:17.6871370' AS DateTime2))
SET IDENTITY_INSERT [dbo].[FlashSales] OFF
GO
INSERT [dbo].[FlashSaleStatus] ([StatusCode], [StatusName], [Description]) VALUES (N'ACTIVE', N'Đang diễn ra', N'Flash Sale đang diễn ra')
INSERT [dbo].[FlashSaleStatus] ([StatusCode], [StatusName], [Description]) VALUES (N'CANCELLED', N'Đã hủy', N'Flash Sale đã bị hủy')
INSERT [dbo].[FlashSaleStatus] ([StatusCode], [StatusName], [Description]) VALUES (N'COMPLETED', N'Đã kết thúc', N'Flash Sale đã kết thúc')
INSERT [dbo].[FlashSaleStatus] ([StatusCode], [StatusName], [Description]) VALUES (N'PENDING', N'Chờ duyệt', N'Flash Sale đã được tạo nhưng chưa bắt đầu')
INSERT [dbo].[FlashSaleStatus] ([StatusCode], [StatusName], [Description]) VALUES (N'SCHEDULED', N'Đã lên lịch', N'Flash Sale đã được lên lịch')
GO
INSERT [dbo].[Languages] ([LanguageCode], [LanguageName]) VALUES (N'en', N'Tiếng Anh')
INSERT [dbo].[Languages] ([LanguageCode], [LanguageName]) VALUES (N'vi', N'Tiếng Việt')
GO
SET IDENTITY_INSERT [dbo].[OrderItems] ON 

INSERT [dbo].[OrderItems] ([OrderItemID], [OrderShopID], [ProductID], [FlashSaleItemID], [Quantity], [OriginalPrice], [SalePrice], [Subtotal], [VATRate]) VALUES (2, 2, 2, NULL, 1, CAST(85000.00 AS Decimal(12, 2)), CAST(69000.00 AS Decimal(12, 2)), CAST(69000.00 AS Decimal(12, 2)), CAST(5.00 AS Decimal(5, 2)))
SET IDENTITY_INSERT [dbo].[OrderItems] OFF
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([OrderID], [UserID], [AddressID], [VoucherDiscountID], [VoucherShipID], [TotalAmount], [DiscountAmount], [ShippingFee], [ShippingDiscount], [FinalAmount], [OrderStatus], [CreatedAt], [DeliveredAt], [CancelReason], [ReturnReason], [CancelledAt]) VALUES (1, 4, 3, NULL, NULL, CAST(120000.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), CAST(120000.00 AS Decimal(12, 2)), N'PENDING', CAST(N'2025-10-14T15:29:55.9616560' AS DateTime2), NULL, NULL, NULL, NULL)
INSERT [dbo].[Orders] ([OrderID], [UserID], [AddressID], [VoucherDiscountID], [VoucherShipID], [TotalAmount], [DiscountAmount], [ShippingFee], [ShippingDiscount], [FinalAmount], [OrderStatus], [CreatedAt], [DeliveredAt], [CancelReason], [ReturnReason], [CancelledAt]) VALUES (2, 8, 6, NULL, NULL, CAST(120000.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), CAST(120000.00 AS Decimal(12, 2)), N'PENDING', CAST(N'2025-10-14T15:33:17.6958520' AS DateTime2), NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderShops] ON 

INSERT [dbo].[OrderShops] ([OrderShopID], [OrderID], [ShopID], [VoucherID], [Subtotal], [Discount], [ShippingFee], [FinalAmount], [Status], [CreatedAt]) VALUES (2, 2, 2, NULL, CAST(69000.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), CAST(69000.00 AS Decimal(12, 2)), N'PENDING', CAST(N'2025-10-14T15:33:17.6958520' AS DateTime2))
SET IDENTITY_INSERT [dbo].[OrderShops] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([ProductID], [ShopID], [Title], [Description], [OriginalPrice], [SalePrice], [SoldCount], [Quantity], [PublisherID], [Status], [PublishedDate], [Weight], [RejectReason], [CreatedAt]) VALUES (2, 2, N'Chuyện con mèo dạy hải âu bay', N'Sách thiếu nhi nổi tiếng', CAST(85000.00 AS Decimal(12, 2)), CAST(69000.00 AS Decimal(12, 2)), 0, 120, 3, N'ACTIVE', NULL, CAST(0.25 AS Decimal(10, 2)), NULL, CAST(N'2025-10-14T15:33:17.6871370' AS DateTime2))
INSERT [dbo].[Products] ([ProductID], [ShopID], [Title], [Description], [OriginalPrice], [SalePrice], [SoldCount], [Quantity], [PublisherID], [Status], [PublishedDate], [Weight], [RejectReason], [CreatedAt]) VALUES (3, 3, N'Re:Zero - Tập 1', N'Light Novel Nhật Bản được yêu thích', CAST(110000.00 AS Decimal(12, 2)), CAST(95000.00 AS Decimal(12, 2)), 0, 80, 4, N'ACTIVE', NULL, CAST(0.35 AS Decimal(10, 2)), NULL, CAST(N'2025-10-14T15:33:17.6871370' AS DateTime2))
INSERT [dbo].[Products] ([ProductID], [ShopID], [Title], [Description], [OriginalPrice], [SalePrice], [SoldCount], [Quantity], [PublisherID], [Status], [PublishedDate], [Weight], [RejectReason], [CreatedAt]) VALUES (6, 2, N'ABC', N'ACB', CAST(100000.00 AS Decimal(12, 2)), CAST(990000.00 AS Decimal(12, 2)), 0, 100, 3, N'ACTIVE', NULL, CAST(0.35 AS Decimal(10, 2)), NULL, CAST(N'2025-10-14T17:43:30.0289270' AS DateTime2))
INSERT [dbo].[Products] ([ProductID], [ShopID], [Title], [Description], [OriginalPrice], [SalePrice], [SoldCount], [Quantity], [PublisherID], [Status], [PublishedDate], [Weight], [RejectReason], [CreatedAt]) VALUES (11, 2, N'QQQ', N'Q', CAST(10000.00 AS Decimal(12, 2)), CAST(10000.00 AS Decimal(12, 2)), 0, 10, 2, N'REJECTED', NULL, CAST(0.33 AS Decimal(10, 2)), N'q', CAST(N'2025-10-14T17:49:24.1306590' AS DateTime2))
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[Publishers] ON 

INSERT [dbo].[Publishers] ([PublisherID], [Name]) VALUES (1, N'NXB Kim Đồng')
INSERT [dbo].[Publishers] ([PublisherID], [Name]) VALUES (2, N'NXB Trẻ')
INSERT [dbo].[Publishers] ([PublisherID], [Name]) VALUES (3, N'NXB Kim Đồng')
INSERT [dbo].[Publishers] ([PublisherID], [Name]) VALUES (4, N'NXB Trẻ')
SET IDENTITY_INSERT [dbo].[Publishers] OFF
GO
SET IDENTITY_INSERT [dbo].[Reviews] ON 

INSERT [dbo].[Reviews] ([ReviewID], [OrderItemID], [UserID], [Rating], [Comment], [CreatedAt]) VALUES (1, 2, 8, 5, N'Sách giao nhanh, chất lượng tốt!', CAST(N'2025-10-14T15:33:17.6968590' AS DateTime2))
SET IDENTITY_INSERT [dbo].[Reviews] OFF
GO
INSERT [dbo].[Roles] ([RoleCode], [RoleName]) VALUES (N'ADMIN', N'Quản trị')
INSERT [dbo].[Roles] ([RoleCode], [RoleName]) VALUES (N'CUSTOMER', N'Khách hàng')
INSERT [dbo].[Roles] ([RoleCode], [RoleName]) VALUES (N'SELLER', N'Người bán')
GO
SET IDENTITY_INSERT [dbo].[Shops] ON 

INSERT [dbo].[Shops] ([ShopID], [Name], [Description], [RatingAvg], [Status], [OwnerUserID], [CreatedAt], [PickupAddressID], [InvoiceEmail], [AvatarUrl], [RejectReason]) VALUES (2, N'Shop A - Sách Mới', N'Chuyên bán sách văn học hiện đại', CAST(4.80 AS Decimal(3, 2)), N'APPROVED', 6, CAST(N'2025-10-14T15:33:17.6871370' AS DateTime2), 4, N'shopowner1@gmail.com', NULL, NULL)
INSERT [dbo].[Shops] ([ShopID], [Name], [Description], [RatingAvg], [Status], [OwnerUserID], [CreatedAt], [PickupAddressID], [InvoiceEmail], [AvatarUrl], [RejectReason]) VALUES (3, N'Shop B - Light Novel', N'Chuyên Light Novel Nhật Bản', CAST(4.70 AS Decimal(3, 2)), N'BANNED', 7, CAST(N'2025-10-14T15:33:17.6871370' AS DateTime2), 5, N'shopowner2@gmail.com', NULL, N'a')
SET IDENTITY_INSERT [dbo].[Shops] OFF
GO
INSERT [dbo].[ShopStatus] ([StatusCode], [StatusName]) VALUES (N'APPROVED', N'Đã duyệt')
INSERT [dbo].[ShopStatus] ([StatusCode], [StatusName]) VALUES (N'BANNED', N'Cấm vĩnh viễn')
INSERT [dbo].[ShopStatus] ([StatusCode], [StatusName]) VALUES (N'PENDING', N'Chờ duyệt')
INSERT [dbo].[ShopStatus] ([StatusCode], [StatusName]) VALUES (N'REJECTED', N'Đã từ chối')
INSERT [dbo].[ShopStatus] ([StatusCode], [StatusName]) VALUES (N'SUSPENDED', N'Tạm ngưng')
GO
INSERT [dbo].[UserRoles] ([UserID], [RoleCode]) VALUES (1, N'ADMIN')
INSERT [dbo].[UserRoles] ([UserID], [RoleCode]) VALUES (2, N'SELLER')
INSERT [dbo].[UserRoles] ([UserID], [RoleCode]) VALUES (3, N'SELLER')
INSERT [dbo].[UserRoles] ([UserID], [RoleCode]) VALUES (4, N'CUSTOMER')
INSERT [dbo].[UserRoles] ([UserID], [RoleCode]) VALUES (5, N'ADMIN')
INSERT [dbo].[UserRoles] ([UserID], [RoleCode]) VALUES (6, N'SELLER')
INSERT [dbo].[UserRoles] ([UserID], [RoleCode]) VALUES (7, N'SELLER')
INSERT [dbo].[UserRoles] ([UserID], [RoleCode]) VALUES (8, N'CUSTOMER')
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserID], [Email], [Password], [FullName], [AvatarUrl], [Status], [CreatedAt], [AuthProvider]) VALUES (1, N'admin@aurora.com', N'123456', N'Quản trị viên hệ thống', NULL, N'locked', CAST(N'2025-10-14T15:29:55.9477880' AS DateTime2), N'LOCAL')
INSERT [dbo].[Users] ([UserID], [Email], [Password], [FullName], [AvatarUrl], [Status], [CreatedAt], [AuthProvider]) VALUES (2, N'shopowner1@gmail.com', N'123456', N'Chủ shop A', NULL, N'locked', CAST(N'2025-10-14T15:29:55.9487910' AS DateTime2), N'LOCAL')
INSERT [dbo].[Users] ([UserID], [Email], [Password], [FullName], [AvatarUrl], [Status], [CreatedAt], [AuthProvider]) VALUES (3, N'shopowner2@gmail.com', N'123456', N'Chủ shop B', NULL, N'locked', CAST(N'2025-10-14T15:29:55.9487910' AS DateTime2), N'LOCAL')
INSERT [dbo].[Users] ([UserID], [Email], [Password], [FullName], [AvatarUrl], [Status], [CreatedAt], [AuthProvider]) VALUES (4, N'customer1@gmail.com', N'123456', N'Nguyễn Văn A', NULL, N'locked', CAST(N'2025-10-14T15:29:55.9616560' AS DateTime2), N'LOCAL')
INSERT [dbo].[Users] ([UserID], [Email], [Password], [FullName], [AvatarUrl], [Status], [CreatedAt], [AuthProvider]) VALUES (5, N'admin@aurora.com', N'123456', N'Quản trị viên hệ thống', NULL, N'active', CAST(N'2025-10-14T15:33:17.6871370' AS DateTime2), N'LOCAL')
INSERT [dbo].[Users] ([UserID], [Email], [Password], [FullName], [AvatarUrl], [Status], [CreatedAt], [AuthProvider]) VALUES (6, N'shopowner1@gmail.com', N'123456', N'Chủ shop A', NULL, N'ACTIVE', CAST(N'2025-10-14T15:33:17.6871370' AS DateTime2), N'LOCAL')
INSERT [dbo].[Users] ([UserID], [Email], [Password], [FullName], [AvatarUrl], [Status], [CreatedAt], [AuthProvider]) VALUES (7, N'shopowner2@gmail.com', N'123456', N'Chủ shop B', NULL, N'ACTIVE', CAST(N'2025-10-14T15:33:17.6871370' AS DateTime2), N'LOCAL')
INSERT [dbo].[Users] ([UserID], [Email], [Password], [FullName], [AvatarUrl], [Status], [CreatedAt], [AuthProvider]) VALUES (8, N'customer1@gmail.com', N'123456', N'Nguyễn Văn A', NULL, N'ACTIVE', CAST(N'2025-10-14T15:33:17.6956040' AS DateTime2), N'LOCAL')
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
INSERT [dbo].[VAT] ([VATCode], [VATRate], [Description]) VALUES (N'VAT10', CAST(10.00 AS Decimal(5, 2)), N'Thuế VAT 10%')
INSERT [dbo].[VAT] ([VATCode], [VATRate], [Description]) VALUES (N'VAT5', CAST(5.00 AS Decimal(5, 2)), N'Thuế VAT 5%')
GO
SET IDENTITY_INSERT [dbo].[Vouchers] ON 

INSERT [dbo].[Vouchers] ([VoucherID], [Code], [DiscountType], [Value], [MaxAmount], [MinOrderAmount], [StartAt], [EndAt], [UsageLimit], [PerUserLimit], [Status], [UsageCount], [IsShopVoucher], [ShopID], [Description], [CreatedAt]) VALUES (1, N'GIAM10', N'PERCENT', CAST(10.00 AS Decimal(12, 2)), NULL, CAST(100000.00 AS Decimal(12, 2)), CAST(N'2025-10-14T15:29:55.9616560' AS DateTime2), CAST(N'2025-11-13T15:29:55.9616560' AS DateTime2), 100, NULL, N'ACTIVE', 0, 0, NULL, NULL, CAST(N'2025-10-14T22:29:55.960' AS DateTime))
INSERT [dbo].[Vouchers] ([VoucherID], [Code], [DiscountType], [Value], [MaxAmount], [MinOrderAmount], [StartAt], [EndAt], [UsageLimit], [PerUserLimit], [Status], [UsageCount], [IsShopVoucher], [ShopID], [Description], [CreatedAt]) VALUES (2, N'LIGHTSALE', N'AMOUNT', CAST(20000.00 AS Decimal(12, 2)), NULL, CAST(50000.00 AS Decimal(12, 2)), CAST(N'2025-10-14T15:29:55.9616560' AS DateTime2), CAST(N'2025-10-29T15:29:55.9616560' AS DateTime2), 50, NULL, N'ACTIVE', 0, 1, NULL, NULL, CAST(N'2025-10-14T22:29:55.960' AS DateTime))
INSERT [dbo].[Vouchers] ([VoucherID], [Code], [DiscountType], [Value], [MaxAmount], [MinOrderAmount], [StartAt], [EndAt], [UsageLimit], [PerUserLimit], [Status], [UsageCount], [IsShopVoucher], [ShopID], [Description], [CreatedAt]) VALUES (5, N'joinus', N'PERCENT', CAST(12.00 AS Decimal(12, 2)), NULL, CAST(0.00 AS Decimal(12, 2)), CAST(N'2025-10-15T23:58:00.0000000' AS DateTime2), CAST(N'2025-10-18T23:58:00.0000000' AS DateTime2), 100, 1, N'ACTIVE', 0, 0, NULL, NULL, CAST(N'2025-10-14T23:58:40.307' AS DateTime))
SET IDENTITY_INSERT [dbo].[Vouchers] OFF
GO
/****** Object:  Index [UQ__Payments__C3905BAE7524F54A]    Script Date: 10/15/2025 1:53:44 AM ******/
ALTER TABLE [dbo].[Payments] ADD UNIQUE NONCLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Shops__348B85FBC0A76F35]    Script Date: 10/15/2025 1:53:44 AM ******/
ALTER TABLE [dbo].[Shops] ADD UNIQUE NONCLUSTERED 
(
	[PickupAddressID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Shops__737584F6AF32129D]    Script Date: 10/15/2025 1:53:44 AM ******/
ALTER TABLE [dbo].[Shops] ADD UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Vouchers_Code]    Script Date: 10/15/2025 1:53:44 AM ******/
ALTER TABLE [dbo].[Vouchers] ADD  CONSTRAINT [UQ_Vouchers_Code] UNIQUE NONCLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AccountBalances] ADD  DEFAULT ((0)) FOR [Balance]
GO
ALTER TABLE [dbo].[Addresses] ADD  DEFAULT (sysutcdatetime()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[BalanceChanges] ADD  DEFAULT (sysutcdatetime()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[CartItems] ADD  DEFAULT ((0)) FOR [IsChecked]
GO
ALTER TABLE [dbo].[CartItems] ADD  DEFAULT (sysutcdatetime()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[FlashSaleItems] ADD  DEFAULT (sysutcdatetime()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[FlashSales] ADD  DEFAULT (sysutcdatetime()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[OrderItems] ADD  DEFAULT ((0)) FOR [VATRate]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT ((0)) FOR [DiscountAmount]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT ((0)) FOR [ShippingFee]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT ((0)) FOR [ShippingDiscount]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT (sysutcdatetime()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[OrderShops] ADD  DEFAULT ((0)) FOR [Discount]
GO
ALTER TABLE [dbo].[OrderShops] ADD  DEFAULT ((0)) FOR [ShippingFee]
GO
ALTER TABLE [dbo].[OrderShops] ADD  DEFAULT (sysutcdatetime()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Payments] ADD  DEFAULT (sysutcdatetime()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Products] ADD  DEFAULT ((0)) FOR [SoldCount]
GO
ALTER TABLE [dbo].[Products] ADD  DEFAULT ('ACTIVE') FOR [Status]
GO
ALTER TABLE [dbo].[Products] ADD  DEFAULT (sysutcdatetime()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[ReviewImages] ADD  DEFAULT (sysutcdatetime()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Reviews] ADD  DEFAULT (sysutcdatetime()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Shops] ADD  DEFAULT (sysutcdatetime()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (sysutcdatetime()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Vouchers] ADD  DEFAULT ((0)) FOR [UsageCount]
GO
ALTER TABLE [dbo].[Vouchers] ADD  DEFAULT ((0)) FOR [IsShopVoucher]
GO
ALTER TABLE [dbo].[Vouchers] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[AccountBalances]  WITH CHECK ADD  CONSTRAINT [FK_AccountBalances_Shop] FOREIGN KEY([OwnerID])
REFERENCES [dbo].[Shops] ([ShopID])
GO
ALTER TABLE [dbo].[AccountBalances] CHECK CONSTRAINT [FK_AccountBalances_Shop]
GO
ALTER TABLE [dbo].[BalanceChanges]  WITH CHECK ADD  CONSTRAINT [FK_BalanceChanges_Account] FOREIGN KEY([AccountID])
REFERENCES [dbo].[AccountBalances] ([AccountID])
GO
ALTER TABLE [dbo].[BalanceChanges] CHECK CONSTRAINT [FK_BalanceChanges_Account]
GO
ALTER TABLE [dbo].[BalanceChanges]  WITH CHECK ADD  CONSTRAINT [FK_BalanceChanges_Order] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[BalanceChanges] CHECK CONSTRAINT [FK_BalanceChanges_Order]
GO
ALTER TABLE [dbo].[BookAuthors]  WITH CHECK ADD  CONSTRAINT [FK_BookAuthors_Author] FOREIGN KEY([AuthorID])
REFERENCES [dbo].[Authors] ([AuthorID])
GO
ALTER TABLE [dbo].[BookAuthors] CHECK CONSTRAINT [FK_BookAuthors_Author]
GO
ALTER TABLE [dbo].[BookAuthors]  WITH CHECK ADD  CONSTRAINT [FK_BookAuthors_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[BookAuthors] CHECK CONSTRAINT [FK_BookAuthors_Product]
GO
ALTER TABLE [dbo].[BookDetails]  WITH CHECK ADD  CONSTRAINT [FK_BookDetails_Language] FOREIGN KEY([LanguageCode])
REFERENCES [dbo].[Languages] ([LanguageCode])
GO
ALTER TABLE [dbo].[BookDetails] CHECK CONSTRAINT [FK_BookDetails_Language]
GO
ALTER TABLE [dbo].[BookDetails]  WITH CHECK ADD  CONSTRAINT [FK_BookDetails_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BookDetails] CHECK CONSTRAINT [FK_BookDetails_Product]
GO
ALTER TABLE [dbo].[CartItems]  WITH CHECK ADD  CONSTRAINT [FK_CartItems_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[CartItems] CHECK CONSTRAINT [FK_CartItems_Product]
GO
ALTER TABLE [dbo].[CartItems]  WITH CHECK ADD  CONSTRAINT [FK_CartItems_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[CartItems] CHECK CONSTRAINT [FK_CartItems_User]
GO
ALTER TABLE [dbo].[Category]  WITH CHECK ADD  CONSTRAINT [FK_Categories_VAT] FOREIGN KEY([VATCode])
REFERENCES [dbo].[VAT] ([VATCode])
GO
ALTER TABLE [dbo].[Category] CHECK CONSTRAINT [FK_Categories_VAT]
GO
ALTER TABLE [dbo].[FlashSaleItems]  WITH CHECK ADD  CONSTRAINT [FK_FSI_FlashSale] FOREIGN KEY([FlashSaleID])
REFERENCES [dbo].[FlashSales] ([FlashSaleID])
GO
ALTER TABLE [dbo].[FlashSaleItems] CHECK CONSTRAINT [FK_FSI_FlashSale]
GO
ALTER TABLE [dbo].[FlashSaleItems]  WITH CHECK ADD  CONSTRAINT [FK_FSI_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[FlashSaleItems] CHECK CONSTRAINT [FK_FSI_Product]
GO
ALTER TABLE [dbo].[OrderItems]  WITH CHECK ADD  CONSTRAINT [FK_OrderItems_Flash] FOREIGN KEY([FlashSaleItemID])
REFERENCES [dbo].[FlashSaleItems] ([FlashSaleItemID])
GO
ALTER TABLE [dbo].[OrderItems] CHECK CONSTRAINT [FK_OrderItems_Flash]
GO
ALTER TABLE [dbo].[OrderItems]  WITH CHECK ADD  CONSTRAINT [FK_OrderItems_OrderShop] FOREIGN KEY([OrderShopID])
REFERENCES [dbo].[OrderShops] ([OrderShopID])
GO
ALTER TABLE [dbo].[OrderItems] CHECK CONSTRAINT [FK_OrderItems_OrderShop]
GO
ALTER TABLE [dbo].[OrderItems]  WITH CHECK ADD  CONSTRAINT [FK_OrderItems_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[OrderItems] CHECK CONSTRAINT [FK_OrderItems_Product]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Address] FOREIGN KEY([AddressID])
REFERENCES [dbo].[Addresses] ([AddressID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Address]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_User]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_VoucherDiscount] FOREIGN KEY([VoucherDiscountID])
REFERENCES [dbo].[Vouchers] ([VoucherID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_VoucherDiscount]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_VoucherShip] FOREIGN KEY([VoucherShipID])
REFERENCES [dbo].[Vouchers] ([VoucherID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_VoucherShip]
GO
ALTER TABLE [dbo].[OrderShops]  WITH CHECK ADD  CONSTRAINT [FK_OrderShops_Order] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[OrderShops] CHECK CONSTRAINT [FK_OrderShops_Order]
GO
ALTER TABLE [dbo].[OrderShops]  WITH CHECK ADD  CONSTRAINT [FK_OrderShops_Shop] FOREIGN KEY([ShopID])
REFERENCES [dbo].[Shops] ([ShopID])
GO
ALTER TABLE [dbo].[OrderShops] CHECK CONSTRAINT [FK_OrderShops_Shop]
GO
ALTER TABLE [dbo].[OrderShops]  WITH CHECK ADD  CONSTRAINT [FK_OrderShops_Voucher] FOREIGN KEY([VoucherID])
REFERENCES [dbo].[Vouchers] ([VoucherID])
GO
ALTER TABLE [dbo].[OrderShops] CHECK CONSTRAINT [FK_OrderShops_Voucher]
GO
ALTER TABLE [dbo].[Payments]  WITH CHECK ADD  CONSTRAINT [FK_Payments_Order] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[Payments] CHECK CONSTRAINT [FK_Payments_Order]
GO
ALTER TABLE [dbo].[ProductCategory]  WITH CHECK ADD  CONSTRAINT [FK_ProductCategory_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([CategoryID])
GO
ALTER TABLE [dbo].[ProductCategory] CHECK CONSTRAINT [FK_ProductCategory_Category]
GO
ALTER TABLE [dbo].[ProductCategory]  WITH CHECK ADD  CONSTRAINT [FK_ProductCategory_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[ProductCategory] CHECK CONSTRAINT [FK_ProductCategory_Product]
GO
ALTER TABLE [dbo].[ProductImages]  WITH CHECK ADD  CONSTRAINT [FK_ProductImages_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[ProductImages] CHECK CONSTRAINT [FK_ProductImages_Product]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Publisher] FOREIGN KEY([PublisherID])
REFERENCES [dbo].[Publishers] ([PublisherID])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Publisher]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Shop] FOREIGN KEY([ShopID])
REFERENCES [dbo].[Shops] ([ShopID])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Shop]
GO
ALTER TABLE [dbo].[ReviewImages]  WITH CHECK ADD  CONSTRAINT [FK_ReviewImages_Review] FOREIGN KEY([ReviewID])
REFERENCES [dbo].[Reviews] ([ReviewID])
GO
ALTER TABLE [dbo].[ReviewImages] CHECK CONSTRAINT [FK_ReviewImages_Review]
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD  CONSTRAINT [FK_Reviews_OrderItem] FOREIGN KEY([OrderItemID])
REFERENCES [dbo].[OrderItems] ([OrderItemID])
GO
ALTER TABLE [dbo].[Reviews] CHECK CONSTRAINT [FK_Reviews_OrderItem]
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD  CONSTRAINT [FK_Reviews_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Reviews] CHECK CONSTRAINT [FK_Reviews_User]
GO
ALTER TABLE [dbo].[Shops]  WITH CHECK ADD  CONSTRAINT [FK_Shops_Owner] FOREIGN KEY([OwnerUserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Shops] CHECK CONSTRAINT [FK_Shops_Owner]
GO
ALTER TABLE [dbo].[Shops]  WITH CHECK ADD  CONSTRAINT [FK_Shops_PickupAddr] FOREIGN KEY([PickupAddressID])
REFERENCES [dbo].[Addresses] ([AddressID])
GO
ALTER TABLE [dbo].[Shops] CHECK CONSTRAINT [FK_Shops_PickupAddr]
GO
ALTER TABLE [dbo].[Shops]  WITH CHECK ADD  CONSTRAINT [FK_Shops_Status] FOREIGN KEY([Status])
REFERENCES [dbo].[ShopStatus] ([StatusCode])
GO
ALTER TABLE [dbo].[Shops] CHECK CONSTRAINT [FK_Shops_Status]
GO
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD  CONSTRAINT [FK_UserRoles_Roles] FOREIGN KEY([RoleCode])
REFERENCES [dbo].[Roles] ([RoleCode])
GO
ALTER TABLE [dbo].[UserRoles] CHECK CONSTRAINT [FK_UserRoles_Roles]
GO
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD  CONSTRAINT [FK_UserRoles_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[UserRoles] CHECK CONSTRAINT [FK_UserRoles_Users]
GO
ALTER TABLE [dbo].[Users_Addresses]  WITH CHECK ADD  CONSTRAINT [FK_UsersAddr_Address] FOREIGN KEY([AddressID])
REFERENCES [dbo].[Addresses] ([AddressID])
GO
ALTER TABLE [dbo].[Users_Addresses] CHECK CONSTRAINT [FK_UsersAddr_Address]
GO
ALTER TABLE [dbo].[Users_Addresses]  WITH CHECK ADD  CONSTRAINT [FK_UsersAddr_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Users_Addresses] CHECK CONSTRAINT [FK_UsersAddr_Users]
GO
ALTER TABLE [dbo].[UserVouchers]  WITH CHECK ADD  CONSTRAINT [FK_UserVouchers_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[UserVouchers] CHECK CONSTRAINT [FK_UserVouchers_User]
GO
ALTER TABLE [dbo].[UserVouchers]  WITH CHECK ADD  CONSTRAINT [FK_UserVouchers_Voucher] FOREIGN KEY([VoucherID])
REFERENCES [dbo].[Vouchers] ([VoucherID])
GO
ALTER TABLE [dbo].[UserVouchers] CHECK CONSTRAINT [FK_UserVouchers_Voucher]
GO
ALTER TABLE [dbo].[Vouchers]  WITH CHECK ADD  CONSTRAINT [FK_Vouchers_Shop] FOREIGN KEY([ShopID])
REFERENCES [dbo].[Shops] ([ShopID])
GO
ALTER TABLE [dbo].[Vouchers] CHECK CONSTRAINT [FK_Vouchers_Shop]
GO
ALTER TABLE [dbo].[AccountBalances]  WITH CHECK ADD CHECK  (([OwnerType]='SHOP' OR [OwnerType]='ADMIN'))
GO
USE [master]
GO
ALTER DATABASE [online-bookstore-dbserver] SET  READ_WRITE 
GO
