class Cart

  attr_reader :items

  # transforming from hash to a series of cart items.
  def self.build_from_hash hash # pass a hash
    items = if hash["cart"] then # if cart exists then we go inside hash -> cart -> items otherwise return an empty array
      # this hash represents a session, and we want to check if there is a cart in this session/hash
      hash["cart"]["items"].map do |item_data|
        CartItem.new item_data["product_id"], item_data["quantity"]
      end
    else
      []
    end
    new items # at the very end of it, build a new instance of cart
  end

  def initialize items = [] # set the items as an empty array
    @items = items # pass items as the array of items
  end

  def add_item product_id
    # The reason we are adding product_id, not adding a product object, is because the session variable doesn't hold on data: object,
    # but rather on the primitive classes such as numbers, arrays, strings and hashes.
    item = @items.find { |item| item.product_id == product_id } # search if that product_id is already in the items arrays
    if item # if found
      item.increment
    else
      @items << CartItem.new(product_id) # quantity by default is 1 for new CartItem object
    end
  end

  def empty?
    @items.empty?
  end

  def count
    @items.length
  end

  def serialize # we are serializing the contents of the cart into a hash
    items = @items.map do |item|
      {
        "product_id" => item.product_id,
        "quantity" => item.quantity
      }
    end

    # {
    #   "cart" => {
    #     "items" => items
    #   }
    # } ## after modification in the add method, instead of passing a cart,
    ## I will pass a list of items, see below:

    {
      "items" => items
    }
  end
  # test the other way around, we want to get the cart objects from the session hash


  def total_price
    @items.inject(0) { |sum, item| sum + item.total_price }
    # zero will be added first to the item.total_price and so on
  end
end
