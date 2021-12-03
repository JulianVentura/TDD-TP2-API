require './app/models/errores'
class EntregarLlaves
  def initialize(repo_auto)
    @repo_auto = repo_auto
  end

  def entregar_llaves(patente)
    auto = @repo_auto.find(patente)
    @repo_auto.delete(auto)
    usuario_fiubak = @repo_usuario.find(Fiubak.new.id)
    auto.cambio_de_propietario(usuario_fiubak)
    # precio publicacion fiubak - 20% mas
    auto.publicar(auto.precio * 1.2)
  end
end
