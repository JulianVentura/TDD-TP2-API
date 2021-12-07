module WebTemplate
  class App
    module HelperOferta
      ESTADOS = {
        :pendiente => 'Pendiente',
        :rechazado => 'Rechazado',
        :aceptado => 'Aceptado'
      }.freeze
      def repo_oferta
        Persistence::Repositories::RepositorioOferta.new
      end

      def simbolo_estado_a_mensaje_oferta(simbolo)
        ESTADOS[simbolo]
      end
    end
    helpers HelperOferta
  end
end
