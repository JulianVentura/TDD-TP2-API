module Persistence
  module Repositories
    class TagRepository
      def all
        tag_mapper.call tag_relation.all
      end

      def save(tag)
        if tag.id.nil?
          tag_record = tag_relation.create(tag_changeset(tag))
          tag.id = tag_record.id
        else
          tag_relation.update(tag_changeset(tag))
        end

        tag
      end

      def find(id)
        tag_record = find_record_by_id(id)
        tag_mapper.build_tag_from tag_record
      rescue ActiveRecord::RecordNotFound
        raise TagNotFound, "Tag with id [#{id}] not found"
      end

      def find_by_tag_name(name, &when_not_found)
        tag_record = tag_relation.find_by(tag_name: name)
        return tag_mapper.build_tag_from(tag_record) unless tag_record.nil?

        when_not_found.call
      end

      def delete_all
        tag_relation.destroy_all
      end

      def delete(tag)
        find_record_by_id(tag.id).destroy
      end

      private

      def find_record_by_id(id)
        tag_relation.find(id)
      end

      def tag_relation
        Persistence::Relations::TagRelation
      end

      def tag_changeset(tag)
        tag_mapper.tag_changeset(tag)
      end

      def tag_mapper
        Persistence::Mappers::TagMapper.new
      end
    end
  end
end
