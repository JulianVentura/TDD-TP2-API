class ErrorDeNegocio < StandardError
  def initialize(mensaje)
    @mensaje = mensaje
    super()
  end

  attr_reader :mensaje
end

class ErrorIdRepetido < ErrorDeNegocio
  def initialize
    mensaje = 'Error: Ya estas registrado'
    super(mensaje)
  end
end

class ErrorEmailRepetido < ErrorDeNegocio
  def initialize
    mensaje = 'Error: Ya existe un usuario con ese email'
    super(mensaje)
  end
end

class ErrorFaltanArgumentos < ErrorDeNegocio
  def initialize
    mensaje = 'Error: Faltan argumentos'
    super(mensaje)
  end
end

class ErrorUsuarioInexistente < ErrorDeNegocio
  def initialize
    super('Error: Usuario inexistente')
  end
end

class ErrorPatenteRepetida < ErrorDeNegocio
  def initialize
    mensaje = 'Error: Auto con patente ya registrada'
    super(mensaje)
  end
end

class ErrorNoCotizable < ErrorDeNegocio
  def initialize
    mensaje = 'Error: Auto no cotizable'
    super(mensaje)
  end
end

class ErrorAutoNoExiste < ErrorDeNegocio
  def initialize
    mensaje = 'Error: Auto no existe'
    super(mensaje)
  end
end

class ErrorUsuarioNoEsElPropietario < ErrorDeNegocio
  def initialize
    mensaje = 'Error: Usuario no es el propietario del auto'
    super(mensaje)
  end
end

class ErrorAutoNoEsperaEntregaLlaves < ErrorDeNegocio
  def initialize
    mensaje = 'Error: Auto no espera entrega de llaves'
    super(mensaje)
  end
end

class ErrorAutoNoCotizado < ErrorDeNegocio
  def initialize
    mensaje = 'Error: Auto no cotizado'
    super(mensaje)
  end
end

class ErrorPrecioMenorACotizado < ErrorDeNegocio
  def initialize
    mensaje = 'Error: El precio es menor al cotizado'
    super(mensaje)
  end
end

class ErrorAutoNoEstaPublicado < ErrorDeNegocio
  def initialize
    mensaje = 'Error: Auto no esta en venta'
    super(mensaje)
  end
end

class ErrorOfertaInvalida < ErrorDeNegocio
  def initialize
    mensaje = 'Error: Oferta invalida'
    super(mensaje)
  end
end

class ErrorOfertaEnAutoNoParticular < ErrorDeNegocio
  def initialize
    mensaje = 'Error: No se puede ofertar a un auto fiubak'
    super(mensaje)
  end
end

class ErrorYaSeRealizoOferta < ErrorDeNegocio
  def initialize
    mensaje = 'Error: No se puede realizar una oferta mas de una vez'
    super(mensaje)
  end
end

class ErrorOfertaNoExiste < ErrorDeNegocio
  def initialize
    mensaje = 'Error: Oferta no existe'
    super(mensaje)
  end
end

class ErrorOfertaUsuarioNoCoincide < ErrorDeNegocio
  def initialize
    mensaje = 'Error: Usuario no es el propietario de la oferta'
    super(mensaje)
  end
end

class ErrorOfertaNoPendiente < ErrorDeNegocio
  def initialize
    mensaje = 'Error: Oferta no se encuentra en estado pendiente'
    super(mensaje)
  end
end

class ErrorPropietarioRealizaOferta < ErrorDeNegocio
  def initialize
    mensaje = 'Error: No se puede ofertar sobre un auto propio'
    super(mensaje)
  end
end

class ErrorVendedorNoEsElPropietario < ErrorDeNegocio
  def initialize
    mensaje = 'Error: El vendedor no es el propietario del auto'
    super(mensaje)
  end
end

class ErrorVendedorNoPuedeComprarSuPropioAuto < ErrorDeNegocio
  def initialize
    mensaje = 'Error: El vendedor no puede comprar su propio auto'
    super(mensaje)
  end
end

class ErrorIntentoRecompra < ErrorDeNegocio
  def initialize
    mensaje = 'Error: No podes comprar un auto que vendiste'
    super(mensaje)
  end
end