--INSERTAR EL PAGO PARA LA FACTURA
INSERT INTO PROJECT.PAGO
(IDPAGO, FECHA)
VALUES(4, '2012-03-15');

--SELECT PARA VER LOS POSIBLES CLIENTES
SELECT * FROM PROJECT.CLIENTE ;

--INSERTAR LA FACTURA
INSERT INTO PROJECT.FACTURA
(IDFACTURA, FOLIO, FECHA, IVA, IMPORTE, TIPO_FACTURA, SALDO, IDCLIENTE, IDPAGO)
VALUES(5, 'WABJ59957', '2012-03-14', 0, 0, 'CONTADO', 0, 5, 4);

--INSERTAR PRODUCTOS VENDIDOS
--SELECT PARA VER LOS POSIBLES PRODUCTOS
SELECT * FROM PRODUCTO p ;

--INSERTAR PRODUCTO VENDIDO 1
INSERT INTO PROJECT.PROD_VENDIDO
(IDFACTURA, IDPRODUCTO, PRECIO, CANTIDAD)
VALUES(5, 16986, (SELECT PRECIO FROM PRODUCTO WHERE IDPRODUCTO = 16986) * 3, 3);

--INSERTAR PRODUCTO VENDIDO 2
INSERT INTO PROJECT.PROD_VENDIDO
(IDFACTURA, IDPRODUCTO, PRECIO, CANTIDAD)
VALUES(5, 19460, (SELECT PRECIO FROM PRODUCTO WHERE IDPRODUCTO = 19460) * 5, 5);

--INSERTAR PRODUCTO VENDIDO 3
INSERT INTO PROJECT.PROD_VENDIDO
(IDFACTURA, IDPRODUCTO, PRECIO, CANTIDAD)
VALUES(5, 15920, (SELECT PRECIO FROM PRODUCTO WHERE IDPRODUCTO = 15920) * 4, 4);

--ACTUALIZAR EL IMPORTE Y EL IVA DE LA FACTURA BASADO EN LA SUMA DE LOS PRECIOS
UPDATE PROJECT.FACTURA
SET IVA=(SELECT SUM(PRECIO)* 0.16 FROM PROD_VENDIDO WHERE IDFACTURA = 5),
IMPORTE=(SELECT SUM(PRECIO)* 1.16 FROM PROD_VENDIDO WHERE IDFACTURA = 5)
WHERE IDFACTURA=5;

--REVISAR QUE SE A?ADIO CORRECTAMENTE
SELECT * FROM FACTURA WHERE IDFACTURA = 5;

SELECT * FROM PROD_VENDIDO pv WHERE IDFACTURA = 5;






