module Persistence
  module Relations
    class UserRelation < ActiveRecord::Base
      self.table_name = 'users'

      has_many :tasks, class_name: 'Persistence::Relations::TaskRelation', dependent: :destroy, foreign_key: :user_id
    end
  end
end
