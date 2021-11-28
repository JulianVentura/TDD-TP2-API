# Helper methods defined here can be accessed in any controller or view in the application

module WebTemplate
  class App
    module UserHelper
      def repo_usuario
        Persistence::Repositories::RepositorioUsuario.new
      end

      def params_usuario
        @body ||= request.body.read
        JSON.parse(@body).symbolize_keys
      end
    end
    helpers UserHelper
  end
end
