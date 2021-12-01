class ErrorEnLaAPI < StandardError
  def initialize(mensaje)
    @mensaje = mensaje
    super()
  end

  attr_reader :mensaje
end

class ErrorIdRepetido < ErrorEnLaAPI
  def initialize
    mensaje = 'Error: Ya estas registrado'
    super(mensaje)
  end
end

class ErrorEmailRepetido < ErrorEnLaAPI
  def initialize
    mensaje = 'Error: Ya existe un usuario con ese email'
    super(mensaje)
  end
end

class ErrorFaltanArgumentos < ErrorEnLaAPI
  def initialize
    mensaje = 'Error: Faltan argumentos'
    super(mensaje)
  end
end

class ErrorUsuarioInexistente < ErrorEnLaAPI
  def initialize
    super('Error: Usuario inexistente')
  end
end