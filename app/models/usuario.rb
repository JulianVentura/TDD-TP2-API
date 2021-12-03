class Usuario
  attr_reader :nombre, :email, :updated_on, :created_on
  attr_accessor :id

  def initialize(nombre, id, email)
    @nombre = nombre
    @id = id
    @email = email
  end

  def es_particular?
    true
  end
end
