module Persistence
  module Repositories
    class RepositorioCompra < AbstractRepository
      self.table_name = :compra
      self.model_class = 'Compra'

      protected

      def load_object(a_hash)
        id = a_hash[:id]
        id_comprador = a_hash[:id_comprador]
        id_vendedor = a_hash[:id_vendedor]
        patente = a_hash[:patente]
        comprador = RepositorioUsuario.new.find(id_comprador)
        vendedor = RepositorioUsuario.new.find(id_vendedor)
        auto = RepositorioAuto.new.find(patente)

        compra = Compra.new(comprador, vendedor, auto)
        compra.id = id
        compra
      end

      def changeset(compra)
        {
          id_comprador: compra.comprador.id,
          id_vendedor: compra.vendedor.id,
          patente: compra.auto.patente,
        }
      end
    end
  end
end

