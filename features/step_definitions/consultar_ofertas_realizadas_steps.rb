Dado('que tengo realizada una oferta al auto de patente {string} con precio {int}') do |patente, precio|
  @request_realizar_oferta = {
    :id_ofertante => @id_ofertador,
    :precio => precio
  }.to_json

  Faraday.post(realizar_oferta_url(patente), @request_realizar_oferta, header)
end

Cuando('consulto mis ofertas realizadas') do
  @response = Faraday.get(consultar_ofertas_realizadas_url(@id_ofertador), header)
end

Entonces('obtengo la oferta de patente {string} con precio {int}') do |_patente, precio|
  respuesta_parseada = JSON.parse(@response.body)
  match = false
  respuesta_parseada.each do |oferta|
    match |= (oferta['patente'] == pantente && oferta['precio'] == precio)
  end

  expect(match).to eq true
end

Entonces('recibo un mensaje sin ofertas') do
  respuesta_parseada = JSON.parse(@response.body)
  expect(respuesta_parseada.empty?).to eq true
end
