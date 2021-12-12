require './app/models/errores'
class VendedorAuto
  def initialize(repo_auto, repo_usuario, repo_compra)
    @repo_auto = repo_auto
    @repo_usuario = repo_usuario
    @repo_compra = repo_compra
  end

  def vender_a_fiubak(patente, id_usuario)
    raise ErrorAutoNoExiste unless @repo_auto.existe_auto(patente)

    auto = @repo_auto.find(patente)
    vendedor = @repo_usuario.find(id_usuario) # TODO: raise si usuario no existe
    usuario_fiubak = Fiubak.new
    @repo_usuario.save(usuario_fiubak) unless @repo_usuario.existe_usuario(usuario_fiubak.id)

    compra = Compra.new(usuario_fiubak, vendedor, auto)

    auto.vender_a_fiubak
    @repo_compra.save(compra)
    @repo_auto.save(auto)
  end
end
