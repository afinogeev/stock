trade = {}

require "settings";
require "check";
require "log";

function trade.buy()
	local chk = check.depo()
	if chk == 0 then
		settings.transaction.OPERATION = 'B'
		local result = sendTransaction(settings.transaction)
		message("buying")
		log.write(check.price()*(-1))
	end
end

function trade.sell()
	local chk = check.depo()
	if chk == 1 then
		settings.transaction.OPERATION = 'S'
		local result = sendTransaction(settings.transaction)
		message("selling")
		log.write(check.price())
	end
end