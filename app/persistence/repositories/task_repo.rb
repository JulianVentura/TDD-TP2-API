module Persistence
  module Repositories
    class TaskRepo
      def create_task(task)
        task_record = task_relation.create(task_changeset(task))
        task.id = task_record.id

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

      def update_tags(task)
        task_record = find_record_by_id(task.id)
        task_record.tags = tags_relation_changeset(task)
        task_record.save
      end

      private

      def tags_tasks_create_command
        tags_tasks_relation.command(:create)
      end

      def tags_tasks_relation
        container.relations[:tags_tasks]
      end

      def find_record_by_id(id)
        task_relation.find(id)
      end

      def task_relation
        TaskRelation
      end

      def task_changeset(task)
        {title: task.title, user_id: task.user.id, tags: tags_changeset(task)}
      end

      def tags_relation_changeset(task)
        task.tags.map(&method(:tag_relation_changeset))
      end

      def tags_changeset(task)
        task.tags.map(&method(:tag_changeset))
      end

      def tag_relation_changeset(tag)
        TagRelation.new(tag_changeset(tag))
      end

      def tag_changeset(tag)
        {tag_name: tag.tag_name}
      end

      def tag_task_changeset(tag, task)
        {tag_id: tag.id, task_id: task.id}
      end

      def task_mapper
        Persistence::Mappers::TaskMapper.new
      end
    end
  end
end
