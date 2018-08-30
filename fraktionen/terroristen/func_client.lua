local Var = true

local streamURL = "http://listen.technobase.fm/dsl.asx"

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
function ()
	soundT = playSound3D(streamURL, -801.91461181641, -829.03546142578, 148.8828125, true) 
	setSoundMaxDistance(soundT, 20)
end)

addEvent("onHifiClickedTerror", true)
addEventHandler("onHifiClickedTerror", getRootElement(),
function()
	if not(source == gMe) then return end
	if(Var == true) then
	Var = false
	setSoundVolume(soundT, 0)
	elseif(Var == false) then
	Var = true
	setSoundVolume(soundT, 1)
	end
end)