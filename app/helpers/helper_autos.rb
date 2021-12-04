# Helper methods defined here can be accessed in any controller or view in the application

module WebTemplate
  class App
    module HelperAutos
      ESTADOS = {
        :en_revision => 'En revision',
        :cotizado => 'Cotizado',
        :esperando_entrega => 'Esperando entrega',
        :publicado => 'Publicado',
        :vendido => 'Vendido'
      }.freeze
      # TODO: faltan steps que prueben que los estados cambian
      # TODO: Pasar todo esto a una clase
      def repo_auto
        Persistence::Repositories::RepositorioAuto.new
      end

      def simbolo_estado_a_mensaje(simbolo)
        ESTADOS[simbolo]
      end
    end
    helpers HelperAutos
  end
end
