module Persistence
  module Relations
    class TaskRelation < ActiveRecord::Base
      self.table_name = 'tasks'

      belongs_to :user, class_name: 'Persistence::Relations::UserRelation', foreign_key: :user_id
      has_and_belongs_to_many :tags, join_table: :tags_tasks, class_name: 'Persistence::Relations::TagRelation', dependent: :destroy, foreign_key: :task_id, association_foreign_key: :tag_id
    end
  end
end
