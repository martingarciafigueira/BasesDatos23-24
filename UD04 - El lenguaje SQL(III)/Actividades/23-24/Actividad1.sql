DROP DATABASE IF EXISTS ActividadesUD4
GO
CREATE DATABASE ActividadesUD4
GO
USE ActividadesUD4
GO
CREATE TABLE T_Clientes(
id_cliente int,
nombre varchar(50),
apellido varchar(50),
fecha_nacimiento datetime)
GO
CREATE TABLE T_Productos(
id_producto int PRIMARY KEY,
nombre varchar(100),
precio decimal,
stock int)
GO
CREATE TABLE T_Pedidos(
id_pedido int,
id_cliente int,
id_producto int,
cantidad int,
fecha_pedido datetime)
GO
CREATE TABLE T_Empleados(
id_empleado int,
nombre varchar(50),
apellido varchar(50),
puesto varchar(50))
GO
CREATE TABLE T_Ventas(
id_venta int,
id_cliente int,
id_producto int REFERENCES T_Productos(id_producto),
cantidad int,
precio_unitario decimal,
fecha_venta datetime)
