# rubocop:disable all
require 'spec_helper'

RSpec.configure do |config|
  # config.include UserFactory
  config.after :each do
    # Persistence::Repositories::TaskRepository.new.delete_all
    Persistence::Repositories::RepositorioAuto.new.delete_all
    Persistence::Repositories::RepositorioUsuario.new.delete_all
  end
end