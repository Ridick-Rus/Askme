class Question < ApplicationRecord
  after_commit :save_new_tags, on: :create

  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  has_many :question_tags, dependent: :delete_all
  has_many :tags, through: :question_tags, source: :hash_tag

  validates :body, presence: true, length: { maximum: 280 }

  def save_new_tags
    self.tags =
      "#{body} #{answer}".downcase.scan(HashTag::REGEX).uniq.map do |tag|
        HashTag.find_or_create_by(text: tag)
      end
  end
end
