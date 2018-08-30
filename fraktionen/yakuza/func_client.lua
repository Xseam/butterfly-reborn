local Var = true

local streamURL = "http://listen.technobase.fm/dsl.asx"

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
function ()
	soundY = playSound3D(streamURL, -92.787071228027, -224.16049194336, 41.226745605469, true) 
	setSoundMaxDistance(soundY, 50)
end)

addEvent("onHifiClickedYakuza", true)
addEventHandler("onHifiClickedYakuza", getRootElement(),
function()
	if not(source == gMe) then return end
	if(Var == true) then
	Var = false
	setSoundVolume(soundY, 0)
	elseif(Var == false) then
	Var = true
	setSoundVolume(soundY, 1)
	end
end)