--TAREA 4 EJERCICIO 1
DROP DATABASE IF EXISTS Tarea4Ejer1
GO
--Creamos la base de datos
CREATE DATABASE Tarea4Ejer1
GO
--Usamos la base de datos
USE Tarea4Ejer1
GO

CREATE TABLE localidad(
COD_localidad int PRIMARY KEY,
nombre varchar(50) NOT NULL);

CREATE TABLE pub(
COD_pub char(5) PRIMARY KEY,
nombre varchar(50) NOT NULL,
licencia_fiscal varchar(10) UNIQUE NOT NULL,
domicilio varchar(50),
fecha_apertura datetime NOT NULL,
horario char(4) NOT NULL,
COD_localidad int 
CONSTRAINT FK_COD_localidad FOREIGN KEY (COD_localidad) REFERENCES localidad(COD_localidad) ON DELETE CASCADE,
CONSTRAINT CK_horario CHECK (horario = 'HOR1' OR horario = 'HOR2' OR horario = 'HOR3'));

CREATE TABLE titular(
DNI_titular char(9) PRIMARY KEY,
nombre varchar(50) NOT NULL,
domicilio varchar(50),
COD_pub char (5)
CONSTRAINT FK_COD_pub FOREIGN KEY (COD_pub) REFERENCES pub(COD_pub) ON DELETE CASCADE);

CREATE TABLE empleado(
DNI_empleado char(9) PRIMARY KEY,
nombre varchar(50) NOT NULL,
domicilio varchar(50));

CREATE TABLE existencias(
COD_artículo varchar(10) PRIMARY KEY,
nombre varchar(50) NOT NULL,
cantidad int NOT NULL,
precio float NOT NULL,
COD_pub char (5)
CONSTRAINT FK_COD_pub2 FOREIGN KEY (COD_pub) REFERENCES pub(COD_pub) ON DELETE CASCADE,
CONSTRAINT CK_precio CHECK (precio<0));

CREATE TABLE pub_empleado(
COD_pub char(5) REFERENCES pub(COD_pub) ON DELETE CASCADE,
DNI_empleado char(9) REFERENCES empleado(DNI_empleado) ON DELETE CASCADE,
funcion varchar(50) NOT NULL,
CONSTRAINT PK_pub_empleado PRIMARY KEY(COD_pub,DNI_empleado,funcion),
CONSTRAINT CK_funcion CHECK (funcion = 'CAMARERO' OR funcion = 'SEGURIDAD' OR funcion = 'LIMPIEZA'));


--********************TAREA 4 EJERCICIO 2**************************

DROP DATABASE IF EXISTS Tarea4Ejer2
GO
--Creamos la base de datos
CREATE DATABASE Tarea4Ejer2
GO
--Usamos la base de datos
USE Tarea4Ejer2
GO

CREATE TABLE espectaculo(
COD_espectaculo char(5) PRIMARY KEY,
nombre varchar(50) NOT NULL,
tipo varchar(10) NOT NULL,
fecha_inicial datetime NOT NULL,
fecha_final datetime NOT NULL,
interprete varchar(50) NOT NULL,
COD_recinto int NOT NULL);

CREATE TABLE recintos(
COD_recinto int PRIMARY KEY,
nombre varchar(20) NOT NULL, 
direccion varchar(50) NOT NULL,
ciudad varchar(50) NOT NULL,
telefono char(9) NOT NULL,
horario time NOT NULL);

CREATE TABLE zonas_recintos(
COD_recinto int REFERENCES recintos(COD_recinto) ON DELETE CASCADE,
zona int NOT NULL,
capacidad int NOT NULL,
CONSTRAINT PK_zonas_recintos PRIMARY KEY(COD_recinto,zona));

CREATE TABLE asientos(
COD_recinto int,
zona int,
fila int,
numero int,
CONSTRAINT PK_asientos PRIMARY KEY(COD_recinto,zona,fila,numero),
CONSTRAINT FK_asientos FOREIGN KEY (COD_recinto,zona) REFERENCES zonas_recintos(COD_recinto,zona) ON DELETE CASCADE);

