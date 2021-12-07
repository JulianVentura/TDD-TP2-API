class AceptadorOferta
  def initialize(repo_oferta)
    @repo_oferta = repo_oferta
  end

  def aceptar(id_oferta, _id_prop)
    raise ErrorOfertaNoExiste unless @repo_oferta.existe_oferta_id(id_oferta)
    oferta = @repo_oferta.find(id_oferta)

    oferta.aceptar
    @repo_oferta.save(oferta)
  end
end
