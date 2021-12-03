class Fiubak < Usuario
  ID_USUARIO_FIUBAK = 0

  def initialize
    super('Fiubak', ID_USUARIO_FIUBAK, 'fiubak@gmail.com')
  end

  def es_particular?
    false
  end
end
