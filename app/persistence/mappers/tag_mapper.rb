module Persistence
  module Mappers
    class TagMapper
      def call(tags)
        tags.map do |tag_attributes|
          build_tag_from(tag_attributes)
        end
      end

      def build_tag_from(tag_attributes)
        Tag.new(tag_attributes.tag_name, tag_attributes.id)
      end

      def tag_changeset(tag)
        {tag_name: tag.tag_name}
      end

      def tags_relation_changeset(task)
        task.tags.map(&method(:tag_relation_changeset))
      end

      def tag_relation_changeset(tag)
        Persistence::Relations::TagRelation.new(tag_changeset(tag))
      end
    end
  end
end
