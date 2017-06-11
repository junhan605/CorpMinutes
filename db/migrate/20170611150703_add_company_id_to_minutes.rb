class AddCompanyIdToMinutes < ActiveRecord::Migration[5.0]
  def change
    add_column :minutes, :company_id, :integer
  end
end
