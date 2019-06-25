class Deck
  include Mongoid::Document
  IMAGE_RATIO = { width: '280', height: '395' }.freeze
  MIN_VALID_DECK_SIZE = 60.freeze

  field :user_id, type: Integer
  field :cards, type: Array
  field :name, type: String
  field :valid_deck, type: Boolean

  validates :name, presence: true, uniqueness: true

  before_create :set_valid_deck
  before_save :set_valid_deck

  def set_valid_deck
    self.valid_deck = (cards.count >= MIN_VALID_DECK_SIZE)
  end
end
