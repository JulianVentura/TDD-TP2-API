# language: es
Característica: Registracion


  Escenario: R1 - Registro exitoso
    Cuando me registro con id 123456, nombre "juan" y mail "juan@test.com"
    Entonces el registro es exitoso

  @wip
  Escenario: R2 - Registro fallido por id duplicado
    Dado que existe un usuario con id "123456", nombre "juan" y mail "juan@test.com"
    Cuando me registro con id 123456, nombre "jorge" y mail "jorge@test.com"
    Entonces recibo mensaje de error por registro fallido

  @wip
  Escenario: R3 - Registro fallido por email duplicado
    Dado que existe un usuario con id "123456", nombre "juan" y mail "juan@test.com"
    Cuando me registro con id 654321, nombre "jorge" y mail "juan@test.com"
    Entonces recibo mensaje de error por registro fallido
