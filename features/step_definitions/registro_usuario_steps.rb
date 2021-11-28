require 'byebug'

Cuando('me registro con id {int}, nombre {string} y mail {string}') do |id_chat, nombre_usuario, email|
  @request_registro_usuario = {:id => id_chat, :nombre => nombre_usuario, :email => email}.to_json
  @response = Faraday.post(crear_url_usuarios, @request_registro_usuario, header)
end

Entonces('el registro es exitoso') do
  expect(@response.status).to eq(201)
  usuario = JSON.parse(@response.body)
  request = JSON.parse(@request_registro_usuario)

  expect(usuario['id']).to eq request['id']
  expect(usuario['nombre']).to eq request['nombre']
  expect(usuario['email']).to eq request['email']
end

Dado('que existe un usuario con id {string}, nombre {string} y mail {string}') do |_string, _string2, _string3|
  pending # Write code here that turns the phrase above into concrete actions
end

Entonces('recibo mensaje de error por registro fallido') do
  pending # Write code here that turns the phrase above into concrete actions
end
