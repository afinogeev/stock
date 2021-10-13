require "settings"

check = {};

function check.delta_price()
	local price = 0
	local percent = 0
	local ex = getParamEx(settings.CLASSCODE, settings.SECCODE, 'LAST')
	if ex.result == "1" then
		price = ex.param_value
		message( 'price = '..price)
		percent = 100*(math.abs(trade_price-price)/price)
		last_price = price
		message( 'percent = '..percent)
		if percent > delta_price then
			return 1
		end
	end
	return 0
end

function check.depo() -- 0 - not 1 - ready to sell 2 - ready to buy
	local depo = getDepoEx(settings.FIRMID, settings.CLIENT_CODE, settings.SECCODE, settings.ACCOUNT, 2)
	if depo then
		if depo.currentbal > 0  and depo.locked_sell == 0 then
			return 1
		end
		if depo.currentbal == 0 and depo.locked_buy == 0 then
			local money = getMoney(settings.CLIENT_CODE,settings.FIRMID,"EQTV","SUR")
			if depo.wa_position_price*depo.currentbal < money.money_open_balance*0.9 then
				return 0
			end
		end
		return -1
	end
	return 0
end

function check.price()
	local ex = getParamEx(settings.CLASSCODE, settings.SECCODE, 'LAST')
	if ex.result == "1" then
		return ex.param_value
	end
	return 0
end
