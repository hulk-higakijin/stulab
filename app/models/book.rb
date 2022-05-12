class Book < ApplicationRecord
  belongs_to :user
  has_many :chapters
  has_one_attached :thumbnail
  has_many :reviews

  validates :title, presence: true, length: { in: 10..40 }
  validates :introduction, presence: true, length: { in: 20..200 }
  validates :price, numericality: { in: 1000..5000 }

  enum :status, %i[draft reservation published trashed]

  def review(score)
    (reviews.where(score: score).length.to_f * 100 / reviews.length.to_f).round
  rescue StandardError
    0
  end

  def review_rate
    rate = (reviews.pluck(:score).sum.to_f / reviews.length).round(1)
    rate = 0.0 if rate.nan?
    rate
  end
end
