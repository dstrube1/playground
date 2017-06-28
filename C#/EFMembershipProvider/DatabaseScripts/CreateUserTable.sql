SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[Id] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_User_Id]  DEFAULT (newid()),
	[Name] [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
	[CreationDate] [datetime] NULL,
	[Username] [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
	[FirstName] [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
	[LastName] [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
	[ApplicationName] [nvarchar](100) COLLATE Latin1_General_CI_AS NULL,
	[Email] [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
	[Password] [nvarchar](100) COLLATE Latin1_General_CI_AS NULL,
	[PasswordQuestion] [nvarchar](255) COLLATE Latin1_General_CI_AS NULL,
	[PasswordAnswer] [nvarchar](255) COLLATE Latin1_General_CI_AS NULL,
	[IsApproved] [bit] NOT NULL CONSTRAINT [DF_User_IsApproved]  DEFAULT ((1)),
	[LastActivityDate] [datetime] NULL,
	[LastLoginDate] [datetime] NULL,
	[LastPasswordChangedDate] [datetime] NULL,
	[IsOnline] [bit] NULL,
	[IsLockedOut] [bit] NULL,
	[LastLockedOutDate] [datetime] NULL,
	[FailedPasswordAttemptCount] [int] NULL,
	[FailedPasswordAttemptWindowStart] [datetime] NULL,
	[FailedPasswordAnswerAttemptCount] [int] NULL,
	[FailedPasswordAnswerAttemptWindowStart] [datetime] NULL,
	[LastModified] [datetime] NULL,
	[Comment] [nvarchar](255) COLLATE Latin1_General_CI_AS NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]