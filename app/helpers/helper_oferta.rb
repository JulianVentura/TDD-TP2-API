module WebTemplate
  class App
    module HelperOferta
      def repo_oferta
        Persistence::Repositories::RepositorioOferta.new
      end
    end
    helpers HelperOferta
  end
end
