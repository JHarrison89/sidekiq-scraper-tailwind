class Board < ApplicationRecord
  has_one_attached :logo
  has_many :jobs

  validates :name, presence: true
end
