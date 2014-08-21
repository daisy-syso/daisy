class Hospitals::HospitalRoom < ActiveRecord::Base
  belongs_to :parent, class_name: 'HospitalRoom', foreign_key: 'parent_id'

  class << self
    include Cacheable

    def filters
      hospital_rooms = self.all.to_a
      hospital_rooms_by_parent = proc do |parent_id|
        hospital_rooms.select do |hospital_room|
          hospital_room.parent_id == parent_id
        end
      end

      collect_filter = proc do |parent_id|
        hospital_rooms_by_parent.call(parent_id).map do |hospital_room|
          children = collect_filter.call(hospital_room.id)
          Hash.new.tap do |ret|
            ret[:title] = hospital_room.name
            ret[:params] = { hospital_room: hospital_room.id }
            ret[:children] = children if children.any?
          end
        end
      end

      collect_filter.call(nil)
    end

    define_cached_methods :filters
  end

end
