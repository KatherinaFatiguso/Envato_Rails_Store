require 'test_helper'

class CartTest < MiniTest::Test # you can use RSPEC or MINITEST
  def test_adds_one_item
    cart = Cart.new
    cart.add_item 1 # number 1 here represents product_id (not product object)

    assert_equal cart.empty?, false
    # we don't know what to expect when creating the class Cart, so we create .empty? as we need it.
  end

  def test_adds_up_in_quantity
  # this test allows me to add products more than one time
    cart = Cart.new
    3.times { cart.add_item 1 } # I am adding once and I should have 3 items in cart.

    assert_equal 1, cart.items.length
    assert_equal 3, cart.items.first.quantity
  end

  def test_retrieves_products
    product = Product.create! name: "Tomato", price: 4.50

    cart = Cart.new
    cart.add_item product.id

    assert_kind_of Product, cart.items.first.product
  end

  def test_serializes_to_hash # testing the serializing the contents of the cart into a hash
    cart = Cart.new
    cart.add_item 1

    assert_equal cart.serialize, session_hash["cart"]
  end

  def test_builds_from_hash # test the other way around from the above, we want to get the cart objects from the session hash
    cart = Cart.build_from_hash session_hash # we want to get the cart objects from the session hash
    assert_equal 1, cart.items.first.product_id # we expect that in the list of items, we get the first item as the product_id: 1
  end

  private

  def session_hash
    {
      "cart" => {
        "items" => [
          { "product_id" => 1, "quantity" => 1}
        ]
      }
    }
  end
end
