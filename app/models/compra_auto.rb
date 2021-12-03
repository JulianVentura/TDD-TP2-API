class CompraAuto
  def comprar(patente, id_comprador)
    auto = repo_autos.buscar_por_patente(patente)
    comprador = repo_usuarios.buscar_por_id(id_comprador)
    auto.ser_comprado_por comprador
    repo_autos.delete auto.patente
  end
end

# Una compra implica a Fiubak

class Auto
  def ser_comprado_por(_comprador)
    @estado.habilitado_para_vender
    @usuario.compra_directa
  end
end
