class ConsultadorOfertasRecibidas
  def initialize(repo_oferta, repo_auto)
    @repo_oferta = repo_oferta
    @repo_auto = repo_auto
  end

  def consultar(patente, id_prop)
    raise ErrorAutoNoExiste unless @repo_auto.existe_auto(patente)

    auto = @repo_auto.find(patente)
    raise ErrorUsuarioNoEsElPropietario unless auto.usuario.id == id_prop

    @repo_oferta.buscar_por_patente(patente)
  end
end
