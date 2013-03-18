module ApplicationHelper
	# Passes the block 'do / end' into the content tag wrapper.
	def hidden_div_if(condition, attributes = {}, &block)
		if condition
			attributes["style"] = "display: none"
		end
		content_tag("div", attributes, &block)
	end

end
