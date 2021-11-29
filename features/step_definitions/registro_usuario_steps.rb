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

Dado('que existe un usuario con id {int}, nombre {string} y mail {string}') do |id_chat, nombre_usuario, email|
  @request_registro_usuario = {:id => id_chat, :nombre => nombre_usuario, :email => email}.to_json
  @response = Faraday.post(crear_url_usuarios, @request_registro_usuario, header)
end

Entonces('recibo mensaje de error por id duplicado') do
  expect(@response.status).to eq(400)
  respuesta = JSON.parse(@response.body)
  expect(respuesta['error']).to eq 'Error: Ya estas registrado'
end

Entonces('recibo mensaje de error por email duplicado') do
  expect(@response.status).to eq(400)
  respuesta = JSON.parse(@response.body)
  expect(respuesta['error']).to eq 'Error: Ya existe un usuario con ese email'
end

Cuando('me registro con nombre {string}') do |nombre_usuario|
  @request_registro_usuario = {:nombre => nombre_usuario}.to_json
  @response = Faraday.post(crear_url_usuarios, @request_registro_usuario, header)
end

Entonces('recibo mensaje de error por falta de argumentos') do
  expect(@response.status).to eq(400)
  respuesta = JSON.parse(@response.body)
  expect(respuesta['error']).to eq 'Error: Faltan argumentos'
end
