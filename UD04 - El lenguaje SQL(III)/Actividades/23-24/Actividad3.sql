
--1
ALTER TABLE T_Clientes
ADD CONSTRAINT UNQ_nombre UNIQUE(nombre)

--2
ALTER TABLE T_Productos
ALTER COLUMN precio decimal NOT NULL

--3
ALTER TABLE T_Pedidos
ADD CONSTRAINT CK_cantidad CHECK (cantidad > 0)

--4
ALTER TABLE T_Empleados
ADD CONSTRAINT PK_id_empleado PRIMARY KEY(id_empleado)

--5
ALTER TABLE T_Pedidos
ADD CONSTRAINT FK_pedidos_clientes FOREIGN KEY (id_cliente) REFERENCES T_Clientes(id_cliente)

--6
ALTER TABLE T_Ventas
ADD CONSTRAINT FK_ventas_productos FOREIGN KEY (id_producto) REFERENCES T_Productos(id_producto)

--7
ALTER TABLE T_Ventas
ADD CONSTRAINT UNQ_ventas UNIQUE(id_venta)

--8
ALTER TABLE T_Pedidos
ADD CONSTRAINT PK_Pedidos PRIMARY KEY(id_cliente, id_producto)