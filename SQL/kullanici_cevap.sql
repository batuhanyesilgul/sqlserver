USE [anket]
GO

/****** Object:  Table [dbo].[KULLANICI_CEVAP]    Script Date: 13.03.2020 08:34:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[KULLANICI_CEVAP](
	[kullanici_cevapid] [int] NULL,
	[cevapid] [int] NULL,
	[kullaniciid] [int] NULL,
	[karsilik] [nvarchar](10) NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[KULLANICI_CEVAP]  WITH CHECK ADD  CONSTRAINT [FK_KULLANICI_CEVAP_CEVAP] FOREIGN KEY([cevapid])
REFERENCES [dbo].[CEVAP] ([cevapid])
GO

ALTER TABLE [dbo].[KULLANICI_CEVAP] CHECK CONSTRAINT [FK_KULLANICI_CEVAP_CEVAP]
GO

