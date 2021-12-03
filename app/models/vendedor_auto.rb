require './app/models/errores'
class VendedorAuto
  def initialize(repo_auto, repo_usuario)
    @repo_auto = repo_auto
    @repo_usuario = repo_usuario
  end

  def vender_a_fiubak(patente, id_usuario)
    raise ErrorAutoNoExiste unless @repo_auto.existe_auto(patente)

    auto = @repo_auto.find(patente)
    prop_del_auto = @repo_usuario.find(auto.usuario.id)
    raise ErrorUsuarioNoEsElPropietario if id_usuario != prop_del_auto.id

    auto.vender_a_fiubak
    @repo_auto.save(auto)
  end
end
