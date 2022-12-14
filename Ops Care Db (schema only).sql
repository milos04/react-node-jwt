USE [OpsCare]
GO
/****** Object:  User [KOM\Ajay.DANIEL]    Script Date: 19/8/2022 10:45:00 am ******/
CREATE USER [KOM\Ajay.DANIEL] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [KOM\ChengChing.Thu]    Script Date: 19/8/2022 10:45:00 am ******/
CREATE USER [KOM\ChengChing.Thu] FOR LOGIN [KOM\ChengChing.Thu] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [KOM\ChuanHuat.Cheong]    Script Date: 19/8/2022 10:45:00 am ******/
CREATE USER [KOM\ChuanHuat.Cheong] FOR LOGIN [KOM\ChuanHuat.Cheong] WITH DEFAULT_SCHEMA=[guest]
GO
/****** Object:  User [KOM\EngKheng.TEOH]    Script Date: 19/8/2022 10:45:00 am ******/
CREATE USER [KOM\EngKheng.TEOH] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [KOM\KuayYeng.LAI]    Script Date: 19/8/2022 10:45:00 am ******/
CREATE USER [KOM\KuayYeng.LAI] FOR LOGIN [KOM\KuayYeng.LAI] WITH DEFAULT_SCHEMA=[guest]
GO
/****** Object:  User [KOM\maylin.lai]    Script Date: 19/8/2022 10:45:00 am ******/
CREATE USER [KOM\maylin.lai] FOR LOGIN [KOM\maylin.lai] WITH DEFAULT_SCHEMA=[guest]
GO
/****** Object:  User [KOM\Norazura.Baharom]    Script Date: 19/8/2022 10:45:00 am ******/
CREATE USER [KOM\Norazura.Baharom] FOR LOGIN [KOM\Norazura.Baharom] WITH DEFAULT_SCHEMA=[guest]
GO
/****** Object:  User [KOM\SA-KOM-OpsCare]    Script Date: 19/8/2022 10:45:00 am ******/
CREATE USER [KOM\SA-KOM-OpsCare] FOR LOGIN [KOM\SA-KOM-OpsCare] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [KOM\ShiKai.NG]    Script Date: 19/8/2022 10:45:00 am ******/
CREATE USER [KOM\ShiKai.NG] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [KOM\Tirta.NAHARI]    Script Date: 19/8/2022 10:45:00 am ******/
CREATE USER [KOM\Tirta.NAHARI] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [opscare]    Script Date: 19/8/2022 10:45:00 am ******/
CREATE USER [opscare] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [wfmobilekomapi]    Script Date: 19/8/2022 10:45:00 am ******/
CREATE USER [wfmobilekomapi] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [KOM\Ajay.DANIEL]
GO
ALTER ROLE [db_datareader] ADD MEMBER [KOM\Ajay.DANIEL]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [KOM\Ajay.DANIEL]
GO
ALTER ROLE [db_owner] ADD MEMBER [KOM\ChengChing.Thu]
GO
ALTER ROLE [db_datareader] ADD MEMBER [KOM\ChengChing.Thu]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [KOM\ChengChing.Thu]
GO
ALTER ROLE [db_datareader] ADD MEMBER [KOM\EngKheng.TEOH]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [KOM\EngKheng.TEOH]
GO
ALTER ROLE [db_owner] ADD MEMBER [KOM\SA-KOM-OpsCare]
GO
ALTER ROLE [db_accessadmin] ADD MEMBER [KOM\SA-KOM-OpsCare]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [KOM\SA-KOM-OpsCare]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [KOM\SA-KOM-OpsCare]
GO
ALTER ROLE [db_backupoperator] ADD MEMBER [KOM\SA-KOM-OpsCare]
GO
ALTER ROLE [db_datareader] ADD MEMBER [KOM\SA-KOM-OpsCare]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [KOM\SA-KOM-OpsCare]
GO
ALTER ROLE [db_owner] ADD MEMBER [KOM\ShiKai.NG]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [KOM\ShiKai.NG]
GO
ALTER ROLE [db_datareader] ADD MEMBER [opscare]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [opscare]
GO
/****** Object:  Table [dbo].[KPI_HSE_Injury]    Script Date: 19/8/2022 10:45:00 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KPI_HSE_Injury](
	[Nature] [varchar](150) NOT NULL,
	[vYear] [int] NOT NULL,
	[vMonth] [int] NOT NULL,
	[vWeek] [int] NOT NULL,
	[TotalInjury] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_KPI_HSE_Injury]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE view [dbo].[vw_KPI_HSE_Injury]
as

SELECT N.Name AS Nature, YEAR(I.IncidentDate) AS vYear, MONTH(I.IncidentDate) AS vMonth, 
 DATEPART(week, I.IncidentDate) AS vWeek, COUNT(I.InjuryIncidentID) AS TotalInjury
FROM  [10.58.136.245,1399].[iSRPCTR].[dbo].[tblInjuryIncident] I
INNER JOIN [10.58.136.245,1399].[iSRPCTR].[dbo].[tblInjuryIncidentNature] N 
ON I.Nature = N.IncidentNatureID
WHERE BusinessUnitID=3 AND YEAR(I.IncidentDate) > 2018
GROUP BY YEAR(I.IncidentDate), MONTH(I.IncidentDate), DATEPART(week, I.IncidentDate), N.Name

UNION

SELECT Nature, vYear, vMonth, vWeek, TotalInjury
FROM [OpsCare].[dbo].[KPI_HSE_Injury]

GO
/****** Object:  Table [dbo].[KPI_HSE_NearMiss]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KPI_HSE_NearMiss](
	[vYear] [int] NULL,
	[vMonth] [int] NULL,
	[vWeek] [int] NULL,
	[TotalNearMiss] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_KPI_HSE_NearMiss]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE view [dbo].[vw_KPI_HSE_NearMiss]
as

SELECT YEAR(IncidentDate) AS vYear, MONTH(IncidentDate) AS vMonth,DATEPART(week, IncidentDate) AS vWeek, COUNT(InjuryNearMissID) AS TotalNearMiss 
FROM [10.58.136.245,1399].[iSRPCTR].[dbo].[tblInjuryNearMiss]
WHERE BusinessUnitID = 3 AND YEAR(IncidentDate) > 2018
GROUP BY YEAR(IncidentDate), MONTH(IncidentDate), DATEPART(week, IncidentDate)

UNION

SELECT vYear,vMonth,vWeek,TotalNearMiss
FROM [OpsCare].[dbo].[KPI_HSE_NearMiss]


GO
/****** Object:  Table [dbo].[KPI_HSE_Injury_MC]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KPI_HSE_Injury_MC](
	[vYear] [int] NOT NULL,
	[vMonth] [int] NOT NULL,
	[TotalMC] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_KPI_HSE_Injury_MC]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE view [dbo].[vw_KPI_HSE_Injury_MC]
as

SELECT YEAR(I.IncidentDate) AS vYear, MONTH(I.IncidentDate) AS vMonth, SUM(MC) AS TotalMC
  FROM [10.58.136.245,1399].[iSRPCTR].[dbo].[tblInjuryIncident] I 
	INNER JOIN [10.58.136.245,1399].[iSRPCTR].[dbo].[tblInjuryIncidentNature] N 
	ON I.Nature = N.IncidentNatureID
 WHERE N.Name like 'Reportable%' AND BusinessUnitID=3 AND YEAR(I.IncidentDate) > 2018
  GROUP BY  YEAR(I.IncidentDate),MONTH(I.IncidentDate)

  UNION

SELECT vYear, vMonth, TotalMC
FROM [OpsCare].[dbo].[KPI_HSE_Injury_MC]

GO
/****** Object:  Table [dbo].[KPI_HSE_Injury_Reportable]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KPI_HSE_Injury_Reportable](
	[vYear] [int] NOT NULL,
	[vMonth] [int] NOT NULL,
	[TotalReportableCase] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_KPI_HSE_Injury_Reportable]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE view [dbo].[vw_KPI_HSE_Injury_Reportable]
as

SELECT YEAR(I.IncidentDate) AS vYear, MONTH(I.IncidentDate) AS vMonth, COUNT(I.CaseNo) AS TotalReportableCase
  FROM [10.58.136.245,1399].[iSRPCTR].[dbo].[tblInjuryIncident] I  
  INNER JOIN [10.58.136.245,1399].[iSRPCTR].[dbo].[tblInjuryIncidentNature] N  
  ON I.Nature = N.IncidentNatureID
 WHERE N.Name like 'Reportable%' AND BusinessUnitID=3 AND YEAR(I.IncidentDate) > 2018
  GROUP BY  YEAR(I.IncidentDate),MONTH(I.IncidentDate)

  UNION

SELECT vYear, vMonth, TotalReportableCase
FROM [OpsCare].[dbo].[KPI_HSE_Injury_Reportable]

GO
/****** Object:  View [dbo].[KPI_Ops_Daily_Absence_NotUsed]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE view [dbo].[KPI_Ops_Daily_Absence_NotUsed]
as

select WorkDate,Leave,Name,SubContractor,Trade as JCTrade
from [dbo].[KPI_Ops_Daily_Absence_Temp] A inner join [dbo].[KPI_Ops_Contractor_Trade] T
on rtrim(A.SubContractor) = rtrim(T.Company)




GO
/****** Object:  View [dbo].[vw_KPI_HSE_TotalMH]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/** No access currently**/
CREATE view [dbo].[vw_KPI_HSE_TotalMH]
as

SELECT year(fulldate) AS vYear, month(fulldate) AS vMonth, (sum([ActualHour])/1000000) AS TotalManhourinMil
  FROM [10.58.136.245,1399].[WorkForceDW].[dbo].[vwDailyManhour_eWPS]
  where year(fulldate)= year(getdate()) 
  OR year(fulldate)= year(getdate())-1
  group by year(fulldate), month(fulldate)


