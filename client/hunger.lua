-- Scripts bei MuLTi --
-- Copyright! --

--[[ 
|===================|
|Script bei MuLTi&  |
|SK_Styla! [C]!     |
|===================| --]]


function showHunger()
	guiSetVisible(Hunger1, true)
	guiSetVisible(Hunger2, true)
	guiSetVisible(Hunger3, true)
end

function hideHunger()
	guiSetVisible(Hunger1, false)
	guiSetVisible(Hunger2, false)
	guiSetVisible(Hunger3, false)
end

local minus = 0.001
local sunk = 0.001
local ende = 0.0026
local halb = 0.025
local full = 0.05
local h_warning = 0

function setToNormal()

end

function checkForLeben()
	local x, y = guiGetSize ( Hunger2, true )
	if(x < 0.010) then
		if(h_warning == 0) then
		h_warning = 1
		outputChatBox("Du hast Hunger. Besorg dir was zu Essen, oder du wirst bald Verhungern!", 255, 0, 0, false) 
		end
	end
	if(x < 0.009) and (x > 0.008) then
		setElementHealth(gMe, getElementHealth(gMe)-1)
	elseif(x < 0.008) and (x > 0.007) then
		setElementHealth(gMe, getElementHealth(gMe)-3)
	elseif(x < 0.007) and (x > 0.006) then
		setElementHealth(gMe, getElementHealth(gMe)-5)
	elseif(x < 0.006) and (x > 0.005) then
		setElementHealth(gMe, getElementHealth(gMe)-7)
	elseif(x < 0.005) and (x > 0.004)then
		setElementHealth(gMe, getElementHealth(gMe)-10)
	elseif(x < 0.004) and (x > 0.003) then
		setElementHealth(gMe, getElementHealth(gMe)-15)
	elseif(x < 0.003) and (x > 0.002) then
		setElementHealth(gMe, getElementHealth(gMe)-20)
	elseif(x < 0.002) and (x > 0.001) then
		setElementHealth(gMe, getElementHealth(gMe)-35)
	end
	if(x < 0.001) then
		setElementHealth(gMe, getElementHealth(gMe)-100)
	end
	if(x < 0.009) then
		showLebenKurz()
	end
	outputConsole(x)

end

function setHunger(value)
	if(value == "Full") or(value == "full") then
	guiSetSize (Hunger2,full,0.025, true )
	elseif(value == "Halb") or(value == "halb") then
	guiSetSize (Hunger2,halb,0.025, true )
	end
end
addEvent("setPlayerHunger", true)
addEventHandler("setPlayerHunger", getRootElement(), setHunger)

function addHunger(value)
	local x, y = guiGetSize ( Hunger2, true )
	if(x > full) then return end
	guiSetSize (Hunger2,(x+value/1000),0.025, true )
end

addEventHandler ( "onClientPlayerSpawn", getLocalPlayer(), 
function()
	guiSetSize (Hunger2, halb,0.025, true )
	showHunger()
	if(isTimer(h_timer)) then killTimer(h_timer) end
	local h_timer = setTimer(function() hideHunger() end, 4000, 1)
end )

function habe_Hunger()
	local x, y = guiGetSize ( Hunger2, true )
	guiSetSize (Hunger2,(x-minus),0.025, true )
	sunk = (sunk+minus)
	showHunger()
	if(isTimer(h_timer)) then killTimer(h_timer) end
	local h_timer = setTimer(function() hideHunger() end, 4000, 1)
	checkForLeben()
end
setTimer(habe_Hunger, 180000, 0)
--addCommandHandler("hunger", habe_Hunger)

--addCommandHandler("test2", resize)
--[[
addCommandHandler("test",
function(cmd)
	guiSetPosition ( Hunger2, (0.1073-minus),0.7287, true )
	sunk = (sunk+minus)
end)--]]

function createThisHungerBar()

	Hunger1 = guiCreateStaticImage(0.1073,0.7287,0.05,0.0278,"data/images/hunger/hunger2.png",true)
	guiSetAlpha(Hunger1, 0.8)
	Hunger2 = guiCreateStaticImage(0.1073,0.7287,0.05,0.0278,"data/images/hunger/hunger1.png",true)
	guiSetAlpha(Hunger2, 0.8)
	Hunger3 = guiCreateStaticImage(0.1229,0.7296,0.0193,0.0241,"data/images/hunger/pommes.png",true)
	guiSetAlpha(Hunger3, 0.8)	


	guiSetVisible(Hunger1, false)
	guiSetVisible(Hunger2, false)
	guiSetVisible(Hunger3, false)	

	guiSetSize (Hunger2,halb,0.025, true )
	
end
addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), createThisHungerBar )