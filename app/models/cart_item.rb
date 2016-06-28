class CartItem
  attr_reader :product_id, :quantity

  def initialize product_id, quantity = 1 # quantity is 1 if nothing is defined
    @product_id = product_id
    @quantity = quantity
  end

  def increment
    @quantity = @quantity + 1
  end

  def product
    Product.find product_id # Product is from the class Product.
    # product_id exists because we have an attr_reader :product_id
  end

  def total_price
    product.price * quantity  
  end
end
