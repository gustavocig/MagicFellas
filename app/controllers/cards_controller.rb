class CardsController < ApplicationController
  def index
    @current_page = params[:page]&.to_i || 1
    
    @cards = Requester.cards({page: @current_page})

    @has_more_pages = @cards['has_more']
    @total_cards = @cards['total_cards']
    @cards_per_page = @cards['data']&.size

    format_cards! @cards['data']
    set_pagination

    render 'user/index'
  end

  def search
    @current_page = params[:page]&.to_i || 1
    
    @cards = Requester.card_search(params[:q], {page: @current_page})

    @has_more_pages = @cards['has_more']
    @total_cards = @cards['total_cards']
    @cards_per_page = @cards['data']&.size

    format_cards! @cards['data']
    set_pagination

    render 'user/index'
  end

  def format_cards!(cards)
    cards&.each do |card|
      Requester.formatted_request! card
    end
  end

  def set_pagination
    @first_page = @current_page > 2 ? 1 : nil
    @final_page = @has_more_pages ? (@total_cards / @cards_per_page.to_f).ceil : nil
    @next_page = (@has_more_pages && @current_page + 1 != @final_page) ? @current_page + 1 : nil
    @previous_page = @current_page == 1 ? nil : @current_page - 1
  end
end
