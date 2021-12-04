require './app/models/errores'
class CreadorAuto
  def initialize(repo_auto, repo_usuario)
    @repo_auto = repo_auto
    @repo_usuario = repo_usuario
  end

  def crear_auto(patente, modelo, anio, kilometros, id_prop)
    raise ErrorUsuarioInexistente unless @repo_usuario.existe_usuario(id_prop)
    raise ErrorPatenteRepetida if @repo_auto.existe_auto(patente)

    usuario = @repo_usuario.find(id_prop)
    auto = Auto.crear(patente, modelo, anio, kilometros, usuario)
    @repo_auto.save(auto)
    auto
  end
end
