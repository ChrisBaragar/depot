require 'test_helper'

class CartTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "two unique products in the cart should have proper sum and cart size 2" do
  	cart = Cart.create
  	product1 = products(:ruby)
  	product2 = products(:two)

  	#add products to cart
  	cart.add_product(product1.id).save!
  	cart.add_product(product2.id).save!

  	#assert line_items.size
  	assert_equal 2, cart.line_items.size
  	#assert cart.total_price
  	assert_equal product1.price + product2.price, cart.total_price
  end

  test "two duplicate products should have one line item with quantity 2" do
  	cart = Cart.create
  	product1 = products(:ruby)

  	cart.add_product(product1.id).save!
  	cart.add_product(product1.id).save!

  	assert_equal 1, cart.line_items.size
  	assert_equal 2, cart.line_items[0].quantity
  	assert_equal product1.price*2, cart.total_price
  end

end
