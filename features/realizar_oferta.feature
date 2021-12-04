# language: es
Característica: Realizar oferta
  
  Antecedentes:
    Dado que existe un usuario con nombre "juan" y mail "juan@test.com"
    Y tiene un auto modelo "Fiat Uno" patente "ABC123" publicado como p2p
    Y que existe un usuario con nombre "Jorge" y email "jorge@test.com"
  
  Escenario: RO1 - Realizacion de oferta exitosa
    Cuando realizo una oferta de 1000 sobre el auto de patente "ABC123"
    Entonces recibo mensaje de oferta exitosa
  
  Escenario: RO2 - Realizacion de oferta fallida por auto inexistente
    Cuando realizo una oferta de 5000 sobre el auto de patente "GHJ456"
    Entonces recibo mensaje de error por auto inexistente
  
  @wip
  Escenario: RO3 -  Realizacion de oferta fallida por falta de argumentos
    Cuando realizo una oferta sin indicar precio sobre el auto de patente "ABC123"
    Entonces recibo mensaje de error por falta de argumentos