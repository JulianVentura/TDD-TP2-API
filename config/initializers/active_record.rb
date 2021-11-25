require 'active_record'

case ENV['RACK_ENV'].to_sym
when :test
  DATABASE_URL = ENV['TEST_DB_URL'] || 'postgres://postgres:postgres@localhost/webapi_template_test'
when :development
  DATABASE_URL = ENV['DEV_DB_URL'] || 'postgres://postgres:postgres@localhost/webapi_template_development'
else
  DATABASE_URL = ENV['DATABASE_URL']
end

ActiveRecord::Base.establish_connection(DATABASE_URL)