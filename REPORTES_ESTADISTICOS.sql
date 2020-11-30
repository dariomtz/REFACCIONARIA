--Cu�les son los cinco productos m�s vendidos? <clave externa, grupo, marca y precio>
SELECT (SELECT SUM(pv.CANTIDAD) FROM PROD_VENDIDO pv WHERE pv.IDPRODUCTO = p.IDPRODUCTO) AS VENTAS, 
		p.CLAVE_EXTERNA, p.IDGRUPO , p.MARCA , p.PRECIO 
FROM PRODUCTO p
WHERE (SELECT SUM(pv.CANTIDAD) FROM PROD_VENDIDO pv WHERE pv.IDPRODUCTO = p.IDPRODUCTO) IS NOT NULL
ORDER BY VENTAS DESC
LIMIT 5;


--�Cu�les son las cinco marcas m�s vendidas? <nombre, unidades vendidas, total vendido $>
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


--�Cu�les son los cinco clientes que m�s me compran con respecto al total de la factura de venta?
-- <RFC, nombre de cliente, total facturado $>
SELECT 
	c.RFC , 
	c.NOMBRE ,
	(SELECT SUM(IMPORTE) FROM FACTURA f WHERE f.IDCLIENTE = c.IDCLIENTE) AS TOTAL_FACTURADO 
FROM CLIENTE c
WHERE (SELECT SUM(IMPORTE) FROM FACTURA f WHERE f.IDCLIENTE = c.IDCLIENTE) IS NOT NULL
ORDER BY TOTAL_FACTURADO DESC
LIMIT 5;


--�Cu�les son los cinco proveedores a los que le compramos m�s con respecto al total de la factura
-- de pedido? <RFC, Nombre, total comprado $>
SELECT 
	p.RFC ,
	p.NOMBRE ,
	(SELECT SUM(p2.IMPORTE) FROM PEDIDO p2 WHERE p2.IDPROVEEDOR = p.IDPROVEEDOR) AS TOTAL_COMPRADO
FROM PROVEEDOR p
WHERE (SELECT SUM(p2.IMPORTE) FROM PEDIDO p2 WHERE p2.IDPROVEEDOR = p.IDPROVEEDOR) IS NOT NULL
ORDER BY TOTAL_COMPRADO DESC
LIMIT 5;


-- �Cu�l es el total de ventas por producto? <clave externa, grupo, marca, est�ndar, unidades
-- vendidas, total vendido $> El resultado deber� ordenarse de acuerdo al total vendido de mayor a
-- menor y como segundo criterio las unidades vendidas.
SELECT CLAVE_EXTERNA , IDGRUPO , MARCA , IDESTANDAR, 
	(SELECT SUM(pv.CANTIDAD) FROM PROD_VENDIDO pv WHERE pv.IDPRODUCTO = p.IDPRODUCTO) AS UNIDADES_VENDIDAS,
	(SELECT SUM(pv.PRECIO) FROM PROD_VENDIDO pv WHERE pv.IDPRODUCTO = p.IDPRODUCTO) AS TOTAL_VENDIDO
FROM PRODUCTO p 
ORDER BY TOTAL_VENDIDO DESC, UNIDADES_VENDIDAS DESC;


-- �Cu�les proveedores me venden productos de una marca dada por el usuario? <RFC, Nombre> El
-- resultado deber� ordenarse alfab�ticamente por el nombre del proveedor.
SELECT p.RFC , p.NOMBRE FROM PROVEEDOR p 
WHERE IDPROVEEDOR IN 
	(SELECT ps.IDPROVEEDOR FROM PROD_SURTIDO ps WHERE ps.IDPRODUCTO IN 
		(SELECT p2.IDPRODUCTO FROM PRODUCTO p2 WHERE p2.MARCA = 'MONROE'))
ORDER BY NOMBRE;


-- �Cu�les proveedores me venden un grupo de productos dado por el usuario? <RFC, Nombre> El
-- resultado deber� ordenarse alfab�ticamente por el nombre del proveedor.
SELECT p.RFC , p.NOMBRE FROM PROVEEDOR p 
WHERE IDPROVEEDOR IN 
	(SELECT ps.IDPROVEEDOR FROM PROD_SURTIDO ps WHERE ps.IDPRODUCTO IN 
		(SELECT p2.IDPRODUCTO FROM PRODUCTO p2 WHERE p2.IDGRUPO = 1))
