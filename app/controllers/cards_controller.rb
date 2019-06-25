class CardsController < ApplicationController
  before_action :authenticate_user!

  def index
    @current_page = params[:page]&.to_i || 1
    
    @cards = Requester.cards({page: @current_page})

    @has_more_pages = @cards['has_more']
    @total_cards = @cards['total_cards']
    @cards_per_page = @cards['data']&.size

    format_cards! @cards['data']
    set_pagination

    render 'users/index'
  end

  def search
    @current_page = params[:page]&.to_i || 1
    
    @cards = Requester.card_search(params[:q], {page: @current_page})

    @has_more_pages = @cards['has_more']
    @total_cards = @cards['total_cards']
    @cards_per_page = @cards['data']&.size

    format_cards! @cards['data']
    set_pagination

    render 'users/index'
  end

  def add_to_deck
    return if params[:deck].nil? || params[:card].nil?

    deck = Deck.find params[:deck]
    card = params[:card].permit!.to_h
    deck.cards << card

    deck.save
  end

  def remove_from_deck
    return if params[:deck].nil? || params[:card].nil?

    deck = Deck.find params[:deck]
    selected_index = deck.cards.index { |card| card[:id] == params[:card][:id] }
    deck.cards.delete_at selected_index

    deck.save
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
