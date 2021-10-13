require "settings"
require "check"

analyzeind = {}

function analyzeind.init()
	--local num_candles = getNumCandles(graph_histo_tag)
	--local tabl, num, leg = getCandlesByIndex(graph_histo_tag, 0, num_candles-1, 1)
	--last_value = math.floor(tabl[0].close*1000)
end

function analyzeind.macdh() -- -2:SELL -1:sell 0:None 1:buy 2:BUY 
	local num_candles = getNumCandles(settings.macdh_tag)
	local tabl, num, leg = getCandlesByIndex(settings.macdh_tag, 0, num_candles-2, 2)
	local last_value = math.floor(tabl[0].close*1000)
	local value = math.floor(tabl[1].close*1000)
	message("macdh: last = "..last_value.." current = "..value)
	--if math.abs(value) > 4 then
		if last_value > value then
			return -1
		end
		if last_value < value then
			return 1
		end
	--end
	return 0
end

function analyzeind.chaikin_oscillator() -- -2:SELL -1:sell 0:None 1:buy 2:BUY
	local num_candles = getNumCandles(settings.chaikin_oscillator_tag)
	local tabl, num, leg = getCandlesByIndex(settings.chaikin_oscillator_tag, 0, num_candles-2, 2)
	local last_value = math.floor(tabl[0].close*1000)
	local value = math.floor(tabl[1].close*1000)
	if value > 0 then
		return -1
	end
	if value < 0 then
		return 1
	end
	return 0
end

function analyzeind.trix() -- -2:SELL -1:sell 0:None 1:buy 2:BUY
	message(settings.trix_tag)
	local num_candles = getNumCandles(settings.trix_tag)
	--message("num_candles = "..num_candles)
	local tabl, num, leg = getCandlesByIndex(settings.trix_tag, 0, num_candles-2, 2)
	local last_value = math.floor(tabl[0].close*1000)
	local value = math.floor(tabl[1].close*1000)
	message("trix: last = "..last_value.." current = "..value)
	if value < last_value then
		return -1
	end
	if value > last_value then
		return 1
	end
	return 0
end

function analyzeind.stochastic() -- -2:SELL -1:sell 0:None 1:buy 2:BUY
	message(settings.stochastic_tag)
	local num_candles = getNumCandles(settings.stochastic_tag)
	--message("num_candles = "..num_candles)
	local tabl, num, leg = getCandlesByIndex(settings.stochastic_tag, 0, num_candles-2, 2)
	local last_value = math.floor(tabl[0].close)
	local value = math.floor(tabl[1].close)
	message("stochastic: "..value)
	if value > 60 then -- value < last_value and
		return -1
	end
	if value < 40 then -- value > last_value and
		return 1
	end
	return 0
end

function analyzeind.bollinger() -- -2:SELL -1:sell 0:None 1:buy 2:BUY
	message(settings.bollinger_tag)
	local num_candles = getNumCandles(settings.bollinger_tag)
	--message("num_candles = "..num_candles)
	local tabl, num, leg = getCandlesByIndex(settings.bollinger_tag, 0, num_candles-1, 1)
	local value = math.floor(tabl[0].close*1000)
	local price = math.floor(check.price()*1000)
	message("bollinger: value = "..value.." price = "..price)
	if price < value then
		return 1
	end
	if price > value then
		return -1
	end
	return 0
end

function analyzeind.price() -- -2:SELL -1:sell 0:None 1:buy 2:BUY
	message(settings.price_tag)
	local num_candles = getNumCandles(settings.price_tag)
	--message("num_candles = "..num_candles)
	local tabl, num, leg = getCandlesByIndex(settings.price_tag, 0, num_candles-2, 2)
	local last_value = math.floor(tabl[0].close*1000)
	local value = math.floor(tabl[1].close*1000)
	message("price: last = "..last_value.." current = "..value)
	if last_value < value then
		return 1
	end
	if last_value > value then
		return -1
	end
	return 0
end