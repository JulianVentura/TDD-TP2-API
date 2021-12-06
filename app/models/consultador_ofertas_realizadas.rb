class ConsultadorOfertasRealizadas
  def initialize(repo_oferta)
    @repo_oferta = repo_oferta
  end

  def consultar(id_ofertante)
    @repo_oferta.buscar_por_ofertante(id_ofertante)
  end
end
