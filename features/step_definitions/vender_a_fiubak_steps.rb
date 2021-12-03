Cuando('el usuario vende al auto con patente {string} a Fiubak') do |patente|
  @request_venta_auto_a_fiubak = {
    :id_prop => id_falso,
  }.to_json
  @response = Faraday.post(vender_url_autos(patente), @request_venta_auto_a_fiubak, header)
end

Entonces('recibe mensaje de confirmacion de venta') do
  expect(@response.status).to eq(200)
  auto = JSON.parse(@response.body)
  request = JSON.parse(@request_venta_auto_a_fiubak)
  expect(auto['id_prop']).to eq request['id_prop']
  expect(auto['estado']).to eq 'Esperando entrega'
end

Cuando('se realiza la entrega de llaves') do
  pending # Write code here that turns the phrase above into concrete actions
end
