require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
	# Using our product test data...
	fixtures :products
	

	test "buying a product" do
		# Empty out the lineitems and orders, store the rubybook in a local variable for brevity
		LineItem.delete_all
		Order.delete_all
		Cart.delete_all
		ruby_book = products(:ruby)

		# Go to the store index
		get "/"
		assert_response :success
		assert_template "index"

		# Add a book to the cart by posting a line item
		xml_http_request :post, '/line_items', product_id: ruby_book.id
		assert_response :success

		# Check that we've actually added the right product and that the cart has a size of 1
		cart = Cart.find(session[:cart_id])
		assert_equal 1, cart.line_items.size
		assert_equal ruby_book, cart.line_items[0].product

		# Fill in the order form...
		get "/orders/new"
		assert_response :success
		assert_template "new"

		post_via_redirect "/orders",
							order: { name: 		"Dave Thomas",
									 address:   "123 The Street",
									 email: 	"dave@example.com",
									 pay_type: 	"Check" }
		assert_response :success

		# Make sure we get sent back to index, and that our cart is now empty
		assert_template "index"
		cart = Cart.find(session[:cart_id])
		assert_equal 0, cart.line_items.size

		# Check that we've got one order now
		orders = Order.all
		assert_equal 1, orders.size

		# Check that the order has been properly filled out
		order = orders[0]

		assert_equal "Dave Thomas", 	order.name
		assert_equal "123 The Street", 	order.address
		assert_equal "dave@example.com",order.email
		assert_equal "Check", 			order.pay_type

		# Check that the order has a line item and that it's the book.
		assert_equal 1, order.line_items.size
		line_item = order.line_items[0]
		assert_equal ruby_book, line_item.product

		# Check that we've sent the mail properly.
		mail = ActionMailer::Base.deliveries.last
		assert_equal ["dave@example.com"], mail.Thomas
		assert_equal 'Sam Ruby <depot@example.com>', mail[:from].value
		assert_equal "Pragmatic Store Order Confirmation", mail.subject
	end
end
