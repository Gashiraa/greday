# frozen_string_literal: true

class ApplicationController < ActionController::Base

  helper_method :company
  helper_method :change_locale

  protect_from_forgery with: :reset_session
  include TranslateEnum
  include RansackMemory::Concern # insert this line

  before_action :authenticate_user!, :load_schema, :company
  before_action :set_locale
  before_action :save_and_load_filters # insert this line after Devise auth before filter (Devise gem is not necessary)


  def set_locale
    I18n.locale = if current_user
                    current_user.locale || I18n.default_locale
                  else
                    I18n.default_locale
                  end
  end

  def change_locale
    locale = params[:id]
    current_user.locale = locale
    respond_to do |format|
      if current_user.save
        format.html { redirect_to root_path, notice: t('locale_changed') }
      end
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to request.env["HTTP_REFERER"], alert: t('unauthorized_action')
  end

  def company
    if current_user.present?
      @company = current_user.company
    end
  end

  def display_id(id)
    id = id.to_s
    id.length < 5 ? id = id.rjust(4, "0") : ""
    value = id.last(4)
  end
  helper_method :display_id

  def display_invoice_id(id)
    if @company&.prefix
      id = id.to_s
      id = @company.prefix+'F'+id
    else
      id.to_s
    end
  end
  helper_method :display_invoice_id

  private

  def load_schema
    Apartment::Tenant.switch!('public')
    return unless current_user.present?

    if current_user
      Apartment::Tenant.switch!(current_user.company.name)
    else
      redirect_to root_url(subdomain: false)
    end
  end
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    attributes = [:display_name, :email, :password, :password_confirmation, :company_id]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
  end

end