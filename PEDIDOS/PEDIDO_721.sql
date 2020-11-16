--SELECT PARA IDENTIFICAR LOS PRODUCTOS QUE PUEDE SURTIR EL PROOVEDOR 1
SELECT p.IDPROVEEDOR, p.NOMBRE, ps.IDPRODUCTO AS SURTE_PRODUCTO FROM  PROVEEDOR p, PROD_SURTIDO ps
WHERE p.IDPROVEEDOR = ps.IDPROVEEDOR AND p.IDPROVEEDOR = 3;

--INSERTAR EL PEDIDO
INSERT INTO PROJECT.PEDIDO
(IDPEDIDO, FECHA_PEDIDO, IMPORTE, FECHA_RECIBIDO, IVA, IDPROVEEDOR)
VALUES(721, '2012-02-25-00.00.00.000000', 6073.76, NULL, 837.76, 3);

--REVISAR QUE SE INSERTO CORRECTAMENTE
SELECT * FROM PEDIDO WHERE IDPEDIDO = 721;

--INSERTAR LOS PRODUCTOS PEDIDOS

--SELECT PARA CALCULAR EL COSTO PRODUCTO 1
SELECT PRECIO, PRECIO / 1.3 AS COSTO FROM PRODUCTO WHERE IDPRODUCTO = 15185;

--INSERT PRODUCTO 1
INSERT INTO PROJECT.PROD_PEDIDO
(IDPRODUCTO, IDPEDIDO, CANTIDAD, COSTO)
VALUES(15185, 721, 3, 1092);

--SELECT PARA CALCULAR EL COSTO PRODUCTO 2
SELECT PRECIO, PRECIO / 1.3 AS COSTO FROM PRODUCTO WHERE IDPRODUCTO = 16234;

--INSERT PRODUCTO 2
INSERT INTO PROJECT.PROD_PEDIDO
(IDPRODUCTO, IDPEDIDO, CANTIDAD, COSTO)
VALUES(16234, 721, 4, 35);

--SELECT PARA CALCULAR EL COSTO PRODUCTO 3
SELECT PRECIO, PRECIO / 1.3 AS COSTO FROM PRODUCTO WHERE IDPRODUCTO = 18615;

--INSERT PRODUCTO 3
INSERT INTO PROJECT.PROD_PEDIDO
(IDPRODUCTO, IDPEDIDO, CANTIDAD, COSTO)
VALUES(18615, 721, 2, 910);

--REVISAR QUE SE INSERTARON CORRECTAMENTE
SELECT * FROM PROD_PEDIDO pp WHERE IDPEDIDO = 721;
