module Persistence
  module Repositories
    class RepositorioUsuario < AbstractRepository
      self.table_name = :usuario
      self.model_class = 'Usuario'

      protected

      def load_object(a_hash)
        Usuario.new(a_hash[:nombre], a_hash[:id], a_hash[:email])
      end

      def changeset(usuario)
        {
          nombre: usuario.nombre,
          id: usuario.id,
          email: usuario.email
        }
      end

    end
  end
end
