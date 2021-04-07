# rubocop:disable all
require 'spec_helper'

RSpec.configure do |config|
  config.after :each do
    ActiveRecord::Base.subclasses.each(&:delete_all)
  end
end
