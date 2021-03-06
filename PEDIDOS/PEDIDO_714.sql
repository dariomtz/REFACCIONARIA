--INSERTAR EL PEDIDO
INSERT INTO PROJECT.PEDIDO
(IDPEDIDO, FECHA_PEDIDO, IMPORTE, FECHA_RECIBIDO, IVA, IDPROVEEDOR)
VALUES(714, '2012-02-25-00.00.00.000000', 0, '2012-02-26-00.00.00.000000', 0, 1);

--INSERTAR LOS PRODUCTOS PEDIDOS

--INSERT PRODUCTO 1
INSERT INTO PROJECT.PROD_PEDIDO
(IDPRODUCTO, IDPEDIDO, CANTIDAD, COSTO)
VALUES(10164, 714, 3, (SELECT PRECIO / 1.3 FROM PRODUCTO WHERE IDPRODUCTO = 10164));

--INSERT PRODUCTO 2
INSERT INTO PROJECT.PROD_PEDIDO
(IDPRODUCTO, IDPEDIDO, CANTIDAD, COSTO)
VALUES(10658, 714, 4, (SELECT PRECIO / 1.3 FROM PRODUCTO WHERE IDPRODUCTO = 10658));

--INSERT PRODUCTO 3
INSERT INTO PROJECT.PROD_PEDIDO
(IDPRODUCTO, IDPEDIDO, CANTIDAD, COSTO)
VALUES(13111, 714, 5, (SELECT PRECIO / 1.3 FROM PRODUCTO WHERE IDPRODUCTO = 13111));


--COMPLETAR LOS VALORES DEL PEDIDO
UPDATE PEDIDO 
SET 
IMPORTE = (SELECT SUM(CANTIDAD*COSTO) FROM PROD_PEDIDO WHERE IDPEDIDO = 714) * 1.16,
IVA = (SELECT SUM(CANTIDAD*COSTO) FROM PROD_PEDIDO WHERE IDPEDIDO = 714) * 0.16
WHERE IDPEDIDO = 714;

--ACTUALIZAR EXISTENCIAS
UPDATE PRODUCTO 
SET EXISTENCIAS = EXISTENCIAS + 3
WHERE IDPRODUCTO = 10164;

UPDATE PRODUCTO 
SET EXISTENCIAS = EXISTENCIAS + 4 
WHERE IDPRODUCTO = 10658;

UPDATE PRODUCTO 
SET EXISTENCIAS = EXISTENCIAS +5
WHERE IDPRODUCTO = 13111;

