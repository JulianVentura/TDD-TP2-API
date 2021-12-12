class AceptadorOferta
  def initialize(repo_oferta, repo_auto)
    @repo_oferta = repo_oferta
    @repo_auto = repo_auto
  end

  def aceptar(id_oferta, id_prop) # rubocop:disable Metrics/AbcSize
    raise ErrorOfertaNoExiste unless @repo_oferta.existe_oferta_id(id_oferta)

    oferta = @repo_oferta.find(id_oferta)
    raise ErrorOfertaUsuarioNoCoincide unless id_prop == oferta.obtener_id_propietario

    auto = oferta.auto
    oferta.aceptar
    auto.comprar

    ofertas_pendientes = @repo_oferta.buscar_por_patente_y_estado(oferta.auto.patente, Pendiente.new)
    rechazador = RechazadorOferta.new(@repo_oferta)
    ofertas_pendientes.each do |oferta_pendiente|
      rechazador.rechazar(oferta_pendiente.id, oferta_pendiente.obtener_id_propietario)
    end
    @repo_auto.save(auto)
    @repo_oferta.save(oferta)
  end
end
