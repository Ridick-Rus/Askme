class CreateHashTags < ActiveRecord::Migration[7.0]
  def change
    create_table :hash_tags do |t|
      t.string :text, index: true, null: false

      t.timestamps
    end
  end
end
