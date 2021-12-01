module Persistence
  module Repositories
    class RepositorioAuto < AbstractRepository
      self.table_name = :auto
      self.model_class = 'Auto'

      protected
      def load_object(a_hash)
        Auto.new(a_hash[:patente], a_hash[:modelo], a_hash[:kilometros], a_hash[:anio], a_hash[:id])
      end

      def changeset(auto)
        {
          patente: auto.patente,
          modelo: auto.modelo,
          kilometros: auto.kilometros,
          anio: auto.anio,
          estado: auto.estado
        }
      end

    end
  end
end
