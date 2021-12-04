module Persistence
  module Repositories
    class RepositorioAuto < AbstractRepository
      self.table_name = :auto
      self.model_class = 'Auto'

      ESTADOS = {
        :en_revision => 'en_revision',
        'en_revision' => EnRevision,
        :cotizado => 'cotizado',
        'cotizado' => Cotizado,
        :esperando_entrega => 'esperando_entrega',
        'esperando_entrega' => EsperandoEntrega,
        :publicado => 'publicado',
        'publicado' => Publicado,
        :vendido => 'vendido',
        'vendido' => Vendido
      }.freeze
      # TODO: faltan test unitarios que prueben los estados

      def existe_auto(patente)
        !dataset.first(Sequel.ilike(:patente, patente)).nil?
      end

      def por_propietario(id_prop)
        load_collection dataset.where(id_usuario: id_prop)
      end

      def por_estado(estado)
        load_collection dataset.where(estado: ESTADOS[estado.estado])
      end

      def find(patente)
        found_record = dataset.first(Sequel.ilike(:patente, patente))
        raise ObjectNotFound.new(self.class.model_class, patente) if found_record.nil?

        load_object dataset.first(found_record)
      end

      protected

      def load_object(a_hash)
        id_usuario = a_hash[:id_usuario]
        estado = ESTADOS[a_hash[:estado]].new
        repo_usuario = RepositorioUsuario.new
        usuario = repo_usuario.find(id_usuario)
        Auto.crear_desde_repo(a_hash[:patente], a_hash[:modelo], a_hash[:kilometros], a_hash[:anio], usuario, a_hash[:precio], estado)
      end

      def changeset(auto)
        {
          patente: auto.patente,
          modelo: auto.modelo,
          kilometros: auto.kilometros,
          anio: auto.anio,
          estado: ESTADOS[auto.estado.estado],
          id_usuario: auto.usuario.id,
          precio: auto.precio
        }
      end

      private

      def pk_column
        Sequel[self.class.table_name][:patente]
      end

      def get_id(an_object)
        an_object.patente
      end

      def set_id(an_object, patente)
        an_object.patente = patente
      end
    end
  end
end
