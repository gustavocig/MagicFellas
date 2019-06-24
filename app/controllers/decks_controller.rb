class DecksController < ApplicationController
  include Crudable

  def index
    @results = current_user.decks
  end

  protected

  def load_resource
    @resource = Deck.find params[:id]
  end

  def new_resource(new_params = {})
    new_params[:cards] = []

    Deck.new new_params
  end

  def resource_params
    params.require(:deck).permit!
  end
end
