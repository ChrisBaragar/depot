class StoreController < ApplicationController
  skip_before_action :authorize

  include CurrentCart
  before_action :set_cart
  
  def index
    if params[:set_locale]
      redirect_to store_url(locale: params[:set_locale])
    else
  	 @products = Product.order(:title)
    end
  	
  	if session[:store_index_counter].nil?
  		session[:store_index_counter] = 0
  	end

  	session[:store_index_counter] += 1
  end
end
