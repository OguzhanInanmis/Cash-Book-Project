USE [master]
GO
/****** Object:  Database [Defter]    Script Date: 4.07.2022 16:42:33 ******/
CREATE DATABASE [Defter]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Defter', FILENAME = N'C:\Users\admin\Defter.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Defter_log', FILENAME = N'C:\Users\admin\Defter_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Defter] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Defter].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Defter] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Defter] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Defter] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Defter] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Defter] SET ARITHABORT OFF 
GO
ALTER DATABASE [Defter] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Defter] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Defter] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Defter] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Defter] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Defter] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Defter] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Defter] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Defter] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Defter] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Defter] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Defter] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Defter] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Defter] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Defter] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Defter] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [Defter] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Defter] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Defter] SET  MULTI_USER 
GO
ALTER DATABASE [Defter] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Defter] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Defter] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Defter] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Defter] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Defter] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Defter] SET QUERY_STORE = OFF
GO
USE [Defter]
GO
/****** Object:  Table [dbo].[Defter]    Script Date: 4.07.2022 16:42:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Defter](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Aciklama] [nvarchar](max) NOT NULL,
	[Tur] [nvarchar](max) NOT NULL,
	[GirenMiktar] [real] NOT NULL,
	[CikanMiktar] [real] NOT NULL,
	[Tarih] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Defter] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[ViewDefter]    Script Date: 4.07.2022 16:42:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ViewDefter]
AS
SELECT        Id, Aciklama, Tur, GirenMiktar, CikanMiktar, Tarih
FROM            dbo.Defter
GO
/****** Object:  View [dbo].[View_1]    Script Date: 4.07.2022 16:42:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_1]
AS
SELECT        Id, Aciklama, Tur, GirenMiktar, CikanMiktar, Tarih
FROM            dbo.Defter
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 4.07.2022 16:42:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[proc_devir]    Script Date: 4.07.2022 16:42:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[proc_devir]
	@islem			nvarchar(50)

AS
BEGIN
	if(@islem='Liste')
	begin
		Select * From Defter

	end
	
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_filtrele_tarih]    Script Date: 4.07.2022 16:42:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_filtrele_tarih]
	@islem			nvarchar(50),
	@id				int,
	@bas			nvarchar(50),
	@son			nvarchar(50)
AS
BEGIN
	if(@islem='Liste')
	begin
		Select * From Defter
		Where (ID=@id or @id=0)
	end
	else if(@islem='ListeCikan')
	begin
		Select * From Defter
		--Where tur='çıkan' 
		where Tur = 'cikan'
	end
	else if(@islem='ListeGiren')
	begin
		Select * From Defter
		Where tur='giren'
	end
	else if(@islem='TarihListelecikan')
	begin
		select * from Defter where Tarih between @bas and @son and Tur='cikan'
	end
	else if(@islem='TarihListelegiren')
	begin
		select * from Defter where Tarih between @bas and @son and Tur='giren'
	end
	else if(@islem='TarihListele')
	begin
		select * from Defter where Tarih between @bas and @son
	end

END




GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Defter"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 2
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Defter"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewDefter'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewDefter'
GO
USE [master]
GO
ALTER DATABASE [Defter] SET  READ_WRITE 
GO
