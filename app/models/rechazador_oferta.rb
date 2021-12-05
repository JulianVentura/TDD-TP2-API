class RechazadorOferta
  def initialize(repo_oferta)
    @repo_oferta = repo_oferta
  end

  def rechazar(id_oferta, _id_prop)
    # TODO: validar si id_prop coincide con oferta
    # TODO: validar que exista oferta
    # TODO: validar que oferta este en estado pendiente
    oferta = @repo_oferta.find(id_oferta)
    oferta.rechazar

    @repo_oferta.save(oferta)
  end
end
