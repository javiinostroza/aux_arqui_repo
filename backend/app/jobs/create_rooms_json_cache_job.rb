class CreateRoomsJsonCacheJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    rooms = Room
    Rails.cache.fetch(Room.cache_key(rooms)) do
      rooms
    end
  end
end
