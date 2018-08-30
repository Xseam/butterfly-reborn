-- Realtime --

local durCheckTime = 360

function set_realtime_func()
	local realtime = getRealTime()
	setTime(realtime.hour, realtime.minute)
	setMinuteDuration(60000)
end

setTimer(set_realtime_func, durCheckTime*60*1000, 0)

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), set_realtime_func)