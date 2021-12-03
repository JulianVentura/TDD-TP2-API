require './app/models/errores'
class VendedorAuto
  def initialize(repo_auto)
    @repo_auto = repo_auto
  end

  def vender_a_fiubak(patente)
    auto = @repo_auto.find(patente)
    auto.vender_a_fiubak
    @repo_auto.save(auto)
  end
end
