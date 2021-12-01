require './app/models/errores'
class CreadorAuto
  def initialize(repo_auto, repo_usuario)
    @repo_auto = repo_auto
    @repo_usuario = repo_usuario
  end

  def crear_auto(patente, modelo, anio, kilometros, id_prop)
    raise ErrorUsuarioInexistente unless @repo_usuario.existe_usuario(id_prop)
    usuario = @repo_usuario.find(id_prop)
    auto = Auto.new(patente, modelo, anio, kilometros, usuario)
    @repo_auto.save(auto)
    auto
  end
end