GO
/****** Object:  View [dbo].[vw_KPI_Subcon_Award]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE view [dbo].[vw_KPI_Subcon_Award]
as

SELECT  COUNT(*) AS SCRTotal, COUNT(JC_SC_Dtl.JobCardID) AS SCRClosed, getdate() AS RetrieveDate
FROM       [10.58.136.245,1399].[iSRPCTR].[dbo].[tbleSCRActivityDetails] SCR_Dtl
			LEFT OUTER JOIN [10.58.136.245,1399].[iSRPCTR].[dbo].[tbleSCRHeader] SCR_Hdr
				ON SCR_Dtl.eSCRHeaderID = SCR_Hdr.eSCRHeaderID
            LEFT OUTER JOIN [10.58.136.245,1399].[iSRPCTR].[dbo].tblWorkOrderDetail WO_Dtl
				ON SCR_Dtl.eSCRActivityDetailID = WO_Dtl.eSCRActivityDetailID 
            LEFT OUTER JOIN [10.58.136.245,1399].[iSRPCTR].[dbo].tblWorkOrderHeader WO_Hdr
				ON WO_Dtl.WOHeaderID = WO_Hdr.WOHeaderID 
            LEFT OUTER JOIN [10.58.136.245,1399].[iSRPCTR].[dbo].tblJobCard JC
				ON WO_Hdr.WOHeaderID = JC.WOHeaderID 
			LEFT OUTER JOIN [10.58.136.245,1399].[iSRPCTR].[dbo].tblJobCardSubCodesDetail JC_SC_Dtl
				ON JC.JobCardID = JC_SC_Dtl.JobCardID 
                AND WO_Dtl.SubCodeID = JC_SC_Dtl.SubCodeID
WHERE datediff(day,SCR_Hdr.RequestDate,getdate()) < 365 --!!! Only get records for last 365 days !!!
AND SCR_Hdr.Status >= 45  --Submitted 
AND SCR_Hdr.Status != 50  --Rejected





GO
/****** Object:  Table [dbo].[Assets]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Assets](
	[assetEntryDataId] [bigint] IDENTITY(1,1) NOT NULL,
	[assetName] [varchar](50) NOT NULL,
	[project] [varchar](50) NOT NULL,
	[assetEntryDateTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[assetEntryDataId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CraneLiftData]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CraneLiftData](
	[row] [int] NOT NULL,
	[timestamp] [datetime] NULL,
	[H1LOAD] [float] NULL,
	[H2LOAD] [float] NULL,
	[SUMH1H2] [float] NULL,
	[H3LOAD] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[datadump]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[datadump](
	[tagname] [varchar](max) NULL,
	[value] [varchar](max) NULL,
	[quality] [varchar](max) NULL,
	[timestamp] [datetime] NULL,
	[id] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GasCheckerAssets]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GasCheckerAssets](
	[assetId] [bigint] IDENTITY(1,1) NOT NULL,
	[assetName] [varchar](50) NOT NULL,
	[dateTime] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[assetId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GasCheckerCurrentData]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GasCheckerCurrentData](
	[indexId] [bigint] IDENTITY(1,1) NOT NULL,
	[assetId] [bigint] NOT NULL,
	[value] [varchar](4000) NOT NULL,
	[receivedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[indexId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GasCheckerData]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GasCheckerData](
	[indexId] [bigint] IDENTITY(1,1) NOT NULL,
	[assetId] [bigint] NOT NULL,
	[value] [varchar](4000) NOT NULL,
	[receivedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[indexId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HistorianCurrentData]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HistorianCurrentData](
	[indexId] [int] IDENTITY(1,1) NOT NULL,
	[tagname] [varchar](255) NOT NULL,
	[value] [varchar](255) NOT NULL,
	[quality] [varchar](255) NOT NULL,
	[timestamp] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HistorianRawData]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HistorianRawData](
	[indexId] [int] IDENTITY(1,1) NOT NULL,
	[tagname] [varchar](255) NOT NULL,
	[value] [varchar](255) NOT NULL,
	[quality] [varchar](255) NOT NULL,
	[timestamp] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KForkLiftBooking]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KForkLiftBooking](
	[id] [bigint] NOT NULL,
	[KForkId] [bigint] NULL,
	[requestorID] [bigint] NULL,
	[JobDescription] [varchar](500) NULL,
	[JsonValueFields] [varchar](4000) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KForkLiftBookingStatus]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KForkLiftBookingStatus](
	[id] [bigint] NOT NULL,
	[status] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KForkLiftCurrentData]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KForkLiftCurrentData](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[JsonValueFields] [varchar](4000) NULL,
	[userid] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KForkLiftServices]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KForkLiftServices](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[DriverID] [bigint] NULL,
	[RequesterID] [bigint] NULL,
	[JsonValueFields] [varchar](4000) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KForkLiftServiceStatus]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KForkLiftServiceStatus](
	[id] [bigint] NOT NULL,
	[status] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KForkLiftStatus]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KForkLiftStatus](
	[id] [bigint] NOT NULL,
	[status] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KForkUser]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KForkUser](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[type] [varchar](30) NULL,
	[username] [varchar](50) NULL,
	[password] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KPI_HSE_MarineIndex]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KPI_HSE_MarineIndex](
	[Name] [varchar](150) NOT NULL,
	[vYear] [int] NOT NULL,
	[Rate] [decimal](18, 2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KPI_HSE_TotalMH]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KPI_HSE_TotalMH](
	[vYear] [int] NOT NULL,
	[vMonth] [int] NOT NULL,
	[TotalManhourinMil] [decimal](18, 2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KPI_Logistics_GoodsIssuance]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KPI_Logistics_GoodsIssuance](
	[sno] [int] IDENTITY(1,1) NOT NULL,
	[matkl] [varchar](50) NOT NULL,
	[count] [int] NOT NULL,
	[metkpi] [int] NOT NULL,
	[timestamp] [datetime] NOT NULL,
 CONSTRAINT [PK_KPI_Logistics_GoodsIssuance] PRIMARY KEY CLUSTERED 
(
	[sno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KPI_Logistics_GoodsReceipt]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KPI_Logistics_GoodsReceipt](
	[sno] [int] IDENTITY(1,1) NOT NULL,
	[matkl] [varchar](50) NOT NULL,
	[count] [int] NOT NULL,
	[metkpi] [int] NOT NULL,
	[timestamp] [datetime] NOT NULL,
 CONSTRAINT [PK_KPI_Logistics_GoodsReceipt] PRIMARY KEY CLUSTERED 
(
	[sno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KPI_Ops_Contractor_Trade(Not Used)]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KPI_Ops_Contractor_Trade(Not Used)](
	[Company] [varchar](500) NOT NULL,
	[Trade] [varchar](150) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KPI_Ops_Daily_Absence]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KPI_Ops_Daily_Absence](
	[WorkDate] [datetime] NULL,
	[Leave] [varchar](100) NOT NULL,
	[Name] [varchar](150) NOT NULL,
	[Skill] [varchar](100) NULL,
	[SubContractor] [varchar](500) NULL,
	[JCTrade] [varchar](150) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KPI_Ops_Daily_Absence_Temp(Not Used)]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KPI_Ops_Daily_Absence_Temp(Not Used)](
	[WorkDate] [datetime] NULL,
	[Leave] [varchar](100) NOT NULL,
	[Name] [varchar](150) NOT NULL,
	[Skill] [varchar](100) NULL,
	[SubContractor] [varchar](500) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KPI_Ops_Daily_Manpower]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KPI_Ops_Daily_Manpower](
	[WorkDate] [datetime] NOT NULL,
	[TotalRCWorkers] [int] NULL,
	[PreAllocatedRCWorkers] [int] NULL,
	[TotalAttendence] [int] NULL,
	[TotalLeave] [int] NULL,
	[Unknown] [int] NULL,
	[Absent] [int] NULL,
	[Standby] [int] NULL,
	[HomeLeave] [int] NULL,
	[OffDay] [int] NULL,
	[AnnualLeave] [int] NULL,
	[HospitalizationLeave] [int] NULL,
	[Training] [int] NULL,
	[SickLeave] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KPI_QA_Inspection_temp]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KPI_QA_Inspection_temp](
	[ProjectNo] [varchar](20) NULL,
	[ProjectName] [varchar](50) NULL,
	[DisciplineCode] [varchar](10) NULL,
	[DisciplineName] [varchar](50) NULL,
	[TotalInspection] [int] NULL,
	[FirstTimeFailInspection] [float] NULL,
	[AcceptIndex] [float] NULL,
	[FirstTimeFailIndex] [float] NULL,
	[FromDate] [varchar](20) NULL,
	[ToDate] [varchar](20) NULL,
	[AI] [float] NULL,
	[FI] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KPI_QA_InspectionPassRate]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KPI_QA_InspectionPassRate](
	[ProjectNo] [varchar](20) NULL,
	[ProjectName] [varchar](50) NULL,
	[DisciplineCode] [varchar](10) NULL,
	[DisciplineName] [varchar](50) NULL,
	[TotalInspection] [int] NULL,
	[FirstTimeFailInspection] [float] NULL,
	[AcceptIndex] [float] NULL,
	[FirstTimeFailIndex] [float] NULL,
	[FromDate] [varchar](20) NULL,
	[ToDate] [varchar](20) NULL,
	[AI] [float] NULL,
	[FI] [float] NULL,
	[ModifiedDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KPI_QA_NDTDefectRate]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KPI_QA_NDTDefectRate](
	[ProjectID] [int] NOT NULL,
	[ProjectNo] [varchar](20) NULL,
	[ProjectName] [varchar](50) NULL,
	[ClassificationDepartmentName] [varchar](50) NULL,
	[NDTMethod] [varchar](200) NULL,
	[TotalInsLength] [int] NULL,
	[TotalDftLength] [int] NULL,
	[DateInsLength] [int] NULL,
	[DateDftLength] [int] NULL,
	[OverallHullInspected] [int] NULL,
	[OverallHullDefect] [int] NULL,
	[PeriodHullInspected] [int] NULL,
	[PeriodHullDefect] [int] NULL,
	[OverallInspected] [int] NULL,
	[OverallDefect] [int] NULL,
	[PeriodInspected] [int] NULL,
	[PeriodDefect] [int] NULL,
	[RTUTHullInspected] [int] NULL,
	[RTUTHullDefect] [int] NULL,
	[PeriodRTUTInsp] [int] NULL,
	[PeriodRTUTDefect] [int] NULL,
	[RTUTPipeInspected] [int] NULL,
	[RTUTPipeDefect] [int] NULL,
	[PeriodRTUTPipeInsp] [int] NULL,
	[PeriodRTUTPipeDefect] [int] NULL,
	[ModifiedDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KPI_QA_PunchList]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KPI_QA_PunchList](
	[ProjectID] [int] NOT NULL,
	[DepartmentID] [int] NULL,
	[DepartmentName] [varchar](1) NULL,
	[IssuedCatA] [int] NULL,
	[IssuedCatB] [int] NULL,
	[IssuedTotal] [int] NULL,
	[ClosedCatA] [int] NULL,
	[ClosedCatB] [int] NULL,
	[ClosedTotal] [int] NULL,
	[OutstgCatA] [int] NULL,
	[OutstgCatB] [int] NULL,
	[OutstgTotal] [int] NULL,
	[LastWeekIssuedCatA] [int] NULL,
	[LastWeekIssuedCatB] [int] NULL,
	[LastWeekIssuedTotal] [int] NULL,
	[LastWeekClosedCatA] [int] NULL,
	[LastWeekClosedCatB] [int] NULL,
	[LastWeekClosedTotal] [int] NULL,
	[LastWeekOutstgCatA] [int] NULL,
	[LastWeekOutstgCatB] [int] NULL,
	[LastWeekOutstgTotal] [int] NULL,
	[ProjectNo] [varchar](1) NULL,
	[ModifiedDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KPI_Security_CasesInvestigated]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KPI_Security_CasesInvestigated](
	[vYear] [int] NULL,
	[vMonth] [varchar](10) NULL,
	[ClosedCaseLT30Days] [int] NULL,
	[ClosedCase] [int] NULL,
	[TotalCases] [int] NULL,
	[vUser] [varchar](50) NULL,
	[DateUpdated] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KPI_Security_LeadingStatistics]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KPI_Security_LeadingStatistics](
	[vYear] [int] NULL,
	[vMonth] [varchar](10) NULL,
	[LeadingStatistics] [varchar](50) NULL,
	[value] [int] NULL,
	[vUser] [varchar](50) NULL,
	[DateUpdated] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KPI_Subcon_Award]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KPI_Subcon_Award](
	[SCRTotal] [int] NULL,
	[SCRClosed] [int] NULL,
	[RetrieveDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KPI_Subcon_Settlement]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KPI_Subcon_Settlement](
	[Cancelled] [int] NOT NULL,
	[Closed] [int] NOT NULL,
	[Total] [int] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[ModifiedBy] [nvarchar](500) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OpsCare_PaneLineMachine]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OpsCare_PaneLineMachine](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[tagname] [varchar](255) NULL,
	[machinename] [varchar](255) NULL,
	[status] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OpsCareCurrentData]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OpsCareCurrentData](
	[OpsCareDataEntryId] [bigint] IDENTITY(1,1) NOT NULL,
	[assetEntryDataId] [bigint] NOT NULL,
	[OpsCareDatafieldvalues] [nvarchar](4000) NULL,
	[OpsCareDataReceivedDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OpsCareDataEntryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OpsCareData]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OpsCareData](
	[OpsCareDataEntryId] [bigint] IDENTITY(1,1) NOT NULL,
	[assetEntryDataId] [bigint] NOT NULL,
	[OpsCareDatafieldvalues] [nvarchar](4000) NULL,
	[OpsCareDataReceivedDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OpsCareDataEntryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PersonnelTrackingCurrentData]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PersonnelTrackingCurrentData](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[JsonValueFields] [varchar](4000) NULL,
	[userid] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PersonnelTrackingUser]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PersonnelTrackingUser](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[type] [varchar](30) NULL,
	[username] [varchar](50) NULL,
	[password] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TempRawData]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TempRawData](
	[indexId] [int] IDENTITY(1,1) NOT NULL,
	[tagname] [varchar](100) NOT NULL,
	[value] [decimal](20, 8) NOT NULL,
	[timestamp] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[indexId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserAccount]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserAccount](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](255) NULL,
	[salt] [varchar](255) NULL,
	[password] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserAccount_App]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserAccount_App](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[accountId] [int] NULL,
	[app] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WidgetProgressGaugeCollection]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WidgetProgressGaugeCollection](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[widgetTitle] [varchar](255) NULL,
	[targetText] [varchar](255) NULL,
	[belongsTo] [varchar](255) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[GasCheckerCurrentData]  WITH CHECK ADD FOREIGN KEY([assetId])
REFERENCES [dbo].[GasCheckerAssets] ([assetId])
GO
ALTER TABLE [dbo].[GasCheckerData]  WITH CHECK ADD FOREIGN KEY([assetId])
REFERENCES [dbo].[GasCheckerAssets] ([assetId])
GO
ALTER TABLE [dbo].[OpsCareCurrentData]  WITH CHECK ADD FOREIGN KEY([assetEntryDataId])
REFERENCES [dbo].[Assets] ([assetEntryDataId])
GO
ALTER TABLE [dbo].[OpsCareData]  WITH CHECK ADD FOREIGN KEY([assetEntryDataId])
REFERENCES [dbo].[Assets] ([assetEntryDataId])
GO
/****** Object:  StoredProcedure [dbo].[Get700TCraneData]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ajay Daniel>
-- Create date: <30/03/202>
-- Description:	<Used to show real time values for the 700T Crane Page in OpsCare>
-- =============================================
CREATE PROCEDURE [dbo].[Get700TCraneData]
AS
BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	CREATE TABLE #temptable
	(
		param varchar(1000),
		value varchar(1000)
	)
	
	/*
	-- Lifts
	;WITH my_table AS(
		SELECT ROW_NUMBER() OVER (ORDER BY timestamp) row,timestamp, ISNULL([PZ1_700Crane_H1LOAD],0) AS [H1LOAD],
		 ISNULL([PZ1_700Crane_H2LOAD],0) AS [H2LOAD], ISNULL([PZ1_700Crane_H1LOAD],0)+ISNULL([PZ1_700Crane_H2LOAD],0) AS [SUMH1H2],
		 ISNULL([PZ1_700Crane_H3LOAD],0) AS [H3LOAD] FROM(
			  SELECT tagname, MAX(CAST(value AS FLOAT)/100) AS value, DATEADD(MINUTE, DATEDIFF(MINUTE, 0, timestamp), 0) as timestamp
				FROM [OpsCare].[dbo].[HistorianRawData]
				WHERE tagname LIKE '%H%LOAD%'
				AND timestamp >= (select dateadd(day, datediff(day, 0, getdate()), 0) + '07:30')
				GROUP BY tagname,DATEADD(MINUTE, DATEDIFF(MINUTE, 0, timestamp), 0)
		  ) AS source_table
		  PIVOT(
			  SUM(value) FOR tagname IN ([PZ1_700Crane_H1LOAD],[PZ1_700Crane_H2LOAD],[PZ1_700Crane_H3LOAD])
		  ) AS pivot_table	
	)

	SELECT 'LIFTS',count(*) FROM my_table a LEFT JOIN my_table b ON a.row = b.row+5
	WHERE (a.H3LOAD > 10 and b.H3LOAD <= 10) OR (a.SUMH1H2 > 36 and b.SUMH1H2 <= 36)
	*/
    -- HOIST LOAD Values
	INSERT INTO #temptable SELECT tagname,CAST(value AS float) AS value FROM HistorianCurrentData WHERE tagname LIKE ('PZ1_700Crane_%LOAD')

	-- Gantry Speed
	INSERT INTO #temptable SELECT tagname,ROUND(ABS(CAST(value AS FLOAT)/1000),2) AS value FROM HistorianCurrentData WHERE tagname = 'PZ1_700Crane_GSPD'

	-- Lower trolley Velocity
	INSERT INTO #temptable SELECT tagname,ROUND(value,2) as value FROM HistorianCurrentData WHERE tagname LIKE ('PZ1_Emerson_LowerTrolley%Velocity')

	-- Upper trolley Velocity
	INSERT INTO #temptable SELECT tagname,ROUND(value,2) as value FROM HistorianCurrentData WHERE tagname LIKE ('PZ1_Emerson_UpperTrolley%Velocity')

	--Transformers
	INSERT INTO #temptable SELECT tagname,ROUND(CAST(value AS float),2) AS value FROM HistorianCurrentData WHERE tagname LIKE ('PZ1_Emerson_TransformerRoom%')

	--Pos
	INSERT INTO #temptable SELECT tagname,ROUND(CAST(value AS float)/100,2) AS value FROM HistorianCurrentData WHERE tagname LIKE ('PZ1_700Crane_Display_CMS_%POS_CMS%')

	
