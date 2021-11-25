module Persistence
  module Relations
    class TagRelation < ActiveRecord::Base
      self.table_name = 'tags'

      has_and_belongs_to_many :tasks, join_table: :tags_tasks, class_name: 'Persistence::Relations::TaskRelation', foreign_key: :tag_id, association_foreign_key: :task_id
    end
  end
end
