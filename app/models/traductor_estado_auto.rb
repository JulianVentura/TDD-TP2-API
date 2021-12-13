class TraductorEstadoAuto
  TEXTO_A_ESTADO = {
    'en_revision' => EnRevision,
    'cotizado' => Cotizado,
    'esperando_entrega' => EsperandoEntrega,
    'publicado' => Publicado,
    'vendido' => Vendido
  }.freeze

  SIMBOLO_A_TEXTO = {
    :en_revision => 'en_revision',
    :cotizado => 'cotizado',
    :esperando_entrega => 'esperando_entrega',
    :publicado => 'publicado',
    :vendido => 'vendido',
  }.freeze

  def texto_a_estado(estado_texto)
    raise ErrorEstadoNoExiste unless TEXTO_A_ESTADO[estado_texto]
    TEXTO_A_ESTADO[estado_texto]
  end

  def simbolo_a_texto(simbolo)
    SIMBOLO_A_TEXTO[simbolo]
  end
end