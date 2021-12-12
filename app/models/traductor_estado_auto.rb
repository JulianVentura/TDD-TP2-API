class TraductorEstadoAuto
  ESTADOS = {
    'en_revision' => EnRevision
  }.freeze

  def initialize
    super
  end

  def crear(estado_texto)
    ESTADOS[estado_texto]
  end
end