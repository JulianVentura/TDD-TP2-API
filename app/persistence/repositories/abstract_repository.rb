require 'byebug'

module Persistence
  module Repositories
    class AbstractRepository
      def save(an_object)
        if find_dataset_by_id(get_id(an_object)).first
          update(an_object)
        else
          insert(an_object)
        end
        an_object
      end

      def destroy(an_object)
        find_dataset_by_id(get_id(an_object)).delete
      end
      alias delete destroy

      def delete_all
        dataset.delete
      end

      def all
        load_collection dataset.all
      end

      def find(id)
        found_record = dataset.first(pk_column => id)
        raise ObjectNotFound.new(self.class.model_class, id) if found_record.nil?

        load_object dataset.first(found_record)
      end

      def first
        load_collection dataset.where(is_active: true)
        load_object dataset.first
      end

      class << self
        attr_accessor :table_name, :model_class
      end

      protected

      def dataset
        DB[self.class.table_name]
      end

      def load_collection(rows)
        rows.map { |an_object| load_object(an_object) }
      end

      def update(an_object)
        find_dataset_by_id(get_id(an_object)).update(update_changeset(an_object))
      end

      def insert(an_object)
        id = dataset.insert(insert_changeset(an_object))
        set_id(an_object, id)
        an_object
      end

      def find_dataset_by_id(id)
        dataset.where(pk_column => id)
      end

      def load_object(_a_record)
        raise 'Subclass must implement'
      end

      def changeset(_a_object)
        raise 'Subclass must implement'
      end

      def insert_changeset(an_object)
        changeset_with_timestamps(an_object).merge(created_on: Date.today)
      end

      def update_changeset(an_object)
        changeset_with_timestamps(an_object).merge(updated_on: Date.today)
      end

      def changeset_with_timestamps(an_object)
        changeset(an_object).merge(created_on: an_object.created_on, updated_on: an_object.updated_on)
      end

      def class_name
        self.class.model_class
      end

      def pk_column
        Sequel[self.class.table_name][:id]
      end

      private

      def get_id(an_object)
        an_object.id
      end

      def set_id(an_object, id)
        an_object.id = id
      end
    end
  end
end
