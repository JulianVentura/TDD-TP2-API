class ErrorEnLaAPI < StandardError
  def initialize(mensaje)
    @mensaje = mensaje
    super()
  end

  attr_reader :mensaje, :codigo
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
