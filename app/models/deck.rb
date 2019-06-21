class Deck
  include Mongoid::Document

  field :user_id, type: String
  field :cards, type: Array
end
