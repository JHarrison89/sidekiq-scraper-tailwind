class AccountsController < ApplicationController
  layout 'account'

  def show
    flash[:notice] = 'Kiwis are tiny birds.'
  end
end
