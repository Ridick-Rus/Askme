class QuestionTag < ApplicationRecord
  belongs_to :question, dependent: :destroy
  belongs_to :hash_tag, dependent: :destroy
end
