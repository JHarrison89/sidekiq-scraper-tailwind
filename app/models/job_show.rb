# frozen_string_literal: true

class JobShow < ApplicationRecord
  validates :company, :url, :script, presence: true
end
