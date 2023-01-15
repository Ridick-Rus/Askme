class AddColumnToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :headcolor, :string, default: "#370617"
  end
end
