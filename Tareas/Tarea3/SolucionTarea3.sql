/* Consultas SELECT Nivel: Fácil
1. Seleccionar el nombre del producto y la cantidad comprada para todas las  compras realizadas. 
2. Seleccionar el nombre del cliente y el total de todas las compras realizadas. 
3. Seleccionar el nombre del producto y el precio promedio de venta para cada  producto. 
4. Seleccionar el nombre del cliente y el número de compras realizadas por cada  cliente. 
5. Seleccionar el precio total y la fecha de todas las compras realizadas en febrero  de 2022. 
6. Seleccionar el nombre del cliente y el total gastado por cada cliente en compras  realizadas, agrupado por mes. 
7. Seleccionar el nombre del producto, el número de compras en las que se ha  vendido, y la cantidad total de unidades vendidas. 
8. Seleccionar el nombre del cliente y el total gastado por cada cliente en compras  realizadas en febrero de 2022. 
9. Seleccionar los detalles de las compras que tienen un precio mayor que 100. 
10. Seleccionar el nombre de los clientes y la cantidad total que han gastado en compras
*/
-------------------------------------------------------------------
/* Consultas SELECT Nivel: Difícil
1. Seleccionar el nombre del cliente y el producto más caro comprado por cada  cliente. 
2. Seleccionar el nombre del producto, el total gastado en ese producto y el  porcentaje del total de ventas que representa ese producto. 
3. Seleccionar el nombre del cliente y el total gastado por cada cliente en  productos que empiezan por "P". 
4. Seleccionar el nombre del producto y el número de compras en las que se ha  vendido más de una unidad del producto. 
5. Seleccionar el nombre del cliente que más ha gastado en una sola compra. 
6. Seleccionar el número total de compras realizadas por cada cliente. 
7. Seleccionar los productos que tienen un precio mayor que el promedio de los  precios de todos los productos. 
8. Seleccionar los productos que han sido comprados por más de un cliente. 
9. Seleccionar el nombre de los clientes y la cantidad total que han gastado en compras. 
10. Obtén toda la información de los clientes que han comprado más de un producto, junto con el total de su compra.
*/

--Consultas SELECT Nivel: Fácil-------------------------------------------------------
--1. Seleccionar el nombre del producto y la cantidad comprada para todas las compras realizadas. 
-- Nombre del Producto   |  Total uds compradas
SELECT p.nombre 'Ej. 1. Nombre del Producto', SUM(dc.cantidad) 'Total uds compradas'
FROM clientes cl
INNER JOIN compras co ON co.id_cliente=cl.id
INNER JOIN detalles_compra dc ON dc.id_compra=co.id
INNER JOIN productos p ON p.id=dc.id_producto
GROUP BY p.nombre 
ORDER BY [Total uds compradas]

--2. Seleccionar el nombre del cliente y el total de todas las compras realizadas. 
-- Nombre Cliente  |  Importe total compras realizadas
SELECT cl.nombre 'Ej. 2. Nombre Cliente', CONVERT(VARCHAR(10), SUM(dc.cantidad*dc.precio_unitario))+' €' 'Importe total compras realizadas'
FROM clientes cl
INNER JOIN compras co ON co.id_cliente=cl.id
INNER JOIN detalles_compra dc ON dc.id_compra=co.id
GROUP BY cl.nombre 

--3. Seleccionar el nombre del producto y el precio promedio de venta para cada  producto. 
-- Nombre de Producto  |  Precio promedio de venta
SELECT p.nombre 'Ej. 3. Nombre de Producto', CONVERT(VARCHAR(10), FLOOR(AVG(dc.precio_unitario)))+' €' 'Precio promedio de venta'
FROM clientes cl
INNER JOIN compras co ON co.id_cliente=cl.id
INNER JOIN detalles_compra dc ON dc.id_compra=co.id
INNER JOIN productos p ON p.id=dc.id_producto
GROUP BY p.nombre 
ORDER BY AVG(dc.precio_unitario) DESC

