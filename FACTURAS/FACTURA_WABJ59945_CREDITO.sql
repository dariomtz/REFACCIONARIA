--SELECT PARA VER LOS POSIBLES CLIENTES
SELECT * FROM PROJECT.CLIENTE ;

--INSERTAR LA FACTURA
INSERT INTO PROJECT.FACTURA
(IDFACTURA, FOLIO, FECHA, IVA, IMPORTE, TIPO_FACTURA, SALDO, IDCLIENTE, IDPAGO)
VALUES(6, 'WABJ59945', '2012-03-16', 0, 0, 'CREDITO', 0, 6, NULL);

--INSERTAR PRODUCTOS VENDIDOS
--SELECT PARA VER LOS POSIBLES PRODUCTOS
SELECT * FROM PRODUCTO p ;

--INSERTAR PRODUCTO VENDIDO 1
INSERT INTO PROJECT.PROD_VENDIDO
(IDFACTURA, IDPRODUCTO, PRECIO, CANTIDAD)
VALUES(6, 18615, (SELECT PRECIO FROM PRODUCTO WHERE IDPRODUCTO = 18615) * 3, 3);

--INSERTAR PRODUCTO VENDIDO 2
INSERT INTO PROJECT.PROD_VENDIDO
(IDFACTURA, IDPRODUCTO, PRECIO, CANTIDAD)
VALUES(6, 19460, (SELECT PRECIO FROM PRODUCTO WHERE IDPRODUCTO = 19460) * 5, 5);

--INSERTAR PRODUCTO VENDIDO 3
INSERT INTO PROJECT.PROD_VENDIDO
(IDFACTURA, IDPRODUCTO, PRECIO, CANTIDAD)
VALUES(6, 20614, (SELECT PRECIO FROM PRODUCTO WHERE IDPRODUCTO = 20614) * 4, 4);

--ACTUALIZAR EL IMPORTE Y EL IVA DE LA FACTURA BASADO EN LA SUMA DE LOS PRECIOS
UPDATE PROJECT.FACTURA
SET IVA=(SELECT SUM(PRECIO)* 0.16 FROM PROD_VENDIDO WHERE IDFACTURA = 6),
IMPORTE=(SELECT SUM(PRECIO)* 1.16 FROM PROD_VENDIDO WHERE IDFACTURA = 6),
SALDO=(SELECT SUM(PRECIO)* 1.16 FROM PROD_VENDIDO WHERE IDFACTURA = 6)
WHERE IDFACTURA=6;

--REVISAR QUE SE A?ADIO CORRECTAMENTE
SELECT * FROM FACTURA WHERE IDFACTURA = 6;

SELECT * FROM PROD_VENDIDO pv WHERE IDFACTURA = 6;






