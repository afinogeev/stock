require "settings";


is_run = true

function OnInit()
	message('script started')
	grabb()
end

function OnStop()
	is_run = false
	message( 'script stopped')
end

function main()
	-- while is_run do
	-- 	if isConnected() then
			
	-- 	end
	-- end
end

function grabb()
	message(settings.price_tag)
	local num_candles = getNumCandles(settings.price_tag)
	message("num_candles = "..num_candles)
	local tabl, num, leg = getCandlesByIndex(settings.price_tag, 0, 0, num_candles)

	local filename = ".\\data\\"..tostring(settings.price_tag)..".csv"

	local f = io.open(filename, "w")
	if f then
		f:write("num;open;close;low;high\n")
		for i=0,num_candles-1 do
			f:write(tostring(i)..";"..tostring(tabl[i].open)..";"..tostring(tabl[i].close)..";"..tostring(tabl[i].low)..";"..tostring(tabl[i].high)..";".."\n")
		end
		
	end
	f:close()


end


