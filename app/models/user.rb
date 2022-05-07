class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  generate_public_uid generator: PublicUid::Generators::HexStringSecureRandom.new(15)

  has_many :books
  has_one_attached :avatar
end
