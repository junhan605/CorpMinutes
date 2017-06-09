class AddCompanyIdToDirectors < ActiveRecord::Migration[5.0]
  def change
    add_column :directors, :company_id, :integer
  end
end
