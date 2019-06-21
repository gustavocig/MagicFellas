class Api::V1::UsersController < ApplicationController
  before_action :find_user, only: :show
  before_action :get_users, only: :index

	def index
    render_json @users.map(&:to_json)
  end

  def show
    render_json @user.to_json
  end

  def deck_statistics
    case params[:options]
    when 'average' then render_average
    when 'max' then render_max
    when 'min' then render_min
    else render_count
    end
  end

  def render_count
    render_json({ result: User.total_decks, query: 'total' })
  end

  def render_min
    render_json({ result: User.min_decks, query: 'min' })
  end

  def render_max
    render_json({ result: User.max_decks, query: 'max' })
  end

  def render_average
    render_json({ result: User.average_decks, query: 'average' })
  end

  private

  def render_json(message_hash, status = :ok)
    render json: message_hash.to_json, status: status
  end

  def find_user
    begin
      @user = User.find params[:id]
    rescue ActiveRecord::RecordNotFound

      begin
        user_id = Integer params[:id]

        error_string = "User with ID: #{params[:id]} not found, please check your parameters and try again"
      rescue ArgumentError
        error_string = 'Invalid command, please try again'
      end

      error_hash = { error: error_string }
      render_json error_hash, :not_found
    end
  end
end