END	 SELECT * FROM #temptable
GO
/****** Object:  StoredProcedure [dbo].[Get700TCraneLiftTrend]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ajay Daniel
-- Create date: 02-04-2020
-- Description:	To create trends for Crane lift in the Opscare Crane page
-- Changes Made:
-- 13/01/2020: Split calculation of the load to H1H2 and H3 separately as we realised that both trolley can lift independently
-- =============================================
CREATE PROCEDURE [dbo].[Get700TCraneLiftTrend]
	@category VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE
      @cRow INT,
      @cTimestamp datetime,
	  @cH1LOAD decimal,
	  @cH2LOAD decimal,
	  @cH1H2 decimal,
	  @cH3LOAD decimal,

	  @startRow int,
	  @lastRow int,
	  @liftCount int,
	  @startdate datetime,
	  @enddate datetime,
	  @starttime datetime,
	  @endtime datetime,
	  @todaystart datetime,
	  @todayend datetime

	  CREATE TABLE #temptable
		(
			timestamp datetime,
			duration decimal
		)
	  CREATE TABLE #trendtable
		(
			timestamp date,
			lifts int
		)

	  CREATE TABLE #liftdata
	    (
			row int,
			timestamp datetime,
			H1LOAD float ,
			H2LOAD float ,
			SUMH1H2 float,
			H3LOAD float
		)

		------------------------------------------------------------------------------------------------
		--Below section is to calculate the number of lifts and duration of each lifts for past 7 days--
		------------------------------------------------------------------------------------------------
		IF(@category = 'weekly_trend')
		BEGIN
			-- For H1H2 calculation
			SET @enddate = (SELECT DATEADD(DAY,1,(SELECT CONVERT(VARCHAR(10), getdate(), 111))))
			SET @startdate = (SELECT DATEADD(day,-7,@enddate))
        
			-- The idea is to loop through values and find out consecutive rows with lift happening using the 'row' column
			-- The 'row' column is calculated used stored procedure ZCraneLiftData to get the consecutive lifts

			WHILE (@startdate < @enddate)
			BEGIN
				SET @starttime = (SELECT DATEADD(HOUR,7,@startdate))
				SET @endtime = (SELECT DATEADD(HOUR,19,@startdate))				
				SET @liftCount = 0
				DECLARE cur_cranelift CURSOR LOCAL STATIC READ_ONLY FORWARD_ONLY FOR		
					SELECT DISTINCT(timestamp),row,H1LOAD,H2LOAD,SUMH1H2,H3LOAD FROM [Opscare].[dbo].[CraneLiftData] WHERE (timestamp >= @starttime AND timestamp < @endtime) AND (SUMH1H2 > 72) ORDER BY timestamp 	
				OPEN cur_cranelift
				FETCH NEXT FROM cur_cranelift INTO @cTimestamp,@cRow,@cH1LOAD, @cH2LOAD, @cH1H2, @cH3LOAD
				SET @startRow = @cRow
				WHILE (@@FETCH_STATUS <> -1)
				BEGIN
					IF @startRow < @cRow
					BEGIN
						IF (@cRow - @lastRow = 1) -- this is continous 1 min
						BEGIN
							SET @liftCount = @liftCount +1
						END
						ELSE
						BEGIN
							if(@liftCount >=5)
							BEGIN
								INSERT INTO #temptable SELECT @cTimestamp,@liftCount
							END
							SET @liftCount = 0  -- reset count to 0
							SET @startRow = @cRow
						END

						IF @liftCount = 5
						BEGIN
							SET @startRow = @cRow  --reset startRow

						END
					END
					ELSE
					BEGIN
						SET @startRow = @cRow
					END
					SET @lastRow = @cRow
				
					FETCH NEXT FROM cur_cranelift  INTO @cTimestamp,@cRow,@cH1LOAD, @cH2LOAD, @cH1H2, @cH3LOAD
				END
				if(@liftCount > 5)
					BEGIN
						INSERT INTO #temptable SELECT @cTimestamp,@liftCount
					END
			
				CLOSE cur_cranelift
				DEALLOCATE cur_cranelift
			
				SET @startdate = (SELECT DATEADD(day,1,@startdate))
			END

			-- For H3LOAD
			SET @enddate = (SELECT DATEADD(DAY,1,(SELECT CONVERT(VARCHAR(10), getdate(), 111))))
			SET @startdate = (SELECT DATEADD(day,-7,@enddate))
        
			-- The idea is to loop through values and find out consecutive rows with lift happening using the 'row' column
			-- The 'row' column is calculated used stored procedure ZCraneLiftData to get the consecutive lifts

			WHILE (@startdate < @enddate)
			BEGIN
				SET @starttime = (SELECT DATEADD(HOUR,7,@startdate))
				SET @endtime = (SELECT DATEADD(HOUR,19,@startdate))				
				SET @liftCount = 0
				DECLARE cur_cranelift CURSOR LOCAL STATIC READ_ONLY FORWARD_ONLY FOR		
					SELECT DISTINCT(timestamp),row,H1LOAD,H2LOAD,SUMH1H2,H3LOAD FROM [Opscare].[dbo].[CraneLiftData] WHERE (timestamp >= @starttime AND timestamp < @endtime) AND (H3LOAD >10) ORDER BY timestamp 	
				OPEN cur_cranelift
				FETCH NEXT FROM cur_cranelift INTO @cTimestamp,@cRow,@cH1LOAD, @cH2LOAD, @cH1H2, @cH3LOAD
				SET @startRow = @cRow
				WHILE (@@FETCH_STATUS <> -1)
				BEGIN
					IF @startRow < @cRow
					BEGIN
						IF (@cRow - @lastRow = 1) -- this is continous 1 min
						BEGIN
							SET @liftCount = @liftCount +1
						END
						ELSE
						BEGIN
							if(@liftCount >=5)
							BEGIN
								INSERT INTO #temptable SELECT @cTimestamp,@liftCount
							END
							SET @liftCount = 0  -- reset count to 0
							SET @startRow = @cRow
						END

						IF @liftCount = 5
						BEGIN
							SET @startRow = @cRow  --reset startRow

						END
					END
					ELSE
					BEGIN
						SET @startRow = @cRow
					END
					SET @lastRow = @cRow
				
					FETCH NEXT FROM cur_cranelift  INTO @cTimestamp,@cRow,@cH1LOAD, @cH2LOAD, @cH1H2, @cH3LOAD
				END
				if(@liftCount > 5)
					BEGIN
						INSERT INTO #temptable SELECT @cTimestamp,@liftCount
					END
			
				CLOSE cur_cranelift
				DEALLOCATE cur_cranelift
			
				SET @startdate = (SELECT DATEADD(day,1,@startdate))
		END
		END
		ELSE -- To get today's numbers. CraneLiftData is only updated at the end of the day with today's numbers
		BEGIN
			SET @starttime = (SELECT DATEADD(HOUR,7,(SELECT CONVERT(VARCHAR(10), getdate(), 111))))
			SET @endtime = (SELECT DATEADD(HOUR,19,(SELECT CONVERT(VARCHAR(10), getdate(), 111))))
			;WITH my_table AS(
				SELECT ROW_NUMBER() OVER (ORDER BY timestamp) row,timestamp, ISNULL([PZ1_700Crane_H1LOAD],0) AS [H1LOAD],
				 ISNULL([PZ1_700Crane_H2LOAD],0) AS [H2LOAD], ISNULL([PZ1_700Crane_H1LOAD],0)+ISNULL([PZ1_700Crane_H2LOAD],0) AS [SUMH1H2],
				 ISNULL([PZ1_700Crane_H3LOAD],0) AS [H3LOAD] FROM(
					  SELECT tagname, MAX(CAST(value AS FLOAT)) AS value, DATEADD(MINUTE, DATEDIFF(MINUTE, 0, timestamp), 0) as timestamp
						FROM [OpsCare].[dbo].[HistorianRawData]
						WHERE tagname LIKE '%H%LOAD%'
						AND (timestamp >= @starttime AND timestamp < @endtime)
						GROUP BY tagname,DATEADD(MINUTE, DATEDIFF(MINUTE, 0, timestamp), 0)
				  ) AS source_table
				  PIVOT(
					  SUM(value) FOR tagname IN ([PZ1_700Crane_H1LOAD],[PZ1_700Crane_H2LOAD],[PZ1_700Crane_H3LOAD])
				  ) AS pivot_table	
			)
			INSERT INTO #liftdata SELECT * FROM my_table
			-- Calculate for H1H2
			SET @starttime = (SELECT DATEADD(HOUR,7,(SELECT CONVERT(VARCHAR(10), getdate(), 111))))
			SET @endtime = (SELECT DATEADD(HOUR,19,(SELECT CONVERT(VARCHAR(10), getdate(), 111))))				
			SET @liftCount = 0
			DECLARE cur_cranelift CURSOR LOCAL STATIC READ_ONLY FORWARD_ONLY FOR		
				SELECT DISTINCT(timestamp),row,H1LOAD,H2LOAD,SUMH1H2,H3LOAD FROM #liftdata WHERE (timestamp >= @starttime AND timestamp < @endtime) AND SUMH1H2 > 72 ORDER BY timestamp 	
			OPEN cur_cranelift
			FETCH NEXT FROM cur_cranelift INTO @cTimestamp,@cRow,@cH1LOAD, @cH2LOAD, @cH1H2, @cH3LOAD
			SET @startRow = @cRow
			WHILE (@@FETCH_STATUS <> -1)
			BEGIN
				IF @startRow < @cRow
				BEGIN
					IF (@cRow - @lastRow = 1) -- this is continous 1 min
					BEGIN
						SET @liftCount = @liftCount +1
					END
					ELSE
					BEGIN
						if(@liftCount >=5)
						BEGIN
							INSERT INTO #temptable SELECT @cTimestamp,@liftCount
						END
						SET @liftCount = 0  -- reset count to 0
						SET @startRow = @cRow
					END

					IF @liftCount = 5
					BEGIN
						SET @startRow = @cRow  --reset startRow

					END
				END
				ELSE
				BEGIN
					SET @startRow = @cRow
				END
				SET @lastRow = @cRow
				
				FETCH NEXT FROM cur_cranelift  INTO @cTimestamp,@cRow,@cH1LOAD, @cH2LOAD, @cH1H2, @cH3LOAD
			END
			if(@liftCount > 5)
				BEGIN
					INSERT INTO #temptable SELECT @cTimestamp,@liftCount
				END
			
			CLOSE cur_cranelift
			DEALLOCATE cur_cranelift

			--Calculate for H3
			SET @starttime = (SELECT DATEADD(HOUR,7,(SELECT CONVERT(VARCHAR(10), getdate(), 111))))
			SET @endtime = (SELECT DATEADD(HOUR,19,(SELECT CONVERT(VARCHAR(10), getdate(), 111))))				
			SET @liftCount = 0
			DECLARE cur_cranelift CURSOR LOCAL STATIC READ_ONLY FORWARD_ONLY FOR		
				SELECT DISTINCT(timestamp),row,H1LOAD,H2LOAD,SUMH1H2,H3LOAD FROM #liftdata WHERE (timestamp >= @starttime AND timestamp < @endtime) AND H3LOAD >10 ORDER BY timestamp 	
			OPEN cur_cranelift
			FETCH NEXT FROM cur_cranelift INTO @cTimestamp,@cRow,@cH1LOAD, @cH2LOAD, @cH1H2, @cH3LOAD
			SET @startRow = @cRow
			WHILE (@@FETCH_STATUS <> -1)
			BEGIN
				IF @startRow < @cRow
				BEGIN
					IF (@cRow - @lastRow = 1) -- this is continous 1 min
					BEGIN
						SET @liftCount = @liftCount +1
					END
					ELSE
					BEGIN
						if(@liftCount >=5)
						BEGIN
							INSERT INTO #temptable SELECT @cTimestamp,@liftCount
						END
						SET @liftCount = 0  -- reset count to 0
						SET @startRow = @cRow
					END

					IF @liftCount = 5
					BEGIN
						SET @startRow = @cRow  --reset startRow

					END
				END
				ELSE
				BEGIN
					SET @startRow = @cRow
				END
				SET @lastRow = @cRow
				
				FETCH NEXT FROM cur_cranelift  INTO @cTimestamp,@cRow,@cH1LOAD, @cH2LOAD, @cH1H2, @cH3LOAD
			END
			if(@liftCount > 5)
				BEGIN
					INSERT INTO #temptable SELECT @cTimestamp,@liftCount
				END
			
			CLOSE cur_cranelift
			DEALLOCATE cur_cranelift
			
		END
		
		-----------------------
		----------end----------
		-----------------------
		if(@category = 'todays_lift')
		BEGIN
			SELECT COUNT(*) AS 'LIFTS' FROM #temptable WHERE timestamp > (SELECT CONVERT(VARCHAR(10), getdate(), 111) )
		END
		ELSE IF(@category='weekly_trend')
		BEGIN
			SET @enddate = (SELECT CONVERT(VARCHAR(10), getdate(), 111))
			SET @enddate = (SELECT DATEADD(day,0,@enddate))
			SET @startdate = (SELECT DATEADD(day,-5,@enddate))
			WHILE(@startdate < @enddate)
			BEGIN
				INSERT INTO #trendtable SELECT CONVERT(varchar(10),@startdate,111), COUNT(*) FROM  #temptable WHERE timestamp > @startdate AND timestamp < (SELECT DATEADD(day,1,@startdate))
				SET @startdate = (SELECT DATEADD(day,1,@startdate))
			END
			SELECT * from #trendtable
		END
		ELSE IF(@category = 'duration')
		BEGIN
			SET @todaystart = (SELECT DATEADD(HOUR,7, (SELECT CONVERT(VARCHAR(10), getdate(), 111))))
			SET @todayend = (SELECT DATEADD(HOUR,19, (SELECT CONVERT(VARCHAR(10), getdate(), 111))))	

			SELECT * FROM #temptable WHERE timestamp >=  @todaystart AND timestamp < @todayend

		END
		ELSE
		BEGIN
			SET @todaystart = (SELECT DATEADD(HOUR,7, (SELECT CONVERT(VARCHAR(10), getdate(), 111))))
			SET @todayend = (SELECT DATEADD(HOUR,19, (SELECT CONVERT(VARCHAR(10), getdate(), 111))))	

			SELECT DISTINCT(timestamp),SUMH1H2,H3LOAD FROM #liftdata  ORDER BY timestamp
		END
END
GO
/****** Object:  StoredProcedure [dbo].[Get700TCraneMechTrend]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ajay Daniel
-- Create date: 06-12-2020
-- Description:	To create trends for mechanical condition in the Opscare Crane page
-- =============================================
CREATE PROCEDURE [dbo].[Get700TCraneMechTrend]
	@hoist VARCHAR(50),
	@category VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE
		@starttime datetime,
		@endtime datetime

	SET @starttime = (select dateadd(day, datediff(day, 0, getdate()), 0) + '07:00')
	SET @endtime = (select dateadd(day, datediff(day, 0, getdate()), 0) + '19:00')

    -- Insert statements for procedure here
	IF(@hoist = 'Hoist 1')
	BEGIN
		IF(@category = 'drum')
		BEGIN
			SELECT timestamp, [PZ1_Emerson_UpperTrolley_H1_Drum_DE_H_Velocity] AS H_Velocity,
			[PZ1_Emerson_UpperTrolley_H1_Drum_DE_V_Velocity] AS V_Velocity
			FROM(
			SELECT timestamp,tagname, ROUND(value,2) AS value FROM HistorianRawData WHERE tagname IN ('PZ1_Emerson_UpperTrolley_H1_Drum_DE_H_Velocity','PZ1_Emerson_UpperTrolley_H1_Drum_DE_V_Velocity') AND 
			(timestamp >= @starttime and timestamp < @endtime)) 
			AS p

			PIVOT
			(MAX(value) FOR tagname IN ([PZ1_Emerson_UpperTrolley_H1_Drum_DE_H_Velocity],[PZ1_Emerson_UpperTrolley_H1_Drum_DE_V_Velocity]))AS pvt
			 ORDER BY timestamp
		END
		IF(@category = 'gearbox_nde')
		BEGIN
			SELECT timestamp, [PZ1_Emerson_UpperTrolley_H1_GB_NDE_H_Velocity] AS H_Velocity,
			[PZ1_Emerson_UpperTrolley_H1_GB_NDE_V_Velocity] AS V_Velocity
			FROM(
			SELECT timestamp,tagname, ROUND(value,2) AS value FROM HistorianRawData WHERE tagname IN ('PZ1_Emerson_UpperTrolley_H1_GB_NDE_H_Velocity','PZ1_Emerson_UpperTrolley_H1_GB_NDE_V_Velocity') AND 
						(timestamp >= @starttime and timestamp < @endtime)) as p

			PIVOT
			(MAX(value) FOR tagname IN ([PZ1_Emerson_UpperTrolley_H1_GB_NDE_H_Velocity],[PZ1_Emerson_UpperTrolley_H1_GB_NDE_V_Velocity]))AS pvt
			 ORDER BY timestamp
		END
		IF(@category = 'gearbox_de')
		BEGIN
			SELECT timestamp, [PZ1_Emerson_UpperTrolley_H1_GB_DE_H_Velocity] AS H_Velocity,
			[PZ1_Emerson_UpperTrolley_H1_GB_DE_V_Velocity] AS V_Velocity
			FROM(
			SELECT timestamp,tagname, ROUND(value,2) AS value FROM HistorianRawData WHERE tagname IN ('PZ1_Emerson_UpperTrolley_H1_GB_DE_H_Velocity','PZ1_Emerson_UpperTrolley_H1_GB_DE_V_Velocity') AND 
						(timestamp >= @starttime and timestamp < @endtime)) as p

			PIVOT
			(MAX(value) FOR tagname IN ([PZ1_Emerson_UpperTrolley_H1_GB_DE_H_Velocity],[PZ1_Emerson_UpperTrolley_H1_GB_DE_V_Velocity]))AS pvt
			 ORDER BY timestamp

		END
		IF(@category = 'motor')
		BEGIN
			SELECT timestamp, [PZ1_Emerson_UpperTrolley_H1_Motor_DE_H_Velocity] AS H_Velocity,
			[PZ1_Emerson_UpperTrolley_H1_Motor_DE_V_Velocity] AS V_Velocity
			FROM(
			SELECT timestamp,tagname, ROUND(value,2) AS value FROM HistorianRawData WHERE tagname IN ('PZ1_Emerson_UpperTrolley_H1_Motor_DE_H_Velocity','PZ1_Emerson_UpperTrolley_H1_Motor_DE_V_Velocity') AND 
						(timestamp >= @starttime and timestamp < @endtime)) as p

			PIVOT
			(MAX(value) FOR tagname IN ([PZ1_Emerson_UpperTrolley_H1_Motor_DE_H_Velocity],[PZ1_Emerson_UpperTrolley_H1_Motor_DE_V_Velocity]))AS pvt
			 ORDER BY timestamp

		END

	END
	
	IF(@hoist = 'Hoist 2')
	BEGIN
		IF(@category = 'drum')
		BEGIN
			SELECT timestamp, [PZ1_Emerson_UpperTrolley_H2_Drum_DE_H_Velocity] AS H_Velocity,
			[PZ1_Emerson_UpperTrolley_H2_Drum_DE_V_Velocity] AS V_Velocity
			FROM(
			SELECT timestamp,tagname, ROUND(value,2) AS value FROM HistorianRawData WHERE tagname IN ('PZ1_Emerson_UpperTrolley_H2_Drum_DE_H_Velocity','PZ1_Emerson_UpperTrolley_H2_Drum_DE_V_Velocity') AND 
						(timestamp >= @starttime and timestamp < @endtime)) as p

			PIVOT
			(MAX(value) FOR tagname IN ([PZ1_Emerson_UpperTrolley_H2_Drum_DE_H_Velocity],[PZ1_Emerson_UpperTrolley_H2_Drum_DE_V_Velocity]))AS pvt
			 ORDER BY timestamp
		END
		IF(@category = 'gearbox_nde')
		BEGIN
			SELECT timestamp, [PZ1_Emerson_UpperTrolley_H2_GB_NDE_H_Velocity] AS H_Velocity,
			[PZ1_Emerson_UpperTrolley_H2_GB_NDE_V_Velocity] AS V_Velocity
			FROM(
			SELECT timestamp,tagname, ROUND(value,2) AS value FROM HistorianRawData WHERE tagname IN ('PZ1_Emerson_UpperTrolley_H2_GB_NDE_H_Velocity','PZ1_Emerson_UpperTrolley_H2_GB_NDE_V_Velocity') AND 
						(timestamp >= @starttime and timestamp < @endtime)) as p

			PIVOT
			(MAX(value) FOR tagname IN ([PZ1_Emerson_UpperTrolley_H2_GB_NDE_H_Velocity],[PZ1_Emerson_UpperTrolley_H2_GB_NDE_V_Velocity]))AS pvt
			 ORDER BY timestamp
		END
		IF(@category = 'gearbox_de')
		BEGIN
			SELECT timestamp, [PZ1_Emerson_UpperTrolley_H2_GB_DE_H_Velocity] AS H_Velocity,
			[PZ1_Emerson_UpperTrolley_H2_GB_DE_V_Velocity] AS V_Velocity
			FROM(
			SELECT timestamp,tagname, ROUND(value,2) AS value FROM HistorianRawData WHERE tagname IN ('PZ1_Emerson_UpperTrolley_H2_GB_DE_H_Velocity','PZ1_Emerson_UpperTrolley_H2_GB_DE_V_Velocity') AND 
						(timestamp >= @starttime and timestamp < @endtime)) as p

			PIVOT
			(MAX(value) FOR tagname IN ([PZ1_Emerson_UpperTrolley_H2_GB_DE_H_Velocity],[PZ1_Emerson_UpperTrolley_H2_GB_DE_V_Velocity]))AS pvt
			 ORDER BY timestamp

		END
		IF(@category = 'motor')
		BEGIN
			SELECT timestamp, [PZ1_Emerson_UpperTrolley_H2_Motor_DE_H_Velocity] AS H_Velocity,
			[PZ1_Emerson_UpperTrolley_H2_Motor_DE_V_Velocity] AS V_Velocity
			FROM(
			SELECT timestamp,tagname, ROUND(value,2) AS value FROM HistorianRawData WHERE tagname IN ('PZ1_Emerson_UpperTrolley_H2_Motor_DE_H_Velocity','PZ1_Emerson_UpperTrolley_H2_Motor_DE_V_Velocity') AND 
						(timestamp >= @starttime and timestamp < @endtime)) as p

			PIVOT
			(MAX(value) FOR tagname IN ([PZ1_Emerson_UpperTrolley_H2_Motor_DE_H_Velocity],[PZ1_Emerson_UpperTrolley_H2_Motor_DE_V_Velocity]))AS pvt
			 ORDER BY timestamp

		END

	END
	
IF(@hoist = 'Hoist 3')
	BEGIN
		IF(@category = 'drum')
		BEGIN
			SELECT timestamp, [PZ1_Emerson_LowerTrolley_H3_Drum_DE_H_Velocity] AS H_Velocity,
			[PZ1_Emerson_LowerTrolley_H3_Drum_DE_V_Velocity] AS V_Velocity
			FROM(
			SELECT timestamp,tagname, ROUND(value,2) AS value FROM HistorianRawData WHERE tagname IN ('PZ1_Emerson_LowerTrolley_H3_Drum_DE_H_Velocity','PZ1_Emerson_LowerTrolley_H3_Drum_DE_V_Velocity') AND 
						(timestamp >= @starttime and timestamp < @endtime)) as p

			PIVOT
			(MAX(value) FOR tagname IN ([PZ1_Emerson_LowerTrolley_H3_Drum_DE_H_Velocity],[PZ1_Emerson_LowerTrolley_H3_Drum_DE_V_Velocity]))AS pvt
			 ORDER BY timestamp
		END
		IF(@category = 'gearbox_nde')
		BEGIN
			SELECT timestamp, [PZ1_Emerson_LowerTrolley_H3_GB_NDE_H_Velocity] AS H_Velocity,
			[PZ1_Emerson_LowerTrolley_H3_GB_NDE_V_Velocity] AS V_Velocity
			FROM(
			SELECT timestamp,tagname, ROUND(value,2) AS value FROM HistorianRawData WHERE tagname IN ('PZ1_Emerson_LowerTrolley_H3_GB_NDE_H_Velocity','PZ1_Emerson_LowerTrolley_H3_GB_NDE_V_Velocity') AND 
						(timestamp >= @starttime and timestamp < @endtime)) as p

			PIVOT
			(MAX(value) FOR tagname IN ([PZ1_Emerson_LowerTrolley_H3_GB_NDE_H_Velocity],[PZ1_Emerson_LowerTrolley_H3_GB_NDE_V_Velocity]))AS pvt
			 ORDER BY timestamp
		END
		IF(@category = 'gearbox_de')
		BEGIN
			SELECT timestamp, [PZ1_Emerson_LowerTrolley_H3_GB_DE_H_Velocity] AS H_Velocity,
			[PZ1_Emerson_LowerTrolley_H3_GB_DE_V_Velocity] AS V_Velocity
			FROM(
			SELECT timestamp,tagname, ROUND(value,2) AS value FROM HistorianRawData WHERE tagname IN ('PZ1_Emerson_LowerTrolley_H3_GB_DE_H_Velocity','PZ1_Emerson_LowerTrolley_H3_GB_DE_V_Velocity') AND 
						(timestamp >= @starttime and timestamp < @endtime)) as p

			PIVOT
			(MAX(value) FOR tagname IN ([PZ1_Emerson_LowerTrolley_H3_GB_DE_H_Velocity],[PZ1_Emerson_LowerTrolley_H3_GB_DE_V_Velocity]))AS pvt
			 ORDER BY timestamp

		END
		IF(@category = 'motor')
		BEGIN
			SELECT timestamp, [PZ1_Emerson_LowerTrolley_H3_Motor_DE_H_Velocity] AS H_Velocity,
			[PZ1_Emerson_LowerTrolley_H3_Motor_DE_V_Velocity] AS V_Velocity
			FROM(
			SELECT timestamp,tagname, ROUND(value,2) AS value FROM HistorianRawData WHERE tagname IN ('PZ1_Emerson_LowerTrolley_H3_Motor_DE_H_Velocity','PZ1_Emerson_LowerTrolley_H3_Motor_DE_V_Velocity') AND 
						(timestamp >= @starttime and timestamp < @endtime)) as p

			PIVOT
			(MAX(value) FOR tagname IN ([PZ1_Emerson_LowerTrolley_H3_Motor_DE_H_Velocity],[PZ1_Emerson_LowerTrolley_H3_Motor_DE_V_Velocity]))AS pvt
			 ORDER BY timestamp

		END

	END

END
GO
/****** Object:  StoredProcedure [dbo].[Get700TCraneOverData]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ajay Daniel
-- Create date: 02/02/2020
-- Description:	To get Crane overspeed data for YOTF crane page
-- =============================================
CREATE PROCEDURE [dbo].[Get700TCraneOverData]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE 
		@minutes_from_start INT,
		@starttime datetime,
		@endtime datetime,
		@openquery VARCHAR(1000),
		@sql VARCHAR(1000),
		@cTagname varchar(50),
		@cvalue decimal,
		@ch1h2 decimal,
		@ch3 decimal,
		@overspeedcount int,
		@overliftcount int,
		@totalcount int

	CREATE TABLE #temptable
	(
		param varchar(1000),
		value varchar(1000)
	)
	
	--Overspeed
	SET @overspeedcount = 0
	SET @totalcount = 0
	SET @starttime = (select dateadd(day, datediff(day, 0, GETDATE()), 0) + '07:00')
	SET @endtime = (select dateadd(day, datediff(day, 0, GETDATE()), 0) + '19:00')

	DECLARE today_speed CURSOR LOCAL STATIC READ_ONLY FORWARD_ONLY FOR
				SELECT tagname,ABS(CAST(value AS float)/1000) as value from HistorianRawData where tagname='PZ1_700Crane_GSPD' and (timestamp >= @starttime and timestamp < @endtime)
				order by timestamp	
	OPEN today_speed
	FETCH NEXT FROM today_speed INTO @cTagname,@cValue
			
	WHILE (@@FETCH_STATUS <> -1)
	BEGIN
		if(@cValue > 30)
		BEGIN
			SET @overspeedcount = @overspeedcount + 1
		END
		ELSE
		BEGIN
			if(@overspeedcount !=0)
			BEGIN
				SET @totalcount = @totalcount + 1
				SET @overspeedcount = 0
			END
		END
	FETCH NEXT FROM today_speed  INTO @cTagname,@cValue
	END
	CLOSE today_speed
	DEALLOCATE today_speed
	INSERT INTO #temptable SELECT 'OVERSPEED_COUNT', @totalcount

	--Overload
	SET @overliftcount = 0
	SET @totalcount = 0
	SET @starttime = (select dateadd(day, datediff(day, 0, GETDATE()), 0) + '07:00')
	SET @endtime = (select dateadd(day, datediff(day, 0, GETDATE()), 0) + '19:00')

	DECLARE today_lift CURSOR LOCAL STATIC READ_ONLY FORWARD_ONLY FOR
				SELECT timestamp, SUMH1H2,H3LOAD FROM CraneLiftData WHERE (timestamp >= @starttime and timestamp < @endtime)
				order by timestamp
	OPEN today_lift
	FETCH NEXT FROM today_lift INTO @cTagname,@ch1h2,@ch3
			
	WHILE (@@FETCH_STATUS <> -1)
	BEGIN
		if(@ch1h2 + @ch3 > 700)
		BEGIN
			SET @overliftcount = @overliftcount + 1
		END
		ELSE
		BEGIN
			if(@overliftcount !=0)
			BEGIN
				SET @totalcount = @totalcount + 1
				SET @overliftcount = 0
			END
		END
	FETCH NEXT FROM today_lift  INTO @cTagname,@ch1h2,@ch3
	END
	CLOSE today_lift
	DEALLOCATE today_lift
	INSERT INTO #temptable SELECT 'OVERLOAD_COUNT', @totalcount

	SELECT * from #temptable
END
GO
/****** Object:  StoredProcedure [dbo].[Get700TCraneSafetyLimitData]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Get700TCraneSafetyLimitData]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE
		@starttime datetime,
		@endtime datetime

	SET @starttime = (select dateadd(day, datediff(day, 0, GETDATE()), 0) + '07:00')
	SET @endtime = (select dateadd(day, datediff(day, 0, GETDATE()), 0) + '19:00')
    -- Insert statements for procedure here
	SELECT t1.timestamp,t1.speed,t2.load FROM (
	(select DATEADD(MINUTE, DATEDIFF(MINUTE, 0, timestamp), 0) as timestamp, ROUND(avg(ABS(CAST(value AS float)/1000)),2) as speed from HistorianRawData 
		where (timestamp >= @starttime and timestamp < @endtime)
		and tagname like 'PZ1_700Crane_GSPD'
		GROUP BY DATEADD(MINUTE, DATEDIFF(MINUTE, 0, timestamp), 0))as t1
	INNER JOIN
	(
		select timestamp,
		CASE 
			WHEN SUMH1H2 > 72 THEN SUMH1H2  
			WHEN H3LOAD > 10 THEN H3LOAD 
			ELSE 0
		END AS load from CraneLiftData where (timestamp >= @starttime and timestamp < @endtime)
	) as t2
	ON t1.timestamp = t2.timestamp
)

END
GO
/****** Object:  StoredProcedure [dbo].[GetGasCheckerDetailByAssetId]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetGasCheckerDetailByAssetId]
	-- Add the parameters for the stored procedure here
	@assetId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @json  varchar(4000)
	declare @receiveddate datetime
	declare @minutesDiff int

	set @receiveddate = (SELECT Convert(varchar,receivedDate,120)
    FROM [OpsCare].[dbo].[GasCheckerCurrentData] where assetId = @assetId)
   --set @receiveddate = GETDATE()

    set @minutesDiff =( select DATEDIFF(MINUTE, @receiveddate, GETDATE()))

    set @json = (SELECT value
    FROM [OpsCare].[dbo].[GasCheckerCurrentData] where assetId = @assetId)

    SET @json=JSON_MODIFY(@json,'$.lastReceivedInMin',@minutesDiff)

    SELECT *
	FROM OPENJSON(@json);
   
END
GO
/****** Object:  StoredProcedure [dbo].[GetGasCheckerStatusByAsset]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ajay Daniel
-- Create date: 21/06/2019
-- Description:	Used to check Gaschecker value and give status back to thingworx
-- =============================================
CREATE PROCEDURE [dbo].[GetGasCheckerStatusByAsset]
	-- Add the parameters for the stored procedure here
	@asset VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @value VARCHAR(1000)
	DECLARE @updatedtime datetime
	DECLARE @lelstatus VARCHAR(10)
	DECLARE @o2status VARCHAR(10)
	DECLARE @costatus VARCHAR(10)
	DECLARE @h2sstatus VARCHAR(10)
	DECLARE @result VARCHAR(25)

    -- Insert statements for procedure here
	SET @value = (SELECT value FROM GasCheckerCurrentData WHERE assetId=@asset)
	--SET @updatedtime = CAST(JSON_VALUE(@value,'$.timestamp') as datetime)
	SET @updatedtime = (SELECT receivedDate FROM GasCheckerCurrentData WHERE assetId=@asset)
	SET @lelstatus = JSON_VALUE(@value,'$.lel_status')
	SET @o2status = JSON_VALUE(@value,'$.o2_status')
	SET @costatus = JSON_VALUE(@value,'$.co_status')
	SET @h2sstatus = JSON_VALUE(@value,'$.h2s_status')
	if datediff(minute, @updatedtime, CURRENT_TIMESTAMP) > 20
	BEGIN
		SET @result = 'offline' -- grey
	END
	ELSE 
	IF (@lelstatus = 'OK' AND  @o2status = 'OK' AND @costatus = 'OK' AND @h2sstatus = 'OK')
	BEGIN
		SET @result = 'gas_check_ok' -- green
	END
	ELSE
	BEGIN
		SET @result = 'gas_check_high_high_alarm' -- red
	END
	SELECT @result as status
END
GO
/****** Object:  StoredProcedure [dbo].[GetkForkLocation]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetkForkLocation]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    select userid, JSON_VALUE(JsonValueFields, N'$.lat') as lat, JSON_VALUE(JsonValueFields,N'$.lng') as lng, JSON_VALUE(JsonValueFields,N'$.username') as username ,
	JSON_VALUE(JsonValueFields,N'$.status') as status  from KForkLiftCurrentData where JSON_VALUE(JsonValueFields,N'$.type') = 'Driver'
	
END
GO
/****** Object:  StoredProcedure [dbo].[GetkForkProgressData]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetkForkProgressData]
	-- Add the parameters for the stored procedure here
	@title varchar(150)
AS
	declare @total int;
	declare @inUsed int;
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF(@title = 'UTILIZATION')
	BEGIN

	set @total = (SELECT count(*) FROM [OpsCare].[dbo].[KForkLiftCurrentData] where JSON_VALUE(JsonValueFields, N'$.type') = 'Driver');
	set @inUsed = (SELECT count(*) FROM [OpsCare].[dbo].[KForkLiftCurrentData] where JSON_VALUE(JsonValueFields, N'$.type') = 'Driver' and ISNULL(JSON_VALUE(JsonValueFields, N'$.status'),'Offline') = 'Busy' );
	
	Select cast(cast( (cast(ISNULL(@inUsed,0) as decimal(10,2)) / cast(ISNULL(@total,0) as decimal(10,2))) * 100 as integer) as varchar)+ '%' as percentage,
	cast( (cast(ISNULL(@inUsed,0) as decimal(10,2)) / cast(ISNULL(@total,0) as decimal(10,2))) * 100 as integer) as percentageNum,
	 @title as 'widgetTitle', targetText from WidgetProgressGaugeCollection where belongsTo ='kFork' and widgetTitle = @title;

	END
	ELSE IF(@title='HEALTH')
	BEGIN
	set @total = (SELECT count(*) FROM [OpsCare].[dbo].[KForkLiftCurrentData] where JSON_VALUE(JsonValueFields, N'$.type') = 'Driver');
	set @inUsed = (SELECT count(*) FROM [OpsCare].[dbo].[KForkLiftCurrentData] where JSON_VALUE(JsonValueFields, N'$.type') = 'Driver' and ISNULL(JSON_VALUE(JsonValueFields, N'$.status'),'Offline') = 'Free' );
	
	Select cast(cast( (cast(ISNULL(@inUsed,0) as decimal(10,2)) / cast(ISNULL(@total,0) as decimal(10,2))) * 100 as integer) as varchar)+ '%' as percentage,
	cast( (cast(ISNULL(@inUsed,0) as decimal(10,2)) / cast(ISNULL(@total,0) as decimal(10,2))) * 100 as integer) as percentageNum,
	 @title as 'widgetTitle', targetText from WidgetProgressGaugeCollection where belongsTo ='kFork' and widgetTitle = @title;


	END
END
GO
/****** Object:  StoredProcedure [dbo].[GetNearMissTrend]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetNearMissTrend]
AS

BEGIN
       
	   SET NOCOUNT ON;
       DECLARE @createtable VARCHAR(max)

       CREATE TABLE #temptable
       (
              x_axis varchar(1000),
              data INTEGER
       )

       SET @createtable = 'INSERT INTO #temptable SELECT vYear, SUM(TotalNearMiss) as num_of_cases FROM vw_KPI_HSE_NearMiss
							GROUP BY vYear'
       EXEC(@createtable)


	   SELECT  x_axis, data FROM #temptable 

END

GO
/****** Object:  StoredProcedure [dbo].[GetPanelLineData]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetPanelLineData]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

  select s.tagname, s.value,s.timestamp,s.samplingmode, m.machinename as machinename, 
 CASE WHEN s.value = 288 THEN '/Thingworx/MediaEntities/YOTF_GreenDot'  
 ELSE '/Thingworx/MediaEntities/YOTF_RedDot' 
 END as imageLink  from openquery("GEHISTORIAN",'select * from ihRawData where samplingmode="Current" ') s right join 
 OpsCare_PaneLineMachine m on s.tagname = m.tagname 

END
GO
/****** Object:  StoredProcedure [dbo].[GetPanelLineProgressData]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetPanelLineProgressData]
	-- Add the parameters for the stored procedure here
	@title varchar(150)
AS
	declare @total int;
	declare @isNormal int;
	declare @isAlarm int;
	
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	set @total = (select  count(*) from openquery("GEHISTORIAN",'select * from ihRawData where samplingmode="Current" ') s right join 
	 OpsCare_PaneLineMachine m on s.tagname = m.tagname)

	set @isAlarm = (select count(CASE WHEN (s.value IS NULL or s.value = 61440)  then 1 ELSE NULL END) from openquery("GEHISTORIAN",'select * from ihRawData where samplingmode="Current" ') s right join 
 OpsCare_PaneLineMachine m on s.tagname = m.tagname);

	--set @isNormal = (select count(CASE WHEN value = 288 then 1 ELSE NULL END) from openquery("GEHISTORIAN",'select * from ihRawData where  samplingmode="Current" '));
	set @isNormal = ( select count(CASE WHEN (TRY_PARSE(value as int) LIKE '%[0-9]%') then CASE when value=288 then 1 ELSE null end ELSE NULL END) from openquery("GEHISTORIAN",'select * from ihRawData where  samplingmode="Current" '));
    -- Insert statements for procedure here
	IF(@title = 'UTILIZATION')
	BEGIN
	Select cast(cast( (cast('2' as decimal(10,2)) / cast('9' as decimal(10,2))) * 100 as integer) as varchar)+ '%' as percentage,
	cast( (cast('2' as decimal(10,2)) / cast('9' as decimal(10,2))) * 100 as integer) as percentageNum,
	@title as 'widgetTitle', targetText from WidgetProgressGaugeCollection where belongsTo ='PanelLine' and widgetTitle = @title;
	--select opm.machinename, count(*) as utilization from openquery("GEHISTORIAN",'select * from ihRawData') ge,OpsCare_PaneLineMachine opm where ge.tagname = opm.tagname group by opm.tagname,opm.machinename;
	--select * from openquery("GEHISTORIAN",'select * from ihRawData   ');



	END
	ELSE IF(@title='HEALTH')
	BEGIN
	Select cast(cast( (cast(ISNULL(@isNormal,0) as decimal(10,2)) / cast(ISNULL(@total,0) as decimal(10,2))) * 100 as integer) as varchar)+ '%' as percentage,
	cast( (cast(ISNULL(@isNormal,0) as decimal(10,2)) / cast(ISNULL(@total,0) as decimal(10,2))) * 100 as integer) as percentageNum,
	 @title as 'widgetTitle', targetText from WidgetProgressGaugeCollection where belongsTo ='PanelLine' and widgetTitle = @title;
	END
END
GO
/****** Object:  StoredProcedure [dbo].[GetPanelLineTotals]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetPanelLineTotals]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select  count(*) as total, 
(select count(CASE WHEN (TRY_PARSE(value as int) LIKE '%[0-9]%') then CASE when value=288 then 1 ELSE null end ELSE NULL END) from openquery("GEHISTORIAN",'select * from ihRawData where  samplingmode="Current" ')) as normal,
 (select count(CASE WHEN (s.value IS NULL or s.value = 61440)  then 1 ELSE NULL END) from openquery("GEHISTORIAN",'select * from ihRawData where samplingmode="Current" ') s right join 
 OpsCare_PaneLineMachine m on s.tagname = m.tagname ) as alarm
from openquery("GEHISTORIAN",'select * from ihRawData where samplingmode="Current" ') s right join 
	 OpsCare_PaneLineMachine m on s.tagname = m.tagname 

END
GO
/****** Object:  StoredProcedure [dbo].[GetRecordableInjuryRate]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetRecordableInjuryRate]
	@year AS VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @selectstatement VARCHAR(max)

	CREATE TABLE #temptable
	(
			workmonth VARCHAR(1000),
			data FLOAT
	)

	CREATE TABLE #prevtemptable
	(
			month VARCHAR(1000),
			data FLOAT
	)

	CREATE TABLE #currtemptable
	(
			month varchar(1000),
			data FLOAT
	)

	-- Creating #temptable with 53 work weeks
	DECLARE @id INT
	SET @id = 1
	WHILE (@id <= 12)
	BEGIN
		insert into #temptable (workmonth) values (@id)
		SELECT @id = @id + 1
	END
	IF(@year = 'prev_year')
	BEGIN
		INSERT INTO #prevtemptable SELECT s1.vMonth, ROUND(s1.data/s2.data,2) FROM(
		SELECT vYear,vMonth, (SUM(SUM(TotalInjury)) OVER (ORDER BY vYear, vMonth)) as data
		FROM vw_KPI_HSE_Injury i
		WHERE (Nature IN ('First Aid','Non-Reportable') OR Nature LIKE 'Reportable%') AND vYear = (SELECT YEAR(getdate()) - 1)
		GROUP BY vYear,VMonth) s1, (SELECT vYear,vMonth, (SUM(SUM(TotalManhourinMil)) OVER (ORDER BY vYear, vMonth)) as data
		FROM KPI_HSE_TotalMH WHERE vYear = (SELECT YEAR(getdate()) -1 ) GROUP BY vYear,VMonth) s2
		WHERE s1.vYear = s2.vYear AND s1.vMonth = s2.vMonth

		UPDATE #temptable SET data = 
		(SELECT data FROM #prevtemptable WHERE month = workmonth)
	END
	ELSE
	BEGIN
		INSERT INTO #currtemptable SELECT s1.vMonth, ROUND(s1.data/s2.data,2) FROM(
		SELECT vYear,vMonth, (SUM(SUM(TotalInjury)) OVER (ORDER BY vYear, vMonth)) as data
		FROM vw_KPI_HSE_Injury i
		WHERE(Nature IN ('First Aid','Non-Reportable') OR Nature LIKE 'Reportable%') AND vYear = (SELECT YEAR(getdate()))
		GROUP BY vYear,VMonth) s1, (SELECT vYear,vMonth, (SUM(SUM(TotalManhourinMil)) OVER (ORDER BY vYear, vMonth)) as data
		FROM KPI_HSE_TotalMH WHERE vYear = (SELECT YEAR(getdate())) GROUP BY vYear,VMonth) s2
		WHERE s1.vYear = s2.vYear AND s1.vMonth = s2.vMonth

		UPDATE #temptable SET data = 
		(SELECT data FROM #currtemptable WHERE month = workmonth)
	END
	SELECT * from #temptable


END
GO
/****** Object:  StoredProcedure [dbo].[GetRecordableInjuryTrend]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetRecordableInjuryTrend]
AS

BEGIN
       
	   SET NOCOUNT ON;
       DECLARE @createtable VARCHAR(max)
	   DECLARE @updatetable VARCHAR(max)

       CREATE TABLE #temptable
       (
              injury_type varchar(1000),
              year varchar(1000),
              data INTEGER
       )

		INSERT INTO #temptable SELECT Nature, vYear, SUM(TotalInjury) as num_of_cases FROM vw_KPI_HSE_Injury 
		WHERE (Nature IN ('First Aid','Non-Reportable') OR Nature LIKE 'Reportable%')
		GROUP BY Nature, vYear
                             
	   SET @updatetable = 'Update #temptable SET injury_type=''Reportable'' WHERE injury_type LIKE ''Reportable%'''
	   EXEC(@updatetable)

	   SELECT injury_type, year, SUM(data) as num_of_cases FROM #temptable 
		WHERE (injury_type IN ('First Aid','Non-Reportable') OR injury_type LIKE 'Reportable%')
		GROUP BY injury_type, year
       

END

GO
/****** Object:  StoredProcedure [dbo].[GetRecordableWeeklyCumulative]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetRecordableWeeklyCumulative]
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @selectstatement VARCHAR(max)

	CREATE TABLE #temptable
	(
			workweek varchar(1000),
			prev_year_data INTEGER,
			curr_year_data INTEGER
	)

	CREATE TABLE #prevtemptable
	(
			week varchar(1000),
			data INTEGER
	)

	CREATE TABLE #currtemptable
	(
			week varchar(1000),
			data INTEGER
	)

	-- Creating #temptable with 53 work weeks
	DECLARE @id INT
	SET @id = 1
	WHILE (@id <= 53)
	BEGIN
		insert into #temptable (workweek) values (@id)
		SELECT @id = @id + 1
	END

	INSERT INTO #prevtemptable SELECT vWeek, SUM(SUM(TotalInjury)) OVER (ORDER BY vYear, vWeek) as data FROM vw_KPI_HSE_Injury
	WHERE (Nature LIKE 'First Aid' OR Nature LIKE 'Reportable%' OR Nature LIKE 'Non-Reportable') AND vYear = (SELECT YEAR(getdate()) - 1)
	GROUP BY vYear, vWeek

	UPDATE #temptable SET prev_year_data = 
	(SELECT data FROM #prevtemptable WHERE week = workweek)

	INSERT INTO #currtemptable SELECT vWeek, SUM(SUM(TotalInjury)) OVER (ORDER BY vYear, vWeek) as data FROM vw_KPI_HSE_Injury
	WHERE (Nature LIKE 'First Aid' OR Nature LIKE 'Reportable%' OR Nature LIKE 'Non-Reportable') AND vYear = (SELECT YEAR(getdate()))
	GROUP BY vYear, vWeek

	UPDATE #temptable SET curr_year_data = 
	(SELECT data FROM #currtemptable WHERE week = workweek)

	SELECT * from #temptable


END
GO
/****** Object:  StoredProcedure [dbo].[GetSecurityClosureRate]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetSecurityClosureRate]
	@category AS VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF(@category = 'closure_rate')
	BEGIN
	SELECT ROUND((CAST(sum(ClosedCase) AS FLOAT)/CAST(sum(TotalCases) AS FLOAT))*100,2) as closure_rate, 
	  CAST(sum(TotalCases) AS FLOAT) - CAST(sum(ClosedCase) AS FLOAT) as open_cases
	  FROM [OpsCare].[dbo].[KPI_Security_CasesInvestigated]
	  where vYear = YEAR(GETDATE())
	END
	ELSE
	BEGIN
	SELECT ROUND((CAST(sum(ClosedCaseLT30Days) AS FLOAT)/CAST(sum(TotalCases) AS FLOAT))*100,2) as closure_rate,
	  CAST(sum(TotalCases) AS FLOAT) - CAST(sum(ClosedCaseLT30Days) AS FLOAT) as open_cases
	  FROM [OpsCare].[dbo].[KPI_Security_CasesInvestigated]
	  where vYear = YEAR(GETDATE())
	END
END
GO
/****** Object:  StoredProcedure [dbo].[GetSecurityLeadStatistics]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetSecurityLeadStatistics]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT LeadingStatistics,sum(value) as value
	  FROM [OpsCare].[dbo].[KPI_Security_LeadingStatistics]
	  WHERE vYear = YEAR(GETDATE())
	  GROUP BY LeadingStatistics
END
GO
/****** Object:  StoredProcedure [dbo].[GetSecurityMonthlyStat]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetSecurityMonthlyStat]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT vMonth,sum(TotalCases) as value
	  FROM [OpsCare].[dbo].[KPI_Security_CasesInvestigated]
	  where vYear = YEAR(GETDATE())
	  group by vYear,VMonth
END
GO
/****** Object:  StoredProcedure [dbo].[GetSubconWorkforceAbsence]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ajay Daniel>
-- Create date: <26/03/2020>
-- Description:	<Used to give value to the donut and trend in KOMPI subcon attendence page>
-- =============================================
CREATE PROCEDURE [dbo].[GetSubconWorkforceAbsence]
	@category VARCHAR(15)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if(@category = 'table')
	  BEGIN
		SELECT Subcontractor,COUNT(Name) AS AbsentNumber
		  FROM KPI_Ops_Daily_Absence
		  WHERE WorkDate = '2020-03-09 00:00:00'
		  GROUP BY Subcontractor
		  ORDER BY AbsentNumber DESC
	  END
	 ELSE
	 BEGIN
		SELECT JCTrade as Trade, COUNT(Name) AS AbsentNumber
		  FROM KPI_Ops_Daily_Absence 
		  WHERE WorkDate = '2020-03-09 00:00:00'
		  AND Leave = @category
		  GROUP BY Leave, JCTrade
	 END

END
GO
/****** Object:  StoredProcedure [dbo].[GetSubconWorkforceAttendance]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ajay Daniel>
-- Create date: <26/03/2020>
-- Description:	<Used to give value to the donut and trend in KOMPI subcon attendance page>
-- =============================================
CREATE PROCEDURE [dbo].[GetSubconWorkforceAttendance]
	@category VARCHAR(15)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if(@category = 'today')
	BEGIN
		SELECT TOP 1 ROUND(CAST(CAST(TotalAttendence AS FLOAT)/CAST(PreAllocatedRCWorkers AS FLOAT) AS FLOAT)*100,2) AS AttendancePercentage,PreAllocatedRCWorkers as TotalAttendance
		  FROM [OpsCare].[dbo].[KPI_Ops_Daily_Manpower]
	  ORDER BY WorkDate DESC
	END
	ELSE
	BEGIN
		SELECT TOP 7 CAST(CAST(WorkDate AS DATE) AS VARCHAR(10)) as WorkDate,ROUND(CAST(CAST(TotalAttendence AS FLOAT)/CAST(PreAllocatedRCWorkers AS FLOAT) AS FLOAT)*100,2) AS AttendancePercentage 
		  FROM [OpsCare].[dbo].[KPI_Ops_Daily_Manpower]
		  ORDER BY WorkDate ASC
	END
END
GO
/****** Object:  StoredProcedure [dbo].[GetSubstationData]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetSubstationData]
	@category VARCHAR(100),
	@start_date DATETIME,
	@end_date DATETIME
AS
BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if(@category = 'active_power')
	BEGIN
		SELECT convert(datetime,timestamp) as timestamp,[Meter_7_Active_Power_Total]/1000 as 'data1',
		[Meter_8_Active_Power_Total]/1000 as 'data2',[Meter_9_Active_Power_Total]/1000 as 'data3' FROM
		(
			SELECT tagname,value,timestamp FROM TempRawData WHERE tagname LIKE '%[_]Active_Power%'
		) AS t1 
		PIVOT
		(
			MAX(value)
			FOR tagname IN ([Meter_7_Active_Power_Total],[Meter_8_Active_Power_Total],[Meter_9_Active_Power_Total])
		) AS pivot_table
		WHERE (convert(datetime,timestamp) >= @start_date and convert(datetime,timestamp) <= @end_date)
		order by timestamp
	END
	ELSE IF(@category = 'current')
	BEGIN
		SELECT convert(datetime,timestamp) as timestamp,[Meter_7_Current_Avg] as 'data1',[Meter_8_Current_Avg] as 'data2',[Meter_9_Current_Avg] as 'data3' FROM
		(
			SELECT tagname,value,timestamp FROM TempRawData WHERE tagname LIKE '%Current_Avg%'
		) AS t1 
		PIVOT
		(
			MAX(value)
			FOR tagname IN ([Meter_7_Current_Avg],[Meter_8_Current_Avg],[Meter_9_Current_Avg])
		) AS pivot_table
		WHERE (convert(datetime,timestamp) >= @start_date and convert(datetime,timestamp) <= @end_date)
		order by timestamp
	END
	ELSE IF(@category = 'voltage')
	BEGIN
		SELECT convert(datetime,timestamp) as timestamp,[Meter_7_Voltage_L_to_L],[Meter_7_Voltage_L_to_N],[Meter_8_Voltage_L_to_L],[Meter_8_Voltage_L_to_N],[Meter_9_Voltage_L_to_L],[Meter_9_Voltage_L_to_N] FROM
		(
			SELECT tagname,value,timestamp FROM TempRawData WHERE tagname IN ('Meter_7_Voltage_L_to_L','Meter_7_Voltage_L_to_N','Meter_8_Voltage_L_to_L','Meter_8_Voltage_L_to_N','Meter_9_Voltage_L_to_L','Meter_9_Voltage_L_to_N')
		) AS t1 
		PIVOT
		(
			MAX(value)
			FOR tagname IN ([Meter_7_Voltage_L_to_L],[Meter_7_Voltage_L_to_N],[Meter_8_Voltage_L_to_L],[Meter_8_Voltage_L_to_N],[Meter_9_Voltage_L_to_L],[Meter_9_Voltage_L_to_N])
		) AS pivot_table
		WHERE (convert(datetime,timestamp) >= @start_date and convert(datetime,timestamp) <= @end_date)
		order by timestamp
	END
	ELSE
	BEGIN
		SELECT convert(datetime,timestamp) as timestamp,
			([Meter_7_Active_Power_Total]/([Meter_7_Current_Avg] * [Meter_7_Voltage_L_to_L])) as 'data1', 
			([Meter_8_Active_Power_Total]/([Meter_8_Current_Avg] * [Meter_8_Voltage_L_to_L])) as 'data2',
			([Meter_9_Active_Power_Total]/([Meter_9_Current_Avg] * [Meter_9_Voltage_L_to_L])) as 'data3'
			FROM
			(
				SELECT tagname,value,timestamp FROM TempRawData WHERE tagname IN (
				'Meter_7_Current_Avg','Meter_7_Active_Power_Total','Meter_7_Voltage_L_to_L',
				'Meter_8_Current_Avg','Meter_8_Active_Power_Total','Meter_8_Voltage_L_to_L',
				'Meter_9_Current_Avg','Meter_9_Active_Power_Total','Meter_9_Voltage_L_to_L'
				)
			) AS t1 
			PIVOT
			(
				MAX(value)
				FOR tagname IN (
				[Meter_7_Current_Avg],[Meter_7_Active_Power_Total],[Meter_7_Voltage_L_to_L],
				[Meter_8_Current_Avg],[Meter_8_Active_Power_Total],[Meter_8_Voltage_L_to_L],
				[Meter_9_Current_Avg],[Meter_9_Active_Power_Total],[Meter_9_Voltage_L_to_L])
			) AS pivot_table
			WHERE (convert(datetime,timestamp) >= @start_date and convert(datetime,timestamp) <= @end_date)
			order by timestamp
	END

END
GO
/****** Object:  StoredProcedure [dbo].[GetSubstationDataNew]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetSubstationDataNew]
	@category VARCHAR(100),
	@start_date DATETIME,
	@end_date DATETIME
AS
BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if(@category = 'active_power')
	BEGIN
		SELECT convert(datetime,timestamp) as timestamp,[Meter_7_Active_Power_Total]/1000 as 'data1',
		[Meter_8_Active_Power_Total]/1000 as 'data2',[Meter_9_Active_Power_Total]/1000 as 'data3','' as data4,'' as data5,'' as data6 FROM
		(
			SELECT tagname,value,timestamp FROM TempRawData WHERE tagname LIKE '%[_]Active_Power%'
		) AS t1 
		PIVOT
		(
			MAX(value)
			FOR tagname IN ([Meter_7_Active_Power_Total],[Meter_8_Active_Power_Total],[Meter_9_Active_Power_Total])
		) AS pivot_table
		WHERE (convert(datetime,timestamp) >= @start_date and convert(datetime,timestamp) <= @end_date)
		order by timestamp
	END
	ELSE IF(@category = 'current')
	BEGIN
		SELECT convert(datetime,timestamp) as timestamp,[Meter_7_Current_Avg] as 'data1',[Meter_8_Current_Avg] as 'data2',[Meter_9_Current_Avg] as 'data3' FROM
		(
			SELECT tagname,value,timestamp FROM TempRawData WHERE tagname LIKE '%Current_Avg%'
		) AS t1 
		PIVOT
		(
			MAX(value)
			FOR tagname IN ([Meter_7_Current_Avg],[Meter_8_Current_Avg],[Meter_9_Current_Avg])
		) AS pivot_table
		WHERE (convert(datetime,timestamp) >= @start_date and convert(datetime,timestamp) <= @end_date)
		order by timestamp
	END
	ELSE IF(@category = 'voltage')
	BEGIN
		SELECT convert(datetime,timestamp) as timestamp,[Meter_7_Voltage_L_to_L] as 'data1',[Meter_7_Voltage_L_to_N] as 'data2',
		[Meter_8_Voltage_L_to_L] as 'data3',[Meter_8_Voltage_L_to_N] as 'data4',[Meter_9_Voltage_L_to_L] as 'data5',
		[Meter_9_Voltage_L_to_N] as 'data6' FROM
		(
			SELECT tagname,value,timestamp FROM TempRawData WHERE tagname IN ('Meter_7_Voltage_L_to_L','Meter_7_Voltage_L_to_N','Meter_8_Voltage_L_to_L','Meter_8_Voltage_L_to_N','Meter_9_Voltage_L_to_L','Meter_9_Voltage_L_to_N')
		) AS t1 
		PIVOT
		(
			MAX(value)
			FOR tagname IN ([Meter_7_Voltage_L_to_L],[Meter_7_Voltage_L_to_N],[Meter_8_Voltage_L_to_L],[Meter_8_Voltage_L_to_N],[Meter_9_Voltage_L_to_L],[Meter_9_Voltage_L_to_N])
		) AS pivot_table
		WHERE (convert(datetime,timestamp) >= @start_date and convert(datetime,timestamp) <= @end_date)
		order by timestamp
	END
	ELSE
	BEGIN
		SELECT convert(datetime,timestamp) as timestamp,
			([Meter_7_Active_Power_Total]/([Meter_7_Current_Avg] * [Meter_7_Voltage_L_to_L])) as 'data1', 
			([Meter_8_Active_Power_Total]/([Meter_8_Current_Avg] * [Meter_8_Voltage_L_to_L])) as 'data2',
			([Meter_9_Active_Power_Total]/([Meter_9_Current_Avg] * [Meter_9_Voltage_L_to_L])) as 'data3'
			FROM
			(
				SELECT tagname,value,timestamp FROM TempRawData WHERE tagname IN (
				'Meter_7_Current_Avg','Meter_7_Active_Power_Total','Meter_7_Voltage_L_to_L',
				'Meter_8_Current_Avg','Meter_8_Active_Power_Total','Meter_8_Voltage_L_to_L',
				'Meter_9_Current_Avg','Meter_9_Active_Power_Total','Meter_9_Voltage_L_to_L'
				)
			) AS t1 
			PIVOT
			(
				MAX(value)
				FOR tagname IN (
				[Meter_7_Current_Avg],[Meter_7_Active_Power_Total],[Meter_7_Voltage_L_to_L],
				[Meter_8_Current_Avg],[Meter_8_Active_Power_Total],[Meter_8_Voltage_L_to_L],
				[Meter_9_Current_Avg],[Meter_9_Active_Power_Total],[Meter_9_Voltage_L_to_L])
			) AS pivot_table
			WHERE (convert(datetime,timestamp) >= @start_date and convert(datetime,timestamp) <= @end_date)
			order by timestamp
	END

END
GO
/****** Object:  StoredProcedure [dbo].[InsertFleetFLUserData]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InsertFleetFLUserData]
	-- Add the parameters for the stored procedure here
	@message nvarchar(4000)
AS
	declare @userType varchar(40);
	declare @userID int;
	declare @username varchar(50);
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET @userType = (Select JSON_VALUE(@message,'$.type'));	
	SET @username = (Select JSON_VALUE(@message,'$.username'));	
    -- Insert statements for procedure here
	IF EXISTS (select * from KForkUser k where k.username = JSON_VALUE(@message,'$.username') and k.password = JSON_VALUE(@message,'$.password')
	and k.type = JSON_VALUE(@message,'$.type'))
	BEGIN

		--IF(@userType='driver')
		--BEGIN
		UPDATE [dbo].[KForkLiftCurrentData]
		SET [JsonValueFields] = @message
		WHERE [userid] = (select id from KForkUser k where k.username = JSON_VALUE(@message,'$.username') and k.password = JSON_VALUE(@message,'$.password')
		and k.type = JSON_VALUE(@message,'$.type'));
		--END
		select type, id as userid,'true' as authen, 'Login successful' as message, username from KForkUser k where k.username = JSON_VALUE(@message,'$.username') and k.password = JSON_VALUE(@message,'$.password')
		and k.type = JSON_VALUE(@message,'$.type') 


	END
	ELSE
	BEGIN
		
		select TOP 1 '' as type, '0' as userid,'false' as authen, 'Login failed' as message, @username as username 

	END

END
GO
/****** Object:  StoredProcedure [dbo].[InsertGasCheckerData]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InsertGasCheckerData]
	-- Add the parameters for the stored procedure here
	@message nvarchar(4000)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--set @message = '{"DeviceID": "gaschecker01","Values":[{"timestamp":"19:06:27:14:23:50","unit_id":"W01B000015W2","location":"AreaRAE","unit_status":"OK","GPS":"GPS:0.000000,0.000000","lel_unit":"%LEL","lel":"0","lel_status":"OK","o2_unit":"%","O2":"20.9","o2_status":"OK","co_unit":"ppm","co":"0","co_status":"OK","h2s_unit":"ppm","h2s":"0.0","h2s_status":"OK"}{"timestamp":"19:06:27:14:23:53","unit_id":"W01B000015W2","location":"AreaRAE","unit_status":"OK","GPS":"GPS:0.000000,0.000000","lel_unit":"%LEL","lel":"0","lel_status":"OK","o2_unit":"%","O2":"20.9","o2_status":"OK","co_unit":"ppm","co":"0","co_status":"OK","h2s_unit":"ppm","h2s":"0.0","h2s_status":"OK"}{"timestamp":"19:06:27:14:23:54","unit_id":"W01B000015W2","location":"AreaRAE","unit_status":"OK","GPS":"GPS:0.000000,0.000000","lel_unit":"%LEL","lel":"0","lel_status":"OK","o2_unit":"%","O2":"20.9","o2_status":"OK","co_unit":"ppm","co":"0","co_status":"OK","h2s_unit":"ppm","h2s":"0.0","h2s_status":"OK"}{"timestamp":"19:06:27:14:23:57","unit_id":"W01B000015W2","location":"AreaRAE","unit_status":"OK","GPS":"GPS:0.000000,0.000000","lel_unit":"%LEL","lel":"0","lel_status":"OK","o2_unit":"%","O2":"20.9","o2_status":"OK","co_unit":"ppm","co":"0","co_status":"OK","h2s_unit":"ppm","h2s":"0.0","h2s_status":"OK"}{"timestamp":"19:06:27:14:23:59","unit_id":"W01B000015W2","location":"AreaRAE","unit_status":"OK","GPS":"GPS:0.000000,0.000000","lel_unit":"%LEL","lel":"0","lel_status":"OK","o2_unit":"%","O2":"20.9","o2_status":"OK","co_unit":"ppm","co":"0","co_status":"OK","h2s_unit":"ppm","h2s":"0.0","h2s_status":"OK"}]}';
	SET NOCOUNT ON;

	declare @curValue nvarchar(4000)
    -- Insert statements for procedure here

	-- get message json last record and insert into current data table
	set @curValue =( select top 1 value 
    from openjson(@message,'$.Values')
    order by [key] desc)

	DELETE FROM GasCheckerCurrentData;

	INSERT INTO [dbo].[GasCheckerCurrentData]
           ([assetId]
           ,[value]
           ,[receivedDate]) VALUES (1,@curValue,GETDATE());



	-- insert history

	  INSERT INTO GasCheckerData
  (assetId, value,receivedDate)
   SELECT  1 as assetId, [value], GETDATE() as receivedDate
	from openjson(@message,'$.Values') t1
	 WHERE JSON_VALUE(t1.value,'$.timestamp') not IN (SELECT JSON_VALUE(t2.value,'$.timestamp') as timestamp
						FROM GasCheckerData t2
					   )


	
END
GO
/****** Object:  StoredProcedure [dbo].[InsertPersonnelTrackingUserData]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InsertPersonnelTrackingUserData]
	-- Add the parameters for the stored procedure here
	@message nvarchar(4000)
AS
	declare @userType varchar(40);
	declare @userID int;
	declare @username varchar(50);
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	--SET @userType = (Select JSON_VALUE(@message,'$.type'));	
	SET @username = (Select JSON_VALUE(@message,'$.username'));	

	--print @userType;
	print @username;
    -- Insert statements for procedure here
	IF EXISTS (select * from PersonnelTrackingUser k where k.username = JSON_VALUE(@message,'$.username') and k.password = JSON_VALUE(@message,'$.password'))
	BEGIN
		print 'in';
		--IF(@userType='driver')
		--BEGIN
		UPDATE [dbo].[PersonnelTrackingCurrentData]
		SET [JsonValueFields] = @message
		WHERE [userid] = (select id from KForkUser k where k.username = JSON_VALUE(@message,'$.username') and k.password = JSON_VALUE(@message,'$.password')
		and k.type = JSON_VALUE(@message,'$.type'));
		--END
		select type, id as userid,'true' as authen, 'Login successful' as message, username from PersonnelTrackingUser k where k.username = JSON_VALUE(@message,'$.username') and k.password = JSON_VALUE(@message,'$.password');
		


	END
	ELSE
	BEGIN
		print 'not in';
		select TOP 1 '' as type, '0' as userid,'false' as authen, 'Login failed' as message, @username as username 

	END

END

GO
/****** Object:  StoredProcedure [dbo].[KPI_Commercial_GetData]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[KPI_Commercial_GetData]
	@category VARCHAR(100)
AS
BEGIN
	DECLARE @total INT
	DECLARE @cancelled INT
	DECLARE @closed INT
	DECLARE @value FLOAT 

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if(@category = 'settle_performance')
	BEGIN
		SET @total = (SELECT TOP 1 Total FROM KPI_Subcon_Settlement ORDER BY ModifiedDate DESC)
		SET @cancelled = (SELECT TOP 1 Cancelled FROM KPI_Subcon_Settlement ORDER BY ModifiedDate DESC)
		SET @closed = (SELECT TOP 1 Closed FROM KPI_Subcon_Settlement ORDER BY ModifiedDate DESC)
		SET @value = @closed*100/(@total-@cancelled)
		SELECT @value as value
	END
	ELSE IF(@category = 'award_performance')
	BEGIN
		/* temp workout to use table instead
		SET @closed = (SELECT TOP 1 SCRCLOSED FROM vw_KPI_Subcon_Award ORDER BY RetrieveDate DESC)
		SET @total = (SELECT TOP 1 SCRTOTAL FROM vw_KPI_Subcon_Award ORDER BY RetrieveDate DESC)
		*/
		SET @closed = (SELECT TOP 1 SCRCLOSED FROM KPI_Subcon_Award ORDER BY RetrieveDate DESC)
		SET @total = (SELECT TOP 1 SCRTOTAL FROM KPI_Subcon_Award ORDER BY RetrieveDate DESC)
		SET @value = ROUND(CAST(@closed as float)/CAST(@total as float),3) * 100
		SELECT @value as value
	END
	ELSE IF(@category = 'goods_receipt')
	BEGIN
		SET @value = (SELECT ROUND(CAST(SUM(metkpi) AS FLOAT)/CAST(SUM(count) AS FLOAT) * 100, 2) FROM [OpsCare].[dbo].[KPI_Logistics_GoodsReceipt]
						WHERE CONVERT(DATE,timestamp) = CONVERT(date, GETDATE()))
		SELECT @value as value
	END
	ELSE IF(@category = 'goods_issuance')
	BEGIN
		SET @value = (SELECT ROUND(CAST(SUM(metkpi) AS FLOAT)/CAST(SUM(count) AS FLOAT) * 100, 2) FROM [OpsCare].[dbo].[KPI_Logistics_GoodsIssuance]
						WHERE CONVERT(DATE,timestamp) = CONVERT(date, GETDATE()))
		SELECT @value as value

	END
	ELSE
	BEGIN
		SELECT NULL as value
	END