--4. Seleccionar el nombre del cliente y el número de compras realizadas por cada  cliente. 
-- Nombre del cliente |  Número de compras realizadas
SELECT DISTINCT cl.nombre 'Ej. 4. Nombre Cliente', COUNT(co.id) 'Número de compras realizadas'
FROM clientes cl
INNER JOIN compras co ON co.id_cliente=cl.id
GROUP BY cl.nombre

--5. Seleccionar el precio (cuantía) total y la fecha de todas las compras realizadas en febrero de 2022. 
-- Cuantía total de la compra  |  Fecha compra
SELECT co.fecha 'Ej. 5. Fecha compra', CONVERT(VARCHAR(10), SUM(dc.cantidad*dc.precio_unitario))+' €' 'Cuantía total de la compra'
FROM compras co
INNER JOIN	detalles_compra dc ON dc.id_compra=co.id
WHERE co.fecha <CAST('2022-01-03' AS datetime) AND co.fecha > CAST('2022-31-01' AS datetime)
GROUP BY co.fecha
ORDER BY co.fecha

--6. Seleccionar el nombre del cliente y el total gastado por cada cliente en compras realizadas, agrupado por mes
-- Nombre Cliente |  Total Gastado mes |  Mes 
SELECT cl.nombre 'Ej. 6. Nombre del Cliente', SUM(dc.cantidad*precio_unitario) 'Total gastado mes', 
CASE DATEPART(m,co.fecha)
	WHEN 1 THEN 'Enero'
	WHEN 2 THEN 'Febrero'
	WHEN 3 THEN 'Marzo'
	WHEN 4 THEN 'Abril'
	WHEN 5 THEN 'Mayo'
	WHEN 6 THEN 'Junio'
	WHEN 7 THEN 'Julio'
	WHEN 8 THEN 'Agosto'
	WHEN 9 THEN 'Septiembre'
	WHEN 10 THEN 'Octubre'
	WHEN 11 THEN 'Noviembre'
	WHEN 12 THEN 'Diciembre'
END 'Mes'
FROM clientes cl
INNER JOIN compras co ON co.id_cliente=cl.id
INNER JOIN detalles_compra dc ON dc.id_compra=co.id
GROUP BY cl.nombre, DATEPART(m,co.fecha)
ORDER BY DATEPART(m,co.fecha)

-- 7. Seleccionar el nombre del producto, el número de compras en las que se ha vendido, y la cantidad total de unidades vendidas. 
-- Nombre del producto  |  Nº de compras en las que se ha vendido  |  Total uds. vendidas
SELECT p.nombre 'Nombre del producto', COUNT(co.id) 'Nº de compras en las que se ha vendido', SUM(dc.cantidad) 'Total uds. vendidas'
FROM productos p
INNER JOIN detalles_compra dc ON dc.id_producto=p.id
INNER JOIN compras co ON co.id=dc.id_compra
GROUP BY p.nombre

-- 8. Seleccionar el nombre del cliente y el total gastado por cada cliente en compras realizadas en febrero de 2022. 
-- Ej. 8. Nombre del Cliente  |  Total gastado por cada cliente en compras realizadas en febrero de 2022
SELECT cl.nombre 'Ej. 8. Nombre del Cliente', CONVERT(VARCHAR(10), SUM(dc.cantidad*precio_unitario))+' €' 'Total gastado por el cliente en compras realizadas en febrero de 2022'
FROM clientes cl
INNER JOIN compras co ON co.id_cliente=cl.id
INNER JOIN detalles_compra dc ON dc.id_compra=co.id
WHERE co.fecha <CAST('2022-01-03' AS datetime) AND co.fecha > CAST('2022-31-01' AS datetime)
GROUP BY cl.nombre
ORDER BY cl.nombre

-- 9. Seleccionar los detalles de las compras que tienen un precio mayor que 100 
SELECT *
FROM detalles_compra
WHERE precio_unitario>100

