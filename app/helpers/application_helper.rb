module ApplicationHelper

	def print_price(price)
		number_to_currency price
	end
	
	def print_date(datetime)
  		datetime.strftime("%m/%d/%Y")
   end

   def print_season(date)
   	
   end
end
