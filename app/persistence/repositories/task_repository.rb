module Persistence
  module Repositories
    class TaskRepository
      def all
        task_mapper.call task_relation.all
      end

      def save(task)
        if task.id.nil?
          task_record = task_relation.create(task_changeset(task))
          task.id = task_record.id
        else
          task_relation.update(task_changeset(task))
          task_record = find_record_by_id(task.id)
        end
        task_record.tags = tags_relation_changeset(task)

        task
      end

      def find(id)
        task_record = find_record_by_id(id)
        task_mapper.build_task_from task_record, task_record.user
      rescue ActiveRecord::RecordNotFound
        raise TaskNotFound, "Task with id [#{id}] not found"
      end

      def delete_all
        task_relation.destroy_all
      end

      def delete(task)
        find_record_by_id(task.id).destroy
      end

      private

      def task_changeset(task)
        task_mapper.task_changeset(task)
      end

      def find_record_by_id(id)
        task_relation.find(id)
      end

      def task_relation
        Persistence::Relations::TaskRelation
      end

      def tags_relation_changeset(task)
        task_mapper.tags_relation_changeset(task)
      end

      def task_mapper
        Persistence::Mappers::TaskMapper.new
      end
    end
  end
end
