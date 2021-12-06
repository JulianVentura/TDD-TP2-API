WebTemplate::App.controllers :usuarios, :provides => [:json] do
  post :create, :map => '/usuarios' do
    begin
      # input
      parametros = parametros_simbolizados
      # modelo
      nuevo_usuario = CreadorUsuario.new(repo_usuario).crear_usuario(parametros[:nombre], parametros[:id], parametros[:email])
      # output
      status 201
      {:id => nuevo_usuario.id, :nombre => nuevo_usuario.nombre, :email => nuevo_usuario.email}.to_json
    rescue ErrorEnLaAPI => e
      status 400
      {error: e.mensaje}.to_json
    end
  end

  get :consultar_ofertas_realizadas, :map => '/usuarios/:id_usuario/ofertas' do
    begin
      # input
      id = params[:id_usuario].to_i

      # modelo
      ofertas = ConsultadorOfertasRealizadas.new(repo_oferta).consultar(id)

      # output
      status 200
      respuesta = ofertas.map do |oferta|
        {
          :id_oferta => oferta.id,
          :patente => oferta.auto.patente,
          :id_ofertante => oferta.ofertante.id,
          :precio => oferta.precio,
          :estado => simbolo_estado_a_mensaje_oferta(oferta.estado.estado)
        }
      end
      respuesta.to_json
    rescue ErrorEnLaAPI => e
      status 400
      {error: e.mensaje}.to_json
    end
  end
end
