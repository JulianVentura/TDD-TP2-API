require './app/models/errores'
class CreadorUsuario
  def initialize(repo_usuario)
    @repo_usuario = repo_usuario
  end

  def crear_usuario(nombre, id, email)

    usuario = Usuario.new(nombre, id, email)
    raise ErrorIdRepetido if @repo_usuario.existe_usuario(id)
    raise ErrorEmailRepetido if @repo_usuario.existe_email(email)

    @repo_usuario.save(usuario)
    usuario
  end
end
