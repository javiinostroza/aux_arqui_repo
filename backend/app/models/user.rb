class User < ApplicationRecord
    validates :username, uniqueness: true, presence: true
    has_one_attached :photo
end
