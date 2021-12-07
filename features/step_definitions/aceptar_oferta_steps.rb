Cuando('acepto la oferta sobre el auto de patente {string}') do |_patente|
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

Entonces('el auto de patente {string} no se encuentra') do |patente|
  match = false
  @parse_response.each do |auto|
    match |= (auto['patente'] == patente)
  end

  expect(match).to eq false
end

Dado('que existe un tercer usuario con nombre {string} y mail {string}') do |nombre, email|
  registrar_usuario(nombre, email, id_falso3)
end

Dado('el tercer usuario realiza una oferta de {int} sobre el auto {string}') do |precio, patente|
  @request_realizar_oferta = {
    :id_ofertante => id_falso3,
    :precio => precio
  }.to_json

  Faraday.post(realizar_oferta_url(patente), @request_realizar_oferta, header)
end

Cuando('consulto el tercer usuario consulta sus ofertas realizadas') do
  @response = Faraday.get(consultar_ofertas_realizadas_url(id_falso3), header)
end

Entonces('la oferta del auto {string} del tercer usuario esta rechazada') do |patente|
  respuesta_parseada = JSON.parse(@response.body)
  match = false
  respuesta_parseada.each do |oferta|
    match |= (oferta['patente'] == patente && oferta['estado'] == 'Rechazado')
  end

  expect(match).to eq true
end
