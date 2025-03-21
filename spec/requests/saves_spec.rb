require "rails_helper"

RSpec.describe "Saves", type: :request do
  let(:user) { create(:user) }

  before do
    sign_in_as(user)

    job_one = create(:job, title: "Job one")
    job_two = create(:job, title: "Job two")

    create(:job_user, job: job_one, user:, status: "saved")
    create(:job_user, job: job_two, user:, status: "rejected")
  end

  describe "GET job/saves" do
    context "when hitting the job saves index endpoint" do
      it "response only includes saved jobs" do
        get saves_path
        expect(response).to have_http_status(:ok)

        expect(response.body).to include("Job one")
        expect(response.body).not_to include("Job two")
      end
    end
  end

  describe "PATCH /jobs/:job_id/save" do
    fit "saves a job" do
      job = create(:job)

      expect(user.jobs).not_to include(job)

      patch safe_path(job, format: :turbo_stream)

      expect(response).to have_http_status(:ok)
      expect(user.jobs.reload).to include(job)
      expect(user.job_users.find_by(job_id: job).status).to eq("saved")
    end
  end
end
