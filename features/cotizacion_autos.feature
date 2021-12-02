# language: es
Característica: Cotizacion de autos

  Antecedentes:
    Dado que existe un usuario con nombre "juan" y mail "juan@test.com"
    Y ingreso un auto modelo "Fiat Uno", patente "ABC123", kilometros 100000 y año 1999

  Escenario: CO1 - Consulta de cotizado
    Cuando se cotiza el auto de patente "ABC123" con precio 120000
    Y el usuario consulta el estado de sus autos
    Entonces recibo una lista que contiene 1 autos
    Y contiene patente "ABC123", estado "Cotizado" y precio 120000
  
  Escenario: CO2 - Cotizacion de auto no existente
    Cuando se cotiza el auto de patente "ZXC123" con precio 120000
    Entonces obtengo un mensaje de error por auto no existente