CREATE TABLE representaciones(
COD_espectaculo char(5) REFERENCES espectaculo(COD_espectaculo),
fecha datetime,
hora time,
CONSTRAINT PK_representaciones PRIMARY KEY (COD_espectaculo,fecha,hora));

CREATE TABLE espectadores(
DNI_cliente char(9) PRIMARY KEY,
nombre varchar(50) NOT NULL,
direccion varchar(50) NOT NULL,
telefono char(9) UNIQUE NOT NULL,
ciudad varchar(50) NOT NULL,
tarjeta varchar(20) NOT NULL);

CREATE TABLE entradas(
COD_entrada int PRIMARY KEY,
COD_espectaculo char(5),
fecha datetime,
hora time,
COD_recinto int,
zona int,
fila int,
numero int,
DNI_cliente char(9) REFERENCES espectadores(DNI_cliente) ON DELETE CASCADE,
CONSTRAINT FK_COD_espectaculo FOREIGN KEY (COD_espectaculo) REFERENCES espectaculo(COD_espectaculo) ON DELETE CASCADE,
CONSTRAINT FK_asientos2 FOREIGN KEY (COD_recinto,zona,fila,numero) REFERENCES asientos(COD_recinto,zona,fila,numero) ON DELETE CASCADE);


CREATE TABLE precios_espectaculos (
COD_espectaculo char(5),
COD_recinto int,
zona int,
precio float CHECK (precio >0),
CONSTRAINT PK_precios_espectaculos PRIMARY KEY (COD_espectaculo,precio),
CONSTRAINT FK_precios_espectaculos FOREIGN KEY (COD_recinto,zona) REFERENCES zonas_recintos(COD_recinto,zona) ON DELETE CASCADE);


--********************TAREA 4 EJERCICIO 3**************************

DROP DATABASE IF EXISTS Tarea4Ejer3
GO
--Creamos la base de datos
CREATE DATABASE Tarea4Ejer3
GO
--Usamos la base de datos
USE Tarea4Ejer3
GO

CREATE TABLE empleados(
dni char(8) PRIMARY KEY,
nombre varchar(10) NOT NULL,
apellido1 varchar(15) NOT NULL,
apellido2 varchar(15),
direcc1 varchar(25),
direcc2 varchar(20),
provincia varchar(20),
COD_postal varchar(5),
sexo varchar(1) CHECK (sexo = 'H' OR sexo = 'M') NOT NULL,
fecha_nac datetime);

CREATE TABLE departamentos(
COD_dpto char(5) PRIMARY KEY,
nombre_dtpo varchar(30) NOT NULL,
dpto_padre char(5),
presupuesto float NOT NULL,
pres_actual float NOT NULL);

CREATE TABLE universidades(
COD_univ char(5) PRIMARY KEY,
nombre_univ varchar(25) NOT NULL,
ciudad varchar(20),
municipio varchar(2),
COD_postal varchar(5));

CREATE TABLE estudios(
dni_empleado char(8) PRIMARY KEY REFERENCES empleados(dni) ON DELETE CASCADE,
universidad char(5) REFERENCES universidades(COD_univ) ON DELETE CASCADE,
año int,
grado varchar(3),
especialidad varchar(20));

CREATE TABLE trabajos(
COD_trabajo char(5) PRIMARY KEY,
nombre_trab varchar(20) UNIQUE NOT NULL,
salario_min float(2) NOT NULL,
salario_max float(2) NOT NULL);

CREATE TABLE historial_laboral(
dni_empleado char(8) REFERENCES empleados(dni) ON DELETE CASCADE ,
COD_trabajo char(5) REFERENCES trabajos(COD_trabajo) ON DELETE CASCADE,
fecha_inicio datetime,
fecha_fin datetime,
COD_dpto char(5) REFERENCES departamentos(COD_dpto),
dni_supervisor char(8),
CONSTRAINT PK_historial_laboral PRIMARY KEY (dni_empleado,COD_trabajo));

CREATE TABLE historial_salarial(
dni_empleado char(8) PRIMARY KEY REFERENCES empleados(dni),
salario float(2),
fecha_comienzo datetime,
fecha_fin datetime);