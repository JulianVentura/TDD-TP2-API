require './app/models/errores'
class CreadorOferta
  def initialize(repo_oferta, repo_auto, repo_usuario)
    @repo_oferta = repo_oferta
    @repo_auto = repo_auto
    @repo_usuario = repo_usuario
  end

  def crear(patente, id_ofertante, precio)
    raise ErrorAutoNoExiste unless @repo_auto.existe_auto(patente)
    ofertante = @repo_usuario.find(id_ofertante)
    auto = @repo_auto.find(patente)
    oferta = Oferta.crear(auto, ofertante, precio)

    @repo_oferta.save(oferta)
  end
end
