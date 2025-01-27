USE [financial_data_warehouse]
GO

/****** Object:  Table [dbo].[financial_transactions]    Script Date: 13-01-2025 19:49:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[financial_transactions](
	[transaction_id] [int] NOT NULL,
	[customer_id] [int] NULL,
	[supplier_name] [varchar](20) NULL,
	[transaction_date] [date] NULL,
	[amount] [decimal](10, 2) NULL,
	[currency] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[transaction_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
USE [financial_data_warehouse]
ALTER TABLE financial_transactions
ADD 
    customer_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20);
select * from financial_transactions;
--TRUNCATE TABLE [dbo].[financial_transactions]; created SQL data flow , before every load from source to target , data is truncated


CREATE TABLE dbo.exchange_rates
(
from_currency VARCHAR(10),
to_currency VARCHAR(10),
exchange_rate FLOAT,
effective_date DATE
);

CREATE TABLE dbo.suppliers
(
supplier_id int,
supplier_name VARCHAR(100),
contact_name VARCHAR(100),
phone VARCHAR(25)
)
USE [financial_data_warehouse]
select * from financial_transactions;
select * from dbo.exchange_rates;
select * from dbo.suppliers;

ALTER TABLE financial_transactions
ADD amount_USD float;

select * from financial_transactions;

ALTER TABLE financial_transactions
ADD amount_USD float;

ALTER TABLE financial_transactions
ADD supplier_contact_name VARCHAR(100),
	supplier_phone VARCHAR(25);

ALTER TABLE financial_transactions
ALTER COLUMN supplier_contact_name VARCHAR(100);

USE [financial_data_warehouse]
select * from financial_transactions;
select * from suppliers;

