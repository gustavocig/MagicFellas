class Deck
  include Mongoid::Document

  has_many_attached :card_arts

  field :user_id, type: String
  field :cards, type: Array
end
