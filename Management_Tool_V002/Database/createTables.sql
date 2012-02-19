USE [MTDB]

DROP TABLE mtdb.dbo.addresses
DROP TABLE mtdb.dbo.dictionary 
DROP TABLE mtdb.dbo.persons
DROP TABLE mtdb.dbo.phones
DROP TABLE mtdb.dbo.mtdb_reference
DROP TABLE mtdb.dbo.rights
DROP TABLE mtdb.dbo.roles
DROP TABLE mtdb.dbo.users
DROP TABLE mtdb.dbo.www
DROP TABLE mtdb.dbo.articles
DROP TABLE mtdb.dbo.article_groups
DROP TABLE mtdb.dbo.inventory_positions
/*
IF EXISTS (select * from [mtdb].[dbo].[addresses]) DROP TABLE [mtdb].[dbo].[addresses]
IF EXISTS (select * from mtdb.dbo.dictionary) DROP TABLE mtdb.dbo.dictionary 
IF EXISTS (select * from mtdb.dbo.persons) DROP TABLE mtdb.dbo.persons
IF EXISTS (select * from mtdb.dbo.phones) DROP TABLE mtdb.dbo.phones
IF EXISTS (select * from mtdb.dbo.mtdb_reference) DROP TABLE mtdb.dbo.mtdb_reference
IF EXISTS (select * from mtdb.dbo.rights) DROP TABLE mtdb.dbo.rights
IF EXISTS (select * from mtdb.dbo.roles) DROP TABLE mtdb.dbo.roles
IF EXISTS (select * from mtdb.dbo.users) DROP TABLE mtdb.dbo.users
IF EXISTS (select * from mtdb.dbo.www) DROP TABLE mtdb.dbo.www
*/

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE TABLE [dbo].[phones](
  [ph_id] INT NOT NULL IDENTITY,
  [ph_adr_id] INT NULL  ,
  [ph_pe_id] INT NULL  ,
  [ph_us_id] INT NULL  ,
  [ph_phoneType] INT NOT NULL ,
  [ph_areaCode] VARCHAR(10) NULL  ,
  [ph_phone] INT NOT NULL ,
  [ph_deleted] INT NULL  ,
  [ph_date_inserted] DATETIME NOT NULL ,
  [ph_us_id_inserted] INT NOT NULL ,
  [ph_date_modified] DATETIME NULL  ,
  [ph_us_id_modified] INT NULL  ,
  [ph_date_deleted] DATETIME NULL  ,
  [ph_us_id_deleted] INT NULL    

  CONSTRAINT [ph_pk] PRIMARY KEY CLUSTERED
(
	[ph_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [ph_uk] UNIQUE NONCLUSTERED
(
	[ph_adr_id],[ph_areaCode],[ph_phone] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[phones] ADD  DEFAULT (0) FOR [ph_us_id_inserted]
GO
ALTER TABLE [dbo].[phones] ADD  DEFAULT (getdate()) FOR [ph_date_inserted]
GO
ALTER TABLE [dbo].[phones] ADD  DEFAULT (getdate()) FOR [ph_date_modified]
GO



CREATE TABLE [dbo].[addresses](
  adr_id INT NOT NULL IDENTITY,
  adr_type INT NOT NULL ,
  adr_name VARCHAR(255) NOT NULL ,
  adr_firstname VARCHAR(255) NULL,
  adr_street VARCHAR(255) NULL  ,
  adr_hno VARCHAR(10) NULL  ,
  adr_zip INT NULL  ,
  adr_city VARCHAR(255) NULL  ,
  adr_countryCode VARCHAR(255) NOT NULL ,
  adr_comment VARCHAR(500) NULL  ,
  adr_deleted INT NULL  ,
  adr_date_inserted DATETIME NOT NULL ,
  adr_us_id_inserted INT NOT NULL ,
  adr_date_modified DATETIME NULL  ,
  adr_us_id_modified INT NULL  ,
  adr_date_deleted DATETIME NULL  ,
  adr_us_id_deleted INT NULL  
  CONSTRAINT [adr_pk] PRIMARY KEY CLUSTERED
(
	[adr_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [adr_uk] UNIQUE NONCLUSTERED
(
	[adr_type],[adr_name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[addresses] ADD  DEFAULT (0) FOR [adr_us_id_inserted]
GO
ALTER TABLE [dbo].[addresses] ADD  DEFAULT (getdate()) FOR [adr_date_inserted]
GO
ALTER TABLE [dbo].[addresses] ADD  DEFAULT (getdate()) FOR [adr_date_modified]
GO
  
CREATE TABLE [dbo].[www](
  [www_id] INT NOT NULL IDENTITY,
  [www_adr_id] INT NULL ,
  [www_pe_id] INT NULL ,
  [www_us_id] INT NULL ,
  [www_Type] INT NOT NULL ,
  [www_value] VARCHAR(255) NOT NULL ,
  [www_deleted] INT NULL  ,
  [www_date_inserted] DATETIME NOT NULL ,
  [www_us_id_inserted] INT NOT NULL ,
  [www_date_modified] DATETIME NULL ,
  [www_us_id_modified] INT NULL ,
  [www_date_deleted] DATETIME NULL ,
  [www_us_id_deleted] INT NULL 
  CONSTRAINT [www_pk] PRIMARY KEY CLUSTERED
(
	[www_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [www_uk] UNIQUE NONCLUSTERED
(
	[www_value] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[www] ADD  DEFAULT (0) FOR [www_us_id_inserted]
GO
ALTER TABLE [dbo].[www] ADD  DEFAULT (getdate()) FOR [www_date_inserted]
GO
ALTER TABLE [dbo].[www] ADD  DEFAULT (getdate()) FOR [www_date_modified]
GO

  
 
CREATE TABLE [dbo].[users](
  [us_id] INT NOT NULL IDENTITY  ,
  [us_sex] INT NOT NULL,
  [us_name] VARCHAR(255) NULL ,
  [us_firstname] VARCHAR(255) NULL ,
  [us_username] VARCHAR(255) NOT NULL ,
  [us_password] VARCHAR(255) NOT NULL ,
  [us_deleted] INT NOT NULL ,
  [us_date_inserted] DATETIME NOT NULL ,
  [us_us_id_inserted] INT NOT NULL ,
  [us_date_modified] DATETIME NULL ,
  [us_us_id_modified] INT NULL ,
  [us_date_deleted] DATETIME NULL ,
  [us_us_id_deleted] INT NULL 
 CONSTRAINT [us_pk] PRIMARY KEY CLUSTERED 
(
	[us_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [us_uk] UNIQUE NONCLUSTERED 
(
	[us_name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (0) FOR [us_us_id_inserted]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (getdate()) FOR [us_date_inserted]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (getdate()) FOR [us_date_modified]
GO

CREATE TABLE [dbo].[rights](
  [ri_id] INT NOT NULL IDENTITY  ,
  [ri_name] VARCHAR(45) NOT NULL ,
  [ri_ro_id] INT NULL ,
  [ri_deleted] INT NULL ,
  [ri_date_inserted] DATETIME NOT NULL ,
  [ri_us_id_inserted] INT NOT NULL ,
  [ri_date_modified] DATETIME NULL ,
  [ri_us_id_modified] INT NULL ,
  [ri_date_deleted] DATETIME NULL ,
  [ri_us_id_deleted] INT NULL 
 CONSTRAINT [ri_pk] PRIMARY KEY CLUSTERED 
(
	[ri_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [ri_uk] UNIQUE NONCLUSTERED 
(
	[ri_name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[rights] ADD  DEFAULT (0) FOR [ri_us_id_inserted]
GO
ALTER TABLE [dbo].[rights] ADD  DEFAULT (getdate()) FOR [ri_date_inserted]
GO
ALTER TABLE [dbo].[rights] ADD  DEFAULT (getdate()) FOR [ri_date_modified]
GO


CREATE TABLE [dbo].[roles](
	[ro_id] INT NOT NULL IDENTITY,
	[ro_name] VARCHAR(45) NULL ,
	[ro_us_id] INT NULL ,
	[ro_deleted] INT NULL ,
	[ro_date_inserted] DATETIME NOT NULL ,
	[ro_us_id_inserted] INT NOT NULL ,
	[ro_date_modified] DATETIME NULL ,
	[ro_us_id_modified] INT NULL ,
	[ro_date_deleted] DATETIME NULL ,
	[ro_us_id_deleted] INT NULL 
 CONSTRAINT [ro_pk] PRIMARY KEY CLUSTERED 
(
	[ro_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [ro_uk] UNIQUE NONCLUSTERED 
(
	[ro_name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[roles] ADD  DEFAULT (0) FOR [ro_us_id_inserted]
GO
ALTER TABLE [dbo].[roles] ADD  DEFAULT (getdate()) FOR [ro_date_inserted]
GO
ALTER TABLE [dbo].[roles] ADD  DEFAULT (getdate()) FOR [ro_date_modified]
GO

CREATE TABLE [dbo].[persons](
	[pe_id] [int] NOT NULL IDENTITY,
	[pe_type] INT NOT NULL ,
	[pe_adr_id] INT NULL  ,
	[pe_name] VARCHAR(255) NOT NULL ,
	[pe_firstname] VARCHAR(255) NULL ,
	[pe_street] VARCHAR(255) NULL ,
	[pe_hno] VARCHAR(10) NULL ,
	[pe_zip] INT NULL ,
	[pe_city] VARCHAR(255) NULL ,
	[pe_countryCode] VARCHAR(255) NOT NULL ,
	[pe_deleted] INT NULL  ,
	[pe_date_inserted] DATETIME NOT NULL ,
	[pe_us_id_inserted] INT NOT NULL ,
	[pe_date_modified] DATETIME NULL ,
	[pe_us_id_modified] INT NULL ,
	[pe_date_deleted] DATETIME NULL ,
	[pe_us_id_deleted] INT NULL 
CONSTRAINT [pe_pk] PRIMARY KEY CLUSTERED 
(
	[pe_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [pe_uk] UNIQUE NONCLUSTERED 
(
	[pe_type],[pe_adr_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[persons] ADD  DEFAULT (0) FOR [pe_us_id_inserted]
GO
ALTER TABLE [dbo].[persons] ADD  DEFAULT (getdate()) FOR [pe_date_inserted]
GO
ALTER TABLE [dbo].[persons] ADD  DEFAULT (getdate()) FOR [pe_date_modified]
GO

CREATE TABLE [dbo].[dictionary](
	[dict_id] [int] NOT NULL IDENTITY,
	[dict_name]  VARCHAR(255) NOT NULL 
 CONSTRAINT [dict_pk] PRIMARY KEY CLUSTERED 
(
	[dict_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [dict_uk] UNIQUE NONCLUSTERED 
(
	[dict_name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


CREATE TABLE [dbo].[mtdb_reference](
	[re_id] [int] NOT NULL IDENTITY,
	[re_dict_id] [int] NOT NULL,
	[re_name] VARCHAR(255) NOT NULL ,
	[re_deleted]  INT NULL ,
	[re_date_inserted]  DATETIME NOT NULL ,
	[re_us_id_inserted]  INT NOT NULL ,
	[re_date_modified]  DATETIME NULL ,
	[re_us_id_modified]  INT NULL ,
	[re_date_deleted]  DATETIME NULL ,
	[re_us_id_deleted]  INT NULL 
 CONSTRAINT [re_pk] PRIMARY KEY CLUSTERED 
(
	[re_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [re_uk] UNIQUE NONCLUSTERED 
(
	[re_name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[mtdb_reference] ADD  DEFAULT (0) FOR [re_us_id_inserted]
GO
ALTER TABLE [dbo].[mtdb_reference] ADD  DEFAULT (getdate()) FOR [re_date_inserted]
GO
ALTER TABLE [dbo].[mtdb_reference] ADD  DEFAULT (getdate()) FOR [re_date_modified]
GO

CREATE TABLE [dbo].[articles](
	[ar_id] [int] NOT NULL IDENTITY, 
	[ar_nr] [int] NOT NULL, --Artikelnummer
	[ar_ag_id] INT NOT NULL, --Artikelgruppe
	[ar_iv_id] INT NULL, --Lagerposition
	[ar_adr_id] INT NULL, --Lieferant
	[ar_cnt] INT NOT NULL, --Bestand Artikel
	[ar_name] VARCHAR(255) NOT NULL ,
	[ar_price] INT NOT NULL,
	[ar_picturePath] VARCHAR(255) NULL, 
	[ar_barcode] VARCHAR(255) NULL,
	[ar_description] VARCHAR(255) NULL,
	[ar_deleted]  INT NULL ,
	[ar_date_inserted]  DATETIME NOT NULL ,
	[ar_us_id_inserted]  INT NOT NULL ,
	[ar_date_modified]  DATETIME NULL ,
	[ar_us_id_modified]  INT NULL ,
	[ar_date_deleted]  DATETIME NULL ,
	[ar_us_id_deleted]  INT NULL 
 CONSTRAINT [ar_pk] PRIMARY KEY CLUSTERED 
(
	[ar_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [ar_uk] UNIQUE NONCLUSTERED 
(
	[ar_nr] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[articles] ADD  DEFAULT (0) FOR [ar_us_id_inserted]
GO
ALTER TABLE [dbo].[articles] ADD  DEFAULT (getdate()) FOR [ar_date_inserted]
GO
ALTER TABLE [dbo].[articles] ADD  DEFAULT (getdate()) FOR [ar_date_modified]
GO

CREATE TABLE [dbo].[article_groups](
	[ag_id] [int] NOT NULL IDENTITY,
	[ag_name] VARCHAR(255) NOT NULL ,
	[ag_description] VARCHAR(255) NULL,
	[ag_deleted]  INT NULL ,
	[ag_date_inserted]  DATETIME NOT NULL ,
	[ag_us_id_inserted]  INT NOT NULL ,
	[ag_date_modified]  DATETIME NULL ,
	[ag_us_id_modified]  INT NULL ,
	[ag_date_deleted]  DATETIME NULL ,
	[ag_us_id_deleted]  INT NULL 
 CONSTRAINT [ag_pk] PRIMARY KEY CLUSTERED 
(
	[ag_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [ag_uk] UNIQUE NONCLUSTERED 
(
	[ag_name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[article_groups] ADD  DEFAULT (0) FOR [ag_us_id_inserted]
GO
ALTER TABLE [dbo].[article_groups] ADD  DEFAULT (getdate()) FOR [ag_date_inserted]
GO
ALTER TABLE [dbo].[article_groups] ADD  DEFAULT (getdate()) FOR [ag_date_modified]
GO

CREATE TABLE [dbo].[inventory_positions](
	[iv_id] [int] NOT NULL IDENTITY,
	[iv_building] VARCHAR(255) NOT NULL,
	[iv_room] VARCHAR(255) NULL,
	[iv_row] VARCHAR(255) NULL,
	[iv_shelf] VARCHAR(255) NULL,
	[iv_position] VARCHAR(255)NULL,
	[iv_description] VARCHAR(255) NULL,
	[iv_deleted]  INT NULL ,
	[iv_date_inserted]  DATETIME NOT NULL ,
	[iv_us_id_inserted]  INT NOT NULL ,
	[iv_date_modified]  DATETIME NULL ,
	[iv_us_id_modified]  INT NULL ,
	[iv_date_deleted]  DATETIME NULL ,
	[iv_us_id_deleted]  INT NULL 
 CONSTRAINT [iv_pk] PRIMARY KEY CLUSTERED 
(
	[iv_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [iv_uk] UNIQUE NONCLUSTERED 
(
	[iv_building] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[inventory_positions] ADD  DEFAULT (0) FOR [iv_us_id_inserted]
GO
ALTER TABLE [dbo].[inventory_positions] ADD  DEFAULT (getdate()) FOR [iv_date_inserted]
GO
ALTER TABLE [dbo].[inventory_positions] ADD  DEFAULT (getdate()) FOR [iv_date_modified]
GO