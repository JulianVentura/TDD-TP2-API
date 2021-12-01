WebTemplate::App.controllers :autos, :provides => [:json] do

  post :create, :map => '/autos' do
    # input
    parametros = parametros_simbolizados
    # modelo
    nuevo_auto = CreadorAuto.new(repo_usuario).crear_auto(parametros[:patente], parametros[:modelo], parametros[:kilometros], parametros[:anio])
    # output
    status 201
    {:id => nuevo_auto.patente, :nombre => nuevo_auto.modelo, :email => nuevo_auto.kilometros, :anio => nuevo_auto.anio}.to_json
  rescue ErrorEnLaAPI => e
    status 400
    {error: e.mensaje}.to_json
  end

end
