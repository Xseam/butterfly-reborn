local Var = true

local streamURL = "http://listen.technobase.fm/dsl.asx"
local sound
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
function ()
	sound = playSound3D(streamURL, 1113.0799560547, -310.13000488281, 72.98999786377, true) 
	setSoundMaxDistance(sound, 50)
end)

addEvent("onRedBrothersHifi", true)
addEventHandler("onRedBrothersHifi", getRootElement(),
function()
	if(Var == true) then
		Var = false
		setSoundVolume(sound, 0)
	elseif(Var == false) then
		Var = true
		setSoundVolume(sound, 1)
	end
end)