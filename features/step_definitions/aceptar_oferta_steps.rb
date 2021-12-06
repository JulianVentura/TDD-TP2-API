git Cuando('acepto la oferta sobre el auto de patente {string}') do |_patente|
  @request_aceptar_oferta = {
    :id_prop => id_falso
  }.to_json

  @id_oferta = JSON.parse(@response.body)['id_oferta']
  @response = Faraday.post(aceptar_oferta_url(@id_oferta), @request_aceptar_oferta, header)
end

Entonces('recibo mensaje de oferta aceptada') do
  expect(@response.status).to eq(200)
  respuesta = JSON.parse(@response.body)

  expect(respuesta['id_oferta']).to eq(@id_oferta)
  expect(respuesta['patente']).to eq(@patente_oferta)
  expect(respuesta['id_ofertante']).to eq(id_falso2)
end

Cuando('acepto una oferta inexistente') do
  @request_aceptar_oferta = {
    :id_prop => id_falso
  }.to_json

  @id_oferta = 59_154_376
  @response = Faraday.post(aceptar_oferta_url(@id_oferta), @request_aceptar_oferta, header)
end

Cuando('acepto una oferta cuando el id del propietario no coincide') do
  @request_aceptar_oferta = {
    :id_prop => id_falso2
  }.to_json

  @id_oferta ||= JSON.parse(@response.body)['id_oferta']
  @response = Faraday.post(aceptar_oferta_url(@id_oferta), @request_aceptar_oferta, header)
end
