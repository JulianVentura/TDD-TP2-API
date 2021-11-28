class Usuario
  attr_reader :nombre, :id, :email

  def initialize(nombre, id, email)
    @nombre = nombre
    @id = id
    @email = email
  end
end
