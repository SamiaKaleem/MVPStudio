USE [master]
GO
/****** Object:  Database [DWHPropertyAnalysis]    Script Date: 4/15/2020 10:52:27 PM ******/
CREATE DATABASE [DWHPropertyAnalysis]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DWHPropertyAnalysis', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\DWHPropertyAnalysis.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DWHPropertyAnalysis_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\DWHPropertyAnalysis_log.ldf' , SIZE = 139264KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [DWHPropertyAnalysis] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DWHPropertyAnalysis].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DWHPropertyAnalysis] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DWHPropertyAnalysis] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DWHPropertyAnalysis] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DWHPropertyAnalysis] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DWHPropertyAnalysis] SET ARITHABORT OFF 
GO
ALTER DATABASE [DWHPropertyAnalysis] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DWHPropertyAnalysis] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DWHPropertyAnalysis] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DWHPropertyAnalysis] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DWHPropertyAnalysis] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DWHPropertyAnalysis] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DWHPropertyAnalysis] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DWHPropertyAnalysis] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DWHPropertyAnalysis] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DWHPropertyAnalysis] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DWHPropertyAnalysis] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DWHPropertyAnalysis] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DWHPropertyAnalysis] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DWHPropertyAnalysis] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DWHPropertyAnalysis] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DWHPropertyAnalysis] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DWHPropertyAnalysis] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DWHPropertyAnalysis] SET RECOVERY FULL 
GO
ALTER DATABASE [DWHPropertyAnalysis] SET  MULTI_USER 
GO
ALTER DATABASE [DWHPropertyAnalysis] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DWHPropertyAnalysis] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DWHPropertyAnalysis] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DWHPropertyAnalysis] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DWHPropertyAnalysis] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'DWHPropertyAnalysis', N'ON'
GO
ALTER DATABASE [DWHPropertyAnalysis] SET QUERY_STORE = OFF
GO
USE [DWHPropertyAnalysis]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [DWHPropertyAnalysis]
GO
/****** Object:  Table [dbo].[DimAuLocalSchool]    Script Date: 4/15/2020 10:52:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimAuLocalSchool](
	[school_name] [varchar](50) NULL,
	[suburb] [varchar](50) NULL,
	[school_level] [varchar](50) NULL,
	[school_id] [smallint] IDENTITY(1,1) NOT NULL,
	[longitude] [float] NULL,
	[latitude] [float] NULL,
	[state_code] [nchar](10) NULL,
	[location_id] [smallint] NULL,
 CONSTRAINT [PK_DimAuLocalSchool] PRIMARY KEY CLUSTERED 
(
	[school_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimGeography]    Script Date: 4/15/2020 10:52:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimGeography](
	[location_id] [smallint] IDENTITY(1,1) NOT NULL,
	[state] [varchar](50) NULL,
	[city] [varchar](50) NULL,
	[district] [varchar](50) NULL,
	[postcode] [numeric](18, 0) NULL,
	[state_code] [nvarchar](50) NULL,
	[suburb] [varchar](50) NULL,
	[long] [float] NULL,
	[lat] [float] NULL,
 CONSTRAINT [PK_DimGeography] PRIMARY KEY CLUSTERED 
(
	[location_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimState]    Script Date: 4/15/2020 10:52:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimState](
	[DWstatekey] [nchar](10) NOT NULL,
	[state_code] [nchar](10) NULL,
	[state_name] [nvarchar](50) NULL,
 CONSTRAINT [PK_DimState] PRIMARY KEY CLUSTERED 
(
	[DWstatekey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimTransport]    Script Date: 4/15/2020 10:52:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimTransport](
	[stop_id] [numeric](18, 0) NULL,
	[stop_name] [varchar](max) NULL,
	[stop_long] [float] NULL,
	[stop_lat] [float] NULL,
	[mode] [varchar](50) NULL,
	[DWstatekey] [nchar](10) NULL,
	[stop_key] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[suburb] [varchar](50) NULL,
	[location_id] [smallint] NULL,
 CONSTRAINT [PK_DimTransport] PRIMARY KEY CLUSTERED 
(
	[stop_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FactCrimeByYear]    Script Date: 4/15/2020 10:52:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactCrimeByYear](
	[suburb] [varchar](50) NULL,
	[crime] [smallint] NULL,
	[year] [smallint] NULL,
	[state_code] [nchar](10) NULL,
	[FactCrimeID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[location_id] [smallint] NULL,
 CONSTRAINT [PK_FactCrimeByYear] PRIMARY KEY CLUSTERED 
(
	[FactCrimeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FactMedianPropertyByYear]    Script Date: 4/15/2020 10:52:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactMedianPropertyByYear](
	[suburb] [varchar](50) NULL,
	[median] [numeric](18, 0) NULL,
	[Year] [smallint] NULL,
	[propertymedianID] [smallint] IDENTITY(1,1) NOT NULL,
	[location_id] [smallint] NULL,
	[state_code] [nchar](10) NULL,
 CONSTRAINT [PK_FactMedianPropertyByYear] PRIMARY KEY CLUSTERED 
(
	[propertymedianID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FactSuburbRentalMedian]    Script Date: 4/15/2020 10:52:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactSuburbRentalMedian](
	[location_id] [smallint] NULL,
	[BR1_Flat] [float] NULL,
	[BR2_Flat] [float] NULL,
	[BR3_Flat] [float] NULL,
	[BR4_Flat] [float] NULL,
	[BR1_House] [float] NULL,
	[BR2_House] [float] NULL,
	[BR3_House] [float] NULL,
	[BR4_House] [float] NULL,
	[FactRentalMedianID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[suburb] [varchar](50) NULL,
	[state_code] [nchar](10) NULL,
 CONSTRAINT [PK_FactSuburbRentalMedian_1] PRIMARY KEY CLUSTERED 
(
	[FactRentalMedianID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DimAuLocalSchool]  WITH CHECK ADD  CONSTRAINT [FK_DimAuLocalSchool_DimGeography] FOREIGN KEY([location_id])
REFERENCES [dbo].[DimGeography] ([location_id])
GO
ALTER TABLE [dbo].[DimAuLocalSchool] CHECK CONSTRAINT [FK_DimAuLocalSchool_DimGeography]
GO
ALTER TABLE [dbo].[DimTransport]  WITH CHECK ADD  CONSTRAINT [FK_DimTransport_DimGeography] FOREIGN KEY([location_id])
REFERENCES [dbo].[DimGeography] ([location_id])
GO
ALTER TABLE [dbo].[DimTransport] CHECK CONSTRAINT [FK_DimTransport_DimGeography]
GO
ALTER TABLE [dbo].[FactCrimeByYear]  WITH CHECK ADD  CONSTRAINT [FK_FactCrimeByYear_DimGeography] FOREIGN KEY([location_id])
REFERENCES [dbo].[DimGeography] ([location_id])
GO
ALTER TABLE [dbo].[FactCrimeByYear] CHECK CONSTRAINT [FK_FactCrimeByYear_DimGeography]
GO
ALTER TABLE [dbo].[FactMedianPropertyByYear]  WITH CHECK ADD  CONSTRAINT [FK_FactMedianPropertyByYear_DimGeography] FOREIGN KEY([location_id])
REFERENCES [dbo].[DimGeography] ([location_id])
GO
ALTER TABLE [dbo].[FactMedianPropertyByYear] CHECK CONSTRAINT [FK_FactMedianPropertyByYear_DimGeography]
GO
ALTER TABLE [dbo].[FactSuburbRentalMedian]  WITH CHECK ADD  CONSTRAINT [FK_FactSuburbRentalMedian_DimGeography] FOREIGN KEY([location_id])
REFERENCES [dbo].[DimGeography] ([location_id])
GO
ALTER TABLE [dbo].[FactSuburbRentalMedian] CHECK CONSTRAINT [FK_FactSuburbRentalMedian_DimGeography]
GO
USE [master]
GO
ALTER DATABASE [DWHPropertyAnalysis] SET  READ_WRITE 
GO
