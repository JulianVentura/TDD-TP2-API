Dado('que existe un auto publicado por FIUBAK modelo {string}, patente {string}, kilometros {int} y año {int}') do |modelo, patente, km, anio|
  registrar_auto(modelo, patente, km, anio)
  cotizar_auto(patente, 10_000)
  vender_a_fiubak(patente)
  entregar_llaves(patente)
end

Cuando('compro el auto de patente {string}') do |patente|
  @response = comprar_auto(patente)
  @patente_compra = patente
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

Dado('que vendi un auto a FIUBAK de patente {string}') do |patente|
  registrar_auto("Ford Falcon", patente, 1000, 2020)
  cotizar_auto(patente, 10_000)
  vender_a_fiubak(patente)
  entregar_llaves(patente)
end

Entonces('obtengo un mensaje de error por intento de recompra') do
  expect(@response.status).to eq(400)
  respuesta = JSON.parse(@response.body)
  expect(respuesta['error']).to eq 'Error: No podes comprar un auto que vendiste'
end