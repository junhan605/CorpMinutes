ActiveAdmin.register User do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  permit_params :email, :name, :password, :password_confirmation, :suspend, :companies

  index do
    column :name
    column :email
    column :companies
    column do
        link_to 'Suspend', "#"
    end
    actions

  end

  form do |f|
    f.inputs 'User' do
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :suspend
      f.input :companies, :as => :check_boxes
    end
    f.actions
  end

end
