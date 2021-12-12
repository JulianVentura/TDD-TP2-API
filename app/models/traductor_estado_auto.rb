class TraductorEstadoAuto
  TEXTO_A_ESTADO = {
    'en_revision' => EnRevision
  }.freeze

  SIMBOLO_A_TEXTO = {
    :en_revision => 'en_revision'
  }.freeze

  def initialize
    super
  end

  def texto_a_estado(estado_texto)
    TEXTO_A_ESTADO[estado_texto]
  end

  def simbolo_a_texto(simbolo)
    SIMBOLO_A_TEXTO[simbolo]
  end
end