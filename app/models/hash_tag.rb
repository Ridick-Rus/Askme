class HashTag < ApplicationRecord
  has_many :question_tags
  has_many :questions, through: :question_tags

  REGEX = /#[[:word:]-]+/

  def to_param
    text
  end
end
