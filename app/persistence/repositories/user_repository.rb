module Persistence
  module Repositories
    class UserRepository
      def all
        user_mapper.call user_relation.all
      end

      def find(id)
        user_record = find_record_by_id(id)
        user_mapper.build_user_from user_record
      rescue ActiveRecord::RecordNotFound
        raise UserNotFound, "User with id [#{id}] not found"
      end

      def save(user)
        if user.id.nil?
          user_record = user_relation.create(user_changeset(user))
          user.id = user_record.id
        else
          user_relation.update(user_changeset(user))
        end

        user
      end

      def delete(user)
        find_record_by_id(user.id).destroy
      end

      def delete_all
        user_relation.destroy_all
      end

      private

      def find_record_by_id(id)
        user_relation.find(id)
      end

      def user_relation
        UserRelation
      end

      def user_changeset(user)
        user_mapper.user_changeset(user)
      end

      def user_mapper
        Persistence::Mappers::UserMapper.new
      end
    end
  end
end
