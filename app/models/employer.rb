# frozen_string_literal: true

class Employer < ApplicationRecord
  has_one_attached :logo
  has_many :jobs

  validates :name, presence: true
end
