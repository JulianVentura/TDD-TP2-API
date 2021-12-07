WebTemplate::App.controllers :ofertas, :provides => [:json] do
  post :rechazar_oferta, :map => '/ofertas/:id_oferta/rechazar' do
    begin
      # input
      id_oferta = params[:id_oferta]
      parametros = parametros_simbolizados

      # modelo
      oferta_rechazada = RechazadorOferta.new(repo_oferta).rechazar(
        id_oferta,
        parametros[:id_prop]
      )

      # output
      status 200
      {
        :id_oferta => oferta_rechazada.id,
        :patente => oferta_rechazada.auto.patente,
        :id_ofertante => oferta_rechazada.ofertante.id,
        :precio => oferta_rechazada.precio,
        :estado => oferta_rechazada.estado.estado
      }.to_json
    rescue ErrorEnLaAPI => e
      status 400
      {error: e.mensaje}.to_json
    end
  end

  post :aceptar_oferta, :map => '/ofertas/:id_oferta/aceptar' do
    begin
      # input
      id_oferta = params[:id_oferta]
      parametros = parametros_simbolizados

      # modelo
      oferta_aceptada = AceptadorOferta.new(repo_oferta).aceptar(
        id_oferta,
        parametros[:id_prop]
      )

      # output
      status 200
      {
        :id_oferta => oferta_aceptada.id,
        :patente => oferta_aceptada.auto.patente,
        :id_ofertante => oferta_aceptada.ofertante.id,
        :precio => oferta_aceptada.precio,
        :estado => oferta_aceptada.estado.estado
      }.to_json
    rescue ErrorEnLaAPI => e
      status 400
      {error: e.mensaje}.to_json
    end
  end
end
