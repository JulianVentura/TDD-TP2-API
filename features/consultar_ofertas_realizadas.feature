#language: es
Característica: Consultar ofertas realizadas

  Antecedentes:
    Dado que existe un usuario con nombre "juan" y mail "juan@test.com"
    Y tiene un auto modelo "Fiat Uno" patente "ABC123" publicado como p2p
    Y que existe un usuario ofertador con nombre "jorge" y mail "jorge@test.com"
  @wip
  Escenario: CORC1 - Consulta de ofertas realizadas con una oferta
    Dado que tengo realizada una oferta al auto de patente "ABC123" con precio 50000
    Cuando consulto mis ofertas realizadas
    Entonces obtengo la oferta de patente "ABC123" con precio 50000
  @wip
  Escenario: CORC2 - Consulta de ofertas realizadas sin ofertas
    Cuando consulto mis ofertas realizadas
    Entonces recibo un mensaje sin ofertas
