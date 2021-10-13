require "settings"
require "log"
require "check"

is_run = true

function OnInit()
	message('script started')
end

function OnStop()
	is_run = false
	message( 'script stopped')
end

function main()
	message("main")
	while is_run do
		if isConnected() then
			test()
			is_run = false
		end
	end
end

function test()

	message(settings.bollinger_tag)
	local num_candles = getNumCandles(settings.bollinger_tag)
	message("num_candles = "..num_candles)
	local tabl, num, leg = getCandlesByIndex(settings.bollinger_tag, 0, num_candles-2, 2)
	local last_value = math.floor(tabl[0].close*1000)
	local value = math.floor(tabl[1].close*1000)
	message("bollinger: last = "..last_value.." current = "..value)

	message(settings.price_tag)
	local num_candles = getNumCandles(settings.price_tag)
	message("num_candles = "..num_candles)
	local tabl, num, leg = getCandlesByIndex(settings.price_tag, 0, num_candles-2, 2)
	local last_value = math.floor(tabl[0].close*1000)
	local value = math.floor(tabl[1].close*1000)
	message("price: last = "..last_value.." current = "..value)

	message("price = "..check.price())

end

	-- local f = io.open(".\\lua\\log\\1.csv", "a")
	-- if f then
	-- 	f:write("test;\n")
	-- 	f:close()
	-- 	message("test done")
	-- 	return
	-- end


-- local depo = getDepoEx(settings.FIRMID, settings.CLIENT_CODE, settings.SECCODE, settings.ACCOUNT, 2)
-- 	if depo then
-- 		message("yes "..depo.currentbal)
-- 		return
-- 	end
-- 	message("error")



-- settings.transaction.OPERATION = 'B'
-- 	message("oper = "..settings.transaction.OPERATION)
-- 	local result = sendTransaction(settings.transaction)




	-- local depo = getDepoEx(settings.FIRMID, settings.CLIENT_CODE, settings.SECCODE, settings.ACCOUNT, 2)
	-- if depo then
	-- 	message("yes "..depo.currentbal)
	-- 	return
	-- end
	-- message("error")




-- for i=0,getNumberOf("trade_accounts")-1 do
-- 		message(getItem("trade_accounts",i).trdaccid)
-- 	end





	-- local depo = getDepoEx(settings.FIRMID, settings.CLIENT_CODE, settings.SECCODE, settings.ACCOUNT, 0)  
	-- if depo then
	-- 	if depo.currentbal > 0  and depo.locked_sell == 0 then
	-- 		message("yes")
	-- 		return
	-- 	end
	-- 	if depo.currentbal == 0 and depo.locked_buy == 0 then
	-- 		local money = getMoney(settings.CLIENT_CODE,settings.FIRMID,"EQTV","SUR")
	-- 		if depo.wa_position_price*depo.currentbal < money.money_open_balance*0.9 then
	-- 			message("no")
	-- 			return
	-- 		end
	-- 	end
	-- 	message("no money")
	-- else 
	-- 	message("error")
	-- end






	--message(settings.trix_tag)
	-- local num_lines = getLinesCount("SBERTRIX")
	-- message("lines = "..num_lines)
	-- local num_candles = getNumCandles("SBERTRIX")
	-- message("candles = "..num_candles)