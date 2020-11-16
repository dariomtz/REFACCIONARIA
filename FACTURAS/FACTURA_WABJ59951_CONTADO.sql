--INSERTAR EL PAGO PARA LA FACTURA
INSERT INTO PROJECT.PAGO
(IDPAGO, FECHA)
VALUES(0, '2012-03-12');

--SELECT PARA VER LOS POSIBLES CLIENTES
SELECT * FROM PROJECT.CLIENTE ;

--INSERTAR LA FACTURA
INSERT INTO PROJECT.FACTURA
(IDFACTURA, FOLIO, FECHA, IVA, IMPORTE, TIPO_FACTURA, SALDO, IDCLIENTE, IDPAGO)
VALUES(1, 'WABJ59951', '2012-03-12', 0, 0, 'CONTADO', 0, 2, 0);

--INSERTAR PRODUCTOS VENDIDOS
--SELECT PARA VER LOS POSIBLES PRODUCTOS
SELECT * FROM PRODUCTO p ;

--INSERTAR PRODUCTO VENDIDO 1
INSERT INTO PROJECT.PROD_VENDIDO
(IDFACTURA, IDPRODUCTO, PRECIO, CANTIDAD)
VALUES(1, 17909, (SELECT PRECIO FROM PRODUCTO WHERE IDPRODUCTO = 17909) * 3, 3);

--INSERTAR PRODUCTO VENDIDO 2
INSERT INTO PROJECT.PROD_VENDIDO
(IDFACTURA, IDPRODUCTO, PRECIO, CANTIDAD)
VALUES(1, 20614, (SELECT PRECIO FROM PRODUCTO WHERE IDPRODUCTO = 20614) * 5, 5);

--INSERTAR PRODUCTO VENDIDO 3
INSERT INTO PROJECT.PROD_VENDIDO
(IDFACTURA, IDPRODUCTO, PRECIO, CANTIDAD)
VALUES(1, 13142, (SELECT PRECIO FROM PRODUCTO WHERE IDPRODUCTO = 13142) * 4, 4);

--ACTUALIZAR EL IMPORTE Y EL IVA DE LA FACTURA BASADO EN LA SUMA DE LOS PRECIOS
UPDATE PROJECT.FACTURA
SET IVA=(SELECT SUM(PRECIO)* 0.16 FROM PROD_VENDIDO WHERE IDFACTURA = 1),
IMPORTE=(SELECT SUM(PRECIO)* 1.16 FROM PROD_VENDIDO WHERE IDFACTURA = 1)
WHERE IDFACTURA=1;

--REVISAR QUE SE A�ADIO CORRECTAMENTE
SELECT * FROM FACTURA WHERE IDFACTURA = 1;

SELECT * FROM PROD_VENDIDO pv WHERE IDFACTURA = 1;






