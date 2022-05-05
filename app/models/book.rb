class Book < ApplicationRecord
  belongs_to :user
  has_many :chapters
  has_one_attached :thumbnail
end
