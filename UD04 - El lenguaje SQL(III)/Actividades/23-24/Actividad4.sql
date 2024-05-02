
--1
SELECT * INTO #Ventas
FROM T_VENTAS
WHERE fecha_venta >= DATEADD(MONTH, -3, GETDATE())

SELECT * FROM #Ventas

--2
SELECT c.*
INTO #clientes_activos
FROM T_VENTAS v
INNER JOIN T_Clientes c on v.id_cliente = c.id_cliente
WHERE fecha_venta >= DATEADD(MONTH, -1, GETDATE())

--3
SELECT *
INTO #pedidos_procesados
FROM T_Pedidos
WHERE fecha_pedido >= DATEADD(WEEK, -1, GETDATE())

SELECT * FROM #pedidos_procesados

--4
SELECT TOP 10 p.nombre, COUNT(p.id_producto) 'CantidadVentas'
INTO #productos_mas_vendidos
FROM T_VENTAS v
INNER JOIN T_Productos p ON v.id_producto = p.id_producto
WHERE fecha_venta >= DATEADD(MONTH, -3, GETDATE())
GROUP BY p.nombre
ORDER BY CantidadVentas

SELECT * FROM #productos_mas_vendidos