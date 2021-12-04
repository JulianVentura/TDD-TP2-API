module Persistence
  module Repositories
    class RepositorioOferta < AbstractRepository
      self.table_name = :oferta
      self.model_class = 'Oferta'

      protected

      def load_object(a_hash)
        # id_usuario = a_hash[:id_usuario]
        # repo_usuario = RepositorioUsuario.new
        # repo_auto = RepositorioAuto.new
        # usuario = repo_usuario.find(id_usuario)
        # Auto.crear_desde_repo(a_hash[:patente], a_hash[:modelo], a_hash[:kilometros], a_hash[:anio], usuario, a_hash[:precio], estado)
      end

      def changeset(oferta)
        {
          patente: oferta.auto.patente,
          id_ofertante: oferta.ofertante.id,
          precio: oferta.precio
        }
      end
    end
  end
end
