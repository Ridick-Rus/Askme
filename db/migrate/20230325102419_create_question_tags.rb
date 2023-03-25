class CreateQuestionTags < ActiveRecord::Migration[7.0]
  def change
    create_table :question_tags do |t|
      t.references :question, null: false, index: true, foreign_key: true
      t.references :hash_tag, null: false, index: true, foreign_key: true

      t.timestamps
    end
  end
end
