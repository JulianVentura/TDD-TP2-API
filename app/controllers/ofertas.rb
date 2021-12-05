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
end
