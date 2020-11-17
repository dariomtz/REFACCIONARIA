--Cuáles son los cinco productos más vendidos? <clave externa, grupo, marca y precio>
SELECT (SELECT SUM(pv.CANTIDAD) FROM PROD_VENDIDO pv WHERE pv.IDPRODUCTO = p.IDPRODUCTO) AS VENTAS, 
		p.CLAVE_EXTERNA, p.IDGRUPO , p.MARCA , p.PRECIO 
FROM PRODUCTO p
WHERE (SELECT SUM(pv.CANTIDAD) FROM PROD_VENDIDO pv WHERE pv.IDPRODUCTO = p.IDPRODUCTO) IS NOT NULL
ORDER BY VENTAS DESC
LIMIT 5;


--¿Cuáles son las cinco marcas más vendidas? <nombre, unidades vendidas, total vendido $>
SELECT 
	DISTINCT prod.MARCA ,
	(SELECT SUM(CANTIDAD) FROM PROD_VENDIDO pv WHERE 
		(SELECT P.MARCA FROM PRODUCTO P WHERE P.IDPRODUCTO = pv.IDPRODUCTO) = prod.MARCA)
	AS UNIDADES_VENDIDAS,
	(SELECT SUM(PRECIO) FROM PROD_VENDIDO pv WHERE 
		(SELECT P.MARCA FROM PRODUCTO P WHERE P.IDPRODUCTO = pv.IDPRODUCTO) = prod.MARCA)
	AS TOTAL_VENDIDO
FROM PRODUCTO prod 
WHERE (SELECT SUM(CANTIDAD) FROM PROD_VENDIDO pv WHERE 
		(SELECT P.MARCA FROM PRODUCTO P WHERE P.IDPRODUCTO = pv.IDPRODUCTO) = prod.MARCA) IS NOT NULL
ORDER BY UNIDADES_VENDIDAS DESC
LIMIT 5;


--¿Cuáles son los cinco clientes que más me compran con respecto al total de la factura de venta?
-- <RFC, nombre de cliente, total facturado $>
SELECT 
	c.RFC , 
	c.NOMBRE ,
	(SELECT SUM(IMPORTE) FROM FACTURA f WHERE f.IDCLIENTE = c.IDCLIENTE) AS TOTAL_FACTURADO 
FROM CLIENTE c
WHERE (SELECT SUM(IMPORTE) FROM FACTURA f WHERE f.IDCLIENTE = c.IDCLIENTE) IS NOT NULL
ORDER BY TOTAL_FACTURADO DESC
LIMIT 5;


--¿Cuáles son los cinco proveedores a los que le compramos más con respecto al total de la factura
-- de pedido? <RFC, Nombre, total comprado $>
SELECT 
	p.RFC ,
	p.NOMBRE ,
	(SELECT SUM(p2.IMPORTE) FROM PEDIDO p2 WHERE p2.IDPROVEEDOR = p.IDPROVEEDOR) AS TOTAL_COMPRADO
FROM PROVEEDOR p
WHERE (SELECT SUM(p2.IMPORTE) FROM PEDIDO p2 WHERE p2.IDPROVEEDOR = p.IDPROVEEDOR) IS NOT NULL
ORDER BY TOTAL_COMPRADO DESC
LIMIT 5;


-- ¿Cuál es el total de ventas por producto? <clave externa, grupo, marca, estándar, unidades
-- vendidas, total vendido $> El resultado deberá ordenarse de acuerdo al total vendido de mayor a
-- menor y como segundo criterio las unidades vendidas.



