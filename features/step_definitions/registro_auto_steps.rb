Dado('que existe un usuario con nombre {string} y mail {string}') do |nombre_usuario, email|
  request_registro_usuario = {:id => id_falso, :nombre => nombre_usuario, :email => email}.to_json
  Faraday.post(crear_url_usuarios, request_registro_usuario, header)
end

Cuando('ingreso un auto modelo {string}, patente {string}, kilometros {int} y año {int}') do |modelo, patente, km, anio|
  # TODO: enviar id_chat
  @request_registro_auto = {:patente => patente, :nombre => modelo, :kilometros => km, :anio => anio}.to_json
  @response = Faraday.post(crear_url_autos, @request_registro_auto, header)
end

Entonces('recibo mensaje de ingreso de auto exitoso') do
  expect(@response.status).to eq(201)
  auto = JSON.parse(@response.body)
  request = JSON.parse(@request_registro_usuario)

  expect(auto['patente']).to eq request['patente']
  expect(auto['modelo']).to eq request['modelo']
  expect(auto['anio']).to eq request['anio']
  expect(auto['kilometros']).to eq request['kilometros']
end

Cuando('ingreso un auto modelo {string} y año {int}') do |string, int|
  pending # Write code here that turns the phrase above into concrete actions
end

Entonces('recibo mensaje de error por ingreso de auto fallido por falta de datos') do
  pending # Write code here that turns the phrase above into concrete actions
end

Dado('que existe un auto modelo {string}, patente {string}, kilometros {int} y año {int}') do |string, string2, int, int2|
  pending # Write code here that turns the phrase above into concrete actions
end

Entonces('recibo mensaje de error por ingreso de auto fallido por patente repetida') do
  pending # Write code here that turns the phrase above into concrete actions
end

