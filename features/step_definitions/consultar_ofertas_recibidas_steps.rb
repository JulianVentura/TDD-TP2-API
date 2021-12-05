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

Cuando('consulto las ofertas recibidas sobre el auto de patente {string}') do |_string|
  pending # Write code here that turns the phrase above into concrete actions
end

Entonces('recibo mensaje de ofertas recibidas exitosas') do
  pending # Write code here that turns the phrase above into concrete actions
end

Entonces('recibo mensaje de no haber ofertas') do
  pending # Write code here that turns the phrase above into concrete actions
end
