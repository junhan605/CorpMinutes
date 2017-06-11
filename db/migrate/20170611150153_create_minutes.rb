class CreateMinutes < ActiveRecord::Migration[5.0]
  def change
    create_table :minutes do |t|
      t.string :minute_type
      t.string :location
      t.string :orther_party
      t.string :escriibe_property

      t.timestamps
    end
  end
end
