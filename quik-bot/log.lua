log = {}

function log.write(price)
	local d = os.date("!*t",os.time())
	local filename = ".\\lua\\log\\"..tostring(d.year).."."..tostring(d.month).."."..tostring(d.day)..".csv"
	--arg[0]..
	--print(filename)
	local f = io.open(filename, "a")
	if f then
		f:write(tostring(price)..";\n")
		f:close()
	end
end