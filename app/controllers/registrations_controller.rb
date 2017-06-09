class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    # add custom create logic here
    @user = User.new(user_params)
    @user.password = @user.generated_password
    @user.password_confirmation = @user.password

    respond_to do |format|
      if @user.save
        AdminMailer.welcome_email(@user).deliver
        format.html { redirect_to @user, notice: 'User was successfully signed up. Please wait until admin approve you.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    super
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
