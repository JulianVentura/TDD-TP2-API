require './app/models/errores'
class PublicadorP2P
  def initialize(repo_auto, repo_usuario)
    @repo_auto = repo_auto
    @repo_usuario = repo_usuario
  end

  def publicar_p2p(patente, id_usuario, precio)
    raise ErrorFaltanArgumentos if patente.nil? || id_usuario.nil? || precio.nil?
    raise ErrorAutoNoExiste unless @repo_auto.existe_auto(patente)

    auto = @repo_auto.find(patente)
    raise ErrorUsuarioNoEsElPropietario if id_usuario != auto.usuario.id

    auto.publicar_p2p(precio)
    @repo_auto.save(auto)
  end
end
