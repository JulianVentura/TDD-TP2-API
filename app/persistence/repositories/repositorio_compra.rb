module Persistence
  module Repositories
    class RepositorioCompra < AbstractRepository
      self.table_name = :compra
      self.model_class = 'Compra'

      protected

      def load_object(a_hash)
        # id_ofertante = a_hash[:id_ofertante]
        # precio = a_hash[:precio]
        # patente = a_hash[:patente]
        # id = a_hash[:id]
        # ofertante = RepositorioUsuario.new.find(id_ofertante)
        # auto = RepositorioAuto.new.find(patente)
        # estado = ESTADOS[a_hash[:estado]].new

        # Oferta.crear_desde_repo(auto, ofertante, precio, id, estado)
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

