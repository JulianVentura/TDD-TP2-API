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

class ErrorPatenteRepetida < ErrorEnLaAPI
  def initialize
    mensaje = 'Error: Auto con patente ya registrada'
    super(mensaje)
  end
end

class ErrorNoCotizable < ErrorEnLaAPI
  def initialize
    mensaje = 'Error: Auto no cotizable'
    super(mensaje)
  end
end

class ErrorAutoNoExiste < ErrorEnLaAPI
  def initialize
    mensaje = 'Error: Auto no existe'
    super(mensaje)
  end
end

class ErrorUsuarioNoEsElPropietario < ErrorEnLaAPI
  def initialize
    mensaje = 'Error: Usuario no es el propietario del auto'
    super(mensaje)
  end
end

class ErrorAutoNoEsperaEntregaLlaves < ErrorEnLaAPI
  def initialize
    mensaje = 'Error: Auto no espera entrega de llaves'
    super(mensaje)
  end
end

class ErrorAutoNoCotizado < ErrorEnLaAPI
  def initialize
    mensaje = 'Error: Auto no cotizado'
    super(mensaje)
  end
end

class ErrorPrecioMenorACotizado < ErrorEnLaAPI
  def initialize
    mensaje = 'Error: El precio es menor al cotizado'
    super(mensaje)
  end
end

class ErrorAutoNoEstaPublicado < ErrorEnLaAPI
  def initialize
    mensaje = 'Error: Auto no esta en venta'
    super(mensaje)
  end
end

class ErrorOfertaInvalida < ErrorEnLaAPI
  def initialize
    mensaje = 'Error: Oferta invalida'
    super(mensaje)
  end
end

class ErrorOfertaEnAutoNoParticular < ErrorEnLaAPI
  def initialize
    mensaje = 'Error: No se puede ofertar a un auto fiubak'
    super(mensaje)
  end
end

class ErrorYaSeRealizoOferta < ErrorEnLaAPI
  def initialize
    mensaje = 'Error: No se puede realizar una oferta mas de una vez'
    super(mensaje)
  end
end

class ErrorOfertaNoExiste < ErrorEnLaAPI
  def initialize
    mensaje = 'Error: Oferta no existe'
    super(mensaje)
  end
end

class ErrorOfertaUsuarioNoCoincide < ErrorEnLaAPI
  def initialize
    mensaje = 'Error: Usuario no es el propietario de la oferta'
    super(mensaje)
  end
end

class ErrorOfertaNoPendiente < ErrorEnLaAPI
  def initialize
    mensaje = 'Error: Oferta no se encuentra en estado pendiente'
    super(mensaje)
  end
end

class ErrorPropietarioRealizaOferta < ErrorEnLaAPI
  def initialize
    mensaje = 'Error: No se puede ofertar sobre un auto propio'
    super(mensaje)
  end
end

class ErrorVendedorNoEsElPropietario < ErrorEnLaAPI
  def initialize
    mensaje = 'Error: El vendedor no es el propietario del auto'
    super(mensaje)
  end
end

class ErrorVendedorNoPuedeComprarSuPropioAuto < ErrorEnLaAPI
  def initialize
    mensaje = 'Error: El vendedor no puede comprar su propio auto'
    super(mensaje)
  end
end
