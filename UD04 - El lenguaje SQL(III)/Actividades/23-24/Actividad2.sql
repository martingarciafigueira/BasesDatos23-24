DROP DATABASE IF EXISTS ActividadesUD4
GO
CREATE DATABASE ActividadesUD4
GO
USE ActividadesUD4
GO
CREATE TABLE T_Empleados(
id_empleado int PRIMARY KEY,
salario float CHECK (salario BETWEEN 0 AND 10000))
GO
CREATE TABLE T_Productos(
id_producto int PRIMARY KEY,
nombre varchar(100),
precio decimal CHECK (precio > 0),
stock int)
GO
CREATE TABLE T_Clientes(
id_cliente int PRIMARY KEY,
nombre varchar(50) NOT NULL,
apellido varchar(50) NOT NULL)
GO
CREATE TABLE T_Pedidos(
id_pedido int PRIMARY KEY,
id_cliente int REFERENCES T_Clientes(id_cliente),
id_producto int REFERENCES T_Productos(id_producto),
cantidad int,
fecha_pedido datetime)
GO
CREATE TABLE T_Estudiantes(
id_estudiante int PRIMARY KEY,
nombre varchar(50))
