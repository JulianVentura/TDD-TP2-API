WebTemplate::App.controllers :usuarios, :provides => [:json] do
  post :create, :map => '/usuarios' do
    begin
      # input
      parametros = parametros_simbolizados
      # modelo
      nuevo_usuario = CreadorUsuario.new(repo_usuario).crear_usuario(parametros[:nombre], parametros[:id], parametros[:email])
      # output
      logger.info("[Registrar usuario]: Se registra el usuario de nombre #{nuevo_usuario.nombre} y email #{nuevo_usuario.email}")
      status 201
      {:id => nuevo_usuario.id, :nombre => nuevo_usuario.nombre, :email => nuevo_usuario.email}.to_json
    rescue ErrorEnLaAPI => e
      logger.error("[Registrar usuario]: #{e.mensaje}")
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
      logger.info("[Consultar ofertas realizadas]: Se consultan las ofertas realizadas por el usuario #{id}")
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
      logger.error("[Consultar ofertas realizadas]: #{e.mensaje}")
      status 400
      {error: e.mensaje}.to_json
    end
  end
end
