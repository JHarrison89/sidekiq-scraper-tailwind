require "rails_helper"

RSpec.describe LogoHelper, type: :helper do
  # Include Rails route helpers so we can use the rails_storage_redirect_path method
  include Rails.application.routes.url_helpers

  let(:example_s3_url) { "https://aws-s3-bucket-url.com" }

  before do
    # Temporarily make FetchImage public so we can stub its methods
    LogoHelper.send(:public_constant, :FetchImage)
  end

  describe "#board_logo_helper" do
    context "when the board logo exists" do
      it "returns a URL for the board logo" do
        board = create(:board, :with_logo)

        expect(helper.board_logo_helper(board:)).to eq(rails_storage_redirect_path(board.logo))
      end
    end

    context "when the board logo does not exist" do
      it "returns a URL for the default logo" do
        allow(LogoHelper::FetchImage).to receive(:presigned_url).and_return(example_s3_url)

        board = create(:board)

        expect(helper.board_logo_helper(board:)).to eq(example_s3_url)
      end
    end
  end

  describe "#employer_logo_helper" do
    context "when the employer logo exists" do
      it "returns a URL for the employer logo" do
        employer = create(:employer, :with_logo)

        expect(helper.employer_logo_helper(employer:)).to eq(rails_storage_redirect_path(employer.logo))
      end
    end

    context "when the employer logo does not exist" do
      it "returns a URL for the default logo" do
        allow(LogoHelper::FetchImage).to receive(:presigned_url).and_return(example_s3_url)

        employer = create(:employer)

        expect(helper.employer_logo_helper(employer:)).to eq(example_s3_url)
      end
    end
  end
end
