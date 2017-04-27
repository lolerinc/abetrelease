module ApplicationHelper
	
	def get_full_names
		@names = User.all.pluck(:fname, :lname)
		@names.map! {|n| n.join(" ")}
		return @names
	end


end
