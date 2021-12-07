#language: es
Característica: Aceptar oferta

Antecedentes:
  Dado que existe un usuario con nombre "juan" y mail "juan@test.com"
  Y que existe otro usuario con nombre "Jorge" y email "jorge@test.com"
  Y tiene un auto modelo "Fiat Uno" patente "ABC123" publicado como p2p
  Y se cotiza el auto de patente "ABC123" con precio 120000
  Y el usuario publica p2p el auto con patente "ABC123" con precio 240000"
  Y realizo una oferta de 200000 sobre el auto de patente "ABC123"

  Escenario: AO1 - Aceptacion de oferta exitosa
    Cuando acepto la oferta sobre el auto de patente "ABC123"
    Entonces recibo mensaje de oferta aceptada

  @wip
  Escenario: AO2 - Aceptacion de oferta fallida por oferta inexistente
    Cuando acepto una oferta inexistente
    Entonces recibo mensaje de error por oferta inexistente

  @wip
  Escenario: AO3 -  Aceptacion de oferta fallida por id no coincidente
    Cuando acepto una oferta cuando el id del propietario no coincide
    Entonces recibo mensaje de error por id no coincidente

  @wip
  Escenario: AO4 -  Aceptacion de oferta fallida por estado de oferta no pendiente
    Dado acepto la oferta sobre el auto de patente "ABC123"
    Cuando acepto la oferta sobre el auto de patente "ABC123"
    Entonces recibo mensaje de error por oferta no pendiente
