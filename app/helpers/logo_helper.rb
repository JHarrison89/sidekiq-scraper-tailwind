# frozen_string_literal: true

module LogoHelper
  # This FetchImage class is responsible for retrieving images from AWS S3
  # I've added this as a temporary solution since we don't have a Board model
  # to store board logos yet.
  #
  # TODO: Create a Board model and store board logos in the database
  #
  class FetchImage
    def self.client
      Aws::S3::Client.new(
        region: "eu-north-1",
        access_key_id: Rails.application.credentials.dig(:aws, :access_key_id),
        secret_access_key: Rails.application.credentials.dig(:aws, :secret_access_key)
      )
    end

    def self.presigned_url(key:)
      signer = Aws::S3::Presigner.new(client:)

      signer.presigned_url(
        :get_object,
        bucket: "spotlight-aws-bucket-#{Rails.env}",
        key:
      )
    end
  end

  private_constant :FetchImage

  def board_logo_helper(board:)
    if board.logo.attached?
      rails_storage_redirect_path(board.logo)
    else
      FetchImage.presigned_url(key: "default logo")
    end
  end

  def employer_logo_helper(employer:)
    if employer.logo.attached?
      rails_storage_redirect_path(employer.logo)
    else
      FetchImage.presigned_url(key: "default logo")
    end
  end
end
