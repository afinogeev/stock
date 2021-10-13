require "settings";
require "strategy"

is_run = true

function OnInit()
	message('script started')
end

function OnStop()
	is_run = false
	message( 'script stopped')
end

function main()
	message('waiting interval')
	syncronize()
	message('interval synchronized')
	while is_run do
		if isConnected() then
			strategy.run()
			sleep(settings.time_advance*1000)
			syncronize()
		end
	end
end

function syncronize()
	sysdate = os.sysdate()
	lmin = settings.interval - math.fmod(sysdate.min, settings.interval) - 1
	lsec = 60 - sysdate.sec - settings.time_advance
	sleep(1000*(lmin*60 + lsec))
end


