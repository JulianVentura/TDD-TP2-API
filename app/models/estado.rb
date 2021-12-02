class Estado
  def initialize(estado)
    @estado = estado
  end

  def cotizar(_precio)
    raise ErrorNoCotizable
  end
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
