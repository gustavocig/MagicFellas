class UserController < ApplicationController
  before_action :authenticate_user!

  def index
    redirect_to cards_index_path
  end
end
