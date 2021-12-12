require './app/models/errores'
class Comprador
  def initialize(repo_auto, repo_usuario, repo_compra)
    @repo_auto = repo_auto
    @repo_usuario = repo_usuario
    @repo_compra = repo_compra
  end

  def comprar(patente, id_comprador)
    raise ErrorAutoNoExiste unless @repo_auto.existe_auto(patente)
    raise ErrorUsuarioInexistente unless @repo_usuario.existe_usuario(id_comprador)

    auto = @repo_auto.find(patente)
    comprador = @repo_usuario.find(id_comprador)  # TODO: raise si usuario no existe
    usuario_fiubak = Fiubak.new
    @repo_usuario.save(usuario_fiubak) unless @repo_usuario.existe_usuario(usuario_fiubak.id)

    auto.comprar
    compra = Compra.new(comprador, usuario_fiubak, auto)
    @repo_compra.save(compra)
    @repo_auto.save(auto)
  end
end
