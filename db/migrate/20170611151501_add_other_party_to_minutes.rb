class AddOtherPartyToMinutes < ActiveRecord::Migration[5.0]
  def change
    add_column :minutes, :other_party, :string
  end
end
