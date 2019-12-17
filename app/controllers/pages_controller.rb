class PagesController < ApplicationController

  skip_before_action :authenticate_user!
  skip_before_action :save_and_load_filters # insert this line after Devise auth before filter (Devise gem is not necessary)

  def show
    render template: "pages/#{params[:page]}", layout: false
  end
end