END
GO
/****** Object:  StoredProcedure [dbo].[PullData]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PullData] 
	-- Add the parameters fr the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @openquery varchar(max)
	DECLARE @sql varchar(max)
	DECLARE @queryenddate datetime
	DECLARE @startdate datetime
	DECLARE @enddate datetime
	DECLARE @colName VARCHAR(max)
	SET @startdate = '2020-09-09 07:00:00'
	SET @enddate = '2020-09-10 19:00:00'
	WHILE @startdate < @enddate BEGIN
		SET @queryenddate = DATEADD(MINUTE,30,@startdate)
		--SET @openquery = 'SET rowcount=10000 SELECT tagname,value,quality, timestamp FROM ihrawdata WHERE samplingmode=rawbytime AND quality=good* AND timestamp >= "'+CONVERT(VARCHAR(50),@startdate,120)+'" AND timestamp < "'+CONVERT(VARCHAR(50),@queryenddate,120)+'" AND ('+@colName+')'
		SET @openquery = 'SET rowcount=10000000000 SELECT tagname,value,quality, timestamp FROM ihrawdata WHERE samplingmode=rawbytime AND quality=good* AND timestamp >= "'+CONVERT(VARCHAR(50),@startdate,120)+'" AND timestamp < "'+CONVERT(VARCHAR(50),@queryenddate,120)+'" 
		AND (tagname = PZ1_700Crane_H1_PHASE_U_ACT_CURR or
tagname = PZ1_700Crane_H1_PHASE_V_ACT_CURR or
tagname = PZ1_700Crane_H1_PHASE_W_ACT_CURR or
tagname = PZ1_700Crane_H1_ACTUAL_POWER_FACTOR or
tagname = PZ1_700Crane_H1_ACTIVE_POWER or
tagname = PZ1_700Crane_H1_ACT_TORQUE or
tagname = PZ1_700Crane_Drive_CMS_H1VLT_CMS or
tagname = PZ1_700Crane_H2_ACTIVE_POWER or
tagname = PZ1_700Crane_H2_ACT_TORQUE or
tagname = PZ1_700Crane_H2_PHASE_U_ACT_CURR or
tagname = PZ1_700Crane_H2_PHASE_V_ACT_CURR or
tagname = PZ1_700Crane_H2_PHASE_W_ACT_CURR or
tagname = PZ1_700Crane_Drive_CMS_H2AMP_CMS or
tagname = PZ1_700Crane_H2_ACTUAL_POWER_FACTOR or
tagname = PZ1_700Crane_Drive_CMS_H2SPD_CMS or
tagname = PZ1_700Crane_Drive_CMS_H2VLT_CMS or
tagname = PZ1_700Crane_H3_ACTUAL_POWER_FACTOR or
tagname = PZ1_700Crane_H3_ACTIVE_POWER or
tagname = PZ1_700Crane_H3_ACT_TORQUE or
tagname = PZ1_700Crane_Drive_CMS_H3VLT_CMS or
tagname = PZ1_700Crane_UT_PHASE_U_ACT_CURR or
tagname = PZ1_700Crane_UT_PHASE_V_ACT_CURR or
tagname = PZ1_700Crane_UT_PHASE_W_ACT_CURR or
tagname = PZ1_700Crane_UT_ACTUAL_POWER_FACTOR or
tagname = PZ1_700Crane_UT_ACTIVE_POWER or
tagname = PZ1_700Crane_UT_ACT_TORQUE or
tagname = PZ1_700Crane_Drive_CMS_UTVLT_CMS or
tagname = PZ1_700Crane_LT_PHASE_U_ACT_CURR or
tagname = PZ1_700Crane_LT_PHASE_V_ACT_CURR or
tagname = PZ1_700Crane_LT_PHASE_W_ACT_CURR or
tagname = PZ1_700Crane_LT_ACTUAL_POWER_FACTOR or
tagname = PZ1_700Crane_LT_ACTIVE_POWER or
tagname = PZ1_700Crane_LT_ACT_TORQUE or
tagname = PZ1_700Crane_Drive_CMS_LTVLT_CMS or
tagname = PZ1_700Crane_FG_PHASE_U_ACT_CURR or
tagname = PZ1_700Crane_FG_PHASE_V_ACT_CURR or
tagname = PZ1_700Crane_FG_PHASE_W_ACT_CURR or
tagname = PZ1_700Crane_FG_ACTUAL_POWER_FACTOR or
tagname = PZ1_700Crane_FG_ACTIVE_POWER or
tagname = PZ1_700Crane_FG_ACT_TORQUE or
tagname = PZ1_700Crane_Drive_CMS_FGVLT_CMS or
tagname = PZ1_700Crane_HG_PHASE_U_ACT_CURR or
tagname = PZ1_700Crane_HG_PHASE_V_ACT_CURR or
tagname = PZ1_700Crane_HG_PHASE_W_ACT_CURR or
tagname = PZ1_700Crane_HG_ACTUAL_POWER_FACTOR or
tagname = PZ1_700Crane_HG_ACTIVE_POWER or
tagname = PZ1_700Crane_HG_ACT_TORQUE or
tagname = PZ1_700Crane_Drive_CMS_HGVLT_CMS)'
		SET @sql = 'INSERT INTO datadump(tagname,value,quality,timestamp) SELECT tagname,value,quality,timestamp from openquery("GEHISTORIAN_OPSCARE",'''+@openquery+''')'
		EXEC(@sql)
		SET @startdate = @queryenddate
	END
END
GO
/****** Object:  StoredProcedure [dbo].[SelectNearestKFork]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SelectNearestKFork]
	-- Add the parameters for the stored procedure here
	@RADIUS INT=15,
    @LAT VARCHAR(10)='',
    @LONG VARCHAR(10)='',
    @geo1 GEOGRAPHY = NULL
	
AS
	
	--SET @g = geography::STGeomFromText('POINT('+@lat+' '+@lng+')', 4326);
	
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	 SET @geo1= geography::Point(@LAT, @LONG, 4326)        
 IF EXISTS (SELECT top 3 userid as driverID,JSON_VALUE([JsonValueFields], N'$.username') as driverName, JSON_VALUE([JsonValueFields], N'$.type') as type, JSON_VALUE([JsonValueFields], N'$.lat') as lat,JSON_VALUE([JsonValueFields], N'$.lng') as lng,
	 JSON_VALUE([JsonValueFields], N'$.status') as status,(Convert(float,(LEFT(CONVERT(VARCHAR,(geography::Point(@LAT, @LONG, 4326).STDistance(geography::Point(ISNULL(JSON_VALUE([JsonValueFields], N'$.lat'),0), 
	 ISNULL(JSON_VALUE([JsonValueFields], N'$.lng'),0), 4326)))/1000),5) ))* 1000 )as MetersAway from KForkLiftCurrentData
	 WHERE (geography::Point(@LAT, @LONG, 4326).STDistance(geography::Point(ISNULL(JSON_VALUE([JsonValueFields], N'$.lat'),0), ISNULL(JSON_VALUE([JsonValueFields], N'$.lng'),0), 4326)))/1000 < 15
	 and JSON_VALUE([JsonValueFields], N'$.status') = 'Free')
	BEGIN
	 SELECT top 3 userid as driverID,JSON_VALUE([JsonValueFields], N'$.username') as driverName, JSON_VALUE([JsonValueFields], N'$.type') as type, JSON_VALUE([JsonValueFields], N'$.lat') as lat,JSON_VALUE([JsonValueFields], N'$.lng') as lng,
	 JSON_VALUE([JsonValueFields], N'$.status') as status,(Convert(float,(LEFT(CONVERT(VARCHAR,(geography::Point(@LAT, @LONG, 4326).STDistance(geography::Point(ISNULL(JSON_VALUE([JsonValueFields], N'$.lat'),0), 
	 ISNULL(JSON_VALUE([JsonValueFields], N'$.lng'),0), 4326)))/1000),5) ))* 1000 )as MetersAway from KForkLiftCurrentData
	 WHERE (geography::Point(@LAT, @LONG, 4326).STDistance(geography::Point(ISNULL(JSON_VALUE([JsonValueFields], N'$.lat'),0), ISNULL(JSON_VALUE([JsonValueFields], N'$.lng'),0), 4326)))/1000 < 15
	 and JSON_VALUE([JsonValueFields], N'$.status') = 'Free'
	 Order by MetersAway 
	END
ELSE
	BEGIN
	Select 'No Nearby ForkLift' as message;
	END


    -- Insert statements for procedure here
	
END
GO
/****** Object:  StoredProcedure [dbo].[sp_KPI_QA_GetActiveProjectRate]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_KPI_QA_GetActiveProjectRate]
@Project AS VARCHAR(20) 	
AS
BEGIN
	SET NOCOUNT ON;
			
			IF (@Project='All') 
			BEGIN

					select b.RTUTPipeDefectRate*100 as RTUTPipeDefectRate , b.RTUTHullDefectRate*100 as RTUTHullDefectRate , a.InpspectionRate*100 as InpspectionRate, a.ProjectNo from (

					SELECT 
					ISNULL(CAST(CAST(MAX(RTUTPipeDefect) AS DECIMAL(12,3)) / CAST(MAX(NULLIF(RTUTPipeInspected,0)) AS DECIMAL(12,3)) as decimal(12,3)),0) as RTUTPipeDefectRate,
					ISNULL(CAST(CAST(MAX(RTUTHullDefect) AS DECIMAL(12,3)) / CAST(MAX(NULLIF(RTUTHullInspected,0)) AS DECIMAL(12,3)) as decimal(12,3)),0) as RTUTHullDefectRate,
					ProjectNo
					FROM dbo.KPI_QA_NDTDefectRate
					WHERE NDTMethod='Liquid Penetration Testing' AND Datediff(dd,ModifiedDate,getdate())<2 group by ProjectNo) b join (
			
					SELECT MAX(ISNULL(AcceptIndex,0)) as InpspectionRate , ProjectNo FROM [dbo].[KPI_QA_InspectionPassRate] 
					WHERE 
					 DisciplineName='OverAll' AND ModifiedDate >= DATEADD(day, -2, getdate()) group by ProjectNo ) a on b.ProjectNo = a.ProjectNo ;
			END
			ELSE
			BEGIN
					select b.RTUTPipeDefectRate*100 as RTUTPipeDefectRate , b.RTUTHullDefectRate*100 as RTUTHullDefectRate , a.InpspectionRate*100 as InpspectionRate, a.ProjectNo from (

					SELECT 
					ISNULL(CAST(CAST(MAX(RTUTPipeDefect) AS DECIMAL(12,3)) / CAST(MAX(NULLIF(RTUTPipeInspected,0)) AS DECIMAL(12,3)) as decimal(12,3)),0) as RTUTPipeDefectRate,
					ISNULL(CAST(CAST(MAX(RTUTHullDefect) AS DECIMAL(12,3)) / CAST(MAX(NULLIF(RTUTHullInspected,0)) AS DECIMAL(12,3)) as decimal(12,3)),0) as RTUTHullDefectRate,
					ProjectNo
					FROM dbo.KPI_QA_NDTDefectRate
					WHERE NDTMethod='Liquid Penetration Testing' AND Datediff(dd,ModifiedDate,getdate())<2 group by ProjectNo) b join (
			
					SELECT MAX(ISNULL(AcceptIndex,0)) as InpspectionRate , ProjectNo FROM [dbo].[KPI_QA_InspectionPassRate] 
					WHERE 
					 DisciplineName='OverAll' AND ModifiedDate >= DATEADD(day, -30, getdate()) group by ProjectNo ) a on b.ProjectNo = a.ProjectNo where a.ProjectNo = @Project ;
			END


END
GO
/****** Object:  StoredProcedure [dbo].[sp_KPI_QA_GetInspectionPassRate]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_KPI_QA_GetInspectionPassRate]
	@Project AS VARCHAR(20) 

AS
BEGIN
	SET NOCOUNT ON;
	
	IF (@Project is not NULL) 
	BEGIN
		IF (@Project='All') 
		BEGIN
			SELECT AVG(AcceptIndex) AS AvgAcceptIndex FROM [dbo].[KPI_QA_InspectionPassRate] 
			WHERE DisciplineName='OverAll' AND Datediff(dd,ModifiedDate,getdate())<2
		END
		ELSE
		BEGIN
		/*	SELECT AVG(AcceptIndex) AS AvgAcceptIndex FROM [dbo].[KPI_QA_InspectionPassRate] 
			WHERE ProjectNo IN (@Project)
			AND DisciplineName='OverAll' AND Datediff(dd,ModifiedDate,getdate())<1*/

		    /*get last 30 day acceptindex by project*/
			SELECT AcceptIndex AS AvgAcceptIndex, ModifiedDate FROM [dbo].[KPI_QA_InspectionPassRate] 
			WHERE ProjectNo IN (@Project)
			AND DisciplineName='OverAll' AND ModifiedDate >= DATEADD(day, -30, getdate())  order by ModifiedDate desc

		
		END
	END
	

