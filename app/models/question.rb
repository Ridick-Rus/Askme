class Question < ApplicationRecord
  after_save_commit :save_new_tags, on: %i[create update]

  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  has_many :question_tags, dependent: :delete_all
  has_many :hash_tags, through: :question_tags

  validates :body, presence: true, length: { maximum: 280 }

  def save_new_tags
    self.hash_tags =
      "#{body} #{answer}".downcase.scan(HashTag::REGEX).uniq.map do |tag|
        HashTag.create_or_find_by(text: tag)
      end
  end
end
