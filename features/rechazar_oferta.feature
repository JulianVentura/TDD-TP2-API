#language: es
Característica: Rechazar oferta

  Antecedentes:
    Dado que existe un usuario con nombre "juan" y mail "juan@test.com"
    Y que existe otro usuario con nombre "Jorge" y email "jorge@test.com"
    Y que existe un auto publicado por FIUBAK modelo "Fiat Uno", patente "ABC123", kilometros 100000 y año 1999
    Y se cotiza el auto de patente "ABC123" con precio 120000
    Y el usuario publica p2p el auto con patente "ABC123" con precio 240000"
    Y realizo una oferta de 200000 sobre el auto de patente "ABC123"

  @wip
  Escenario: RO1 - Rechazo de oferta exitoso
    Cuando rechazo la oferta sobre el auto de patente "ABC123"
    Entonces recibo mensaje de oferta rechazada

  @wip
  Escenario: RO2 - Rechazo de oferta fallida por oferta inexistente
      Cuando rechazo una oferta inexistente
    Entonces recibo mensaje de error por oferta inexistente

  @wip
  Escenario: RO3 -  Rechazo de oferta fallida por falta de datos
    Cuando rechazo una oferta sin indicar su id
    Entonces recibo mensaje de error por falta de argumentos
