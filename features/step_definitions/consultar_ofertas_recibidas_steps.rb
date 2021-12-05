Dado('que existe un usuario ofertador con nombre {string} y mail {string}') do |nombre_usuario, email|
  @id_ofertador = 999
  @request_registro_usuario = {:id => @id_ofertador, :nombre => nombre_usuario, :email => email}.to_json
  Faraday.post(crear_url_usuarios, @request_registro_usuario, header)
end

Dado('el usuario ofertador realizo una oferta a mi auto de patente {string} con precio {int}') do |patente, precio|
  @request_realizar_oferta = {
    :id_ofertante => @id_ofertador,
    :precio => precio
  }.to_json

  Faraday.post(realizar_oferta_url(patente), @request_realizar_oferta, header)
end

Cuando('consulto las ofertas recibidas sobre el auto de patente {string}') do |patente|
  @response = Faraday.get(consultar_ofertas_recibidas_url(patente, id_falso), header)
end

Entonces('recibo mensaje de ofertas recibidas exitosas') do
  respuesta_parseada = JSON.parse(@response.body)
  match = false
  respuesta_parseada.each do |oferta|
    match |= oferta['id_ofertante'] == @id_ofertador
  end

  expect(match).to eq true
end

Entonces('recibo mensaje de no haber ofertas') do
  respuesta_parseada = JSON.parse(@response.body)
  expect(respuesta_parseada.empty?).to eq true
end

Cuando('el usuario ofertador consulta las ofertas recibidas sobre el auto de patente {string}') do |patente|
  @response = Faraday.get(consultar_ofertas_recibidas_url(patente, @id_ofertador), header)
end
