require './app/models/errores'
class EntregarLlaves
  def initialize(repo_auto, repo_usuario)
    @repo_auto = repo_auto
    @repo_usuario = repo_usuario
  end

  def entregar_llaves(patente)
    raise ErrorAutoNoExiste unless @repo_auto.existe_auto(patente)

    auto = @repo_auto.find(patente)

    usuario_fiubak = Fiubak.new
    @repo_usuario.save(usuario_fiubak) unless @repo_usuario.existe_usuario(usuario_fiubak.id)
    auto.cambiar_de_propietario(usuario_fiubak)
    # precio publicacion fiubak - 20% mas
    tasa = 20
    auto.publicar(tasa)
    @repo_auto.save(auto)
  end
end
