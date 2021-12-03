Cuando('el usuario publica p2p el auto con patente {string} con precio {int}"') do |patente, precio|
  @request_publicar_p2p = {
    :id_prop => id_falso,
    :precio => precio
  }.to_json
  # TODO: POST o PATCH?
  @response = Faraday.post(publicar_p2p_url_autos(patente), @request_publicar_p2p, header)
end

Entonces('recibo mensaje de publicacion exitosa') do
  expect(@response.status).to eq(200)
  auto = JSON.parse(@response.body)
  request = JSON.parse(@request_publicar_p2p)
  expect(auto['id_prop']).to eq request['id_prop']
  expect(auto['estado']).to eq 'Publicado'
end

Cuando('el usuario publica p2p el auto con patente {string}') do |patente|
  @request_publicar_p2p = {
    :id_prop => id_falso
  }.to_json
  # TODO: POST o PATCH?
  @response = Faraday.post(publicar_p2p_url_autos(patente), @request_publicar_p2p, header)
end

Entonces('recibo mensaje de error por auto no cotizado') do
  expect(@response.status).to eq(400)
  respuesta = JSON.parse(@response.body)
  expect(respuesta['error']).to eq 'Error: Auto no cotizado'
end
