Dado('que existe un auto publicado por FIUBAK modelo {string}, patente {string}, kilometros {int} y año {int}') do |modelo, patente, km, anio|
  registrar_auto(modelo, patente, km, anio)
  cotizar_auto(patente, 10_000)
  vender_a_fiubak(patente)
  entregar_llaves(patente)
end

Entonces('recibo una confirmacion de compra') do
  expect(@response.status).to eq(200)
  auto = JSON.parse(@response.body)
  expect(auto['patente']).to eq @patente_compra
  expect(auto['estado']).to eq 'Vendido'
end

Entonces('obtengo un mensaje de error por auto no en venta') do
  expect(@response.status).to eq(400)
  respuesta = JSON.parse(@response.body)
  expect(respuesta['error']).to eq 'Error: Auto no esta en venta'
end

Entonces('obtengo un mensaje de error por intento de recompra') do
  expect(@response.status).to eq(400)
  respuesta = JSON.parse(@response.body)
  expect(respuesta['error']).to eq 'Error: No podes comprar un auto que vendiste'
end

Cuando('el otro usuario compra el auto de patente {string}') do |patente|
  @response = comprar_auto(patente, id_falso)
  @patente_compra = patente
end

Dado('que existe un vendedor con nombre {string} y mail {string}') do |nombre, email|
  request_registro_usuario = {:id => id_falso, :nombre => nombre, :email => email}.to_json
  Faraday.post(crear_url_usuarios, request_registro_usuario, header)
end

Dado('que le vendio un auto a FIUBAK modelo {string}, patente {string}, kilometros {int} y año {int}') do |modelo, patente, km, anio|
  registrar_auto("Ford Falcon", patente, 1000, 2020)
  cotizar_auto(patente, 10_000)
  vender_a_fiubak(patente)
  entregar_llaves(patente)
end

Dado('que existe un comprador con nombre {string} y mail {string}') do |nombre, email|
  request_registro_usuario = {:id => id_falso2, :nombre => nombre, :email => email}.to_json
  Faraday.post(crear_url_usuarios, request_registro_usuario, header)
end

Cuando('el comprador compra el auto de patente {string}') do |patente|
  @response = comprar_auto(patente, id_falso2)
  @patente_compra = patente
end

Cuando('el vendedor compra el auto de patente {string}') do |patente|
  @response = comprar_auto(patente, id_falso)
  @patente_compra = patente
end