# frozen_string_literal: true

require "rails_helper"

RSpec.describe SaveJob do
  context "when given new job URL" do
    it "creates a new job" do
      # Unpersisted job, employer and board records are create by the factory
      job = build(:job)

      expect { described_class.call(employer: job.employer, board: job.board, attributes: job) }
        .to change(Job, :count).by(1)
    end
  end

  context "when given existing job URL" do
    it "does not create a new job" do
      # Persisted job
      job = create(:job)

      expect { described_class.call(employer: job.employer, board: job.board, attributes: job) }
        .to change(Job, :count).by(0)
    end
  end
end
