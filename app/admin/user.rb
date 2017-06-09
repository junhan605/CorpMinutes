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

  permit_params :email, :name, :password, :password_confirmation, :suspend, :approved, companies: [], company_ids: []

  index do
    column :name
    column :email

    actions name: "Approve", defaults: false do |resource|
      if resource.approved?
        "Approved"
      else
        link_to("Approve", approve_admin_user_path(resource), method: :post
        )
      end
    end

    # column :approved do |resource|
    #   if resource.approved == false
    #     link_to("Approve",
    #       approve_admin_user_path(resource),
    #       remote: true, method: :post
    #     )
    #   else
    #     resource.approved
    #   end
    # end

    actions name: "Suspend", defaults: false do |resource|
      params = { user_id: resource.id }
      link_to(resource.suspend ? "Active" : "Suspend",
        suspend_admin_user_path(resource, params), method: :post)
    end

    actions
  end

  # action_item :approve, only:[:index] do
  #   link_to("Approve",
  #     approve_admin_user_path(resource),
  #     remote: true, method: :post
  #   )
  # end

  # action_item :suspend, only:[:index]
  #   link_to("Suspend",
  #     suspend_admin_user_path(resource) if resource?,
  #     remote: true, method: :post
  #   )
  # end

  form do |f|
    f.inputs 'User' do
      f.input :name
      f.input :email
      # f.input :password
      # f.input :password_confirmation
      f.input :approved
      f.input :suspend
      f.input :companies, :as => :check_boxes
    end

    f.actions
  end

  member_action :approve, method: :post, only: :index do
  end

  member_action :suspend, method: :post, only: :index do
  end

  controller do
    def suspend
      resource.update_attributes! suspend: resource.suspend ? false : true
      redirect_to admin_users_path
    end

    def approve
      resource.update_attributes! approved: true
      redirect_to admin_users_path
    end
  end

  before_create do |user|
    user.password = user.generated_password
    user.password_confirmation = user.password
  end

  after_create do |user|
    AdminMailer.user_created(comment.id).deliver
    # AdminMailer.new_user_waiting_for_approval(self).deliver
    # mail(to: user.email, subject: "Account was created for you", contents: user.password)
    # RegistrationMailer.welcome(user, user.password).deliver
  end
end
