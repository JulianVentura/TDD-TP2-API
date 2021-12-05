class ConsultadorOfertasRecibidas
  def initialize(repo_oferta, repo_auto)
    @repo_oferta = repo_oferta
    @repo_auto = repo_auto
  end

  def consultar(patente, _id_prop)
    @repo_oferta.buscar_por_patente(patente)
  end
end