-- 10. Seleccionar el nombre de los clientes y la cantidad total que han gastado en compras
-- Nombre del Cliente  |  Cantidad total gastada en compras
SELECT cl.nombre 'Ej. 10. Nombre del Cliente', CONVERT(VARCHAR(10), SUM(DC.cantidad*dc.precio_unitario))+' €' 'Cantidad total gastada en compras'
FROM clientes cl
INNER JOIN compras co ON co.id_cliente=cl.id
INNER JOIN detalles_compra dc ON dc.id_compra=co.id
GROUP BY cl.nombre
ORDER BY SUM(DC.cantidad*dc.precio_unitario) DESC

SELECT 'EMPIEZAN LAS CONSULTAS DIFICILES'

-------------------------------------------------------------------
-------------------------------------------------------------------
/*--Consultas SELECT Nivel: Difícil--------------------------------
1. Seleccionar el nombre del cliente y el producto más caro comprado por cada  cliente. 
2. Seleccionar el nombre del producto, el total gastado en ese producto y el  porcentaje del total de ventas que representa ese producto. 
3. Seleccionar el nombre del cliente y el total gastado por cada cliente en  productos que empiezan por "P". 
4. Seleccionar el nombre del producto y el número de compras en las que se ha  vendido más de una unidad del producto. 
5. Seleccionar el nombre del cliente que más ha gastado en una sola compra. 
6. Seleccionar el número total de compras realizadas por cada cliente. 
7. Seleccionar los productos que tienen un precio mayor que el promedio de los  precios de todos los productos. 
8. Seleccionar los productos que han sido comprados por más de un cliente. 
9. Seleccionar el nombre de los clientes y la cantidad total que han gastado en compras. 
10. Obtén toda la información de los clientes que han comprado más de un  producto, junto con el total de su compra.
*/

-- 1. Seleccionar el nombre del cliente y el producto más caro comprado por cada cliente.
-- Nombre del cliente  |  Producto más caro comprado
SELECT DISTINCT cl.nombre 'Ej. 1. Nombre de Cliente', p.nombre 'Nombre producto más caro comprado por dicho cliente'
FROM clientes cl
INNER JOIN compras co ON co.id_cliente=cl.id
INNER JOIN detalles_compra dc ON dc.id_compra=co.id
INNER JOIN productos p ON p.id=dc.id_producto
INNER JOIN 
(SELECT DISTINCT cl.nombre 'Nombre de Cliente', MAX(dc.precio_unitario) 'Precio'
FROM clientes cl
INNER JOIN compras co ON co.id_cliente=cl.id
INNER JOIN detalles_compra dc ON dc.id_compra=co.id
INNER JOIN productos p ON p.id=dc.id_producto
GROUP BY cl.nombre) cp
ON cl.nombre = cp.[Nombre de Cliente] AND p.precio_unitario = cp.Precio

-- 2. Seleccionar el nombre del producto, el total gastado en ese producto y el porcentaje del total de ventas que representa ese producto
SELECT	p.nombre 'Ej.2. Nombre del producto', 
		CONVERT(VARCHAR(10), SUM(dc.cantidad*dc.precio_unitario))+' €' 'Total gastado en el producto', 
		SUBSTRING(CONVERT(VARCHAR(10), 100*SUM(dc.cantidad*dc.precio_unitario)/(SELECT SUM(dc.cantidad*dc.precio_unitario)FROM detalles_compra dc),2),1,5)
			+'  %' 'Porcentaje del total de ventas que representa'
FROM productos p
INNER JOIN detalles_compra dc ON dc.id_producto=p.id
GROUP BY p.nombre
ORDER BY SUM(dc.cantidad*dc.precio_unitario) DESC

