class PasswordsController < ApplicationController
  layout 'account'

  before_action :set_user

  include JobUserCounter

  def edit
    count_job_user_records
  end

  def update
    if @user.update(user_params)
      redirect_to account_path, notice: "Your password has been changed"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
    def set_user
      @user = Current.user
    end

    def user_params
      params.permit(:password, :password_confirmation, :password_challenge).with_defaults(password_challenge: "")
    end
end
