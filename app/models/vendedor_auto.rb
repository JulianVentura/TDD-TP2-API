require './app/models/errores'
class VendedorAuto
  def initialize(repo_auto, repo_usuario, repo_compra)
    @repo_auto = repo_auto
    @repo_usuario = repo_usuario
    @repo_compra = repo_compra
  end

  def vender_a_fiubak(patente, id_vendedor)
    raise ErrorAutoNoExiste unless @repo_auto.existe_auto(patente)
    raise ErrorUsuarioInexistente unless @repo_usuario.existe_usuario(id_vendedor)

    auto = @repo_auto.find(patente)
    vendedor = @repo_usuario.find(id_vendedor)
    usuario_fiubak = Fiubak.new
    @repo_usuario.save(usuario_fiubak) unless @repo_usuario.existe_usuario(usuario_fiubak.id)

    compra = Compra.new(usuario_fiubak, vendedor, auto)

    auto.vender_a_fiubak
    @repo_compra.save(compra)
    @repo_auto.save(auto)
  end
end
