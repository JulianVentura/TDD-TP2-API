require 'byebug'

module Persistence
  module Repositories
    class RepositorioAuto < AbstractRepository
      self.table_name = :auto
      self.model_class = 'Auto'

      def existe_auto(patente)
        !dataset.first(patente: patente).nil?
      end

      def por_propietario(id_prop)
        load_collection dataset.where(id_usuario: id_prop)
      end

      protected

      def load_object(a_hash)
        id_usuario = a_hash[:id_usuario]
        estado = a_hash[:estado]
        repo_usuario = RepositorioUsuario.new
        usuario = repo_usuario.find(id_usuario)
        Auto.crear_desde_repo(a_hash[:patente], a_hash[:modelo], a_hash[:kilometros], a_hash[:anio], usuario, 0, estado)
      end

      def changeset(auto)
        {
          patente: auto.patente,
          modelo: auto.modelo,
          kilometros: auto.kilometros,
          anio: auto.anio,
          estado: auto.estado,
          id_usuario: auto.usuario.id
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
