Cuando('rechazo la oferta sobre el auto de patente {string}') do |_patente|
  @request_rechazar_oferta = {
    :id_prop => id_falso
  }.to_json

  @id_oferta = JSON.parse(@response.body)['id_oferta']
  @response = Faraday.post(rechazar_oferta_url(@id_oferta), @request_rechazar_oferta, header)
end

Entonces('recibo mensaje de oferta rechazada') do
  expect(@response.status).to eq(200)
  respuesta = JSON.parse(@response.body)

  expect(respuesta['id_oferta']).to eq(@id_oferta)
  expect(respuesta['patente']).to eq(@patente_oferta)
  expect(respuesta['id_ofertante']).to eq(id_falso2)
end

Cuando('rechazo una oferta inexistente') do |_patente|
  @request_rechazar_oferta = {
    :id_prop => id_falso
  }.to_json

  @id_oferta = 59_154_376
  @response = Faraday.post(rechazar_oferta_url(@id_oferta), @request_rechazar_oferta, header)
end

Entonces('recibo mensaje de error por oferta inexistente') do
  expect(@response.status).to eq(400)
  respuesta = JSON.parse(@response.body)

  expect(respuesta['error']).to eq 'Error: Oferta no existe'
end

Cuando('rechazo una oferta sin indicar su id') do |_patente|
  @request_rechazar_oferta = {
    :id_prop => id_falso
  }.to_json

  @id_oferta = nil
  @response = Faraday.post(rechazar_oferta_url(@id_oferta), @request_rechazar_oferta, header)
end
