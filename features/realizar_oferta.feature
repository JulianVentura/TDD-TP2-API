# language: es
Característica: Realizar oferta
  
  Antecedentes:
    Dado que existe un usuario con nombre "juan" y mail "juan@test.com"
    Y tiene un auto modelo "Fiat Uno" patente "ABC123" publicado como p2p
    Y que existe otro usuario con nombre "Jorge" y email "jorge@test.com"
  
  Escenario: RO1 - Realizacion de oferta exitosa
    Cuando realizo una oferta de 1000 sobre el auto de patente "ABC123"
    Entonces recibo mensaje de oferta exitosa
  
  Escenario: RO2 - Realizacion de oferta fallida por auto inexistente
    Cuando realizo una oferta de 5000 sobre el auto de patente "GHJ456"
    Entonces recibo mensaje de error por auto inexistente

  Escenario: RO3 -  Realizacion de oferta fallida por oferta invalida
    Cuando realizo una oferta sin indicar precio sobre el auto de patente "ABC123"
    Entonces recibo mensaje de error por oferta invalida

  Escenario: RO4 - Realizacion de oferta fallida por publicacion inexistente
    Dado que existe un auto modelo "Fiat Uno", patente "FGH123", kilometros 100000 y año 1999
    Cuando realizo una oferta de 5000 sobre el auto de patente "FGH123"
    Entonces recibo mensaje de error por publicacion inexistente

  Escenario: RO5 - Realizacion de oferta fallida por oferta a publicacion fiubak
    Dado que existe un auto publicado por Fiubak modelo "Fiat Uno", patente "HHH888", kilometros 100000, año 1999 y precio 15000
    Cuando realizo una oferta de 5000 sobre el auto de patente "HHH888"
    Entonces recibo mensaje de error por publicacion de fiubak

  Escenario: RO6 - Realizacion de oferta fallida por oferta duplicada
    Cuando realizo una oferta de 1000 sobre el auto de patente "ABC123"
    Y realizo una oferta de 5000 sobre el auto de patente "ABC123"
    Entonces recibo mensaje de error por ofertar mas de una vez