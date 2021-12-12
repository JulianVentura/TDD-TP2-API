WebTemplate::App.controllers :autos, :provides => [:json] do
  post :crear, :map => '/autos' do # rubocop:disable Metrics/BlockLength
    begin
      # input
      parametros = parametros_simbolizados
      # modelo
      nuevo_auto = CreadorAuto.new(repo_auto, repo_usuario)
                              .crear_auto(
                                parametros[:patente],
                                parametros[:modelo],
                                parametros[:kilometros],
                                parametros[:anio],
                                parametros[:id_prop]
                              )
      # output
      logger.info("[Ingresar auto]: Se creo un auto de patente #{nuevo_auto.patente}")
      status 201
      {
        :patente => nuevo_auto.patente,
        :modelo => nuevo_auto.modelo,
        :kilometros => nuevo_auto.kilometros,
        :anio => nuevo_auto.anio,
        :id_prop => nuevo_auto.usuario.id,
        :precio => nuevo_auto.precio,
        :estado => simbolo_estado_a_mensaje(nuevo_auto.estado.estado)
      }.to_json
    rescue ErrorEnLaAPI => e
      logger.error("[Ingresar auto]: #{e.mensaje}")
      status 400
      {error: e.mensaje}.to_json
    end
  end

  patch :cotizar, :map => '/autos/:patente/cotizar' do
    begin
      # input
      patente = params[:patente]
      parametros = parametros_simbolizados

      # modelo
      auto_cotizado = CotizadorAuto.new(repo_auto).cotizar(patente, parametros[:precio])

      # output
      logger.info("[Cotizar]: Se cotiza el auto de patente #{auto_cotizado.patente} a #{auto_cotizado.precio}")
      status 200
      {
        :patente => auto_cotizado.patente,
        :modelo => auto_cotizado.modelo,
        :kilometros => auto_cotizado.kilometros,
        :anio => auto_cotizado.anio,
        :id_prop => auto_cotizado.usuario.id,
        :precio => auto_cotizado.precio,
        :estado => simbolo_estado_a_mensaje(auto_cotizado.estado.estado)
      }.to_json
    rescue ErrorEnLaAPI => e
      logger.error("[Cotizar]: #{e.mensaje}")
      status 400
      {error: e.mensaje}.to_json
    end
  end

  post :vender_a_fiubak, :map => '/autos/:patente/vender_a_fiubak' do
    begin
      # input
      patente = params[:patente]
      parametros = parametros_simbolizados

      # modelo
      auto_vendido = VendedorAuto.new(repo_auto, repo_usuario, repo_compra).vender_a_fiubak(patente, parametros[:id_prop])

      # output
      logger.info("[Vender a Fiubak]: Se vende el auto de patente #{auto_vendido.patente} a Fiubak")
      status 200
      {
        :patente => auto_vendido.patente,
        :modelo => auto_vendido.modelo,
        :kilometros => auto_vendido.kilometros,
        :anio => auto_vendido.anio,
        :id_prop => auto_vendido.usuario.id,
        :precio => auto_vendido.precio,
        :estado => simbolo_estado_a_mensaje(auto_vendido.estado.estado)
      }.to_json
    rescue ErrorEnLaAPI => e
      logger.error("[Vender a Fiubak]: #{e.mensaje}")
      status 400
      {error: e.mensaje}.to_json
    end
  end

  post :entregar_llaves, :map => '/autos/:patente/entregar_llaves' do
    begin
      # input
      patente = params[:patente]

      # modelo
      auto_fiubak = EntregarLlaves.new(repo_auto, repo_usuario).entregar_llaves(patente)

      # output
      logger.info("[Entregar Llaves]: Se entregan las llaves del auto de patente #{auto_fiubak.patente}")
      status 201
      {
        :patente => auto_fiubak.patente,
        :modelo => auto_fiubak.modelo,
        :kilometros => auto_fiubak.kilometros,
        :anio => auto_fiubak.anio,
        :id_prop => auto_fiubak.usuario.id,
        :precio => auto_fiubak.precio,
        :estado => simbolo_estado_a_mensaje(auto_fiubak.estado.estado)
      }.to_json
    rescue ErrorEnLaAPI => e
      logger.error("[Entregar Llaves]: #{e.mensaje}")
      status 400
      {error: e.mensaje}.to_json
    end
  end

  get :listar_en_venta, :map => '/autos' do
    begin
      # base de datos
      autos = ListadorAutos.new(repo_auto).listar_publicado
      # output
      logger.info('[Listar en venta]: Se listan los autos en venta')
      status 200
      respuesta = autos.map do |auto|
        {
          :patente => auto.patente,
          :modelo => auto.modelo,
          :kilometros => auto.kilometros,
          :anio => auto.anio,
          :id_prop => auto.usuario.id,
          :precio => auto.precio,
          :es_fiubak => !auto.usuario.es_particular?,
          :estado => simbolo_estado_a_mensaje(auto.estado.estado)
        }
      end

      respuesta.to_json
    rescue ErrorEnLaAPI => e
      logger.error("[Listar en venta]: #{e.mensaje}")
      status 400
      {error: e.mensaje}.to_json
    end
  end

  post :publicar_p2p, :map => '/autos/:patente/publicar_p2p' do
    begin
      # input
      patente = params[:patente]
      parametros = parametros_simbolizados

      # modelo
      auto_fiubak = PublicadorP2P.new(repo_auto, repo_usuario).publicar_p2p(patente, parametros[:id_prop], parametros[:precio])

      # output
      logger.info("[Publicar P2P]: Se publica en P2P el auto de patente #{auto_fiubak.patente} a $#{auto_fiubak.precio}")
      status 200
      {
        :patente => auto_fiubak.patente,
        :modelo => auto_fiubak.modelo,
        :kilometros => auto_fiubak.kilometros,
        :anio => auto_fiubak.anio,
        :id_prop => auto_fiubak.usuario.id,
        :precio => auto_fiubak.precio,
        :estado => simbolo_estado_a_mensaje(auto_fiubak.estado.estado)
      }.to_json
    rescue ErrorEnLaAPI => e
      logger.error("[Publicar P2P]: #{e.mensaje}")
      status 400
      {error: e.mensaje}.to_json
    end
  end

  post :comprar_fiubak, :map => '/autos/:patente/comprar' do
    begin
      # input
      patente = params[:patente]
      parametros = parametros_simbolizados

      # modelo
      auto_fiubak = Comprador.new(repo_auto, repo_usuario, repo_compra).comprar(patente, parametros[:id_comprador])

      # output
      logger.info("[Comprar a Fiubak]: Se compra a Fiubak el auto de patente #{auto_fiubak.patente}")
      status 200
      {
        :patente => auto_fiubak.patente,
        :modelo => auto_fiubak.modelo,
        :kilometros => auto_fiubak.kilometros,
        :anio => auto_fiubak.anio,
        :id_prop => auto_fiubak.usuario.id,
        :precio => auto_fiubak.precio,
        :estado => simbolo_estado_a_mensaje(auto_fiubak.estado.estado)
      }.to_json
    rescue ErrorEnLaAPI => e
      logger.error("[Comprar a Fiubak]: #{e.mensaje}")
      status 400
      {error: e.mensaje}.to_json
    end
  end

  post :realizar_oferta, :map => '/autos/:patente/realizar_oferta' do
    begin
      # input
      patente = params[:patente]
      parametros = parametros_simbolizados

      # modelo
      oferta = CreadorOferta.new(repo_oferta, repo_auto, repo_usuario).crear(
        patente,
        parametros[:id_ofertante],
        parametros[:precio]
      )

      # output
      logger.info("[Realizar oferta]: Se realiza una oferta de $#{oferta.precio} sobre el auto de patente #{oferta.auto.patente}")
      status 200
      {
        :id_oferta => oferta.id,
        :patente => oferta.auto.patente,
        :id_ofertante => oferta.ofertante.id,
        :precio => oferta.precio,
        :estado => simbolo_estado_a_mensaje_oferta(oferta.estado.estado)
      }.to_json
    rescue ErrorEnLaAPI => e
      logger.error("[Realizar oferta]: #{e.mensaje}")
      status 400
      {error: e.mensaje}.to_json
    end
  end

  get :consultar_ofertas_recibidas, :map => '/autos/:patente/ofertas' do
    begin
      # input
      patente = params[:patente]
      id_prop = params[:id_prop].to_i

      # modelo
      ofertas = ConsultadorOfertasRecibidas.new(repo_oferta, repo_auto).consultar(
        patente,
        id_prop
      )

      # output
      logger.info("[Consultar ofertas recibidas]: Se consultan las ofertas recibidas del auto de patente #{patente}")
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
      logger.error("[Consultar ofertas recibidas]: #{e.mensaje}")
      status 400
      {error: e.mensaje}.to_json
    end
  end
end
