require './app/models/errores'
class CotizadorAuto
  def initialize(repo_auto)
    @repo_auto = repo_auto
  end

  def cotizar(patente, precio)
    auto = @repo_auto.find(patente)
    auto.cotizar(precio)
    @repo_auto.save(auto)
  end
end
