# frozen_string_literal: true

class JobShow < ApplicationRecord
  validates :board, :url, :script, presence: true
end
