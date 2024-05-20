# frozen_string_literal: true

class WebPage < ApplicationRecord
  validates :company, :url, :script, presence: true
end
