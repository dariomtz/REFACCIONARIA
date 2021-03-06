--PROCESO PARA LA FACTURA WABJ59954
--INSERTAR EL PAGO PARA LA FACTURA
INSERT INTO PROJECT.PAGO
(IDPAGO, FECHA)
VALUES(2, '2012-03-14');

--INSERTAR LA FACTURA
INSERT INTO PROJECT.FACTURA
(IDFACTURA, FOLIO, FECHA, IVA, IMPORTE, TIPO_FACTURA, SALDO, IDCLIENTE, IDPAGO)
VALUES(3, 'WABJ59954', '2012-03-14', 0, 0, 'CONTADO', 0, 3, 2);

--INSERTAR PRODUCTOS VENDIDOS

--INSERTAR PRODUCTO VENDIDO 1
INSERT INTO PROJECT.PROD_VENDIDO
(IDFACTURA, IDPRODUCTO, PRECIO, CANTIDAD)
VALUES(3, 14944, (SELECT PRECIO FROM PRODUCTO WHERE IDPRODUCTO = 14944), 3);

--INSERTAR PRODUCTO VENDIDO 2
INSERT INTO PROJECT.PROD_VENDIDO
(IDFACTURA, IDPRODUCTO, PRECIO, CANTIDAD)
VALUES(3, 14470, (SELECT PRECIO FROM PRODUCTO WHERE IDPRODUCTO = 14470), 5);

--INSERTAR PRODUCTO VENDIDO 3
INSERT INTO PROJECT.PROD_VENDIDO
(IDFACTURA, IDPRODUCTO, PRECIO, CANTIDAD)
VALUES(3, 10471, (SELECT PRECIO FROM PRODUCTO WHERE IDPRODUCTO = 10471), 4);

--ACTUALIZAR EL IMPORTE Y EL IVA DE LA FACTURA BASADO EN LA SUMA DE LOS PRECIOS
UPDATE PROJECT.FACTURA
SET IVA=(SELECT SUM(PRECIO*CANTIDAD)* 0.16 FROM PROD_VENDIDO WHERE IDFACTURA = 3),
IMPORTE=(SELECT SUM(PRECIO*CANTIDAD)* 1.16 FROM PROD_VENDIDO WHERE IDFACTURA = 3)
WHERE IDFACTURA=3;

--ACTUALIZAR EXSTENCIAS
UPDATE PRODUCTO
SET
EXISTENCIAS = EXISTENCIAS - 3
WHERE IDPRODUCTO = 14944;

UPDATE PRODUCTO 
SET 
EXISTENCIAS = EXISTENCIAS - 5
WHERE IDPRODUCTO = 14470;

UPDATE PRODUCTO 
SET 
EXISTENCIAS = EXISTENCIAS - 4
WHERE IDPRODUCTO = 10471;