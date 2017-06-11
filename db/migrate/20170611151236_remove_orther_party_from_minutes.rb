class RemoveOrtherPartyFromMinutes < ActiveRecord::Migration[5.0]
  def change
    remove_column :minutes, :orther_party, :string
  end
end
