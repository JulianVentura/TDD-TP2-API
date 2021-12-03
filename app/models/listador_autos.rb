class ListadorAutos
  def initialize(repo_auto)
    @repo_auto = repo_auto
  end

  def listar_publicado
    @repo_auto.por_estado Publicado.new
  end
end