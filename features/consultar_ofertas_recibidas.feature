#language: es
Característica: Consultar ofertas recibidas

  Antecedentes:
    Dado que existe un usuario con nombre "juan" y mail "juan@test.com"
    Y tiene un auto modelo "Fiat Uno" patente "ABC123" publicado como p2p
    Y que existe un usuario ofertador con nombre "jorge" y mail "jorge@test.com"
  
  Escenario: CORV1 - Consulta de ofertas recibidas con una oferta
    Dado el usuario ofertador realizo una oferta a mi auto de patente "ABC123" con precio 50000
    Cuando consulto las ofertas recibidas sobre el auto de patente "ABC123"
    Entonces recibo mensaje de ofertas recibidas exitosas
  
  Escenario: CORV2 - Consulta de ofertas recibidas sin ofertas
    Dado ingreso un auto modelo "Fiat Uno", patente "DHG456", kilometros 100000 y año 1999
    Cuando consulto las ofertas recibidas sobre el auto de patente "DHG456"
    Entonces recibo mensaje de no haber ofertas
  
  Escenario: CORV3 - Consulta de ofertas fallida por auto inexistente
    Dado ingreso un auto modelo "Fiat Uno", patente "DHG456", kilometros 100000 y año 1999
    Cuando consulto las ofertas recibidas sobre el auto de patente "TGF657"
    Entonces recibo mensaje de error por auto inexistente

  Escenario: CORV4 - Consulta de ofertas fallida por vendedor incorrecto
    Cuando el usuario ofertador consulta las ofertas recibidas sobre el auto de patente "ABC123"
    Entonces recibo mensaje de error por usuario incorrecto
