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
