--�Cu�les pedidos a�n no se han recibido (tip: con fecha null)? Por cada uno, me interesa conocer: el
-- n�mero de pedido, la fecha de pedido y el nombre del proveedor.

SELECT IDPEDIDO AS NUMERO_PEDIDO, FECHA_PEDIDO, P2.NOMBRE 
FROM PEDIDO p, PROVEEDOR p2 
WHERE FECHA_RECIBIDO IS NULL AND p.IDPROVEEDOR = p2.IDPROVEEDOR ;


-- �Cu�les son los datos de todos los contactos que tengo del proveedor PRO Europartes S.A. de C.V.?
--Por cada contacto, quiero saber: su nombre completo, el cargo en la empresa, su tel�fono y
--extensi�n.
SELECT CP.NOMBRE, CP.APPATERNO, CP.APMATERNO, CP.CARGO, CP.TELEFONO2, CP.EXTENSION 
FROM CONTACTO_PROVEEDOR cp , PROVEEDOR p 
WHERE cp.IDPROVEEDOR = p.IDPROVEEDOR AND p.NOMBRE = 'PRO Europartes S.A. de C.V.';


-- �Cu�les facturas a�n no se han pagado? Por cada una, me interesa conocer: el folio, la fecha de venta,
-- el nombre completo del cliente, y dos tel�fonos del cliente.
SELECT FOLIO, FECHA, NOMBRE, APPATERNO, APMATERNO, TELEFONO1, TELEFONO2
FROM FACTURA f, CLIENTE c
WHERE IDPAGO IS NULL AND c.IDCLIENTE = f.IDCLIENTE ;

--�Cu�les marcas de retenes son compatibles para un Ford Focus 2007 cuyo motor es de 4-2.0L. Por
-- cada reten, me interesa: su clave externa, marca, precio y existencias.
SELECT p.CLAVE_EXTERNA , p.MARCA , p.PRECIO , p.EXISTENCIAS 
FROM PRODUCTO p , GRUPO g, AUTO_ESTANDAR ae 
WHERE p.IDGRUPO = g.IDGRUPO AND g.NOMBRE = 'RETEN' AND ae.IDESTANDAR = p.IDESTANDAR AND 
ae.IDAUTOMOVIL = (SELECT IDAUTOMOVIL FROM MODELO m, AUTOMOVIL a 
WHERE m.IDMODELO = a.IDMODELO AND A�O = 2007 AND NOMBRE = 'FOCUS' AND FABRICANTE ='FORD' AND MOTOR = '4-2.0L') ;

--SELECT PARA OBTENER EL ID DE FORD FIESTA 2007
SELECT IDAUTOMOVIL FROM MODELO m, AUTOMOVIL a 
WHERE m.IDMODELO = a.IDMODELO AND A�O = 2007 AND NOMBRE = 'FOCUS' AND FABRICANTE ='FORD' AND MOTOR = '4-2.0L';


--�Cu�les productos son compatibles con otro producto, dada su clave externa (la de la caja)? Por cada
-- producto, me interesa: su clave externa, grupo, marca, precio y existencias.
SELECT CLAVE_EXTERNA , IDGRUPO , MARCA , PRECIO , EXISTENCIAS FROM PRODUCTO p WHERE CLAVE_EXTERNA = '24';


--�Cu�l es la informaci�n de la factura WABJ59950? Incluir a) encabezado: fecha de factura, RFC,
-- nombre, tel�fono y fax del cliente, si fue contado o cr�dito, si ya se pag� o no; y b) detalle: c�digo,
-- cantidad, grupo, marca, unidades, precio unitario e importe.

--ENCABEZADO
SELECT FECHA, RFC, NOMBRE, TELEFONO1, TIPO_FACTURA, (f.SALDO = 0) AS PAGADA
FROM FACTURA f, CLIENTE c 
WHERE FOLIO = 'WABJ59950' AND f.IDCLIENTE = c.IDCLIENTE;

--DETALLE
SELECT p.IDPRODUCTO, pv.CANTIDAD, p.IDGRUPO, p.MARCA, pv.CANTIDAD, p.PRECIO, pv.PRECIO AS IMPORTE
FROM PROD_VENDIDO pv, PRODUCTO p 
WHERE IDFACTURA = (SELECT IDFACTURA FROM FACTURA f WHERE FOLIO = 'WABJ59950') AND 
pv.IDPRODUCTO = p.IDPRODUCTO ;