END

GO
/****** Object:  StoredProcedure [dbo].[sp_KPI_QA_GetNDTDefectRate]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[sp_KPI_QA_GetNDTDefectRate]
	@Project AS VARCHAR(20) 

AS
BEGIN
	SET NOCOUNT ON;
	
	IF (@Project is not NULL) 
	BEGIN
		IF (@Project='All') 
		BEGIN
			SELECT SUM(CONVERT(BIGINT, RTUTHullDefect)) as RTUTHullDefect, 
			SUM(CONVERT(BIGINT, RTUTHullInspected)) as RTUTHullInspected, 
			SUM(CONVERT(BIGINT, RTUTPipeDefect)) as RTUTPipeDefect, 
			SUM(CONVERT(BIGINT, RTUTPipeInspected)) as RTUTPipeInspected
			FROM dbo.KPI_QA_NDTDefectRate
			WHERE NDTMethod='Liquid Penetration Testing' AND Datediff(dd,ModifiedDate,getdate())<1
			--Just pick any 1 NDTMethod, as all records are the same
		END
		ELSE
		BEGIN
			SELECT SUM(CONVERT(BIGINT, RTUTHullDefect)) as RTUTHullDefect, 
			SUM(CONVERT(BIGINT, RTUTHullInspected)) as RTUTHullInspected, 
			SUM(CONVERT(BIGINT, RTUTPipeDefect)) as RTUTPipeDefect, 
			SUM(CONVERT(BIGINT, RTUTPipeInspected)) as RTUTPipeInspected
			FROM dbo.KPI_QA_NDTDefectRate
			WHERE ProjectNo IN(@Project) AND NDTMethod='Liquid Penetration Testing' AND Datediff(dd,ModifiedDate,getdate())<1
			--Just pick any 1 NDTMethod, as all records are the same
		END
	END
	

END

GO
/****** Object:  StoredProcedure [dbo].[sp_KPI_QA_GetPunchList]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [dbo].[sp_KPI_QA_GetPunchList]
	@Project AS VARCHAR(20) 

AS
BEGIN
	SET NOCOUNT ON;
	
	BEGIN
	  IF (@Project is not NULL) 	
		DECLARE @FULLSQL NVARCHAR(4000),@q NVARCHAR(1),@s1 NVARCHAR(2000),@s2 NVARCHAR(500),@s3 NVARCHAR(1000)
		set @q = ''''

		 SET @s1 = 'SELECT SubQuery.DepartmentID, SubQuery.DepartmentName, SUM(SubQuery.OutstgCatA) AS [OutstgCatA], SUM(SubQuery.OutstgCatB) AS [OutstgCatB], SUM(SubQuery.OutstgTotal) AS [OutstgTotal]
			INTO #Overall
			FROM (
			SELECT 
				ResponsibleBy.DepartmentID, 
				ResponsibleDept.DepartmentCode AS DepartmentName, 
				ISNULL(COUNT(PLI.PunchListItemID), 0) AS [IssuedTotal],
				ISNULL((SELECT COUNT(PLI.PunchListItemID) WHERE PLI.CloseReferenceNo IS NULL), 0) AS [OutstgTotal],
				ISNULL((SELECT COUNT(PLI.PunchListItemID) WHERE PLI.CloseReferenceNo IS NULL AND PLI.Category IN (''A'', ''1'')), 0) AS [OutstgCatA],
				ISNULL((SELECT COUNT(PLI.PunchListItemID) WHERE PLI.CloseReferenceNo IS NULL AND PLI.Category IN (''B'', ''2'')), 0) AS [OutstgCatB]
			FROM [10.58.136.120,1399].[KFELSQRMS].[dbo].tblPunchList PL
			INNER JOIN [10.58.136.120,1399].[KFELSQRMS].[dbo].tblPunchListItem PLI ON PL.PunchListID = PLI.PunchListID
			INNER JOIN [10.58.136.120,1399].[KFELSQRMS].[dbo].tblDepartment D ON PL.DepartmentID = D.DepartmentID
			INNER JOIN [10.58.136.120,1399].[KFELSQRMS].[dbo].tblProject P on P.ProjectID = PL.ProjectID 
			LEFT JOIN [10.58.136.120,1399].[KFELSQRMS].[dbo].tblDepartmentPerson ResponsibleBy ON PLI.PunchListResponsiblePersonID = ResponsibleBy.DepartmentPersonID
			LEFT JOIN [10.58.136.120,1399].[KFELSQRMS].[dbo].tblDepartment ResponsibleDept ON ResponsibleBy.DepartmentID = ResponsibleDept.DepartmentID
			WHERE '

		IF (@Project='All') 
			set @s2 = 'P.ProjectNo in(''B366'',''B367'',''B368'',''B370'',''B373'',''B379'',''B380'',''B381'',''C0016'',''C0017'',''H402'',''H403'',''H411'',''R436'',''R440'')' 	
		ELSE
			set @s2 = 'P.ProjectNo =' +@q+@Project+@q

		set @s3=' GROUP BY ResponsibleBy.DepartmentID, ResponsibleDept.DepartmentCode, PLI.CloseReferenceNo, PLI.Category
		) AS SubQuery
		GROUP BY SubQuery.DepartmentID, SubQuery.DepartmentName
		order by SubQuery.DepartmentName
		select * from #Overall	
		drop table #Overall'

		set @FULLSQL = @s1+@s2+@s3
		--select @FULLSQL
		EXEC sp_executesql @FULLSQL

	END
	

END


GO
/****** Object:  StoredProcedure [dbo].[sp_KPI_QA_PopulateInspectionPassRate]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[sp_KPI_QA_PopulateInspectionPassRate]

AS
BEGIN
	SET NOCOUNT ON;
	DECLARE
	@s1 NVARCHAR(4000),@s2 NVARCHAR(1000),@s3 NVARCHAR(500),@s4 NVARCHAR(500),@s5 NVARCHAR(500),@s6 NVARCHAR(1000),@s7 NVARCHAR(50),@FULLSQL NVARCHAR(4000),@dtStart NVARCHAR(100),@dtEnd NVARCHAR(100),@q NVARCHAR(1)
	
	-- As per QA requirement, only shows the KPI for last 30 days
	SET @dtStart = CONVERT(VARCHAR,dateadd(dd,-30,GETDATE()), 20)
	SET @dtEnd = CONVERT(VARCHAR,GETDATE(), 20)
	
	-- If records exist, delete
	DELETE FROM [dbo].[KPI_QA_InspectionPassRate] WHERE Datediff(dd,ModifiedDate,getdate())<1
		
	set @s1 = 'INSERT INTO [dbo].[KPI_QA_InspectionPassRate] 
				SELECT [ProjectNo],[ProjectName],[DisciplineCode],[DisciplineName],[TotalInspection],[FirstTimeFailInspection],[AcceptIndex],[FirstTimeFailIndex],[FromDate],[ToDate],[AI],[FI],getdate()
				FROM '
	set @s2 = 'OPENQUERY([10.58.136.120,1399],''EXEC [KFELSQRMS].[dbo].QRMSDb_SP_InspectionGraphAcceptIndexReport @ProjectID=NULL,@FromDate='''
	set @q = ''''
	set @s3 = @q+@dtStart+@q
	set @s4 = @q+',@ToDate='''
	set @s5 = @q+@dtEnd+@q
	set @s6 = @q+',@RegionID=1,@LoginUserID=NULL'+@q
	set @s7 = ')'

	SET @FULLSQL = @s1+@s2+@s3+@s4+@s5+@s6+@s7
	
	EXEC sp_executesql @FULLSQL
	
END





GO
/****** Object:  StoredProcedure [dbo].[sp_KPI_QA_PopulateNDTDefectRate]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [dbo].[sp_KPI_QA_PopulateNDTDefectRate]

AS
BEGIN
	SET NOCOUNT ON;
	DECLARE
	@s1 NVARCHAR(4000),@s2 NVARCHAR(1000),@s3 NVARCHAR(500),@s4 NVARCHAR(500),@s5 NVARCHAR(500),@s6 NVARCHAR(1000),@s7 NVARCHAR(50),@FULLSQL NVARCHAR(4000),@dtStart NVARCHAR(100),@dtEnd NVARCHAR(100),@q NVARCHAR(1)
	
	-- As per QA requirement, only shows the KPI for last 30 days
	SET @dtStart = CONVERT(VARCHAR,dateadd(dd,-30,GETDATE()), 20)
	SET @dtEnd = CONVERT(VARCHAR,GETDATE(), 20)
	
	-- If records already exist, delete then insert updated records
	DELETE FROM [dbo].[KPI_QA_NDTDefectRate] WHERE Datediff(dd,ModifiedDate,getdate())<1

	set @s1 = 'INSERT INTO [dbo].[KPI_QA_NDTDefectRate]
SELECT *,	getdate()
FROM '
	set @s2 = 'OPENQUERY([10.58.136.120,1399],''EXEC [KFELSQRMS].[dbo].QRMSDB_SP_NDTDefectRateReport @ProjectID=NULL,@dtmFromDate='''
	set @q = ''''
	set @s3 = @q+@dtStart+@q
	set @s4 = @q+',@dtmToDate='''
	set @s5 = @q+@dtEnd+@q
	set @s6 = @q+',@RegionID=1,@LoginUserID=NULL'+@q
	set @s7 = ')'

	SET @FULLSQL = @s1+@s2+@s3+@s4+@s5+@s6+@s7
	--select @FULLSQL
	
	EXEC sp_executesql @FULLSQL
	
END






GO
/****** Object:  StoredProcedure [dbo].[Update_KPI_Subcon_Award_Table]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ajay Daniel
-- Create date: 22-10-2019
-- Description:	vw_KPI_Subcon_Award is too slow to return data for the thingworx page
--				therefore using this procedure to take data form the view and push it to a table
--				Job name: Update_Subcon_Award
-- =============================================
CREATE PROCEDURE [dbo].[Update_KPI_Subcon_Award_Table]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	CREATE TABLE #temptable(
		SCRTotal INT,
		SCRClosed INT,
		retrieveDate DATETIME
	)

	INSERT INTO #temptable SELECT * FROM vw_KPI_Subcon_Award

	UPDATE KPI_Subcon_Award 
	SET SCRTotal = v.SCRTotal,
	    SCRClosed = v.SCRClosed,
		RetrieveDate = v.RetrieveDate
	FROM (SELECT * FROM #temptable) v
	
END
GO
/****** Object:  StoredProcedure [dbo].[Update_Total_MH_Table]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ajay Daniel
-- Create date: 23-10-2019
-- Description:	vw_KPI_HSE_TotalMH is too slow to return data for the thingworx page
--				therefore using this procedure to take data form the view and push it to a table
--				Job name: Update_HSE_Manhour
-- =============================================
CREATE PROCEDURE [dbo].[Update_Total_MH_Table]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	DECLARE @cursor CURSOR
	DECLARE @vyear INT
	DECLARE @vmonth INT
	DECLARE @manhours DECIMAL(3,2)
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	SET @cursor = CURSOR FOR 
	SELECT Top 3 vYear,vMonth,CONVERT(DECIMAL(3,2),TotalManhourinMil) FROM vw_KPI_HSE_TotalMH ORDER BY vYear DESC,vMonth DESC
	OPEN @cursor
	FETCH NEXT
	FROM @cursor INTO @vyear,@vmonth,@manhours
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF NOT EXISTS(SELECT * FROM KPI_HSE_TotalMH WHERE vYear = @vyear AND vMonth = @vmonth)
		BEGIN
			INSERT INTO KPI_HSE_TotalMH VALUES (@vyear,@vmonth,@manhours)
		END
		ELSE
		BEGIN
			UPDATE KPI_HSE_TotalMH SET TotalManhourinMil = @manhours WHERE vYear = @vyear AND vMonth = @vmonth
		END
		
		FETCH NEXT
		FROM @cursor INTO @vyear,@vmonth,@manhours
	END
	
END
GO
/****** Object:  StoredProcedure [dbo].[ZCraneLiftData]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ajay Daniel>
-- Create date: <31/05/2019>
-- Description:	<To calculate crane load data to a table to be used by Crane page
--               Runs every night to add that days numbers to the table>
-- =============================================
CREATE PROCEDURE [dbo].[ZCraneLiftData] 
AS
BEGIN
	DECLARE @openquery VARCHAR(1000)
	DECLARE @sqlquery VARCHAR(1000)
	DECLARE @startdate datetime
	DECLARE @enddate datetime
	DECLARE @starttime datetime
	DECLARE @endtime datetime
	DECLARE @rowcount INT
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	CREATE TABLE #temptable
	(
		tagname varchar(1000),
		value varchar(1000),
		quality varchar(1000),
		timestamp DATETIME
	)
	-- Insert statements for procedure here
	IF NOT EXISTS(SELECT TOP 1 * FROM CraneLiftData) -- If the table is empty, take last one year data and dump into table
	BEGIN	
		SET @startdate = '2020-12-01 07:00:00'
		WHILE( @startdate < '2020-12-07 19:00:00')
		BEGIN
			PRINT('Getting data from '+CONVERT(VARCHAR(50),@startdate,120))
			SET @enddate = DATEADD(HOUR,12,@startdate)
			;WITH my_table AS(
				SELECT ROW_NUMBER() OVER (ORDER BY timestamp) row,timestamp, ISNULL([PZ1_700Crane_H1LOAD],0) AS [H1LOAD],
				 ISNULL([PZ1_700Crane_H2LOAD],0) AS [H2LOAD], ISNULL([PZ1_700Crane_H1LOAD],0)+ISNULL([PZ1_700Crane_H2LOAD],0) AS [SUMH1H2],
				 ISNULL([PZ1_700Crane_H3LOAD],0) AS [H3LOAD] FROM(
					  SELECT tagname, MAX(CAST(value AS FLOAT)) AS value, DATEADD(MINUTE, DATEDIFF(MINUTE, 0, timestamp), 0) as timestamp
						FROM [OpsCare].[dbo].[HistorianRawData]
						WHERE tagname LIKE '%H%LOAD%'
						AND (timestamp >= @startdate AND timestamp < @enddate)
						GROUP BY tagname,DATEADD(MINUTE, DATEDIFF(MINUTE, 0, timestamp), 0)
				  ) AS source_table
				  PIVOT(
					  SUM(value) FOR tagname IN ([PZ1_700Crane_H1LOAD],[PZ1_700Crane_H2LOAD],[PZ1_700Crane_H3LOAD])
				  ) AS pivot_table	
			)
			INSERT INTO CraneLiftData SELECT * from my_table
			SET @startdate = DATEADD(d, +1, @startdate)
			SET @enddate = DATEADD(d, +1, @enddate)
			
		END
	END
	ELSE -- If table is not empty, then take the data from the last updated time 
	BEGIN
		SET @starttime = (SELECT DATEADD(HOUR,7,(SELECT CONVERT(VARCHAR(10), getdate(), 111))))
		SET @endtime = (SELECT DATEADD(HOUR,19,(SELECT CONVERT(VARCHAR(10), getdate(), 111))))	
		;WITH my_table AS(
				SELECT ROW_NUMBER() OVER (ORDER BY timestamp) row,timestamp, ISNULL([PZ1_700Crane_H1LOAD],0) AS [H1LOAD],
				 ISNULL([PZ1_700Crane_H2LOAD],0) AS [H2LOAD], ISNULL([PZ1_700Crane_H1LOAD],0)+ISNULL([PZ1_700Crane_H2LOAD],0) AS [SUMH1H2],
				 ISNULL([PZ1_700Crane_H3LOAD],0) AS [H3LOAD] FROM(
					  SELECT tagname, MAX(CAST(value AS FLOAT)) AS value, DATEADD(MINUTE, DATEDIFF(MINUTE, 0, timestamp), 0) as timestamp
						FROM [OpsCare].[dbo].[HistorianRawData]
						WHERE tagname LIKE '%H%LOAD%'
						AND (timestamp >= @starttime AND timestamp < @endtime)
						GROUP BY tagname,DATEADD(MINUTE, DATEDIFF(MINUTE, 0, timestamp), 0)
				  ) AS source_table
				  PIVOT(
					  SUM(value) FOR tagname IN ([PZ1_700Crane_H1LOAD],[PZ1_700Crane_H2LOAD],[PZ1_700Crane_H3LOAD])
				  ) AS pivot_table	
			)
			INSERT INTO CraneLiftData SELECT * from my_table
	END

	SET @startdate = DATEADD(d, -365, GetDate())
	IF EXISTS(SELECT * FROM CraneLiftData WHERE timestamp < @startdate)
	BEGIN
		DELETE FROM CraneLiftData WHERE timestamp < @startdate -- Delete data which is more than a year old
	END
	
END
GO
/****** Object:  StoredProcedure [dbo].[ZCurrentDataFromHistorian]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ajay Daniel>
-- Create date: <31/05/2019>
-- Description:	<To get the good quality current data from Historian and store it into HistorianCurrentData table>
-- Changes Made:
-- 08/06/19 By Ajay
-- Check if tag in SQL table present then update else insert tag
-- 04/09/19 By Ajay
-- Insert only Crane data for now
-- =============================================
CREATE PROCEDURE [dbo].[ZCurrentDataFromHistorian] 
AS
BEGIN
	DECLARE @openquery VARCHAR(1000)
	DECLARE @sqlquery VARCHAR(1000)
	DECLARE @currunning CURSOR
	DECLARE @runningtagname VARCHAR(1000)
	DECLARE @runningvalue VARCHAR(1000)
	DECLARE @runningquality VARCHAR(1000)
	DECLARE @runningtimestamp datetime
	DECLARE @rowcount INT
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	CREATE TABLE #temptable
	(
		tagname varchar(1000),
		value varchar(1000),
		quality varchar(1000),
		timestamp DATETIME
	)
	 -- Insert statements for procedure here
	
	--SET @openquery = '''SELECT tagname,value,quality,timestamp FROM ihrawdata where samplingmode=current AND quality=good*'''
	SET @openquery = '''SET rowcount=10000 SELECT tagname,value,quality, timestamp FROM ihrawdata where samplingmode=current AND criteriastring="#OnlyGood" 
	     AND (tagname=PZ1_700Crane_*LOAD OR tagname=PZ1_700Crane_GSPD OR tagname=PZ1_Emerson_LowerTrolley*Velocity OR tagname=PZ1_Emerson_UpperTrolley*Velocity
		 OR tagname = PZ1_Emerson_TransformerRoom* OR tagname=PZ1_700Crane_Display_CMS_*POS_CMS*)'''
	SET @sqlquery  = 'INSERT INTO #temptable SELECT tagname,value,quality,convert(varchar, timestamp, 20) as timestamp FROM openquery("GEHISTORIAN_OPSCARE", '+@openquery+')'
	EXEC(@sqlquery)
	
	UPDATE #temptable SET tagname = LEFT(tagname, LEN(tagname) - 1) WHERE tagname LIKE '%[_]'

	SET @currunning = CURSOR FOR SELECT tagname, value, quality, timestamp FROM  #temptable

	OPEN @currunning
	FETCH NEXT
	FROM @currunning INTO @runningtagname, @runningvalue, @runningquality, @runningtimestamp
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF NOT EXISTS(SELECT * FROM HistorianCurrentData WHERE tagname=@runningtagname)
		BEGIN
			INSERT INTO HistorianCurrentData (tagname, value, quality, timestamp) VALUES (@runningtagname, @runningvalue, @runningquality, @runningtimestamp)
		END
		ELSE
		BEGIN
			UPDATE HistorianCurrentData SET value = @runningvalue, quality=@runningquality,timestamp = @runningtimestamp
			WHERE tagname = @runningtagname
		END
		FETCH NEXT
		FROM @currunning INTO @runningtagname, @runningvalue, @runningquality, @runningtimestamp
	END

END
GO
/****** Object:  StoredProcedure [dbo].[ZRawDataFromHistorian]    Script Date: 19/8/2022 10:45:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ajay Daniel>
-- Create date: <31/05/2019>
-- Description:	<To get the good quality data from Historian and store it into HistorianRawData table>
-- Changes Made:
-- 08/06/19 by Ajay
-- Add check to delete data more than a year old
-- 25/06/19 by Ajay
-- Changed the condition to use historianrawdata latest time as watermark
-- updated query to directly push to historianrawdata without a temp table
-- 04/09/19 by Ajay
-- Get only Crane data
-- =============================================
CREATE PROCEDURE [dbo].[ZRawDataFromHistorian] 
AS
BEGIN
	DECLARE @openquery VARCHAR(2000)
	DECLARE @sqlquery VARCHAR(3000)
	DECLARE @startdate datetime
	DECLARE @enddate datetime
	DECLARE @rowcount INT
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	CREATE TABLE #temptable
	(
		tagname varchar(1000),
		value varchar(1000),
		quality varchar(1000),
		timestamp DATETIME
	)
	-- Insert statements for procedure here
	IF NOT EXISTS(SELECT TOP 1 * FROM HistorianRawData) -- If the table is empty, take last one year data and dump into table
	BEGIN	
		SET @startdate = '2020-04-01 00:00:00'
		PRINT('Getting data from '+CONVERT(VARCHAR(50),@startdate,120))
		WHILE( @startdate < (SELECT TOP 1 timestamp FROM HistorianCurrentData ORDER BY timestamp DESC))
		BEGIN
			SET @enddate = DATEADD(d, +1, @startdate)
			SET @openquery = 'SET ROWCOUNT=160000000 SELECT tagname,value,quality,timestamp FROM ihrawdata where samplingmode=rawbytime 
						AND quality=good* AND timestamp >= "'+CONVERT(VARCHAR(50),@startdate,120)+'" AND timestamp <="'+CONVERT(VARCHAR(50),@enddate,120)+'"
						AND (tagname=PZ1_700Crane_GSPD or tagname=PZ1_700Crane_H1LOAD or tagname=PZ1_700Crane_H2LOAD or tagname=PZ1_700Crane_H3LOAD)'
			SET @sqlquery = 'INSERT INTO HistorianRawData (tagname, value, quality, timestamp) 
					SELECT tagname,value,quality,timestamp FROM openquery("GEHISTORIAN_OPSCARE",'''+@openquery+''')'
			
			PRINT(@sqlquery)
			EXEC(@sqlquery)
			/*
			UPDATE #temptable SET tagname = LEFT(tagname, LEN(tagname) - 1) WHERE tagname LIKE '%[_]'
			INSERT INTO HistorianRawData SELECT * FROM #temptable  ORDER BY timestamp ASC
			PRINT('Push into historianRawData completed..')
			DELETE FROM #temptable
			*/
			SET @startdate = @enddate
			
		END
	END
	ELSE -- If table is not empty, then take the data from the last updated time 
	BEGIN
		SET @startdate = (SELECT TOP 1  timestamp FROM HistorianRawData ORDER BY timestamp DESC)
		--PRINT('Getting data from '+@startdate)
		SET @openquery = 'SET ROWCOUNT=160000000 SELECT tagname,value,quality,timestamp FROM ihrawdata where samplingmode=rawbytime 
						AND quality=good* AND timestamp > "'+CONVERT(VARCHAR(50),@startdate,120)+'"
						AND tagname=PZ1_700Crane_GSPD or tagname=PZ1_700Crane_H1LOAD or tagname=PZ1_700Crane_H2LOAD or tagname=PZ1_700Crane_H3LOAD
						or tagname=PZ1_Emerson_UpperTrolley_H1_Drum_DE_H_Velocity or tagname=PZ1_Emerson_UpperTrolley_H1_Drum_DE_V_Velocity or tagname=PZ1_Emerson_UpperTrolley_H1_GB_DE_H_Velocity
						or tagname=PZ1_Emerson_UpperTrolley_H1_GB_DE_V_Velocity or tagname=PZ1_Emerson_UpperTrolley_H1_GB_NDE_H_Velocity or tagname=PZ1_Emerson_UpperTrolley_H1_GB_NDE_V_Velocity 
						or tagname=PZ1_Emerson_UpperTrolley_H1_Motor_DE_H_Velocity or tagname=PZ1_Emerson_UpperTrolley_H1_Motor_DE_V_Velocity 
						or tagname=PZ1_Emerson_UpperTrolley_H2_Drum_DE_H_Velocity or tagname=PZ1_Emerson_UpperTrolley_H2_Drum_DE_V_Velocity or tagname=PZ1_Emerson_UpperTrolley_H2_GB_DE_H_Velocity
						or tagname=PZ1_Emerson_UpperTrolley_H2_GB_DE_V_Velocity or tagname=PZ1_Emerson_UpperTrolley_H2_GB_NDE_H_Velocity or tagname=PZ1_Emerson_UpperTrolley_H2_GB_NDE_V_Velocity 
						or tagname=PZ1_Emerson_UpperTrolley_H2_Motor_DE_H_Velocity or tagname=PZ1_Emerson_UpperTrolley_H2_Motor_DE_V_Velocity
						or tagname=PZ1_Emerson_LowerTrolley_H3_Drum_DE_H_Velocity or tagname=PZ1_Emerson_LowerTrolley_H3_Drum_DE_V_Velocity or tagname=PZ1_Emerson_LowerTrolley_H3_GB_DE_H_Velocity
						or tagname=PZ1_Emerson_LowerTrolley_H3_GB_DE_V_Velocity or tagname=PZ1_Emerson_LowerTrolley_H3_GB_NDE_H_Velocity or tagname=PZ1_Emerson_LowerTrolley_H3_GB_NDE_V_Velocity 
						or tagname=PZ1_Emerson_LowerTrolley_H3_Motor_DE_H_Velocity or tagname=PZ1_Emerson_LowerTrolley_H3_Motor_DE_V_Velocity'
		SET @sqlquery = 'INSERT INTO HistorianRawData (tagname, value, quality, timestamp) 
					SELECT tagname,value,quality,timestamp FROM openquery("GEHISTORIAN_OPSCARE",'''+@openquery+''')'
		PRINT(@sqlquery)
		EXEC(@sqlquery)
		/*
		UPDATE #temptable SET tagname = LEFT(tagname, LEN(tagname) - 1) WHERE tagname LIKE '%[_]'

		INSERT INTO HistorianRawData SELECT * FROM #temptable ORDER BY timestamp ASC
		*/
	END

	SET @startdate = DATEADD(d, -365, GetDate())
	IF EXISTS(SELECT * FROM HistorianRawData WHERE timestamp < @startdate)
	BEGIN
		DELETE FROM HistorianRawData WHERE timestamp < @startdate -- Delete data which is more than a year old
	END
	
END
GO
