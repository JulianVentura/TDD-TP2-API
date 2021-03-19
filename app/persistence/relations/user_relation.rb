module Persistence
  module Repositories
    class UserRelation < ActiveRecord::Base
      self.table_name = 'users'

      has_many :tasks, class_name: 'Persistence::Repositories::TaskRelation'
    end
  end
end
