class Deck
  include Mongoid::Document
  IMAGE_RATIO = { width: '280', height: '395' }.freeze

  field :user_id, type: Integer
  field :cards, type: Array
  field :name, type: String

  validates :name, presence: true, uniqueness: true
end
