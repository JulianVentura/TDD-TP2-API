module Persistence
  module Repositories
    class RepositorioOferta < AbstractRepository
      self.table_name = :oferta
      self.model_class = 'Oferta'

      ESTADOS = {
        :pendiente => 'pendiente',
        'pendiente' => Pendiente
      }

      def existe_oferta_id(id_oferta)
        !dataset.first(id: id_oferta).nil?
      end

      def existe_oferta_usuario_auto(id_ofertante, patente)
        dataset.where(Sequel.lit("patente ILIKE ?", patente) & Sequel.lit("id_ofertante = ?", id_ofertante)).map.count >= 1
      end

      protected

      def load_object(a_hash)
        id_ofertante = a_hash[:id_ofertante]
        precio = a_hash[:precio]
        patente = a_hash[:patente]
        id = a_hash[:id]
        ofertante = RepositorioUsuario.new.find(id_ofertante)
        auto = RepositorioAuto.new.find(patente)
        estado = ESTADOS[a_hash[:estado]].new

        Oferta.crear_desde_repo(auto, ofertante, precio, id, estado)
      end

      def changeset(oferta)
        {
          patente: oferta.auto.patente,
          id_ofertante: oferta.ofertante.id,
          precio: oferta.precio,
          estado: ESTADOS[oferta.estado.estado],
        }
      end
    end
  end
end
