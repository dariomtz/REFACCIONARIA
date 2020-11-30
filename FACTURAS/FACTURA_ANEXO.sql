-- CREAR LA FACTURA
INSERT INTO PROJECT.FACTURA
(IDFACTURA, FOLIO, FECHA, IVA, IMPORTE, TIPO_FACTURA, SALDO, IDCLIENTE, IDPAGO)
VALUES
(0, 'WABJ59909', '2012-02-16-19.34.00.000000', 0, 0, 'CREDITO', 0, 
(SELECT IDCLIENTE FROM CLIENTE WHERE NOMBRE = 'ITESO'), NULL);
--SE UTILIZA UN SUB-QUERY PARA AVERIGUAR EL IDCLIENTE DE ITESO

--INSERTAR LOS PRODUCTOS VENDIDOS EN LA FACTURA
INSERT INTO PROJECT.PROD_VENDIDO
(IDFACTURA, IDPRODUCTO, PRECIO, CANTIDAD)
VALUES(0, 15185, (SELECT PRECIO FROM PRODUCTO WHERE IDPRODUCTO = 15185) , 2);

INSERT INTO PROJECT.PROD_VENDIDO
(IDFACTURA, IDPRODUCTO, PRECIO, CANTIDAD)
VALUES(0, 15926, (SELECT PRECIO FROM PRODUCTO WHERE IDPRODUCTO = 15926), 2);

INSERT INTO PROJECT.PROD_VENDIDO
(IDFACTURA, IDPRODUCTO, PRECIO, CANTIDAD)
VALUES(0, 13142, (SELECT PRECIO FROM PRODUCTO WHERE IDPRODUCTO = 13142), 1);

UPDATE PROJECT.FACTURA 
SET 
IVA = (SELECT SUM(PRECIO*CANTIDAD) FROM PROD_VENDIDO WHERE IDFACTURA = 0) * 0.16,
IMPORTE = (SELECT SUM(PRECIO*CANTIDAD) FROM PROD_VENDIDO WHERE IDFACTURA = 0) * 1.16,
SALDO = (SELECT SUM(PRECIO*CANTIDAD) FROM PROD_VENDIDO WHERE IDFACTURA = 0) * 1.16
WHERE IDFACTURA = 0;

--ACTUALIZAR EXSTENCIAS
UPDATE PRODUCTO
SET
EXISTENCIAS = EXISTENCIAS - 2
WHERE IDPRODUCTO IN(15926, 15185);

UPDATE PRODUCTO 
SET 
EXISTENCIAS = EXISTENCIAS - 1
WHERE IDPRODUCTO = 13142;



