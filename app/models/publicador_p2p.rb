require './app/models/errores'
class PublicadorP2P
  def initialize(repo_auto, repo_usuario)
    @repo_auto = repo_auto
    @repo_usuario = repo_usuario
  end

  def publicar_p2p(patente, id_usuario, precio)
    auto = @repo_auto.find(patente)
    prop_del_auto = @repo_usuario.find(id_usuario)
    # raise ErrorUsuarioNoEsElPropietario if id_usuario != prop_del_auto.id

    raise ErrorFaltanArgumentos if patente.nil? || id_usuario.nil? || precio.nil?

    auto.publicar_p2p(precio)
    @repo_auto.save(auto)
  end
end
