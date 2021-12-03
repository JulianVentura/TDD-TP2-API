class Estado
  def initialize(estado)
    @estado = estado
  end

  def cotizar(_precio)
    raise ErrorNoCotizable
  end

  def entregar_llave?
    raise ErrorAutoNoEsperaEntregaLlaves
  end

  def ==(other)
    @estado == other.estado
  end

  attr_reader :estado
end

class EnRevision < Estado
  def initialize
    super(:en_revision)
  end

  def cotizar(precio)
    precio
  end
end

class Cotizado < Estado
  def initialize
    super(:cotizado)
  end
end

class EsperandoEntrega < Estado
  def initialize
    super(:esperando_entrega)
  end

  def entregar_llave?
    nil
  end
end

class Publicado < Estado
  def initialize
    super(:publicado)
  end
end
