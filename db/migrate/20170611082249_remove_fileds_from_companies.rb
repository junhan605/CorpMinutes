class RemoveFiledsFromCompanies < ActiveRecord::Migration[5.0]
  def change
    remove_column :companies, :no_of_company, :string
    remove_column :companies, :email, :string
  end
end
