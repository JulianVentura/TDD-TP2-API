# language: es
Característica: Consultar estado autos

  Antecedentes:
    Dado que existe un usuario con nombre "juan" y mail "juan@test.com"
    Y ingreso un auto modelo "Fiat Uno", patente "ABC123", kilometros 100000 y año 1999

  Escenario: CA1 - Consulta de estado en revisión
    Cuando el usuario consulta el estado de sus autos
    Entonces recibo una lista que contiene 1 autos
    Y contiene patente "ABC123" y estado "En revision"