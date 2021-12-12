# language: es
Característica: Comprar auto a FIUBAK

  Antecedentes:
    Dado que existe un vendedor con nombre "juan" y mail "juan@test.com"
    Y que le vendio un auto a FIUBAK modelo "Fiat Uno", patente "ABC123", kilometros 100000 y año 1999
    Y que existe un comprador con nombre "marcelo" y mail "marcelo@test.com"

  Escenario: RF1 - Compra exitosa
    Cuando el comprador compra el auto de patente "ABC123"
    Entonces recibo una confirmacion de compra

  Escenario: RF2 - Compra fallida auto inexistente
    Cuando el comprador compra el auto de patente "NOE123"
    Entonces obtengo un mensaje de error por auto no existente

  Escenario: RF3 - Compra fallida auto no en venta
    Dado que existe un auto modelo "Fiat Uno", patente "ZXC123", kilometros 100000 y año 1999
    Cuando el comprador compra el auto de patente "ZXC123"
    Entonces obtengo un mensaje de error por auto no en venta

  Escenario: RF4 - Compra fallida al intentar recomprar auto
    Cuando el vendedor compra el auto de patente "ABC123"
    Entonces obtengo un mensaje de error por intento de recompra
