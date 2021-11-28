Cuando('me registro con id {int}, nombre {string} y mail {string}') do |id_chat, nombre_usuario, email|
  @request = {id: id_chat, nombre: nombre_usuario, email: email}.to_json
  @response = Faraday.post(crear_url_usuarios, @request, header)
end

Entonces('recibo mensaje de registro exitoso') do
  expect(@response.status).to eq(201)
  # user = JSON.parse(@response.body)
  # @user_id = user['id']
end

Dado('que existe un usuario con id {string}, nombre {string} y mail {string}') do |_string, _string2, _string3|
  pending # Write code here that turns the phrase above into concrete actions
end

Entonces('recibo mensaje de error por registro fallido') do
  pending # Write code here that turns the phrase above into concrete actions
end
