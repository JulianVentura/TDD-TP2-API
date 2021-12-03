#language:es
Característica: Venta a FIUBAK

  Antecedentes:
    Dado que existe un usuario con nombre "juan" y mail "juan@test.com"
    Y ingreso un auto modelo "Fiat Uno", patente "ABC123", kilometros 100000 y año 1999
    Y se cotiza el auto de patente "ABC123" con precio 120000


  Escenario: VF1 - Confirmacion de venta a FIUBAK
    Cuando el usuario vende al auto con patente "ABC123" a Fiubak
    Entonces recibe mensaje de confirmacion de venta


  Escenario: VF2 - Entrega de llaves
    Cuando el usuario vende al auto con patente "ABC123" a Fiubak
    Y se realiza la entrega de llaves
    Y el usuario consulta el estado de sus autos
    Entonces recibo una lista que contiene 0 autos
