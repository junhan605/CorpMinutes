class AddCompayFieldsToCompanies < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :state, :string
    add_column :companies, :president, :string
    add_column :companies, :treasure, :string
    add_column :companies, :secretary, :string
  end
end
