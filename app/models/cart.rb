class Cart < ActiveRecord::Base
		#dependent here means if the cart is destroyed, so too are the line_items
		has_many :line_items, dependent: :destroy
		attr_protected

		def add_product(product_id)
			# find_by_product_id is a dynamic finder. cool!
			current_item = line_items.find_by_product_id(product_id)
			if current_item
				current_item.quantity += 1
			else
				current_item = line_items.build(product_id: product_id)
				current_item.price = current_item.product.price
			end
			current_item
		end

		def decrement_line_item_quantity(line_item_id)
			current_item = line_items.find(line_item_id)

			if current_item.quantity > 1
				current_item.quantity -= 1
			else
				current_item.destroy
			end

			current_item
		end

		# def remove_product(product_id)
		# 	current_item = line_items.find_by_product_id(product_id)
		# 	if current_item
		# 		current_item.quantity -= 1
				
		# 	end
		# end

		def total_price
			line_items.to_a.sum {|item| item.total_price}
		end
end
