# language: es
Característica: Publicar P2P

  Antecedentes:
    Dado que existe un usuario con nombre "juan" y mail "juan@test.com"
    Y ingreso un auto modelo "Fiat Uno", patente "ABC123", kilometros 100000 y año 1999
    Y se cotiza el auto de patente "ABC123" con precio 120000

  Escenario: P1 - Publicacion P2P exitosa
    Cuando el usuario publica p2p el auto con patente "ABC123" con precio 240000"
    Entonces recibo mensaje de publicacion exitosa

  Escenario: P2 - Publicacion fallida por falta de datos
    Cuando el usuario publica p2p el auto con patente "ABC123"
    Entonces recibo mensaje de error por falta de argumentos

  Escenario: P3 - Publicacion fallida por auto inexistente
    Cuando el usuario publica p2p el auto con patente "JKA142" con precio 240000"
    Entonces obtengo un mensaje de error por auto no existente

  Escenario: P4 - Publicacion fallida por auto no cotizado
    Dado ingreso un auto modelo "Ford Fiesta", patente "NOC435", kilometros 2000 y año 2004
    Cuando el usuario publica p2p el auto con patente "NOC435" con precio 240000"
    Entonces recibo mensaje de error por auto no cotizado

  Escenario: P5 - Publicacion fallida por usuario incorrecto
    Dado que existe otro usuario con nombre "jorge" y mail "jorge@test.com"
    Cuando el otro usuario publica p2p el auto con patente "ABC123" con precio 240000"
    Entonces recibo mensaje de error por usuario incorrecto

  Escenario: P6 - Publicacion P2P fallida por cotizacion menor a precio Fiubak
    Cuando el usuario publica p2p el auto con patente "ABC123" con precio 100"
    Entonces recibo mensaje de error por precio menor al cotizado por Fiubak

