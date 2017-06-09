class AddNoOfCompanyToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :no_of_company, :integer
  end
end
