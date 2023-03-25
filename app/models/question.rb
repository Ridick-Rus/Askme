class Question < ApplicationRecord
  after_commit :save_new_tags, on: :create
  after_commit :update_tags, on: :update

  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  has_many :question_tags, dependent: :delete_all
  has_many :tags, through: :question_tags, source: :hash_tag

  validates :body, presence: true, length: { maximum: 280 }

  def save_new_tags(tags = [])
    hashtags = body.gsub(/#[[:alpha:]][[:word:]]+/).map { |match| match.delete("#").downcase }
    hashtags.concat(tags)
    hashtags.uniq!

    self.tags = hashtags.map { |tag| HashTag.find_or_create_by(text: tag) }
  end

  def update_tags
    self.tags.clear

    hashtags = answer.gsub(/#[[:alpha:]][[:word:]]+/).map { |match| match.delete("#").downcase }
    save_new_tags(hashtags)
  end
end
