Cuando('el usuario consulta el estado de sus autos') do
  @response = Faraday.get(crear_url_autos_usuario(id_falso), header)
  @parse_response = JSON.parse(@response.body)
end

Entonces('recibo una lista que contiene {int} autos') do |cant_autos|
  expect(@response.status).to eq 200
  expect(@parse_response.size).to eq cant_autos
end

Entonces('contiene patente {string} y estado {string}') do |patente, estado|
  auto = @parse_response[0]

  expect(auto['patente']).to eq patente
  expect(auto['estado']).to eq estado
end
