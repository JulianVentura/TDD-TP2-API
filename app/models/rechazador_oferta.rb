class RechazadorOferta
  def initialize(repo_oferta)
    @repo_oferta = repo_oferta
  end

  def rechazar(id_oferta, id_prop)
    raise ErrorOfertaNoExiste unless @repo_oferta.existe_oferta_id(id_oferta)

    # TODO: validar que oferta este en estado pendiente
    oferta = @repo_oferta.find(id_oferta)

    raise ErrorOfertaUsuarioNoCoincide unless id_prop == oferta.obtener_id_propietario

    oferta.rechazar

    @repo_oferta.save(oferta)
  end
end
