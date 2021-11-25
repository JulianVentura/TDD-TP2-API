# rubocop:disable all
require 'spec_helper'
require_relative './factories/user_factory'

RSpec.configure do |config|
  config.include UserFactory
  config.after :each do
    ActiveRecord::Base.subclasses.each(&:destroy_all)
  end
end
