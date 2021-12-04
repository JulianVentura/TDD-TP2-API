require './app/models/errores'
class Comprador
  def initialize(repo_auto, repo_usuario)
    @repo_auto = repo_auto
    @repo_usuario = repo_usuario
  end

  def comprar(patente, id_comprador)

    auto = @repo_auto.find(patente)
    auto.comprar
    @repo_auto.save(auto)
    auto
  end
end