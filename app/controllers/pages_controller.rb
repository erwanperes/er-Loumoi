class PagesController < ApplicationController
  def home
    @items = Item.all.includes(:user) 
  end
  def about
  end
end
