class Book < ApplicationRecord
  belongs_to :user
  has_many :chapters
  has_one_attached :thumbnail

  validates :title, presence: true, length: { in: 10..40 }
  validates :introduction, presence: true, length: { in: 20..200 }
  validates :price, numericality: { in: 1000..5000 }
end
