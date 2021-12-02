Cuando('se cotiza el auto de patente {string} con precio {int}') do |_patente, precio|
  request_registro_usuario = {:cotizacion => precio}.to_json
  @response = Faraday.patch(cotizar_url_autos, request_registro_usuario, header)
  @parse_response = JSON.parse(@response.body)
end

Entonces('contiene patente {string}, estado {string} y precio {int}') do |patente, estado, precio|
  auto = @parse_response[0]

  expect(auto['patente']).to eq patente
  expect(auto['estado']).to eq estado
  expect(auto['precio']).to eq precio
end
