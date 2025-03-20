require "rails_helper"

RSpec.describe "Accounts", type: :request do
  describe "GET /accounts" do
    let(:user) { create(:user) }
    let(:employer) { create(:employer) }

    before do
      session_user_is(user)

      job_one = create(:job, title: "Job one")
      job_two = create(:job, title: "Job two")
      create(:job, title: "Job three", employer:)
      create(:job, title: "Job four")

      create(:job_user, job: job_one, user:, status: "saved")
      create(:job_user, job: job_two, user:, status: "rejected")
    end

    context "when some jobs have been saved or rejected" do
      it "renders the correct HTML response" do
        get account_path

        expect(response).to have_http_status(:ok)
        expect(response.body).not_to include("Job one")
        expect(response.body).not_to include("Job two")
        expect(response.body).to include("Job three")
        expect(response.body).to include("Job four")
      end
    end

    context "when filters are applied" do
      it "renders the turbo_stream response" do
        get account_path,
            params: { employer_id: [employer.id] },
            as: :turbo_stream

        expect(response).to have_http_status(:ok)
        expect(response.body).not_to include("Job one")
        expect(response.body).not_to include("Job two")
        expect(response.body).to include("Job three")
        expect(response.body).not_to include("Job four")
      end
    end
  end
end
