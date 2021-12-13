class TraductorEstadoOferta
  TEXTO_A_ESTADO = {
    'pendiente' => Pendiente,
  }.freeze

  def texto_a_estado(estado_texto)
    TEXTO_A_ESTADO[estado_texto]
  end
end