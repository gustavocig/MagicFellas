class UsersController < ApplicationController
  before_action :authenticate_user!

  include Crudable

  def index
    redirect_to cards_index_path
  end

  def settings    
    render 'settings'
  end

  protected

  def load_resource
    @resource = current_user
  end

  def new_resource(new_params = {})
    User.new new_params
  end

  def resource_params
    params.require(:user).permit!
  end
end
