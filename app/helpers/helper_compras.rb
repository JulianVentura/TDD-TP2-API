module WebTemplate
  class App
    module HelperCompras
      def repo_compra
        Persistence::Repositories::RepositorioCompra.new
      end
    end
    helpers HelperCompras
  end
end
