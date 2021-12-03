# language: es
Característica: Listar autos disponibles para comprar

Antecedentes:
    Dado que existe un usuario con nombre "juan" y mail "juan@test.com"

Escenario: LA1 - Listado de un unico auto
    Dado que existe un auto publicado por Fiubak modelo "Fiat Uno", patente "ABC123", kilometros 100000, año 1999 y precio 15000
    Cuando se listan los autos en venta
    Entonces recibo una lista que contiene 1 autos
    Y contiene patente "ABC123" y duenio Fiubak

Escenario: LA2 - Listado sin autos
    Cuando se listan los autos en venta
    Entonces recibo una lista que contiene 0 autos

Escenario: LA3 - Listado con 3 autos
    Dado que existe un auto publicado por Fiubak modelo "Fiat Uno", patente "ABC123", kilometros 100000, año 1999 y precio 15000
    Y que existe un auto publicado por Fiubak modelo "Volkswagen Golf", patente "AB123CD", kilometros 0, año 2019 y precio 200000
    Y que existe un auto publicado por Fiubak modelo "Ford Fiesta", patente "ZED124", kilometros 250000, año 1987 y precio 8000
    Cuando se listan los autos en venta
    Entonces recibo una lista que contiene 3 autos
    Y contiene patente "ABC123" y duenio Fiubak
    Y contiene patente "AB123CD" y duenio Fiubak
    Y contiene patente "ZED124" y duenio Fiubak
