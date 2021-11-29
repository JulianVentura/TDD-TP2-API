# language: es
Característica: Registracion


  Escenario: R1 - Registro exitoso
    Cuando me registro con id 123456, nombre "juan" y mail "juan@test.com"
    Entonces el registro es exitoso

  
  Escenario: R2 - Registro fallido por id duplicado
    Dado que existe un usuario con id 123456, nombre "juan" y mail "juan@test.com"
    Cuando me registro con id 123456, nombre "jorge" y mail "jorge@test.com"
    Entonces recibo mensaje de error por id duplicado

  
  Escenario: R3 - Registro fallido por email duplicado
    Dado que existe un usuario con id 123456, nombre "juan" y mail "juan@test.com"
    Cuando me registro con id 654321, nombre "jorge" y mail "juan@test.com"
    Entonces recibo mensaje de error por email duplicado

  
  Escenario: R4 - Registro fallido por falta de argumentos
    Cuando me registro con nombre "juan"
    Entonces recibo mensaje de error por falta de argumentos
