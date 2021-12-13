class TraductorEstadoOferta
  TEXTO_A_ESTADO = {
    'pendiente' => Pendiente,
  }.freeze

  SIMBOLO_A_TEXTO = {
    :pendiente => 'pendiente',
  }.freeze

  def texto_a_estado(estado_texto)
    TEXTO_A_ESTADO[estado_texto]
  end

  def simbolo_a_texto(simbolo)
    SIMBOLO_A_TEXTO[simbolo]
  end
end