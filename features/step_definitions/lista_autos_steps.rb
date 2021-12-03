Dado('que existe un auto publicado por Fiubak modelo {string}, patente {string}, kilometros {int}, año {int} y precio {int}') do |modelo, patente, kilometros, anio, precio|
  registrar_auto(modelo, patente, kilometros, anio)
  cotizar_auto(patente, precio)
  vender_a_fiubak(patente)
  entregar_llaves(patente)
end

Cuando('se listan los autos en venta') do
  @response = Faraday.get(listar_autos_url, header)
  @parse_response = JSON.parse(@response.body)
end

Entonces('contiene patente {string} precio {int} y duenio Fiubak') do |patente, precio|
  match = false
  @parse_response.each do |auto|
    match = auto['patente'] == patente && auto['precio'] == precio && auto['es_fiubak']
  end

  expect(match).to eq true
end