class Review < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  belongs_to :book
end
