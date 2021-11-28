class CreadorUsuario
  def initialize(repo_usuario)
    @repo_usuario = repo_usuario
  end

  def crear_usuario(nombre, id, email)
    usuario = Usuario.new(nombre, id, email)
    @repo_usuario.save(usuario)
    usuario
  end
end
