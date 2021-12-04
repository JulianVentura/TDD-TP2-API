Dado('que existe un auto publicado por FIUBAK modelo {string}, patente {string}, kilometros {int} y año {int}') do |modelo,patente,km,anio|
    registrar_auto(modelo,patente,km,anio)
    cotizar_auto(patente, 10000)
    vender_a_fiubak(patente)
    entregar_llaves(patente)
end
    
Cuando('compro el auto de patente {string}') do |patente|
    comprar_auto(patente)
    @patente_compra = patente
end

Entonces('recibo una confirmacion de compra') do
  expect(@response.status).to eq(200)
  auto = JSON.parse(@response.body)
  expect(auto.patente).to eq @patente_compra
end
    