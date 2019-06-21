class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar
  has_many_attached :card_arts

  validates :name, presence: true, uniqueness: true

  def self.count_all_decks
    User.all.map(&:count_decks)
  end

  def self.total_decks
    count_all_decks.sum
  end

  def self.max_decks
    count_all_decks.max
  end

  def self.min_decks
    count_all_decks.min
  end

  def self.average_decks
    total_decks / User.count.to_f
  end

  def decks
    Deck.where(user_id: id)
  end

  def count_decks
    decks.size
  end

  def deck_ids
    decks.pluck(:id).map(&:to_s)
  end

  def create_deck(cards)
    Deck.create(cards: cards, user_id: id)
  end

  def get_deck(deck_id)
    Deck.find_by(id: deck_id, user_id: id)
  end

  def to_json
    user_decks = decks

    {
      id:                 id,
      avatar_url:         avatar,
      name:               name,
      deck_ids:           user_decks.map(&:deck_ids),
      num_of_decks:       user_decks.size,
      total_num_of_cards: user_decks.map(&:count_decks).sum
    }
  end
end
