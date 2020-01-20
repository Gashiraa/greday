class RegistrationsController < Devise::RegistrationsController
  private

  # Notice the name of the method
  def sign_up_params
    params.require(:user).permit(:display_name, :email, :password, :password_confirmation, :company_id)
  end
end