module Persistence
  module Repositories
    class RepositorioOferta < AbstractRepository
      self.table_name = :oferta
      self.model_class = 'Oferta'

      def initialize
        @traductor = TraductorEstadoOferta.new
      end

      def existe_oferta_id(id_oferta)
        !dataset.first(id: id_oferta).nil?
      end

      def existe_oferta_usuario_auto_estado(id_ofertante, patente, estado)
        dataset.where(
          Sequel.lit('patente ILIKE ?', patente) &
          Sequel.lit('id_ofertante = ?', id_ofertante) &
          Sequel.lit('estado ILIKE ?', @traductor.simbolo_a_texto(estado.estado))
        ).map.count >= 1
      end

      def buscar_por_patente(patente)
        load_collection dataset.where(Sequel.lit('patente ILIKE ?', patente))
      end

      def buscar_por_ofertante(id_ofertante)
        load_collection dataset.where(Sequel.lit('id_ofertante = ?', id_ofertante))
      end

      def buscar_por_patente_y_estado(patente, estado)
        load_collection dataset.where(Sequel.lit('patente ILIKE ?', patente) & Sequel.lit('estado ILIKE ?', @traductor.simbolo_a_texto(estado.estado)))
      end

      protected

      def load_object(a_hash)
        id_ofertante = a_hash[:id_ofertante]
        precio = a_hash[:precio]
        patente = a_hash[:patente]
        id = a_hash[:id]
        ofertante = RepositorioUsuario.new.find(id_ofertante)
        auto = RepositorioAuto.new.find(patente)
        estado = @traductor.texto_a_estado(a_hash[:estado]).new

        Oferta.crear_desde_repo(auto, ofertante, precio, id, estado)
      end

      def changeset(oferta)
        {
          patente: oferta.auto.patente,
          id_ofertante: oferta.ofertante.id,
          precio: oferta.precio,
          estado: @traductor.simbolo_a_texto(oferta.estado.estado)
        }
      end
    end
  end
end
