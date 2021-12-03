module Persistence
  module Repositories
    class RepositorioUsuario < AbstractRepository
      self.table_name = :usuario
      self.model_class = 'Usuario'

      def existe_usuario(id)
        !dataset.first(id: id).nil?
      end

      def existe_email(email)
        !dataset.first(email: email).nil?
      end

      protected

      def load_object(a_hash)
        fiubak = Fiubak.new

        return fiubak if a_hash[:id] == fiubak.id

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
