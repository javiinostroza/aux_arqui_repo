class Room < ApplicationRecord
    has_many :room_messages, dependent: :destroy,
                         inverse_of: :room
    has_many :request, dependent: :destroy


    def self.cache_key(rooms)
        {
        serializer: 'rooms', 
        start_record: rooms.maximum(:updated_at)
        }
    end

    after_touch :create_json_cache

    private

    def create_json_cache
        CreateRoomsJsonCacheJob.perform_now
    end
end
