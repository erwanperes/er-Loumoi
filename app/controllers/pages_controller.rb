class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: :home
  
  def home
    @items = Item.all.includes(:user).order(:name)
  end
  def about
  end
end
