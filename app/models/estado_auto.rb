class EstadoAuto

  def cotizar(_precio)
    raise ErrorNoCotizable
  end

  def entregar_llave?
    raise ErrorAutoNoEsperaEntregaLlaves
  end

  def ==(other)
    @estado == other.estado
  end

  def cotizado?
    raise ErrorAutoNoCotizado
  end

  def esta_publicado?
    raise ErrorAutoNoEstaPublicado
  end

  attr_reader :estado

  protected
  
  def initialize(estado)
    @estado = estado
  end
end

class EnRevision < EstadoAuto
  def initialize
    super(:en_revision)
  end

  def cotizar(precio)
    precio
  end
end

class Cotizado < EstadoAuto
  def initialize
    super(:cotizado)
  end

  def cotizado?
    true
  end
end

class EsperandoEntrega < EstadoAuto
  def initialize
    super(:esperando_entrega)
  end

  def entregar_llave?
    nil
  end
end

class Publicado < EstadoAuto
  def initialize
    super(:publicado)
  end

  def esta_publicado?
    true
  end
end

class Vendido < EstadoAuto
  def initialize
    super(:vendido)
  end
end
