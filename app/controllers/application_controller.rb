class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # use ApplicationController to store a cart
  def initialize_cart
    @cart = Cart.build_from_hash session # session variable always exists in each controller
  end
end
