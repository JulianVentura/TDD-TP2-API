module Persistence
  module Repositories
    class UserRepo
      def all
        user_mapper.call user_relation.all
      end

      def find(id)
        user_record = find_record_by_id(id)
        user_mapper.build_user_from user_record
      rescue ActiveRecord::RecordNotFound
        raise UserNotFound, "User with id [#{id}] not found"
      end

      def update_user(user)
        user_record = find_record_by_id(user.id)
        user_record.update(user_changeset(user))

        user
      end

      def create_user(user)
        user_record = user_relation.create(user_changeset(user))
        user.id = user_record.id

        user
      end

      def delete_user(user)
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
        {name: user.name}
      end

      def user_mapper
        Persistence::Mappers::UserMapper.new
      end
    end
  end
end
