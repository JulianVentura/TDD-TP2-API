WebTemplate::App.controllers :usuarios, :provides => [:json] do
  post :create, :map => '/usuarios' do
    # input
    @body ||= request.body.read
    parametros = JSON.parse(@body).symbolize_keys
    nuevo_usuario = Usuario.new(parametros[:nombre], parametros[:id], parametros[:email])
    # modelo?
    # output
    status 201
    {id: nuevo_usuario.id, nombre: nuevo_usuario.nombre, email: nuevo_usuario.email}.to_json
    # rescue InvalidUser => e
    # status 400
    # {error: e.message}.to_json
  end
end
