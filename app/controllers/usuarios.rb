WebTemplate::App.controllers :usuarios, :provides => [:json] do

  post :create, :map => '/usuarios' do
    # input
    parametros = parametros_simbolizados
    nuevo_usuario = CreadorUsuario.new(repo_usuario).crear_usuario(parametros[:nombre], parametros[:id], parametros[:email])
    # modelo?
    # output
    status 201
    {:id => nuevo_usuario.id, :nombre => nuevo_usuario.nombre, :email => nuevo_usuario.email}.to_json
  rescue ErrorEnLaAPI => e
    status 400
    {error: e.mensaje}.to_json
  end

end
