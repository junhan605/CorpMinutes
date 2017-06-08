class AddSuspendToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :suspend, :boolean
  end
end
