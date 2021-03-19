module Persistence
  module Repositories
    class TagRepo
      def create_tag(tag)
        tag_record = tag_relation.create(tag_changeset(tag))
        tag.id = tag_record.id

        tag
      end

      def find_by_tag_name(name, &when_not_found)
        tag_record = tag_relation.find_by(tag_name: name)
        return tag_mapper.build_tag_from(tag_record) unless tag_record.nil?

        when_not_found.call
      end

      def delete_all
        tag_relation.destroy_all
      end

      private

      def tag_relation
        TagRelation
      end

      def tag_changeset(tag)
        {tag_name: tag.tag_name}
      end

      def tag_mapper
        Persistence::Mappers::TagMapper.new
      end
    end
  end
end
