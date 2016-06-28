class CartsController < ApplicationController
  before_filter :initialize_cart

  # we don't want to have cart template, rather, we want it to redirect_to the previous page
  def add
    @cart.add_item params[:id]
    # we need to pass serialize method to the session variable
    ## session = @cart.serialize # DANGEROUS METHOD: DO NOT USE - it's because we do not want to override the session variable
    # rather we want to make sure that the "cart" variable is the result of serialize method
    session["cart"] = @cart.serialize # must update serialize method in the model
    # its like ["cart"] = items hash, items are part of the cart.
    # if we pass cart as a session as the first way above, that's DANGEROUS because there are other variables that might be deleted if
    # we do like the first way above
    product = Product.find params[:id]
    redirect_to :back, notice: "Added #{product.name} to cart."
  end

  def show
    
  end
end
