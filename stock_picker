#Stock Picker
#Takes an array of stock prices, returns besy days to buy and then sell for maximum profit

#Approach 
#I think it may be memory intensive for large data but it works
#A. Build a hash of every single possibility of buy and then sell
#B. Find maximum value (profit) in hash, return key.
def stock_picker(stock_prices)

	#Store all possible options in a hash
	options_hash = {}

	#Loop through all possible buy options
	stock_prices.each_with_index do |buyPrice, buyIndex|
		#For each buy option, loop through all possible sell options
		sell_prices = stock_prices[buyIndex..-1]
		sell_prices.each_with_index do |sellPrice, sellIndex|
			#Add the option and profit to the options_hash
			options_hash[[buyIndex,(sellIndex+buyIndex)]] = (sellPrice-buyPrice)			
		end
	end
	
	#Find the most profitable option
	options_hash.max_by {|key,value| value}[0]

end

stock_picker([17,3,6,9,15,8,6,1,10])