USE [DeluxeDB]
GO
/****** Object:  Table [dbo].[Empleado]    Script Date: 02/09/2018 01:00:01 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Empleado](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Apellidos] [varchar](100) NOT NULL,
	[Edad] [int] NOT NULL,
	[FechaNacimiento] [datetime] NOT NULL,
	[Activo] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inventario]    Script Date: 02/09/2018 01:00:02 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventario](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Activo] [bit] NOT NULL,
	[Cantidad] [int] NOT NULL,
	[IdProducto] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pedido]    Script Date: 02/09/2018 01:00:02 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pedido](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Cantidad] [int] NOT NULL,
	[Total] [float] NOT NULL,
	[Activo] [bit] NOT NULL,
	[FechaEmision] [datetime] NOT NULL,
	[Entregado] [bit] NOT NULL,
	[IdEmpleado] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PedidoProducto]    Script Date: 02/09/2018 01:00:02 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PedidoProducto](
	[IdPedido] [int] NOT NULL,
	[IdProducto] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Precio]    Script Date: 02/09/2018 01:00:02 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Precio](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Precio] [float] NOT NULL,
	[Descripcion] [varchar](100) NULL,
	[Activo] [bit] NOT NULL,
	[IdProducto] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Producto]    Script Date: 02/09/2018 01:00:02 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Producto](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Activo] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Empleado] ON 

INSERT [dbo].[Empleado] ([Id], [Nombre], [Apellidos], [Edad], [FechaNacimiento], [Activo]) VALUES (2, N'Juan Francisco', N'Vazquez Torres', 24, CAST(N'1994-08-29T00:00:00.000' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Empleado] OFF
/****** Object:  Index [ProductoUnico]    Script Date: 02/09/2018 01:00:02 p. m. ******/
ALTER TABLE [dbo].[Inventario] ADD  CONSTRAINT [ProductoUnico] UNIQUE NONCLUSTERED 
(
	[IdProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ__PedidoPr__205BA7CD0FE0C1F2]    Script Date: 02/09/2018 01:00:02 p. m. ******/
ALTER TABLE [dbo].[PedidoProducto] ADD UNIQUE NONCLUSTERED 
(
	[IdProducto] ASC,
	[IdPedido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Empleado] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Inventario] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Pedido] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Pedido] ADD  DEFAULT (getdate()) FOR [FechaEmision]
GO
ALTER TABLE [dbo].[Pedido] ADD  DEFAULT ((0)) FOR [Entregado]
GO
ALTER TABLE [dbo].[Precio] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Producto] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Inventario]  WITH CHECK ADD FOREIGN KEY([IdProducto])
REFERENCES [dbo].[Producto] ([Id])
GO
ALTER TABLE [dbo].[Pedido]  WITH CHECK ADD FOREIGN KEY([IdEmpleado])
REFERENCES [dbo].[Empleado] ([Id])
GO
ALTER TABLE [dbo].[PedidoProducto]  WITH CHECK ADD FOREIGN KEY([IdPedido])
REFERENCES [dbo].[Pedido] ([Id])
GO
ALTER TABLE [dbo].[PedidoProducto]  WITH CHECK ADD FOREIGN KEY([IdProducto])
REFERENCES [dbo].[Producto] ([Id])
GO
ALTER TABLE [dbo].[Precio]  WITH CHECK ADD FOREIGN KEY([IdProducto])
REFERENCES [dbo].[Producto] ([Id])
GO
