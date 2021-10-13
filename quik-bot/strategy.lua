strategy = {}

require "settings";
require "analyzeind"
require "trade"
require "log"

function strategy.run()

	message("analyzing")
	local stochastic = analyzeind.stochastic()
	--local bollinger = analyzeind.bollinger()
	local priceind = analyzeind.price()
	local macdh = analyzeind.macdh()

	total = stochastic + priceind + macdh -- + bollinger

	if total == 3 then
		-- message("trying to buy")
		trade.buy()
	end
	if total == -3 then
		-- message("trying to sell")
		trade.sell()
	end

end

