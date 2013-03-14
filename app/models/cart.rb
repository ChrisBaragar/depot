class Cart < ActiveRecord::Base
		#dependent here means if the cart is destroyed, so too are the line_items
		has_many :line_items, dependent: :destroy
end