-- 3. Seleccionar el nombre del cliente y el total gastado por cada cliente en  productos que empiezan por "P"
SELECT c.nombre 'Ej. 3. Nombre cliente', SUM(dc.cantidad * dc.precio_unitario) AS total_gastado
FROM clientes c
INNER JOIN compras co ON c.id = co.id_cliente
INNER JOIN detalles_compra dc ON co.id = dc.id_compra
INNER JOIN productos p ON dc.id_producto = p.id
WHERE p.nombre LIKE 'M%'
GROUP BY c.nombre;

--4. Seleccionar el nombre del producto y el número de compras en las que se ha vendido más de una unidad del producto. 
SELECT p.nombre 'Ej.4. Nombre Producto', COUNT(dc.id_producto) 'Nº de compras en las que se ha vendido más de una unidad del producto'
FROM detalles_compra dc 
INNER JOIN productos p ON p.id=dc.id_producto
WHERE dc.cantidad>1
GROUP BY p.nombre
ORDER BY [Nº de compras en las que se ha vendido más de una unidad del producto] DESC

-- 5. Seleccionar el nombre del cliente que más ha gastado en una sola compra
SELECT cl.nombre 'Ej. 5. Cliente que más ha gastado en una sola compra'
FROM clientes cl
INNER JOIN compras co ON co.id_cliente=cl.id
INNER JOIN detalles_compra dc ON dc.id_compra=co.id
INNER JOIN (
	SELECT TOP(1) dc.id_compra, SUM(dc.cantidad*dc.precio_unitario) [Coste compra]
	FROM clientes cl
	INNER JOIN compras co ON co.id_cliente=cl.id
	INNER JOIN detalles_compra dc ON dc.id_compra=co.id
	GROUP BY dc.id_compra
	ORDER BY [Coste compra] DESC
	) tgc ON tgc.id_compra=co.id
GROUP BY cl.nombre

-- 6. Seleccionar el número total de compras realizadas por cada cliente. 
SELECT cl.nombre 'Ej. 6. Cliente', COUNT(co.id) 'Nº total de compras realizadas'
FROM clientes cl
INNER JOIN compras co ON co.id_cliente=cl.id
GROUP BY cl.nombre

-- 7. Seleccionar los productos que tienen un precio mayor que el promedio de los  precios de todos los productos. 
SELECT nombre 'Ej. 7. Nombre producto con precio > Precio promedio de todos los productos', id, CONVERT(VARCHAR(10), precio_unitario)+' €' 'Precio del producto'
FROM productos
WHERE precio_unitario> (SELECT AVG(precio_unitario) FROM productos)

-- 8. Seleccionar los productos que han sido comprados por más de un cliente. 
SELECT p.nombre 'Ej. 8. Productos que han sido comprados por más de un cliente'
FROM productos p
INNER JOIN detalles_compra dc ON dc.id_producto=p.id
INNER JOIN compras co ON co.id=dc.id_compra
INNER JOIN clientes cl ON cl.id=co.id_cliente
GROUP BY p.nombre
HAVING COUNT(DISTINCT cl.id)>1

-- 9. Seleccionar el nombre de los clientes y la cantidad total que han gastado en compras. 
SELECT YEAR(co.fecha) AS año, MONTH(co.fecha) AS mes, c.nombre, COUNT(co.id) AS cantidad_compras, SUM(dc.cantidad * dc.precio_unitario) AS total_gastado
FROM clientes c
INNER JOIN compras co ON c.id = co.id_cliente
INNER JOIN detalles_compra dc ON co.id = dc.id_compra
GROUP BY YEAR(co.fecha), MONTH(co.fecha), c.nombre;

-- 10. Obtén toda la información de los clientes que han comprado más de un producto, junto con el total de su compra.
SELECT c.*, SUM(dc.cantidad * dc.precio_unitario) AS total_compra
FROM clientes c
INNER JOIN compras co ON c.id = co.id_cliente
INNER JOIN detalles_compra dc ON co.id = dc.id_compra
GROUP BY c.id, c.nombre, c.correo_electronico, c.direccion
HAVING COUNT(DISTINCT dc.id_producto) > 1;

