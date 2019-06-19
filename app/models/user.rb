class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  validates :name, presence: true, uniqueness: true

  def decks
    Deck.where(user_id: id)
  end

  def create_deck(cards)
    Deck.create(cards: cards, user_id: id)
  end

  def get_deck(deck_id)
    Deck.find_by(id: deck_id, user_id: id)
  end
end