ORDER BY NOMBRE;


-- �Cu�les proveedores me venden una l�nea de productos dada por el usuario? <RFC, Nombre> El
-- resultado deber� ordenarse alfab�ticamente por el nombre del proveedor.
SELECT p.RFC , p.NOMBRE FROM PROVEEDOR p 
WHERE IDPROVEEDOR IN 
	(SELECT ps.IDPROVEEDOR FROM PROD_SURTIDO ps WHERE ps.IDPRODUCTO IN 
		(SELECT p2.IDPRODUCTO FROM PRODUCTO p2 WHERE p2.IDGRUPO IN
			(SELECT g.IDGRUPO FROM GRUPO g WHERE g.LINEA = 'FRENOS')))
ORDER BY NOMBRE;


--Dado un cliente, una fecha inicial y una final, �cu�l es la informaci�n de las ventas que se le han
-- hecho en ese per�odo? <Folio, Fecha, Total de la factura de venta, Factura pagada o no> El
-- resultado deber� ordenarse por el folio de la factura, de menor a mayor.
SELECT FOLIO, FECHA, IMPORTE AS TOTAL_DE_VENTA, CASE WHEN (SALDO=0) THEN 'PAGADA' ELSE 'NO PAGADA' END AS ESTATUS 
FROM FACTURA f 
WHERE IDCLIENTE = 1 AND FECHA BETWEEN '2012-02-01' AND '2012-04-30'
ORDER BY FOLIO ASC;


--Dado un proveedor, una fecha inicial y una final, �cu�l es la informaci�n de las compras que se le
-- han hecho en ese per�odo? <Folio, Fecha, Total de la factura de pedido, Pedido recibido o no> El
-- resultado deber� ordenarse por el folio de la factura, de menor a mayor.
SELECT IDPEDIDO AS FOLIO, FECHA_PEDIDO AS FECHA, IMPORTE AS TOTAL_DE_PEDIDO, 
CASE WHEN (FECHA_RECIBIDO IS NOT NULL) THEN 'RECIBIDO' ELSE 'NO RECIBIDO' END AS RECIBIDO 
FROM PEDIDO p 
WHERE IDPROVEEDOR = 1 AND FECHA_PEDIDO BETWEEN '2012-02-01' AND '2012-04-30'
ORDER BY FOLIO ASC;


--�Cu�les han sido mis ventas diarias hasta la fecha? <Fecha, total facturado $> El resultado deber�
-- ordenarse por fecha (de la m�s antigua a la m�s nueva).
SELECT DISTINCT FECHA, (SELECT SUM(IMPORTE) FROM FACTURA WHERE FECHA = F.FECHA ) AS TOTAL_FACTURADO
FROM FACTURA f 
ORDER BY FECHA;

--�Cu�les han sido mis ingresos diarios hasta la fecha? <Fecha, total ingresado $> El resultado deber�
-- ordenarse por fecha (de la m�s antigua a la m�s nueva).
SELECT DISTINCT FECHA, (SELECT SUM(IMPORTE) FROM FACTURA WHERE FECHA = F.FECHA ) AS TOTAL_INGRESADO
FROM FACTURA f 
UNION
SELECT DISTINCT FECHA_PEDIDO, (SELECT -SUM(IMPORTE) FROM PEDIDO WHERE FECHA_PEDIDO = P.FECHA_PEDIDO ) AS TOTAL_INGRESADO
FROM PEDIDO p 
ORDER BY FECHA;

-- 13.	�Cu�les productos tienen menos de tres piezas en existencia? <clave externa, grupo, marca, costo y existencias>
-- El resultado deber� ordenarse por el n�mero de existencias de menor a mayor y, como segundo criterio, por clave externa.
SELECT CLAVE_EXTERNA , IDGRUPO , MARCA , PRECIO / 1.3, EXISTENCIAS 
FROM PRODUCTO p 
WHERE EXISTENCIAS < 3
ORDER BY EXISTENCIAS, CLAVE_EXTERNA ;


