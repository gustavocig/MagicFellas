class Deck
  include Mongoid::Document
  IMAGE_RATIO = { width: '280', height: '395' }.freeze

  field :user_id, type: Integer
  field :cards, type: Array
  field :name, type: String

  validate :unique_deck_name_by_user

  before_validation :set_name

  def set_name
    return unless name.nil?

    n = 1
    loop do
      self.name = "Deck #{n}"

      break if save

      n += 1
    end
  end

  private

  def unique_deck_name_by_user
    user = User.find user_id
    user_deck_names = user.decks.select { |deck| deck.id != id }.pluck(:name)

    return unless user_deck_names.include? name

    errors.add(:name, 'already in use by user')
  end
end
